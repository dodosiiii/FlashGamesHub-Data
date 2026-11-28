#!/usr/bin/env python3
"""Synchronize Age of War's latest stable GitHub release into both catalogs."""

from __future__ import annotations

from datetime import datetime, timezone
import json
from pathlib import Path
import re
import urllib.request


REPOSITORY = "spidychoipro/Age-of-War-3DS"
RELEASE_API = f"https://api.github.com/repos/{REPOSITORY}/releases/latest"
CATALOG_PATHS = (Path("catalog.json"), Path("data/catalog.json"))
REQUIRED_ASSETS = ("aow3ds.3dsx", "aow3ds.cia")
VERSION_PATTERN = re.compile(r"^v?([0-9]+(?:\.[0-9]+){1,3})$")
SHA256_PATTERN = re.compile(r"^sha256:([0-9a-fA-F]{64})$")


def fetch_latest_release() -> dict:
    request = urllib.request.Request(
        RELEASE_API,
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "FlashGamesHub-AgeOfWarCatalogSync",
        },
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        release = json.load(response)

    if release.get("draft") or release.get("prerelease"):
        raise ValueError("The latest Age of War release is not a stable published release.")

    tag = release.get("tag_name")
    version_match = VERSION_PATTERN.fullmatch(tag) if isinstance(tag, str) else None
    if not version_match:
        raise ValueError(f"Unsupported Age of War release tag: {tag!r}")

    expected_prefix = f"https://github.com/{REPOSITORY}/releases/download/{tag}/"
    assets = {}
    for asset in release.get("assets", []):
        name = asset.get("name")
        if name not in REQUIRED_ASSETS:
            continue
        digest_match = SHA256_PATTERN.fullmatch(asset.get("digest", ""))
        size = asset.get("size")
        url = asset.get("browser_download_url")
        if (
            not digest_match
            or not isinstance(size, int)
            or size <= 0
            or size > 0xFFFFFFFF
            or not isinstance(url, str)
            or not url.startswith(expected_prefix)
        ):
            raise ValueError(f"Invalid metadata for Age of War asset {name!r}.")
        if name in assets:
            raise ValueError(f"Duplicate Age of War asset: {name}")
        assets[name] = {
            "url": url,
            "size": size,
            "sha256": digest_match.group(1).lower(),
        }

    missing_assets = set(REQUIRED_ASSETS) - assets.keys()
    if missing_assets:
        raise ValueError(f"Missing Age of War release assets: {', '.join(sorted(missing_assets))}")

    return {
        "version": version_match.group(1),
        "3dsx": assets["aow3ds.3dsx"],
        "cia": assets["aow3ds.cia"],
    }


def find_age_of_war_object(contents: str) -> tuple[int, int, dict]:
    match = re.search(r'(?m)^    \{\r?\n(?=      "id": "age-of-war",)', contents)
    if not match:
        raise ValueError("Could not locate the Age of War catalog entry.")

    start = match.start()
    depth = 0
    in_string = False
    escaped = False
    for position in range(start, len(contents)):
        character = contents[position]
        if in_string:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == '"':
                in_string = False
            continue
        if character == '"':
            in_string = True
        elif character == "{":
            depth += 1
        elif character == "}":
            depth -= 1
            if depth == 0:
                end = position + 1
                entry = json.loads(contents[start:end])
                if entry.get("id") != "age-of-war":
                    raise ValueError("Catalog entry marker did not resolve to Age of War.")
                return start, end, entry
    raise ValueError("Age of War catalog entry is not a complete JSON object.")


def synchronize_catalog(contents: str, release: dict) -> tuple[str, bool]:
    start, end, entry = find_age_of_war_object(contents)
    if entry.get("status") != "development":
        raise ValueError("Age of War must remain in development status.")

    original_entry = entry.copy()
    entry.update(
        {
            "version": release["version"],
            "file_type": "3dsx",
            "size_bytes": release["3dsx"]["size"],
            "download_url": release["3dsx"]["url"],
            "sha256": release["3dsx"]["sha256"],
            "cia_url": release["cia"]["url"],
            "cia_size_bytes": release["cia"]["size"],
            "cia_sha256": release["cia"]["sha256"],
        }
    )
    if entry == original_entry:
        return contents, False

    newline = "\r\n" if "\r\n" in contents else "\n"
    formatted_entry = newline.join(
        f"    {line}" for line in json.dumps(entry, ensure_ascii=False, indent=2).splitlines()
    )
    updated = contents[:start] + formatted_entry + contents[end:]

    catalog_version = re.search(r'(?m)^  "catalog_version": ([0-9]+),\r?$', updated)
    if not catalog_version:
        raise ValueError("Could not locate catalog_version.")
    next_catalog_version = int(catalog_version.group(1)) + 1
    updated = (
        updated[: catalog_version.start(1)]
        + str(next_catalog_version)
        + updated[catalog_version.end(1) :]
    )

    updated_at = re.search(r'(?m)^  "updated_at": "([^"]+)",\r?$', updated)
    if not updated_at:
        raise ValueError("Could not locate updated_at.")
    today = datetime.now(timezone.utc).date().isoformat()
    updated = (
        updated[: updated_at.start(1)]
        + today
        + updated[updated_at.end(1) :]
    )
    return updated, True


def main() -> None:
    root = Path(__file__).resolve().parents[2]
    release = fetch_latest_release()
    changes = []
    for relative_path in CATALOG_PATHS:
        path = root / relative_path
        contents = path.read_bytes().decode("utf-8")
        updated, changed = synchronize_catalog(contents, release)
        if changed:
            changes.append((path, updated.encode("utf-8")))

    for path, contents in changes:
        path.write_bytes(contents)
        print(f"Updated {path.relative_to(root)} to Age of War {release['version']}.")
    if not changes:
        print(f"Age of War {release['version']} is already current in both catalogs.")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Inventaire complet du projet (équivalent de inventory.ps1, sans PowerShell).
Usage (depuis la racine du projet) :  python inventory.py
Produit : inventory/report.txt, inventory/files.csv et inventory.zip
"""
import csv, os, re, struct, sys, zipfile
from collections import Counter, defaultdict

root = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else ".")
out = os.path.join(root, "inventory")
os.makedirs(out, exist_ok=True)
SKIP = {".git", "node_modules", "inventory"}
MEDIA = {".png", ".wav", ".mp3", ".ogg", ".t3x", ".svg", ".jpg", ".gif"}
HIDE = MEDIA | {".o", ".d"}
TEXT_RX = re.compile(r"(^|/)(Makefile|\.gitignore|build\.ps1)$|\.(rsf|t3s|tsv|md|json|py|ps1|txt|cfg|yml|yaml|toml)$")


def png_size(p):
    try:
        with open(p, "rb") as f:
            b = f.read(24)
        if b[1:4] == b"PNG":
            return struct.unpack(">II", b[16:24])
    except OSError:
        pass
    return None


def wav_info(p):
    try:
        with open(p, "rb") as f:
            b = f.read(44)
        if b[:4] == b"RIFF" and b[8:12] == b"WAVE":
            ch, rate = struct.unpack("<HI", b[22:28])
            bits = struct.unpack("<H", b[34:36])[0]
            return f"ch={ch} rate={rate} bits={bits}"
    except OSError:
        pass
    return ""


rows = []
for dp, dn, fn in os.walk(root):
    dn[:] = [d for d in dn if d not in SKIP]
    for f in fn:
        full = os.path.join(dp, f)
        rel = os.path.relpath(full, root).replace("\\", "/")
        ext = os.path.splitext(f)[1].lower()
        w = h = ""
        extra = ""
        if ext == ".png":
            s = png_size(full)
            if s:
                w, h = s
        elif ext == ".wav":
            extra = wav_info(full)
        rows.append(dict(path=rel, size=os.path.getsize(full), ext=ext, width=w, height=h, extra=extra))
rows.sort(key=lambda r: r["path"])

with open(os.path.join(out, "files.csv"), "w", newline="", encoding="utf-8") as fh:
    wr = csv.DictWriter(fh, fieldnames=["path", "size", "ext", "width", "height", "extra"])
    wr.writeheader()
    wr.writerows(rows)

R = []
W = R.append
total = sum(r["size"] for r in rows)
W("=== INVENTAIRE ===")
W(f"Racine : {root}")
W(f"Fichiers : {len(rows)}   Taille totale : {total/1048576:.1f} Mo\n")

W("=== DOSSIERS DE PREMIER NIVEAU ===")
top = defaultdict(lambda: [0, 0])
for r in rows:
    k = r["path"].split("/")[0] if "/" in r["path"] else "(racine)"
    top[k][0] += 1
    top[k][1] += r["size"]
for k, (n, sz) in sorted(top.items()):
    W(f"{k:<20} {n:7d} fichiers {sz/1048576:9.2f} Mo")
W("\n=== EXTENSIONS (global) ===")
for e, n in Counter(r["ext"] or "(aucune)" for r in rows).most_common():
    W(f"{e:<10} {n:7d}")

W("\n=== DOSSIERS (images / sons) : nombre, tailles PNG min-max, exemples ===")
bydir = defaultdict(list)
for r in rows:
    if r["ext"] in MEDIA:
        bydir[os.path.dirname(r["path"])].append(r)
for d, g in sorted(bydir.items(), key=lambda kv: -len(kv[1]))[:200]:
    pngs = [r for r in g if r["width"] != ""]
    dim = ""
    if pngs:
        ws = [r["width"] for r in pngs]; hs = [r["height"] for r in pngs]
        dim = f"  PNG w:{min(ws)}-{max(ws)} h:{min(hs)}-{max(hs)}"
    W(f"[{d}] {len(g)} fichiers{dim}")
    for r in g[:12]:
        s = "    " + os.path.basename(r["path"])
        if r["width"] != "":
            s += f" ({r['width']}x{r['height']})"
        if r["extra"]:
            s += f" [{r['extra']}]"
        W(s)

W("\n=== AUTRES FICHIERS (code, config, docs, outils, scripts AS3...) ===")
for r in [r for r in rows if r["ext"] not in HIDE][:1500]:
    W(f"{r['path']}  ({r['size']} o)")

W("\n=== CONTENU DES FICHIERS CLES ===")
for r in rows:
    if TEXT_RX.search(r["path"]) and r["size"] < 400000 and not re.match(r"(build|extracted)/", r["path"]):
        W(f"----- {r['path']} ({r['size']} o) -----")
        with open(os.path.join(root, r["path"]), encoding="utf-8", errors="replace") as fh:
            t = fh.read()
        W(t[:30000] + ("\n[... tronqué ...]" if len(t) > 30000 else ""))

W("\n=== SOURCES (lignes) ===")
for r in rows:
    if r["ext"] in (".cpp", ".hpp", ".h", ".c") and not re.match(r"(build|extracted)/", r["path"]):
        with open(os.path.join(root, r["path"]), encoding="utf-8", errors="replace") as fh:
            W(f"{sum(1 for _ in fh):6d}  {r['path']}")

with open(os.path.join(out, "report.txt"), "w", encoding="utf-8") as fh:
    fh.write("\n".join(R) + "\n")
zp = os.path.join(root, "inventory.zip")
with zipfile.ZipFile(zp, "w", zipfile.ZIP_DEFLATED) as z:
    for n in ("report.txt", "files.csv"):
        z.write(os.path.join(out, n), n)
print("OK ->", zp, "(envoie ce fichier)")

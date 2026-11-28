#!/usr/bin/env python3
"""prepare_assets.py — prépare TOUS les assets exportés du SWF pour la 3DS.

  1. Images  : assets/source/images/*.png  -> réduites (--scale) -> atlas tex3ds
               (assets/atlases/atlas_NN.t3s + assets/atlases/img/img_<id>.png), max 1024x1024 par atlas
  2. Sons    : assets/source/sounds/*.wav  -> PCM 16 bits mono <= 22050 Hz -> romfs/audio/<nom>.wav
  2b. Export : assets/source/export/<Classe>/<n>.png (FFDec) -> assets/atlases_real/real_NN.t3s, noms spr_<Classe>_<n>
  3. Manifest: romfs/gfx/manifest.tsv (planche<TAB>index<TAB>nom) pour TOUS les .t3s de assets/

Usage (depuis la racine du projet) :
    pip install pillow
    python tools/prepare_assets.py                 # images à 50 % (écran 320x240), sons convertis
    python tools/prepare_assets.py --scale 0.625   # fonds 640x480 -> 400x300
    python tools/prepare_assets.py --skip-sounds
Puis :  .\\build.ps1 assets   (ou  .\\build.ps1 cia)
"""
import argparse
import array
import os
import re
import shutil
import sys
import wave

try:
    from PIL import Image
except ImportError:
    sys.exit("Pillow est requis :  pip install pillow")

ATLAS_SIZE = 1024
FILL_RATIO = 0.62      # part de la surface d'un atlas réellement remplie (marge pour le packing de tex3ds)
MAX_RATE = 22050


def leading_int(name):
    m = re.match(r"(\d+)", name)
    return int(m.group(1)) if m else 10 ** 9


# ── images ────────────────────────────────────────────────────────────────────
def list_pngs(src, recursive):
    """Retourne [(chemin_complet, nom_logique_sans_prefixe)] triés."""
    out = []
    if recursive:
        for root, _d, files in os.walk(src):
            rel = os.path.relpath(root, src)
            for f in files:
                if f.lower().endswith(".png") and not rel.startswith("_"):
                    stem = os.path.splitext(f)[0]
                    logical = stem if rel == "." else rel.replace(os.sep, "_") + "_" + stem
                    out.append((os.path.join(root, f), logical, (rel, leading_int(stem))))
        out.sort(key=lambda t: t[2])
    else:
        for f in sorted((f for f in os.listdir(src) if f.lower().endswith(".png")),
                        key=lambda f: (leading_int(f), f)):
            out.append((os.path.join(src, f), os.path.splitext(f)[0], None))
    return [(p, n) for p, n, _k in out]


def prepare_images(src, out, scale, fmt, prefix="img_", atlas="atlas", recursive=False):
    pngs = list_pngs(src, recursive)
    imgdir = os.path.join(out, "img")
    os.makedirs(out, exist_ok=True)
    for f in os.listdir(out):                          # régénération propre (uniquement NOS atlas)
        p = os.path.join(out, f)
        if f.startswith(atlas + "_") and f.endswith(".t3s"):
            os.remove(p)
    if os.path.isdir(imgdir):
        shutil.rmtree(imgdir)
    os.makedirs(imgdir, exist_ok=True)

    groups, cur, cur_area = [], [], 0
    cap = ATLAS_SIZE * ATLAS_SIZE * FILL_RATIO
    skipped = 0
    used = set()
    for path, logical in pngs:
        f = os.path.basename(path)
        try:
            im = Image.open(path).convert("RGBA")
        except Exception as e:                          # fichier illisible
            print(f"  ! {f}: {e}")
            skipped += 1
            continue
        w = max(1, round(im.width * scale))
        h = max(1, round(im.height * scale))
        k = min(1.0, (ATLAS_SIZE - 2) / w, (ATLAS_SIZE - 2) / h)   # jamais plus grand qu'un atlas
        if k < 1.0:
            w, h = max(1, int(w * k)), max(1, int(h * k))
        if (w, h) != im.size:
            im = im.resize((w, h), Image.LANCZOS)
        name = prefix + re.sub(r"[^0-9A-Za-z_]+", "_", logical)
        if name in used:                                # collision de noms : suffixe numérique
            n = 2
            while f"{name}_{n}" in used:
                n += 1
            name = f"{name}_{n}"
        used.add(name)
        im.save(os.path.join(imgdir, name + ".png"))
        area = (w + 2) * (h + 2)
        if cur and cur_area + area > cap:
            groups.append(cur)
            cur, cur_area = [], 0
        cur.append(name)
        cur_area += area
    if cur:
        groups.append(cur)

    for i, g in enumerate(groups, 1):
        with open(os.path.join(out, f"{atlas}_{i:02d}.t3s"), "w", encoding="utf-8", newline="\n") as fh:
            fh.write(f"--atlas -f {fmt} -z auto\n")
            for name in g:
                fh.write(f"img/{name}.png\n")
    print(f"images : {len(pngs) - skipped} PNG -> {len(groups)} atlas '{atlas}' (échelle {scale}, format {fmt}) -> {out}")
    return len(groups)


# ── sons ──────────────────────────────────────────────────────────────────────
def convert_wav(src_path, dst_path):
    with wave.open(src_path, "rb") as w:
        ch, sw, rate, n = w.getnchannels(), w.getsampwidth(), w.getframerate(), w.getnframes()
        raw = w.readframes(n)
    if sw == 1:                                         # 8 bits non signé
        samples = array.array("h", ((b - 128) << 8 for b in raw))
    elif sw == 2:
        samples = array.array("h")
        samples.frombytes(raw)
        if sys.byteorder == "big":
            samples.byteswap()
    else:
        raise ValueError(f"{sw * 8} bits non géré")
    if ch > 1:                                          # mixage mono
        samples = array.array("h", (sum(samples[i:i + ch]) // ch for i in range(0, len(samples) - ch + 1, ch)))
    if rate > MAX_RATE and len(samples) > 1:            # ré-échantillonnage linéaire
        ratio = rate / MAX_RATE
        m = int(len(samples) / ratio)
        res = array.array("h")
        for i in range(m):
            pos = i * ratio
            j = int(pos)
            frac = pos - j
            a = samples[j]
            b = samples[j + 1] if j + 1 < len(samples) else a
            res.append(int(a + (b - a) * frac))
        samples, rate = res, MAX_RATE
    os.makedirs(os.path.dirname(dst_path), exist_ok=True)
    with wave.open(dst_path, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(rate)
        w.writeframes(samples.tobytes() if sys.byteorder == "little" else
                      (lambda a: (a.byteswap(), a.tobytes())[1])(array.array("h", samples)))
    return rate, len(samples) * 2


def clean_sound_name(fn):
    base = fn
    while base.lower().endswith(".wav"):
        base = base[:-4]
    base = re.sub(r"^-?\d+_", "", base)                  # "46_buildscreen_music" -> "buildscreen_music"
    return re.sub(r"[^0-9A-Za-z_]+", "_", base).strip("_").lower() or "snd"


def prepare_sounds(src, dst, overwrite):
    done, skipped, used = 0, 0, set()
    for fn in sorted(os.listdir(src), key=lambda f: (leading_int(f.lstrip("-")), f)):
        if not fn.lower().endswith(".wav"):
            continue
        name = clean_sound_name(fn)
        if name in used:                                 # doublon : on suffixe l'id d'origine
            name = f"{name}_{leading_int(fn.lstrip('-'))}"
        used.add(name)
        target = os.path.join(dst, name + ".wav")
        if os.path.exists(target) and not overwrite:
            skipped += 1
            continue
        try:
            rate, size = convert_wav(os.path.join(src, fn), target)
            if size > 2 * 1024 * 1024:
                print(f"  ! {name}.wav fait {size // 1024} Ko (> 2 Mo : refusé par audio_3ds.cpp)")
            done += 1
        except Exception as e:
            print(f"  ! {fn}: {e}")
    print(f"sons   : {done} convertis, {skipped} déjà présents (--overwrite pour remplacer) -> {dst}")


# ── manifest ──────────────────────────────────────────────────────────────────
def parse_t3s(path):
    names = []
    with open(path, encoding="utf-8-sig") as f:
        for raw in f:
            line = raw.strip()
            if not line or line.startswith("#") or line.startswith("-"):
                continue
            names.append(os.path.splitext(os.path.basename(line.replace("\\", "/")))[0])
    return names


def write_manifest(assets_root, out_path):
    t3s = []
    for root, _d, files in os.walk(assets_root):
        if os.path.sep + "source" in root + os.path.sep and os.path.relpath(root, assets_root).startswith("source"):
            continue
        t3s += [os.path.join(root, f) for f in files if f.lower().endswith(".t3s")]
    t3s.sort()
    os.makedirs(os.path.dirname(os.path.abspath(out_path)), exist_ok=True)
    total = 0
    with open(out_path, "w", encoding="utf-8", newline="\n") as out:
        out.write("# planche\tindex\tnom\n")
        for p in t3s:
            sheet = os.path.splitext(os.path.basename(p))[0]
            for i, name in enumerate(parse_t3s(p)):
                out.write(f"{sheet}\t{i}\t{name}\n")
                total += 1
    print(f"manifest : {len(t3s)} planches, {total} sprites -> {out_path}")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", default=".", help="racine du projet")
    ap.add_argument("--scale", type=float, default=0.5, help="échelle des images (défaut 0.5)")
    ap.add_argument("--format", default="rgba8888", help="format tex3ds (rgba8888, rgba4444, rgba5551...)")
    ap.add_argument("--overwrite", action="store_true", help="remplacer les WAV déjà présents dans romfs/audio")
    ap.add_argument("--export-scale", type=float, default=0.5, help="échelle des PNG exportés de FFDec (assets/source/export)")
    ap.add_argument("--skip-export", action="store_true")
    ap.add_argument("--skip-images", action="store_true")
    ap.add_argument("--skip-sounds", action="store_true")
    a = ap.parse_args()
    r = os.path.abspath(a.root)

    if not a.skip_images:
        src = os.path.join(r, "assets", "source", "images")
        if os.path.isdir(src):
            prepare_images(src, os.path.join(r, "assets", "atlases"), a.scale, a.format)
        else:
            print("! assets/source/images introuvable")
    if not a.skip_export:
        src = os.path.join(r, "assets", "source", "export")
        if os.path.isdir(src):                          # vrais symboles composés exportés par FFDec
            prepare_images(src, os.path.join(r, "assets", "atlases_real"), a.export_scale, a.format,
                           prefix="spr_", atlas="real", recursive=True)
        else:
            print("(pas d'assets/source/export : lancez tools/export_real_assets.py)")
    if not a.skip_sounds:
        src = os.path.join(r, "assets", "source", "sounds")
        if os.path.isdir(src):
            prepare_sounds(src, os.path.join(r, "romfs", "audio"), a.overwrite)
        else:
            print("! assets/source/sounds introuvable")
    lay = os.path.join(r, "layout")                      # placement des vrais sprites (suivi par git)
    if os.path.isdir(lay):
        dst = os.path.join(r, "romfs", "layout")
        os.makedirs(dst, exist_ok=True)
        for f in os.listdir(lay):
            if f.lower().endswith(".tsv"):
                shutil.copy2(os.path.join(lay, f), os.path.join(dst, f))
        print(f"layout : {lay} -> {dst}")
    write_manifest(os.path.join(r, "assets"), os.path.join(r, "romfs", "gfx", "manifest.tsv"))


if __name__ == "__main__":
    main()


#!/usr/bin/env python3
"""export_real_assets.py — exporte du SWF les VRAIS symboles composés (écrans, clients, boutons...) en PNG via JPEXS FFDec.

Étapes :
    python tools/swf_index.py input/papascheeseria.swf          # crée meta/swf_symbols.tsv (id <-> classe)
    python tools/export_real_assets.py --list                    # voir les classes disponibles
    python tools/export_real_assets.py --preset core             # écrans principaux
    python tools/export_real_assets.py --match "Screen|HUD"      # ou tout ce dont le nom correspond (regex)
    python tools/export_real_assets.py --classes buildScreenMC,customerMC
    python tools/prepare_assets.py                               # atlasse aussi assets/source/export (voir ce script)

Sortie : assets/source/export/<Classe>/<frame>.png (renommé depuis les dossiers FFDec DefineSprite_<id>_<Classe>).

ATTENTION : la syntaxe exacte de FFDec varie selon les versions. Ce script lit `ffdec -help`, avertit si
-selectid est absent, et --dry-run affiche les commandes sans les lancer. Non testé avec FFDec ici.
"""
import argparse, os, re, shutil, subprocess, sys

CORE = ["buildScreenMC", "cookbookScreenMC", "customerMC", "customerDiningMC", "customerBleachersMC"]

# Écrans / fonds / UI du jeu (noms vus dans meta/swf_symbols.tsv, 1 frame chacun pour la plupart)
SCREENS = ["mainmenuMC", "takeOrderMC", "orderScreenMC", "grillScreenMC", "buildScreenMC", "fryScreenMC",
           "giveOrderMC", "hudMC", "endOfDayMC", "startDayMC", "lobbyBackdropMC", "orderBackdropMC",
           "startdayBackdropMC", "ticketMC", "ticketHolderMC", "platterMC", "spoonMC", "shopScreenMC",
           "splashScreenMC", "slotSelectMC", "cookbookScreenMC", "game_ticket_counter", "build_bread_waxpaper"]

# Ingrédients utilisés par le prototype actuel (pains, fromages, cuisson, frites, tickets)
PROTOTYPE = ["choose_bread_white", "choose_bread_wheat", "clip_bread_white", "clip_bread_wheat",
             "shadow_bread_white", "shadow_bread_wheat", "cut_mozzarellacheese", "cut_shreddedcheddarcheese",
             "choose_mozzarellacheese", "choose_shreddedcheddarcheese",
             "clip_mozzarellacheese_top", "clip_mozzarellacheese_bottom",
             "clip_shreddedcheddarcheese_top", "clip_shreddedcheddarcheese_bottom",
             "fry_regular_basket", "fry_sweetpotatowedges_basket", "fry_regular_clump", "fry_sweetpotatowedges_clump",
             "ticket_panel_bread", "ticket_panel_cheese", "ticket_panel_cook", "ticket_panel_fry"]



def read_symbols(path):
    rows = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            if line.startswith("#") or not line.strip():
                continue
            cid, typ, frames, classes = (line.rstrip("\n").split("\t") + [""] * 4)[:4]
            rows.append((int(cid), typ, int(frames or 0), [c for c in classes.split(",") if c]))
    return rows


def find_ffdec(explicit):
    cands = [explicit, os.environ.get("FFDEC"), shutil.which("ffdec"), shutil.which("ffdec.bat"), shutil.which("ffdec-cli")]
    for base in (os.environ.get("ProgramFiles"), os.environ.get("ProgramFiles(x86)")):
        if base:
            for sub in ("FFDec", "JPEXS Free Flash Decompiler"):
                cands += [os.path.join(base, sub, "ffdec.bat"), os.path.join(base, sub, "ffdec.exe")]
    for c in cands:
        if c and os.path.exists(c):
            return c
    return None


def run(cmd, dry):
    print("  $", " ".join('"%s"' % c if " " in c else c for c in cmd))
    if dry:
        return 0
    return subprocess.call(cmd)


def tidy(tmp, dest):
    """Renomme DefineSprite_<id>_<Classe> -> <Classe> et range les PNG dans dest."""
    n = 0
    for root, _dirs, files in os.walk(tmp):
        pngs = [f for f in files if f.lower().endswith(".png")]
        if not pngs:
            continue
        parent = os.path.basename(root)
        m = re.match(r"DefineSprite_(\d+)(?:_(.+))?$", parent)
        name = (m.group(2) or "sprite_" + m.group(1)) if m else parent
        out = os.path.join(dest, re.sub(r"[^0-9A-Za-z_]+", "_", name))
        os.makedirs(out, exist_ok=True)
        for f in pngs:
            shutil.move(os.path.join(root, f), os.path.join(out, f))
            n += 1
    return n


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--swf", default=os.path.join("input", "papascheeseria.swf"))
    ap.add_argument("--symbols", default=os.path.join("meta", "swf_symbols.tsv"))
    ap.add_argument("--out", default=os.path.join("assets", "source", "export"))
    ap.add_argument("--ffdec")
    ap.add_argument("--preset", choices=["core", "screens", "prototype"])
    ap.add_argument("--classes", help="liste séparée par des virgules")
    ap.add_argument("--match", help="regex sur le nom de classe (sprites uniquement)")
    ap.add_argument("--zoom", default="1", help="zoom FFDec (1 = 640x480 natif)")
    ap.add_argument("--max-frames", type=int, default=120,
                    help="ignore les symboles ayant plus de frames (défaut 120 : évite customerMC = 2830 frames)")
    ap.add_argument("--force", action="store_true", help="exporter même au-delà de --max-frames")
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()

    if not os.path.exists(a.symbols):
        sys.exit("Index absent : lancez d'abord  python tools/swf_index.py %s" % a.swf)
    syms = read_symbols(a.symbols)
    sprites = [(cid, fr, cls) for cid, typ, fr, cls in syms if typ == "sprite" and cls]

    if a.list:
        for cid, fr, cls in sprites:
            print("%-6d %3d fr  %s" % (cid, fr, ",".join(cls)))
        print("%d sprites nommés" % len(sprites))
        return

    wanted = set()
    if a.preset:
        wanted |= set({"core": CORE, "screens": SCREENS, "prototype": PROTOTYPE}[a.preset])
    if a.classes:
        wanted |= {c.strip() for c in a.classes.split(",") if c.strip()}
    rx = re.compile(a.match, re.I) if a.match else None
    ids, skipped = [], []
    for cid, fr, cls in sprites:
        if any(c in wanted for c in cls) or (rx and any(rx.search(c) for c in cls)):
            if fr > a.max_frames and not a.force:
                skipped.append((cls[0], fr))
            else:
                ids.append(cid)
    for name, fr in skipped:
        print("  (ignoré : %s a %d frames > --max-frames %d ; --force pour l'exporter)" % (name, fr, a.max_frames))
    found = {c for _i, _f, cls in sprites for c in cls}
    for w in sorted(wanted - found):
        print("  ! classe introuvable dans l'index :", w)
    if not ids:
        sys.exit("Aucun symbole sélectionné (voir --list, --preset, --classes, --match).")
    print("%d symboles sélectionnés" % len(ids))

    ffdec = find_ffdec(a.ffdec)
    if not ffdec and not a.dry_run:
        sys.exit("FFDec introuvable : passez --ffdec <chemin> ou définissez la variable FFDEC.")
    ffdec = ffdec or "ffdec"
    if not a.dry_run:
        try:
            h = subprocess.run([ffdec, "-help"], capture_output=True, text=True, timeout=60)
            if "selectid" not in (h.stdout + h.stderr):
                print("! Votre FFDec n'annonce pas -selectid : mettez-le à jour (version 15+).")
        except Exception as e:
            print("! impossible de lire `ffdec -help` :", e)

    tmp = os.path.join(a.out, "_ffdec_tmp")
    shutil.rmtree(tmp, ignore_errors=True)
    os.makedirs(tmp, exist_ok=True)
    for i in range(0, len(ids), 20):                      # lots : limite de longueur de ligne de commande
        batch = ",".join(str(x) for x in ids[i:i + 20])
        cmd = [ffdec, "-zoom", a.zoom, "-format", "sprite:png,frame:png", "-selectid", batch,
               "-export", "sprite", tmp, a.swf]
        if run(cmd, a.dry_run) != 0:
            print("! FFDec a renvoyé une erreur sur le lot", batch)
    if not a.dry_run:
        n = tidy(tmp, a.out)
        shutil.rmtree(tmp, ignore_errors=True)
        print("%d PNG -> %s" % (n, a.out))
        if n == 0:
            print("! rien exporté : lancez la commande ci-dessus à la main et lisez le message de FFDec.")


if __name__ == "__main__":
    main()

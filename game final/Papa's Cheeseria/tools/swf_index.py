#!/usr/bin/env python3
"""swf_index.py — indexe un SWF : id de caractère <-> nom de classe (SymbolClass / ExportAssets).

Sert à savoir QUELS symboles exporter avec JPEXS FFDec (buildScreenMC, customerMC, ...) sans deviner les ids.
Sortie : meta/swf_symbols.tsv  (id <TAB> type <TAB> frames <TAB> classes)

Usage :  python tools/swf_index.py input/papascheeseria.swf
         python tools/swf_index.py input/papascheeseria.swf --grep MC
Gère les SWF non compressés (FWS) et zlib (CWS). Les SWF LZMA (ZWS) sont aussi lus si le module lzma est présent.
"""
import argparse, os, struct, sys, zlib

TYPES = {
    2: "shape", 22: "shape", 32: "shape", 83: "shape",
    6: "bitmap", 21: "bitmap", 35: "bitmap", 20: "bitmap", 36: "bitmap", 90: "bitmap",
    14: "sound", 39: "sprite", 7: "button", 34: "button",
    11: "text", 33: "text", 37: "edittext",
    10: "font", 48: "font", 62: "font", 75: "font", 91: "font",
    60: "video", 87: "binary",
}


def load_swf(path):
    d = open(path, "rb").read()
    sig, ver, ln = d[:3], d[3], struct.unpack("<I", d[4:8])[0]
    if sig == b"FWS":
        body = d[8:]
    elif sig == b"CWS":
        body = zlib.decompress(d[8:])
    elif sig == b"ZWS":
        import lzma
        # ZWS : 4 octets de taille compressée, 5 octets de propriétés LZMA, flux brut
        props = d[12:17]
        lc_lp_pb = props[0]
        dict_size = struct.unpack("<I", props[1:5])[0]
        lc, rem = lc_lp_pb % 9, lc_lp_pb // 9
        lp, pb = rem % 5, rem // 5
        filt = [{"id": lzma.FILTER_LZMA1, "lc": lc, "lp": lp, "pb": pb, "dict_size": dict_size}]
        body = lzma.LZMADecompressor(lzma.FORMAT_RAW, filters=filt).decompress(d[17:])
    else:
        sys.exit("Ce n'est pas un SWF (signature %r)" % sig)
    return ver, ln, body


def skip_header(body):
    nbits = body[0] >> 3
    rect_bytes = (5 + 4 * nbits + 7) // 8
    pos = rect_bytes + 4          # + frame rate (2) + frame count (2)
    return pos


def cstr(buf, pos):
    end = buf.index(b"\0", pos)
    return buf[pos:end].decode("utf-8", "replace"), end + 1


def tags(body):
    pos = skip_header(body)
    while pos + 2 <= len(body):
        h = struct.unpack_from("<H", body, pos)[0]
        pos += 2
        code, ln = h >> 6, h & 0x3F
        if ln == 0x3F:
            ln = struct.unpack_from("<I", body, pos)[0]
            pos += 4
        yield code, body[pos:pos + ln]
        pos += ln
        if code == 0:
            break


def index(path):
    ver, _ln, body = load_swf(path)
    chars, classes = {}, {}
    for code, data in tags(body):
        if code in TYPES and len(data) >= 2:
            cid = struct.unpack_from("<H", data, 0)[0]
            frames = struct.unpack_from("<H", data, 2)[0] if code == 39 and len(data) >= 4 else 0
            chars[cid] = (TYPES[code], frames)
        elif code in (76, 56) and len(data) >= 2:      # SymbolClass / ExportAssets
            n = struct.unpack_from("<H", data, 0)[0]
            pos = 2
            for _ in range(n):
                cid = struct.unpack_from("<H", data, pos)[0]
                name, pos = cstr(data, pos + 2)
                classes.setdefault(cid, []).append(name)
    return ver, chars, classes


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("swf")
    ap.add_argument("--out", default=os.path.join("meta", "swf_symbols.tsv"))
    ap.add_argument("--grep", help="n'afficher que les classes contenant ce texte")
    a = ap.parse_args()
    ver, chars, classes = index(a.swf)
    rows = []
    for cid in sorted(set(chars) | set(classes)):
        typ, fr = chars.get(cid, ("?", 0))
        rows.append((cid, typ, fr, ",".join(classes.get(cid, []))))
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
    with open(a.out, "w", encoding="utf-8", newline="\n") as f:
        f.write("# id\ttype\tframes\tclasses\n")
        for r in rows:
            f.write("%d\t%s\t%d\t%s\n" % r)
    named = [r for r in rows if r[3]]
    print("SWF v%d : %d caractères, %d avec nom de classe -> %s" % (ver, len(chars), len(named), a.out))
    shown = [r for r in named if not a.grep or a.grep.lower() in r[3].lower()]
    for r in shown[:60]:
        print("  id %-6d %-8s %3d frames  %s" % r)
    if len(shown) > 60:
        print("  ... (%d de plus, voir le TSV)" % (len(shown) - 60))


if __name__ == "__main__":
    main()

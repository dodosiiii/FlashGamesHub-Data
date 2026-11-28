#!/usr/bin/env python3
"""
generate_meta.py — Génère l'icône 48x48 et la bannière 256x128 pour le CIA 3DS.
Utilise uniquement la bibliothèque standard + PIL/Pillow.
Lance avec : python tools/generate_meta.py
"""

import os, struct, wave, array, math
from pathlib import Path

try:
    from PIL import Image, ImageDraw, ImageFont
    HAS_PIL = True
except ImportError:
    HAS_PIL = False
    print("[WARN] Pillow non installé — images générées en BMP pur Python")

ROOT = Path(__file__).resolve().parent.parent
META = ROOT / "meta"
META.mkdir(exist_ok=True)

# ─── Palette ────────────────────────────────────────────────────────────────
BG_DARK  = (26,  26,  46)
YELLOW   = (255, 215,  0)
ORANGE   = (255, 135,  0)
WHITE    = (255, 255, 255)
RED      = (200,  40,  40)

def gen_icon():
    """Crée icon.png 48×48."""
    path = META / "icon.png"
    if HAS_PIL:
        img = Image.new("RGB", (48, 48), BG_DARK)
        d = ImageDraw.Draw(img)
        # Fond dégradé simulé par rectangles
        d.rectangle([0, 0, 47, 47], outline=ORANGE, width=2)
        # Lettre P stylisée
        d.rectangle([12, 10, 18, 38], fill=YELLOW)
        d.ellipse([12, 10, 32, 24], fill=ORANGE)
        d.ellipse([13, 11, 29, 23], fill=BG_DARK)
        # Burger icon en bas
        d.rounded_rectangle([10, 30, 38, 36], radius=3, fill=ORANGE)
        d.rounded_rectangle([12, 36, 36, 40], radius=2, fill=YELLOW)
        d.rounded_rectangle([10, 40, 38, 46], radius=3, fill=ORANGE)
        img.save(str(path))
        print(f"[OK] {path}")
    else:
        # Fallback : carré orange pur (bannertool accepte BMP et PNG)
        _write_bmp(path.with_suffix(".bmp"), 48, 48, ORANGE)
        print(f"[OK] {path.with_suffix('.bmp')} (Pillow absent)")

def gen_banner():
    """Crée banner.png 256×128."""
    path = META / "banner.png"
    if HAS_PIL:
        img = Image.new("RGB", (256, 128), BG_DARK)
        d = ImageDraw.Draw(img)
        # Bordure
        d.rectangle([0, 0, 255, 127], outline=ORANGE, width=3)
        # Titre
        try:
            font_lg = ImageFont.truetype("arial.ttf", 22)
            font_sm = ImageFont.truetype("arial.ttf", 13)
        except Exception:
            font_lg = ImageFont.load_default()
            font_sm = font_lg
        d.text((128, 35), "Papa's Cheeseria", fill=YELLOW, font=font_lg, anchor="mm")
        d.text((128, 70), "Port 3DS Homebrew", fill=WHITE,  font=font_sm, anchor="mm")
        d.text((128, 90), "FlashGamesHub",     fill=ORANGE, font=font_sm, anchor="mm")
        img.save(str(path))
        print(f"[OK] {path}")
    else:
        _write_bmp(path.with_suffix(".bmp"), 256, 128, BG_DARK)
        print(f"[OK] {path.with_suffix('.bmp')} (Pillow absent)")

def gen_banner_wav():
    """Génère banner.wav : 1 s de silence 16 bits stéréo 44100 Hz."""
    path = META / "banner.wav"
    n_samples = 44100
    with wave.open(str(path), 'w') as wf:
        wf.setnchannels(2)
        wf.setsampwidth(2)
        wf.setframerate(44100)
        # Jingle court (ding simple)
        data = array.array('h')
        for i in range(n_samples):
            t = i / 44100
            if t < 0.3:
                v = int(8000 * math.sin(2 * math.pi * 880 * t) * math.exp(-10 * t))
            else:
                v = 0
            data.append(v)
            data.append(v)
        wf.writeframes(data.tobytes())
    print(f"[OK] {path}  ({path.stat().st_size} octets)")

def _write_bmp(path, w, h, color):
    """Écrit un BMP couleur unie (sans Pillow)."""
    r, g, b = color
    row_size = ((w * 3 + 3) & ~3)
    pixel_data = bytes([b, g, r]) * w
    pixel_data += bytes(row_size - w * 3)
    pixel_data = pixel_data * h
    file_size = 54 + len(pixel_data)
    header = struct.pack('<2sIHHI', b'BM', file_size, 0, 0, 54)
    info   = struct.pack('<IiiHHIIiiII', 40, w, h, 1, 24, 0, len(pixel_data), 2835, 2835, 0, 0)
    with open(path, 'wb') as f:
        f.write(header + info + pixel_data)

if __name__ == "__main__":
    gen_icon()
    gen_banner()
    gen_banner_wav()
    print("\nFichiers meta générés dans:", META)
    print("Lancez ensuite : .\\build.ps1 cia")

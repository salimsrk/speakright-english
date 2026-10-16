"""Generates the study-themed (graduation-cap) app launcher icon.

HISTORY: we first tried committing this icon as a real PNG, then as a
manually-retyped ~23,000-character base64 blob (this repo has no working
git/gh CLI in our build environment -- only the GitHub web editor, which
only reliably pushes plain text). Both attempts silently corrupted a few
bytes despite passing every length check, producing an unreadable PNG
(ImageException: Invalid IDAT checksum) that only failed at build time.

A small script has no such risk: it is plain, readable text, so any
transcription slip becomes an obvious Python syntax error instead of
silent pixel corruption, and it draws the exact same icon fresh on every
build rather than transporting binary data at all.
"""
import numpy as np
from PIL import Image, ImageDraw

SS = 4  # supersample factor, for anti-aliased edges
SIZE = 1024
S = SIZE * SS

# Diagonal gradient background: teal (top-left) -> indigo (bottom-right)
c1 = np.array([20, 184, 166], dtype=np.float32)  # teal   #14B8A6
c2 = np.array([99, 91, 230], dtype=np.float32)   # indigo #635BE6

xx, yy = np.meshgrid(np.arange(S), np.arange(S))
t = ((xx + yy) / (2 * (S - 1)))[..., None]
grad = (c1 * (1 - t) + c2 * t).astype(np.uint8)
img = Image.fromarray(grad, "RGB")
draw = ImageDraw.Draw(img)

# ---- Graduation cap (mortarboard), white silhouette ----
cx, cy = S // 2, int(S * 0.46)
w = S * 0.62
h = S * 0.30
white = (255, 255, 255)

# Diamond: the flat top of the cap
diamond = [
    (cx, cy - h / 2),
    (cx + w / 2, cy),
    (cx, cy + h / 2),
    (cx - w / 2, cy),
]
draw.polygon(diamond, fill=white)

# Head band under the diamond (trapezoid), with rounded bottom corners
band_top_w = S * 0.30
band_bot_w = S * 0.22
band_h = S * 0.16
band_top_y = cy + h * 0.10
band_bot_y = band_top_y + band_h
trapezoid = [
    (cx - band_top_w / 2, band_top_y),
    (cx + band_top_w / 2, band_top_y),
    (cx + band_bot_w / 2, band_bot_y),
    (cx - band_bot_w / 2, band_bot_y),
]
draw.polygon(trapezoid, fill=white)
draw.ellipse(
    [cx - band_bot_w / 2, band_bot_y - S * 0.02, cx + band_bot_w / 2, band_bot_y + S * 0.02],
    fill=white,
)

# Center button on the diamond
btn_r = S * 0.018
draw.ellipse([cx - btn_r, cy - btn_r, cx + btn_r, cy + btn_r], fill=white)

# Tassel: cord from the button, over the brim, hanging down to a small tuft
cord_w = int(S * 0.014)
p0 = (cx, cy - btn_r * 0.5)
p1 = (cx + w * 0.30, cy + h * 0.12)
p2 = (cx + w * 0.30, cy + h * 0.66)
draw.line([p0, p1], fill=white, width=cord_w)
draw.line([p1, p2], fill=white, width=cord_w)
tuft_r = S * 0.028
draw.ellipse(
    [p2[0] - tuft_r, p2[1] - tuft_r * 0.3, p2[0] + tuft_r, p2[1] + tuft_r * 1.6],
    fill=white,
)

# Downsample from the supersampled canvas for anti-aliased edges
final = img.resize((SIZE, SIZE), Image.LANCZOS)
final.save("assets/icon/app_icon.png", "PNG")
print("saved assets/icon/app_icon.png", final.size)

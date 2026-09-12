"""Generates the illustration for the "Bottle Puzzle" in Module 2's Fun
with Words section — a simple glass bottle with a "SPIRIT" label, used
for the multiple-meanings vocabulary puzzle (spirit = a drink, or a
person's mood/soul).

Same approach as assets/icon/generate_icon.py and for the same reason:
this repo has no working git/gh CLI in our build environment (only the
GitHub web editor for pushing changes), and a hand-committed binary PNG
has silently corrupted before. A small script has no such risk — any
transcription slip is an obvious Python syntax error, not silent pixel
corruption — and it draws the same picture fresh on every build instead
of transporting binary image data at all.
"""
from PIL import Image, ImageDraw, ImageFont

SS = 4  # supersample factor, for anti-aliased edges
W, H = 640, 800
S = SS
img = Image.new("RGBA", (W * S, H * S), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Soft rounded card background, matching the app's card style.
bg = (246, 243, 255, 255)  # AppColors.bg
draw.rounded_rectangle([0, 0, W * S, H * S], radius=40 * S, fill=bg)

cx = (W * S) // 2

# ---- Bottle silhouette ----
glass = (109, 90, 230, 255)      # AppColors.primary #6D5AE6
glass_dark = (76, 63, 192, 255)  # AppColors.primaryDark #4C3FC0
liquid = (245, 158, 11, 255)     # amber "spirit" colour, AppColors.gold

neck_w = 60 * S
neck_top = 90 * S
neck_bot = 210 * S
body_top_w = 200 * S
body_top = 230 * S
body_bot_w = 260 * S
body_bot = 650 * S
corner = 28 * S

# Body (rounded trapezoid-ish shape via polygon + rounded corners trick:
# draw as a rounded rectangle then a trapezoid overlay for the shoulder).
body_left = cx - body_bot_w // 2
body_right = cx + body_bot_w // 2
draw.rounded_rectangle(
    [body_left, body_top + 40 * S, body_right, body_bot],
    radius=corner,
    fill=glass,
)

# Shoulder (the sloped part connecting neck to body)
shoulder = [
    (cx - neck_w // 2, neck_bot),
    (cx + neck_w // 2, neck_bot),
    (body_right, body_top + 70 * S),
    (body_left, body_top + 70 * S),
]
draw.polygon(shoulder, fill=glass)

# Neck
draw.rounded_rectangle(
    [cx - neck_w // 2, neck_top, cx + neck_w // 2, neck_bot + 10 * S],
    radius=10 * S,
    fill=glass,
)

# Cap
cap_w = neck_w + 24 * S
draw.rounded_rectangle(
    [cx - cap_w // 2, neck_top - 46 * S, cx + cap_w // 2, neck_top + 20 * S],
    radius=10 * S,
    fill=glass_dark,
)

# A soft highlight streak on the body for a glass/glossy look.
draw.rounded_rectangle(
    [body_left + 26 * S, body_top + 110 * S, body_left + 54 * S, body_bot - 60 * S],
    radius=16 * S,
    fill=(255, 255, 255, 60),
)

# Liquid level line near the bottom (just a subtle amber band peeking
# above the label, hinting there's a drink inside without needing to
# render liquid behind the label itself).
draw.rounded_rectangle(
    [body_left + 6 * S, body_bot - 60 * S, body_right - 6 * S, body_bot - 6 * S],
    radius=corner - 6 * S,
    fill=liquid,
)

# ---- Label ----
label_w = body_bot_w - 40 * S
label_h = 170 * S
label_top = body_top + 160 * S
label_left = cx - label_w // 2
draw.rounded_rectangle(
    [label_left, label_top, label_left + label_w, label_top + label_h],
    radius=14 * S,
    fill=(255, 255, 255, 255),
    outline=glass_dark,
    width=4 * S,
)
# A thin double rule above/below the word, like a real bottle label.
rule_pad = 26 * S
draw.line(
    [label_left + rule_pad, label_top + 40 * S, label_left + label_w - rule_pad, label_top + 40 * S],
    fill=glass_dark, width=3 * S,
)
draw.line(
    [label_left + rule_pad, label_top + label_h - 34 * S, label_left + label_w - rule_pad, label_top + label_h - 34 * S],
    fill=glass_dark, width=3 * S,
)

font = None
for candidate in (
    "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
    "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf",
    "/usr/share/fonts/truetype/freefont/FreeSansBold.ttf",
    "DejaVuSans-Bold.ttf",  # Pillow ships this itself on many installs
):
    try:
        font = ImageFont.truetype(candidate, 58 * S)
        break
    except OSError:
        continue
if font is None:
    font = ImageFont.load_default()

text = "SPIRIT"
bbox = draw.textbbox((0, 0), text, font=font)
tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
draw.text(
    (cx - tw / 2 - bbox[0], label_top + label_h / 2 - th / 2 - bbox[1]),
    text,
    font=font,
    fill=glass_dark,
)

final = img.resize((W, H), Image.LANCZOS)
final.save("assets/module2/bottle_spirit.png", "PNG")
print("saved assets/module2/bottle_spirit.png", final.size)

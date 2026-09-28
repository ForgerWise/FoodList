"""Turns a photo of a product barcode into tool/assets/scan_background.png
for the Play Store scan slide.

    python tool/prepare_scan_photo.py <photo.jpg>

- Blurs third-party trademarks (REGIONS, in upright-photo pixels; adjust for
  a new photo) so the store listing shows no brand logos.
- Rotates so the barcode is horizontal, scales it to fit the app's scan frame
  and centres it where the frame is; empty space is filled with a blurred,
  darkened copy of the same photo.
- Saves pixels only — EXIF (incl. GPS location) is dropped.
"""
import os
import sys

from PIL import Image, ImageDraw, ImageEnhance, ImageFilter, ImageOps

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT_SIZE = (1080, 1898)        # camera area of the scan screen (below the app bar)
FRAME_CENTER = (540, 948)      # scan frame centre inside that area
BARCODE_WIDTH = 680            # frame is 735 px wide

# Upright photo coordinates (3000x4000 photo of the 1.5 L cola bottle).
REGIONS = [
    (2220, 860, 2520, 2600),   # brand logo, "ORIGINAL", ribbon mark (right edge)
    (1160, 960, 1720, 1500),   # JAS certification mark + its caption
]
BARCODE = (1270, 1510, 1980, 2880)  # l, t, r, b — printed vertically
ROTATE = -90                         # clockwise: digits read left → right


def blur_regions(img):
    blurred = img.filter(ImageFilter.GaussianBlur(45))
    mask = Image.new('L', img.size, 0)
    d = ImageDraw.Draw(mask)
    for r in REGIONS:
        d.rounded_rectangle(r, 60, fill=255)
    return Image.composite(blurred, img, mask.filter(ImageFilter.GaussianBlur(25)))


def main(path):
    photo = ImageOps.exif_transpose(Image.open(path)).convert('RGB')
    photo = blur_regions(photo)

    l, t, r, b = BARCODE
    cx, cy = (l + r) / 2, (t + b) / 2
    w, h = photo.size
    photo = photo.rotate(ROTATE, expand=True)
    if ROTATE == -90:
        cx, cy = h - 1 - cy, cx
        bw = b - t
    else:
        bw = r - l
    scale = BARCODE_WIDTH / bw
    photo = photo.resize((round(photo.width * scale), round(photo.height * scale)), Image.LANCZOS)
    ox, oy = round(FRAME_CENTER[0] - cx * scale), round(FRAME_CENTER[1] - cy * scale)

    back = ImageOps.fit(photo, OUT_SIZE, Image.LANCZOS).filter(ImageFilter.GaussianBlur(40))
    back = ImageEnhance.Brightness(back).enhance(0.55)
    # feather the photo's top/bottom edges into the blurred backdrop
    fade = 90
    mask = Image.new('L', photo.size, 255)
    d = ImageDraw.Draw(mask)
    for i in range(fade):
        v = round(255 * i / fade)
        d.line([(0, i), (photo.width, i)], fill=v)
        d.line([(0, photo.height - 1 - i), (photo.width, photo.height - 1 - i)], fill=v)
    back.paste(photo, (ox, oy), mask)

    out = os.path.join(ROOT, 'tool', 'assets', 'scan_background.png')
    Image.frombytes('RGB', back.size, back.tobytes()).save(out, optimize=True)  # no EXIF
    print('written', out)


if __name__ == '__main__':
    main(sys.argv[1])

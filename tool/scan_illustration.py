"""Cartoon "hand holding a snack box with a barcode" for the scan slide.

Used by tool/store_images.py when tool/assets/scan_background.png is absent
(drop an AI/photo image there to replace it). Pure Pillow, no assets needed.
"""
from PIL import Image, ImageDraw, ImageFont

INK = (43, 43, 43)
SKIN, SKIN_SHADE = (247, 200, 160), (226, 170, 128)
SLEEVE, SLEEVE_SHADE = (47, 125, 91), (35, 99, 71)
BOX, BOX_SIDE = (255, 183, 77), (236, 150, 45)

# EAN-13 encoding tables
_L = ['0001101', '0011001', '0010011', '0111101', '0100011', '0110001', '0101111', '0111011', '0110111', '0001011']
_G = ['0100111', '0110011', '0011011', '0100001', '0011101', '0111001', '0000101', '0010001', '0001001', '0010111']
_R = ['1110010', '1100110', '1101100', '1000010', '1011100', '1001110', '1010000', '1000100', '1001000', '1110100']
_P = ['LLLLLL', 'LLGLGG', 'LLGGLG', 'LLGGGL', 'LGLLGG', 'LGGLLG', 'LGGGLL', 'LGLGLG', 'LGLGGL', 'LGGLGL']


def ean13_bits(code):
    bits = '101'
    for i, c in enumerate(code[1:7]):
        bits += (_L if _P[int(code[0])][i] == 'L' else _G)[int(c)]
    bits += '01010'
    for c in code[7:]:
        bits += _R[int(c)]
    return bits + '101'


def barcode(code, w, h, font):
    img = Image.new('RGBA', (w, h), (255, 255, 255, 255))
    d = ImageDraw.Draw(img)
    bits = ean13_bits(code)
    unit = (w - 40) / len(bits)
    bar_h = h - font.size - 40
    for i, b in enumerate(bits):
        if b == '1':
            x = 20 + i * unit
            d.rectangle([x, 16, x + unit - 0.5, 16 + bar_h], fill=INK)
    tw = d.textlength(code, font=font)
    d.text(((w - tw) / 2, bar_h + 22), code, font=font, fill=INK)
    return img


def outlined(d, shape, xy, fill, width=10, **kw):
    getattr(d, shape)(xy, fill=fill, outline=INK, width=width, **kw)


def draw(size=(1080, 1900), barcode_center=(540, 948)):
    S = 2  # supersample
    W, H = size[0] * S, size[1] * S
    img = Image.new('RGBA', (W, H))
    d = ImageDraw.Draw(img)

    # kitchen wall: soft mint gradient + tile grid, wooden counter at the bottom
    for y in range(H):
        t = y / H
        d.line([(0, y), (W, y)], fill=(round(232 - 20 * t), round(244 - 14 * t), round(236 - 18 * t), 255))
    tile = 180 * S
    for x in range(0, W, tile):
        d.line([(x, 0), (x, H * 0.72)], fill=(214, 230, 220, 255), width=4)
    for y in range(0, int(H * 0.72), tile):
        d.line([(0, y), (W, y)], fill=(214, 230, 220, 255), width=4)
    d.rectangle([0, H * 0.72, W, H], fill=(214, 170, 120, 255))
    d.rectangle([0, H * 0.72, W, H * 0.72 + 26 * S], fill=(190, 145, 98, 255))
    # a few friendly props on the counter
    outlined(d, 'ellipse', [110 * S, H * 0.66, 330 * S, H * 0.66 + 220 * S], (255, 107, 107, 255), 8 * S)  # tomato
    d.polygon([(200 * S, H * 0.66 + 10 * S), (220 * S, H * 0.66 - 30 * S), (250 * S, H * 0.66 + 14 * S)], fill=(76, 175, 80, 255))
    outlined(d, 'rounded_rectangle', [360 * S, H * 0.60, 500 * S, H * 0.74], (255, 255, 255, 255), 8 * S, radius=30 * S)  # milk
    outlined(d, 'rectangle', [360 * S, H * 0.635, 500 * S, H * 0.68], (100, 181, 246, 255), 8 * S)

    # snack box (drawn upright, then rotated a little)
    bw, bh = 700 * S, 900 * S
    box = Image.new('RGBA', (bw + 60 * S, bh + 60 * S))
    b = ImageDraw.Draw(box)
    o = 30 * S
    outlined(b, 'rounded_rectangle', [o + 40 * S, o - 20 * S, o + bw + 40 * S, o + bh - 20 * S], BOX_SIDE, 10 * S, radius=36 * S)
    outlined(b, 'rounded_rectangle', [o, o, o + bw, o + bh], BOX, 10 * S, radius=36 * S)
    # cookie mascot on the pack
    cx, cy = o + bw // 2, o + 190 * S
    outlined(b, 'ellipse', [cx - 130 * S, cy - 130 * S, cx + 130 * S, cy + 130 * S], (196, 132, 76, 255), 10 * S)
    for dx, dy in ((-60, -40), (50, -60), (-20, 50), (70, 40)):
        b.ellipse([cx + (dx - 18) * S, cy + (dy - 18) * S, cx + (dx + 18) * S, cy + (dy + 18) * S], fill=(92, 58, 33, 255))
    b.ellipse([cx - 55 * S, cy - 15 * S, cx - 30 * S, cy + 10 * S], fill=INK)
    b.ellipse([cx + 30 * S, cy - 15 * S, cx + 55 * S, cy + 10 * S], fill=INK)
    b.arc([cx - 40 * S, cy + 5 * S, cx + 40 * S, cy + 60 * S], 20, 160, fill=INK, width=8 * S)
    # barcode panel
    font = ImageFont.truetype(r'C:\Windows\Fonts\consolab.ttf', 44 * S)
    code = barcode('4712345678904', 560 * S, 300 * S, font)
    panel = [o + (bw - 600 * S) // 2, o + bh - 380 * S, o + (bw + 600 * S) // 2, o + bh - 40 * S]
    outlined(b, 'rounded_rectangle', panel, (255, 255, 255, 255), 8 * S, radius=24 * S)
    box.alpha_composite(code, (panel[0] + 20 * S, panel[1] + 20 * S))
    box = box.rotate(-6, resample=Image.BICUBIC, expand=True)

    # place so the barcode sits in the scan frame
    bx = barcode_center[0] * S - box.width // 2
    by = barcode_center[1] * S - int(box.height * 0.74)
    img.alpha_composite(box, (bx, by))

    # hand from bottom-right: sleeve, palm under the box, thumb on the front
    d = ImageDraw.Draw(img)
    right, bottom = bx + box.width, by + box.height
    d.polygon([(right - 40 * S, bottom + 40 * S), (W + 40 * S, bottom - 80 * S), (W + 40 * S, H + 40 * S), (right - 260 * S, H + 40 * S)],
              fill=SLEEVE, outline=INK, width=10 * S)
    d.line([(right - 90 * S, bottom + 150 * S), (W, bottom + 40 * S)], fill=SLEEVE_SHADE, width=26 * S)
    palm = [right - 330 * S, bottom - 170 * S, right + 20 * S, bottom + 120 * S]
    outlined(d, 'ellipse', palm, SKIN, 10 * S)
    for i in range(3):  # fingers wrapping the right edge
        y = bottom - 470 * S + i * 110 * S
        outlined(d, 'rounded_rectangle', [right - 120 * S, y, right + 10 * S, y + 100 * S], SKIN, 10 * S, radius=50 * S)
    thumb = Image.new('RGBA', (320 * S, 130 * S))
    t = ImageDraw.Draw(thumb)
    outlined(t, 'rounded_rectangle', [5 * S, 5 * S, 315 * S, 125 * S], SKIN, 10 * S, radius=60 * S)
    t.ellipse([30 * S, 35 * S, 90 * S, 95 * S], fill=SKIN_SHADE)  # nail hint
    thumb = thumb.rotate(55, resample=Image.BICUBIC, expand=True)
    img.alpha_composite(thumb, (right - 330 * S, bottom - 300 * S))

    return img.resize(size, Image.LANCZOS)


if __name__ == '__main__':
    draw().save('scan_illustration_preview.png')

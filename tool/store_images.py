"""Builds Google Play marketing images from the raw screenshots.

    python tool/store_images.py

Input : screenshots/<locale>/NN_name.png   (from tool/capture_screenshots.py)
Output: fastlane/metadata/android/<locale>/images/phoneScreenshots/*.png  (1080x1920)
        fastlane/metadata/android/<locale>/images/featureGraphic.png      (1024x500)
Needs Pillow and the Windows fonts listed in FONTS (swap paths on other OSes).
"""
import os
import sys

from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageOps

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import scan_illustration  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONTS = {
    'en-US': r'C:\Windows\Fonts\segoeuib.ttf',
    'zh-TW': r'C:\Windows\Fonts\msjhbd.ttc',
    'ja-JP': r'C:\Windows\Fonts\YuGothB.ttc',
}
GREEN, GREEN_DARK = (47, 125, 91), (24, 74, 53)
NIGHT, NIGHT_DARK = (27, 33, 30), (10, 13, 12)

# (screenshot, dark background?, {locale: (headline, subline)})
SLIDES = [
    ('01_home_light', False, {
        'en-US': ('Use food before\nit goes bad', 'See what expires first — at a glance'),
        'zh-TW': ('食材過期前\n提醒你用掉', '什麼快過期，一眼就知道'),
        'ja-JP': ('食材を期限内に\n使い切ろう', '期限が近いものがひと目でわかる'),
    }),
    ('03_add_light', False, {
        'en-US': ('Add in two taps', 'Pick a food — name, category and date are filled in'),
        'zh-TW': ('點兩下就新增', '選一個常用食材，名稱、類別、日期自動填好'),
        'ja-JP': ('2タップで追加', 'よく使う食材を選ぶだけで名前も期限も自動入力'),
    }),
    ('11_scan', False, {
        'en-US': ('Scan the barcode', 'Product names filled in — and remembered'),
        'zh-TW': ('掃條碼自動帶入', '查到品名自動填入，輸入過的也會記住'),
        'ja-JP': ('バーコードで入力', '商品名を自動入力、入力した名前も記憶'),
    }),
    ('02_home_dark', True, {
        'en-US': ('Dark mode', 'Easy on the eyes, day and night'),
        'zh-TW': ('深色模式', '白天晚上都好看'),
        'ja-JP': ('ダークモード', '昼も夜も見やすい'),
    }),
    ('05_settings_light', False, {
        'en-US': ('Daily reminder', 'Your time, your "expiring soon" range'),
        'zh-TW': ('每日到期提醒', '提醒時間、到期範圍都能自訂'),
        'ja-JP': ('毎日お知らせ', '通知時間も「期限間近」の範囲も自由に'),
    }),
]

TAGLINE = {  # feature graphic; must stay left of the phone (≈ 560 px)
    'en-US': 'Use food before\nit goes bad',
    'zh-TW': '食材過期前\n提醒你用掉',
    'ja-JP': '食材を期限内に\n使い切ろう',
}


def gradient(size, top, bottom):
    w, h = size
    img = Image.new('RGB', size, top)
    px = ImageDraw.Draw(img)
    for y in range(h):
        t = y / (h - 1)
        px.line([(0, y), (w, y)], fill=tuple(round(a + (b - a) * t) for a, b in zip(top, bottom)))
    return img


def phone(shot_path, width):
    """Screenshot (path or Image) in a rounded dark bezel with a soft shadow."""
    shot = (shot_path if isinstance(shot_path, Image.Image) else Image.open(shot_path)).convert('RGB')
    h = round(shot.height * width / shot.width)
    shot = shot.resize((width, h), Image.LANCZOS)
    bezel, radius = 18, 56
    W, H = width + 2 * bezel, h + 2 * bezel
    frame = Image.new('RGBA', (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(frame).rounded_rectangle([0, 0, W - 1, H - 1], radius + bezel, fill=(17, 20, 18, 255))
    mask = Image.new('L', (width, h), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, width - 1, h - 1], radius, fill=255)
    frame.paste(shot, (bezel, bezel), mask)
    pad = 60
    out = Image.new('RGBA', (W + 2 * pad, H + 2 * pad), (0, 0, 0, 0))
    shadow = Image.new('RGBA', out.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle([pad, pad + 20, pad + W, pad + H + 20], radius + bezel, fill=(0, 0, 0, 110))
    out = Image.alpha_composite(out, shadow.filter(ImageFilter.GaussianBlur(28)))
    out.alpha_composite(frame, (pad, pad))
    return out


def centered(draw, text, font, y, fill, canvas_w, spacing=12):
    box = draw.multiline_textbbox((0, 0), text, font=font, align='center', spacing=spacing)
    draw.multiline_text(((canvas_w - (box[2] - box[0])) / 2, y), text, font=font, fill=fill,
                        align='center', spacing=spacing)
    return y + box[3] - box[1]


def scan_screen(locale):
    """Real scanner UI (captured over a black camera) with a friendly scene
    behind it: tool/assets/scan_background.png if present, else the cartoon."""
    ov = Image.open(os.path.join(ROOT, 'screenshots', locale, 'scan_overlay.png')).convert('RGB')
    W, H = ov.size
    top = 262  # status bar + app bar stay as captured
    gray = ov.convert('L')
    rows = [y for y in range(top, H - 400) if sum(gray.crop((0, y, W, y + 1)).point(lambda v: v > 200).get_flattened_data()) > 300]
    center_y = (rows[0] + rows[-1]) // 2 if rows else (top + H) // 2
    custom = os.path.join(ROOT, 'tool', 'assets', 'scan_background.png')
    size = (W, H - top)
    if os.path.exists(custom):
        bg = ImageOps.fit(Image.open(custom).convert('RGB'), size, Image.LANCZOS)
    else:
        bg = scan_illustration.draw(size, (W // 2, center_y - top)).convert('RGB')
    # same bottom scrim as the app (200 dp, transparent → black54)
    scrim_h = 525
    scrim = Image.new('L', (W, scrim_h))
    for y in range(scrim_h):
        ImageDraw.Draw(scrim).line([(0, y), (W, y)], fill=round(138 * y / scrim_h))
    bg.paste((0, 0, 0), (0, bg.height - scrim_h), scrim)
    out = ov.copy()
    below = ov.crop((0, top, W, H))
    mask = below.convert('L').point(lambda v: min(255, v * 2))  # UI is light on black
    scene = bg.copy()
    scene.paste(below, (0, 0), mask)
    out.paste(scene, (0, top))
    return out


def slide(locale, shot, dark, headline, subline):
    W, H = 1080, 1920
    img = gradient((W, H), *((NIGHT, NIGHT_DARK) if dark else (GREEN, GREEN_DARK))).convert('RGBA')
    d = ImageDraw.Draw(img)
    y = centered(d, headline, ImageFont.truetype(FONTS[locale], 88), 130, 'white', W)
    y = centered(d, subline, ImageFont.truetype(FONTS[locale], 40), y + 44, (230, 240, 235), W)
    src = scan_screen(locale) if shot == '11_scan' else os.path.join(ROOT, 'screenshots', locale, shot + '.png')
    p = phone(src, 760)
    img.alpha_composite(p, ((W - p.width) // 2, y + 20))  # bleeds off the bottom on purpose
    return img.convert('RGB')


def feature_graphic(locale, tagline):
    W, H = 1024, 500
    img = gradient((W, H), GREEN, GREEN_DARK).convert('RGBA')
    d = ImageDraw.Draw(img)
    logo = Image.open(os.path.join(ROOT, 'assets', 'images', 'appLogo.png')).convert('RGBA').resize((112, 112))
    img.alpha_composite(logo, (64, 96))
    d.text((64, 228), 'FoodList', font=ImageFont.truetype(FONTS['en-US'], 76), fill='white')
    d.multiline_text((66, 330), tagline, font=ImageFont.truetype(FONTS[locale], 34),
                     fill=(230, 240, 235), spacing=10)
    p = phone(os.path.join(ROOT, 'screenshots', locale, '01_home_light.png'), 300)
    img.alpha_composite(p, (W - p.width + 10, 40))
    return img.convert('RGB')


if __name__ == '__main__':
    for locale in FONTS:
        out = os.path.join(ROOT, 'fastlane', 'metadata', 'android', locale, 'images')
        os.makedirs(os.path.join(out, 'phoneScreenshots'), exist_ok=True)
        for i, (shot, dark, text) in enumerate(SLIDES, 1):
            slide(locale, shot, dark, *text[locale]).save(
                os.path.join(out, 'phoneScreenshots', f'{i:02d}_{shot[3:]}.png'), optimize=True)
        feature_graphic(locale, TAGLINE[locale]).save(
            os.path.join(out, 'featureGraphic.png'), optimize=True)
        print('done', locale)

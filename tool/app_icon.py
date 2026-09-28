"""Draws the FoodList icon set: three status bars (expired / soon / fresh)
on the brand green. Writes Android launcher + notification icons, iOS, macOS,
web and Windows icons, assets/images/appLogo.png and the Play Store icon.

    python tool/app_icon.py
"""
import os
from PIL import Image, ImageDraw

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RES = os.path.join(ROOT, 'android', 'app', 'src', 'main', 'res')
GREEN = (47, 125, 91, 255)
BARS = [(255, 107, 107, 255), (255, 194, 75, 255), (178, 240, 206, 255)]  # red, amber, mint
S = 4  # supersampling


def bars(size, colors, scale):
    """Three rounded bars centred in a size×size RGBA canvas. `scale` = share
    of the canvas the bar block occupies (adaptive icons need the safe zone)."""
    big = size * S
    img = Image.new('RGBA', (big, big), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    block = big * scale
    bar_h, gap = block * 0.22, block * 0.17
    widths = [1.0, 0.82, 0.64]  # shorter as they go — reads as "time running down"
    top = (big - (3 * bar_h + 2 * gap)) / 2
    left = (big - block) / 2
    for i, (w, c) in enumerate(zip(widths, colors)):
        y = top + i * (bar_h + gap)
        d.rounded_rectangle([left, y, left + block * w, y + bar_h], bar_h / 2, fill=c)
    return img.resize((size, size), Image.LANCZOS)


def full_icon(size, radius_share=0.22):
    big = size * S
    img = Image.new('RGBA', (big, big), (0, 0, 0, 0))
    ImageDraw.Draw(img).rounded_rectangle([0, 0, big - 1, big - 1], big * radius_share, fill=GREEN)
    img = img.resize((size, size), Image.LANCZOS)
    img.alpha_composite(bars(size, BARS, 0.56))
    return img


def write_platform_icons():
    import glob
    # Android status-bar icon: white silhouette on transparent, 24 dp
    # (Android tints it; colour is ignored). Bars fill the 20 dp live area.
    for name, px in {'drawable': 24, 'drawable-mdpi': 24, 'drawable-hdpi': 36,
                     'drawable-xhdpi': 48, 'drawable-xxhdpi': 72, 'drawable-xxxhdpi': 96}.items():
        bars(px, [(255, 255, 255, 255)] * 3, 0.80).save(os.path.join(RES, name, 'ic_stat_foodlist.png'))
    # iOS: full-bleed square, opaque (the system applies the mask)
    for f in glob.glob(os.path.join(ROOT, 'ios', 'Runner', 'Assets.xcassets', 'AppIcon.appiconset', '*.png')):
        n = Image.open(f).size[0]
        full_icon(n, radius_share=0).convert('RGB').save(f)
    # macOS: rounded square with the standard ~10 % transparent margin
    for f in glob.glob(os.path.join(ROOT, 'macos', 'Runner', 'Assets.xcassets', 'AppIcon.appiconset', '*.png')):
        n = Image.open(f).size[0]
        img = Image.new('RGBA', (n, n))
        inner = round(n * 0.8)
        img.alpha_composite(full_icon(inner), ((n - inner) // 2, (n - inner) // 2))
        img.save(f)
    # Web: favicon + PWA icons (maskable ones keep content in the 80 % safe zone)
    web = os.path.join(ROOT, 'web')
    full_icon(32).save(os.path.join(web, 'favicon.png'))
    for n in (192, 512):
        full_icon(n).save(os.path.join(web, 'icons', f'Icon-{n}.png'))
        m = Image.new('RGBA', (n, n), GREEN)
        m.alpha_composite(bars(n, BARS, 0.45))
        m.save(os.path.join(web, 'icons', f'Icon-maskable-{n}.png'))
    # Windows
    full_icon(256).save(os.path.join(ROOT, 'windows', 'runner', 'resources', 'app_icon.ico'),
                        sizes=[(16, 16), (24, 24), (32, 32), (48, 48), (64, 64), (256, 256)])


if __name__ == '__main__':
    write_platform_icons()
    dens = {'mdpi': 1, 'hdpi': 1.5, 'xhdpi': 2, 'xxhdpi': 3, 'xxxhdpi': 4}
    for name, k in dens.items():
        d = os.path.join(RES, f'mipmap-{name}')
        full_icon(round(48 * k)).save(os.path.join(d, 'ic_launcher.png'))
        a = round(108 * k)  # adaptive layers: 108dp, visible safe zone ≈ 66dp
        Image.new('RGBA', (a, a), GREEN).save(os.path.join(d, 'ic_launcher_background.png'))
        bars(a, BARS, 0.40).save(os.path.join(d, 'ic_launcher_foreground.png'))
        bars(a, [(255, 255, 255, 255)] * 3, 0.40).save(os.path.join(d, 'ic_launcher_monochrome.png'))
    full_icon(512).save(os.path.join(ROOT, 'assets', 'images', 'appLogo.png'))
    for loc in ('en-US', 'zh-TW', 'ja-JP', 'zh-CN'):
        out = os.path.join(ROOT, 'fastlane', 'metadata', 'android', loc, 'images')
        os.makedirs(out, exist_ok=True)
        full_icon(512, radius_share=0).convert('RGB').save(os.path.join(out, 'icon.png'))  # Play masks it
    print('icons written')

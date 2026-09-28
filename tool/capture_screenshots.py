"""Captures raw store screenshots from a running emulator (release build).

Needs: a rooted emulator image (google_apis, not google_play), 1080-wide screen.
    flutter build apk --release --split-per-abi --target-platform android-x64
    adb install -r build/app/outputs/flutter-apk/app-x86_64-release.apk
    dart run tool/make_seed.dart build/seed
    python tool/capture_screenshots.py
Output: screenshots/<locale>/NN_name.png, then run tool/store_images.py.
Tip: start the emulator with `-camera-back virtualscene` for the scan shot.
"""
import subprocess, time, re, os, sys
ADB = os.path.expandvars(r'%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe')
PKG = 'com.forgerwise.foodlist'
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SP = os.path.join(ROOT, 'build')
OUT = os.path.join(ROOT, 'screenshots')
LOCALES = {'en': 'en-US', 'zh_TW': 'zh-TW', 'ja': 'ja-JP'}
LABEL = {  # nav + FAB labels per language
  'en': {'settings': 'Settings', 'add': 'Add', 'home': 'Home', 'pick': 'Chicken', 'scan': 'Scan barcode'},
  'zh_TW': {'settings': '設定', 'add': '新增', 'home': '首頁', 'pick': '雞肉', 'scan': '掃描條碼'},
  'ja': {'settings': '設定', 'add': '追加', 'home': 'ホーム', 'pick': '鶏肉', 'scan': 'バーコードをスキャン'},
}

def adb(*a, check=True):
    r = subprocess.run([ADB, *a], capture_output=True)
    return r.stdout

def sh(cmd): return adb('shell', cmd).decode('utf-8', 'ignore')

def prefs_xml(lang, theme, welcome=False):
    return ("<?xml version='1.0' encoding='utf-8' standalone='yes' ?>\n<map>\n"
            f'    <string name="flutter.selectedLanguage">{lang}</string>\n'
            f'    <long name="flutter.theme_mode" value="{theme}" />\n'
            f'    <boolean name="flutter.onboarding_v1_shown" value="{"false" if welcome else "true"}" />\n'
            '    <boolean name="flutter.notificationsEnabled" value="true" />\n'
            '</map>\n')

def reset(lang, theme, seeded, welcome=False):
    sh(f'am force-stop {PKG}; pm clear {PKG}')
    uid = sh(f'stat -c %u /data/data/{PKG}').strip()
    d = f'/data/data/{PKG}'
    sh(f'mkdir -p {d}/shared_prefs {d}/app_flutter')
    p = os.path.join(SP, 'prefs.xml')
    open(p, 'w', encoding='utf-8').write(prefs_xml(lang, theme, welcome))
    adb('push', p, f'{d}/shared_prefs/FlutterSharedPreferences.xml')
    if seeded:
        adb('push', os.path.join(SP, 'seed', lang, 'mybox.hive'), f'{d}/app_flutter/mybox.hive')
    sh(f'chown -R {uid}:{uid} {d}/shared_prefs {d}/app_flutter; restorecon -R {d}')
    sh(f'cmd uimode night {"yes" if theme == 2 else "no"}')
    sh(f'pm grant {PKG} android.permission.POST_NOTIFICATIONS')
    sh('input keyevent KEYCODE_WAKEUP'); sh(f'am start -n {PKG}/.MainActivity')
    time.sleep(5)

def tap_text(text):
    sh('uiautomator dump /sdcard/ui.xml')
    xml = sh('cat /sdcard/ui.xml')
    for m in re.finditer(r'<node [^>]*>', xml):
        n = m.group(0)
        if re.search(r'(text|content-desc)="' + re.escape(text) + r'(&#10;[^"]*)?"', n):
            b = list(map(int, re.findall(r'\d+', re.search(r'bounds="([^"]+)"', n).group(1))))
            sh(f'input tap {(b[0]+b[2])//2} {(b[1]+b[3])//2}')
            time.sleep(1.5)
            return True
    print('  !! not found:', text); return False

def shot(lang, name):
    d = os.path.join(OUT, LOCALES[lang])
    os.makedirs(d, exist_ok=True)
    png = adb('exec-out', 'screencap -p')
    n, _, rest = name.partition('_')
    fname = f'{int(n):02d}_{rest}.png' if n.isdigit() else name + '.png'
    open(os.path.join(d, fname), 'wb').write(png)
    print('  saved', LOCALES[lang], name)

def scan_overlays():
    """Scanner UI over a black camera (start the emulator with
    `-camera-back none`): store_images.py puts its own background behind it."""
    for lang in LOCALES:
        reset(lang, 1, seeded=True)
        sh(f'pm grant {PKG} android.permission.CAMERA')
        tap_text(LABEL[lang]['add']); time.sleep(1)
        tap_text(LABEL[lang]['scan']); time.sleep(4)
        shot(lang, 'scan_overlay')


if __name__ == '__main__' and '--scan-overlay' in sys.argv:
    sh('wm size 1080x2160')
    sh('settings put global sysui_demo_allowed 1')
    for c in ('enter', 'clock -e hhmm 1000', 'battery -e level 100 -e plugged false',
              'network -e wifi show -e level 4', 'notifications -e visible false'):
        sh(f'am broadcast -a com.android.systemui.demo -e command {c}')
    scan_overlays()
elif __name__ == '__main__':
    # Clean status bar: 10:00, full battery, no notification icons; 2:1 screen for Play.
    sh('wm size 1080x2160')
    sh('settings put global sysui_demo_allowed 1')
    for c in ('enter', 'clock -e hhmm 1000', 'battery -e level 100 -e plugged false',
              'network -e wifi show -e level 4', 'notifications -e visible false'):
        sh(f'am broadcast -a com.android.systemui.demo -e command {c}')
    for lang in LOCALES:
        for theme, tn in ((1, 'light'), (2, 'dark')):
            i = 1 if tn == 'light' else 2
            reset(lang, theme, seeded=True)
            shot(lang, f'{i}_home_{tn}')
            tap_text(LABEL[lang]['add']); time.sleep(1)
            tap_text(LABEL[lang]['pick']); time.sleep(1)
            shot(lang, f'{i+2}_add_{tn}')
            if tn == 'light':
                sh(f'pm grant {PKG} android.permission.CAMERA')
                tap_text(LABEL[lang]['scan']); time.sleep(7)
                shot(lang, '11_scan')
                sh('input keyevent KEYCODE_BACK'); time.sleep(1.5)
            sh('input keyevent KEYCODE_BACK'); time.sleep(1.5)
            tap_text(LABEL[lang]['settings'])
            shot(lang, f'{i+4}_settings_{tn}')
            reset(lang, theme, seeded=False)
            shot(lang, f'{i+6}_empty_{tn}')
            reset(lang, theme, seeded=False, welcome=True)
            shot(lang, f'{i+8}_welcome_{tn}')
    
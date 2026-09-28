# Contributing to FoodList

Thanks for helping! Bug reports, translations, product-name fixes and small focused PRs are all welcome.

## Quick start

1. Install **Flutter 3.47.x** (stable) and JDK 17.
2. `flutter pub get`
3. `flutter run` on an Android device or emulator.

Optional — Japanese barcode names via Yahoo! Shopping: register a free Client ID at [Yahoo! Developer Network](https://e.developer.yahoo.co.jp/register), copy `dart_defines.example.json` to `dart_defines.json` (git-ignored), put the ID in it, and run with `--dart-define-from-file=dart_defines.json`. Without it, lookups use Open Food Facts only.

## Branches

- `main` — released versions only.
- `develop` — integration branch. **Open PRs against `develop`.**
- Feature branches: `feature/<short-name>`, fixes: `fix/<short-name>`.

## Before you push

CI runs the same checks on every PR; they must pass before merging.

```sh
dart run intl_utils:generate   # if you changed any .arb file
dart format lib test
flutter analyze
flutter test
```

## Guidelines

- **Keep it simple.** Read [docs/DESIGN.md](docs/DESIGN.md). A small feature that fits beats a big one that adds screens or settings.
- **UI text** goes in all three `lib/l10n/intl_*.arb` files. If you don't speak a language, add the English text there and mention it in the PR — a maintainer will translate.
- **Colours** come from `lib/util/theme.dart` only, so dark mode keeps working.
- **Stored data** must stay backwards compatible. Read the "Data format history" section in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) and add a case to `test/migration_test.dart`.
- **Tests:** add one small test for any non-trivial logic (parsing, date maths, migrations). UI-only changes need a screenshot instead.
- **Dependencies:** avoid new packages when a few lines will do. Plugins that fail on Android Gradle Plugin 9 are vendored in `third_party/` with a patched Gradle file.
- **Commits:** short imperative subject, e.g. `fix(add): keep category when editing`. Conventional-commit prefixes (`feat`, `fix`, `docs`, `refactor`, `test`, `chore`) are appreciated.
- Update `CHANGELOG.md` under **Unreleased** for anything users will notice.

## Missing product names

Names come from [Open Food Facts](https://world.openfoodfacts.org/). If a barcode isn't found, add the product there (free, takes a minute) — every FoodList user benefits.

## Releasing (maintainers)

Write the notes under **[Unreleased]** in `CHANGELOG.md`, then from `develop`:

```powershell
pwsh tool/release.ps1 -Bump patch   # or minor / major; -DryRun to only build
```

It bumps the version, runs the CI checks, builds the signed AAB + APKs with
`--dart-define-from-file=dart_defines.json` (obfuscated, symbols kept),
verifies the release certificate, archives everything to `releases/vX.Y.Z/`,
merges `develop` → `main` through a PR once CI passes, tags, and publishes a
GitHub Release in the usual format (title `vX.Y.Z`, one `FoodList-vX.Y.Z.apk`). Upload the AAB (and the debug-symbols zip) to
Play Console yourself. Keep "Web Services by Yahoo! JAPAN" on the store listing.

## Store screenshots & listing (maintainers)

Everything for Google Play lives in `fastlane/metadata/android/<locale>/` (title, descriptions, marketing screenshots, feature graphic, icon). Raw app screenshots live in `screenshots/<locale>/`. To refresh after UI changes:

```sh
flutter build apk --release --split-per-abi --target-platform android-x64
adb install -r build/app/outputs/flutter-apk/app-x86_64-release.apk   # rooted google_apis emulator
dart run tool/make_seed.dart build/seed
python tool/capture_screenshots.py     # → screenshots/  (emulator: -camera-back virtualscene)
python tool/capture_screenshots.py --scan-overlay   # emulator restarted with -camera-back none
python tool/prepare_scan_photo.py <photo.jpg>   # optional: real photo behind the scan slide
python tool/store_images.py            # → fastlane/…/phoneScreenshots + featureGraphic
python tool/app_icon.py                # only if the icon changes
```

## Code of conduct

Be kind and constructive. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

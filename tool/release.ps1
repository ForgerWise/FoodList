<#
FoodList release builder.

  pwsh tool/release.ps1 -Bump patch          # 3.1.0 → 3.1.1, full release
  pwsh tool/release.ps1 -Bump none           # release the version already in pubspec
  pwsh tool/release.ps1 -Bump minor -DryRun  # checks + build + archive only, no Git/GitHub

Steps: preflight → version bump → checks (format, l10n, analyze, test) →
build AAB + APKs (--dart-define-from-file, obfuscated, symbols kept) →
verify release signature → archive to releases/vX.Y.Z (git-ignored) with
SHA-256 sums → commit + push develop → PR develop→main, wait for CI, merge →
tag → GitHub Release (title "vX.Y.Z", one asset "FoodList-vX.Y.Z.apk", same
notes layout as earlier releases). Split APKs, AAB, symbols and SHA-256 sums
stay in releases/vX.Y.Z; the AAB is for Play Console (manual).
#>
param(
    [ValidateSet('patch', 'minor', 'major', 'none')] [string] $Bump = 'patch',
    [switch] $DryRun
)
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)

# SHA-256 of the upload/release certificate (CN=ForegerWise). Public, safe to commit.
$ExpectedCert = 'a16b44f79c7a1cc084f6f06022027babbaacdd0fa9ac7dd01ea2d5963ca5ceca'

function Step($text) { Write-Host "`n==> $text" -ForegroundColor Green }
function Fail($text) { Write-Host "✗ $text" -ForegroundColor Red; exit 1 }
function Run {
    param([Parameter(ValueFromRemainingArguments)] $cmd)
    & $cmd[0] @($cmd | Select-Object -Skip 1)
    if ($LASTEXITCODE -ne 0) { Fail "$($cmd -join ' ') failed ($LASTEXITCODE)" }
}

# ── 1. Preflight ─────────────────────────────────────────────────────────────
Step 'Preflight'
if (git status --porcelain) { Fail 'Working tree is not clean — commit or stash first.' }
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne 'develop') { Fail "Release from 'develop' (currently on '$branch')." }
Run git fetch origin --quiet
if ((git rev-list --count HEAD..origin/develop) -ne '0') { Fail 'develop is behind origin/develop — pull first.' }
if (-not (Test-Path dart_defines.json)) { Fail 'dart_defines.json missing (copy dart_defines.example.json).' }
$defines = Get-Content dart_defines.json -Raw | ConvertFrom-Json
if (-not $defines.YAHOO_JP_APPID) { Fail 'YAHOO_JP_APPID is empty in dart_defines.json.' }
if (-not (Test-Path android/key.properties)) { Fail 'android/key.properties missing — cannot sign.' }
if (-not $DryRun) { gh auth status *> $null; if ($LASTEXITCODE -ne 0) { Fail 'gh is not logged in (gh auth login).' } }
$apksigner = Get-ChildItem "$env:LOCALAPPDATA/Android/Sdk/build-tools/*/lib/apksigner.jar" |
    Sort-Object FullName | Select-Object -Last 1
if (-not $apksigner) { Fail 'apksigner not found in Android SDK build-tools.' }

# ── 2. Version ───────────────────────────────────────────────────────────────
$pubspec = Get-Content pubspec.yaml -Raw
if ($pubspec -notmatch '(?m)^version:\s*(\d+)\.(\d+)\.(\d+)\+(\d+)') { Fail 'Cannot read version from pubspec.yaml.' }
[int]$maj, [int]$min, [int]$pat, [int]$build = $Matches[1..4]
switch ($Bump) {
    'major' { $maj++; $min = 0; $pat = 0 }
    'minor' { $min++; $pat = 0 }
    'patch' { $pat++ }
}
if ($Bump -ne 'none') { $build++ }
$version = "$maj.$min.$pat"; $tag = "v$version"
Step "Version $version+$build"
if (git tag --list $tag) { Fail "Tag $tag already exists." }

# Play Console release notes: fastlane/metadata/android/<locale>/changelogs/<build>.txt
# (≤ 3 short lines, Play limit 500 chars). Assembled into play-release-notes.txt below.
$PlayLocales = 'en-US', 'ja-JP', 'zh-CN', 'zh-TW'
foreach ($loc in $PlayLocales) {
    $f = "fastlane/metadata/android/$loc/changelogs/$build.txt"
    if (-not (Test-Path $f)) { Fail "Missing Play release notes: $f (≤ 3 lines)." }
    $text = (Get-Content $f -Raw -Encoding utf8).Trim()
    if ($text.Length -gt 500) { Fail "$f is $($text.Length) chars; Play allows 500." }
    if (($text -split "`n").Count -gt 3) { Fail "$f has more than 3 lines." }
}

$changelog = Get-Content CHANGELOG.md -Raw
if ($Bump -ne 'none') {
    # Move "Unreleased" notes under the new version.
    if ($changelog -notmatch '(?s)## \[Unreleased\]\s*\n(.*?)\n## \[') { Fail 'CHANGELOG.md has no [Unreleased] section.' }
    if (-not $Matches[1].Trim()) { Fail 'CHANGELOG [Unreleased] is empty — write the release notes first.' }
    $date = Get-Date -Format 'yyyy-MM-dd'
    $changelog = $changelog -replace '## \[Unreleased\]\s*\n', "## [Unreleased]`n`n## [$version] — $date`n"
    if (-not $DryRun) {
        Set-Content CHANGELOG.md $changelog -NoNewline -Encoding utf8
        $pubspec = $pubspec -replace '(?m)^version:\s*\S+', "version: $version+$build"
        Set-Content pubspec.yaml $pubspec -NoNewline -Encoding utf8
    }
}
if ($changelog -notmatch "(?s)## \[$([regex]::Escape($version))\][^\n]*\n(.*?)(\n## \[|\z)") { Fail "CHANGELOG.md has no section for $version." }
$notes = $Matches[1].Trim()

# ── 3. Checks (same as CI) ───────────────────────────────────────────────────
Step 'Checks'
Run flutter pub get
Run dart format --output=none --set-exit-if-changed lib test
Run dart run intl_utils:generate
Run dart format lib/generated
if (git status --porcelain lib/generated) { Fail 'lib/generated was stale — commit the regenerated files first.' }
Run flutter analyze
Run flutter test

# ── 4. Build ─────────────────────────────────────────────────────────────────
$out = "releases/$tag"
if (Test-Path $out) { Remove-Item $out -Recurse -Force }
New-Item -ItemType Directory $out, "$out/symbols" | Out-Null
$common = @('--release', '--dart-define-from-file=dart_defines.json', '--obfuscate', "--split-debug-info=$out/symbols")
Step 'Build AAB (Play Console)'
Run flutter build appbundle @common
Step 'Build APKs (GitHub)'
Run flutter build apk @common --split-per-abi
Run flutter build apk @common

# ── 5. Verify signatures & collect ───────────────────────────────────────────
Step 'Verify signatures'
$apkDir = 'build/app/outputs/flutter-apk'
$artifacts = @{
    "$apkDir/app-arm64-v8a-release.apk"   = "FoodList-$tag-arm64-v8a.apk"
    "$apkDir/app-armeabi-v7a-release.apk" = "FoodList-$tag-armeabi-v7a.apk"
    "$apkDir/app-x86_64-release.apk"      = "FoodList-$tag-x86_64.apk"
    "$apkDir/app-release.apk"             = "FoodList-$tag-universal.apk"
}
foreach ($src in $artifacts.Keys) {
    $certs = java -jar $apksigner.FullName verify --print-certs $src
    if ($LASTEXITCODE -ne 0) { Fail "Signature check failed: $src" }
    if (-not ($certs -match "SHA-256 digest: $ExpectedCert")) { Fail "$src is not signed with the release key." }
    Copy-Item $src "$out/$($artifacts[$src])"
}
Copy-Item build/app/outputs/bundle/release/app-release.aab "$out/FoodList-$tag.aab"
$mapping = 'build/app/outputs/mapping/release/mapping.txt'
if (Test-Path $mapping) { Copy-Item $mapping "$out/r8-mapping.txt" }
Compress-Archive "$out/symbols/*" "$out/FoodList-$tag-debug-symbols.zip"
Get-ChildItem $out -File | ForEach-Object {
    "$((Get-FileHash $_.FullName -Algorithm SHA256).Hash.ToLower())  $($_.Name)"
} | Set-Content "$out/SHA256SUMS.txt" -Encoding utf8
# GitHub release body — same shape as every release since v2.x:
#   ## FoodList vX.Y.Z / bullet list / thank-you footer
# Short, user-facing list: the version's "### Highlights" if it has one,
# otherwise every bullet of the section.
$source = if ($notes -match '(?s)### Highlights\s*\n(.*?)(\n### |\z)') { $Matches[1] } else { $notes }
$bullets = ($source -split "`n" | Where-Object { $_ -match '^\s*- ' } | ForEach-Object { $_.Trim() -replace '\*\*', '' }) -join "`n"
@"
## FoodList $tag

$bullets

Thank you for using FoodList! We appreciate your feedback and support.
If you encounter any issues or have suggestions, please let us know.
"@ | Set-Content "$out/notes.md" -Encoding utf8
# Same asset name as previous releases: one universal APK.
Copy-Item "$out/FoodList-$tag-universal.apk" "$out/FoodList-$tag.apk"
# Ready to paste into Play Console → Release notes.
($PlayLocales | ForEach-Object {
    "<$_>`n$((Get-Content "fastlane/metadata/android/$_/changelogs/$build.txt" -Raw -Encoding utf8).Trim())`n</$_>"
}) -join "`n" | Set-Content "$out/play-release-notes.txt" -Encoding utf8
Write-Host "Archived to $out"

if ($DryRun) { Step "Dry run done — nothing pushed. Artifacts: $out"; exit 0 }

# ── 6. Git & GitHub ──────────────────────────────────────────────────────────
Step 'Commit & push develop'
Run git add pubspec.yaml CHANGELOG.md
if (git diff --cached --name-only) { Run git commit -m "chore(release): $tag" }
Run git push origin develop

Step 'PR develop → main (waits for CI)'
$pr = gh pr list --base main --head develop --state open --json number --jq '.[0].number'
if (-not $pr) {
    Run gh pr create --base main --head develop --title "Release $tag" --body $notes
    $pr = gh pr list --base main --head develop --state open --json number --jq '.[0].number'
}
Start-Sleep 10  # let GitHub register the checks
Run gh pr checks $pr --watch --fail-fast
Run gh pr merge $pr --merge --subject "Release $tag"

Step "Tag $tag on main"
Run git fetch origin main --quiet
Run git tag $tag origin/main   # lightweight, like earlier tags
Run git push origin $tag

Step 'GitHub Release'
Run gh release create $tag "$out/FoodList-$tag.apk" --title $tag --notes-file "$out/notes.md" --latest

# Bring develop up to date with the merge commit.
Run git pull origin main --no-edit
Run git push origin develop

Step 'Done'
Write-Host "GitHub: https://github.com/ForgerWise/FoodList/releases/tag/$tag"
Write-Host "Play Console: upload $out/FoodList-$tag.aab and $out/FoodList-$tag-debug-symbols.zip"
Write-Host "Release notes to paste: $out/play-release-notes.txt"

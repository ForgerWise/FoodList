# Changelog

All notable user-facing changes. Format based on [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

## [3.1.0] — 2026-09

### Highlights
- Add food faster: pick a common food and its name, category and expiry date are filled in for you
- Scan a barcode to fill in the product name, or take a photo to read the expiry date
- New look with dark mode
- Swipe "Used" to lower the quantity, with Undo
- Friendlier reminders and many bug fixes

### Added
- **Quick pick:** ~70 common foods (en / 繁中 / 日本語) with typical shelf life — tap one and name, category and expiry are filled in. Recently used items appear first.
- **Barcode scanning:** EAN/JAN/UPC, GS1 QR & DataMatrix (reads expiry dates), in-store labels for weighed food, and any other code as a personal shortcut. Names from Open Food Facts and Yahoo! Shopping (Japan); names you type are remembered offline.
- Expiry shortcuts (3 / 7 / 14 / 30 days) and "Save & add another".
- Dark mode (system / light / dark).
- Adjustable "expiring soon" range.
- Welcome dialog explaining tap-to-edit and swipe-to-delete.
- "Rate FoodList" in Settings, and an occasional Google Play rating prompt for active users.
- "Used one" swipe action: lowers the quantity (or removes the last one), with Undo.
- Delete button on the edit screen; "Nothing matches" state with Clear filters.
- Typing a known food name also fills in its typical shelf life; new items default to 7 days.
- Scanner: flashlight, zoom, tap-to-focus and higher resolution, so codes read from further away.
- Two new FAQ entries; data-source credits on the About page.
- **Read the expiry date from a photo** (on-device text recognition via Google Play services, ~100 KB). Handles Asian, European and US date formats; ambiguous day/month order follows the phone's region.
- Japanese product names via Yahoo!ショッピング (when built with a Client ID).
- Friendly daily notification when nothing expires today or tomorrow.

### Changed
- New design: fresh green theme, flat cards, status counters that double as filters, category chips only for categories in use.
- Tap an item to edit it (swipe left still deletes, with Undo).
- System back on Settings returns to Home.
- New app icon set (Android, notification, iOS, macOS, web, Windows) matching the new colours.
- Scanner: readable hint over bright scenes; localized message when the camera is unavailable.
- Language is picked from a sheet like the other settings; Feedback page simplified.
- Deleting a category moves its items to "Others" instead of leaving them without a category.
- Privacy policy updated for barcode lookups.

### Fixed
- Renaming a category no longer disconnects the items in it.
- Opening Settings no longer triggers the notification permission prompt.
- The list now refreshes after editing an item.
- "Expiring soon" meant different things in the counter and the filter.
- Daily notification could use the wrong language; removed an untranslated English line.
- Date picker crashed when editing an item that expired before last year.
- Colour contrast of status labels (orange/green) and of green text in dark mode.
- Japanese "expires today" wording; English plurals ("Expired 1 days ago").

### Removed
- The "Slide to delete" sample item (also cleaned up for existing users).

Earlier releases: see the [tags](https://github.com/ForgerWise/FoodList/tags).

# Design guidelines

FoodList has one job: help people use food before it goes bad. Every screen should be understandable in a few seconds by someone who has never seen it.

## Principles

1. **Fewer taps beat more options.** The common path — add a carrot, see what expires soon — must be the shortest. Adding an item takes two taps: pick a suggestion, save.
2. **Smart defaults, easy overrides.** Pre-fill what we can guess (name, category, expiry from typical shelf life, barcode data). Never force a field the app could fill.
3. **Colour means status, nothing else.** Red, orange and green are reserved for expiry status. Everything else uses the brand green or neutrals.
4. **One primary action per screen.** Home: Add. Add page: Save.
5. **Forgiving.** Deleting shows Undo. Settings changes apply immediately and are reversible.
6. **Local first.** Everything works offline; the network only improves barcode names.

## Colour

All colours come from `lib/util/theme.dart`. Do not write `Colors.grey`, `Colors.white` or hex values in widgets — they break dark mode.

| Token | Light | Dark | Use |
|---|---|---|---|
| `AppColors.primary` | `#2F7D5B` | same | Buttons, selected chips, icons, links |
| `AppColors.expired` | `#D64545` | same | Already expired |
| `AppColors.soon` | `#E58A1F` | same | Expires within the user's "soon" range (default today/tomorrow) |
| `AppColors.fresh` | `#2F9E6A` | same | Everything else |
| `context.c.background` | `#F6F7F4` | `#111513` | Page background |
| `context.c.surface` | `#FFFFFF` | `#1B211E` | Cards, sheets, inputs |
| `context.c.text` | `#1C2420` | `#E5EBE7` | Primary text |
| `context.c.textMuted` | `#6B756F` | `#9AA59F` | Secondary text, labels |
| `context.c.border` | `#E4E8E3` | `#2D3631` | Card borders, dividers |

White (`Colors.white`) is allowed only for text/icons on a `primary` or status-coloured fill.

## Type

System font (Roboto / Noto CJK). Keep to these sizes:

| Role | Size / weight |
|---|---|
| App bar title | 22 / w700 |
| Item name, big numbers | 16–24 / w700–w800 |
| Body | 15 / w400 |
| Secondary / meta | 13 / w400, `textMuted` |
| Section label | 13 / w600, `textMuted` |

## Shape and spacing

- Radius: **16** cards, **14** buttons and inputs, **20** chips, **24** dialogs.
- Page padding 16–20; gap between list cards 8; 4-pt spacing grid.
- Cards are flat: surface colour + 1 px `border`, no shadow.
- App bars are flat, same colour as the background, left-aligned title.
- Touch targets ≥ 48 px.

## Components

- **Status cards (Home):** count + label; tap to filter, tap again to clear.
- **Item tile:** category emoji in a status-tinted square · name · quantity and date · days-left label in status colour. Tap = edit, swipe left = delete with Undo.
- **Chips:** `ChoiceChip` for single choice (category, date shortcuts); `ActionChip` for suggestions.
- **Primary button:** `FilledButton`, full width, pinned at the bottom of forms.
- **Choice settings:** bottom sheet list with a check mark, applied on tap.

## Writing

- Short, friendly, no jargon. "Expires tomorrow!" not "T-1".
- Every string goes into all three ARB files (en, zh_TW, ja). Check long Japanese and English strings don't overflow.
- Error messages say what the user can do next ("Type its name — we'll remember this barcode").

## Before you open a PR with UI changes

- [ ] Works in light **and** dark mode
- [ ] No hardcoded colours
- [ ] Checked in all three languages
- [ ] Screenshot attached to the PR

# fastlane/metadata/

App Store Connect metadata managed by fastlane.

## Structure

```
fastlane/metadata/
├── ja/                  # Japanese (primary)
├── en-US/               # English (US)
└── <other locales>/     # Add as needed
```

For each locale, the following files are required:

- `name.txt` (≤30 chars)
- `subtitle.txt` (≤30 chars)
- `description.txt` (≤4000 chars)
- `keywords.txt` (≤100 chars, comma-separated, no spaces)
- `promotional_text.txt` (≤170 chars)
- `release_notes.txt` (per release)
- `privacy_url.txt`
- `support_url.txt`
- `marketing_url.txt` (optional)

## ASC locale codes

| Language              | ASC code  | Notes                        |
| --------------------- | --------- | ---------------------------- |
| Japanese              | `ja`      | NOT `ja-JP`                  |
| English (US)          | `en-US`   |                              |
| French                | `fr-FR`   | `fr-CA` is separate          |
| Spanish               | `es-ES`   | `es-MX` is separate          |
| German                | `de-DE`   |                              |
| Italian               | `it`      | No region                    |
| Portuguese (BR)       | `pt-BR`   | `pt-PT` is separate, no `pt` |
| Chinese (Simplified)  | `zh-Hans` |                              |
| Chinese (Traditional) | `zh-Hant` |                              |
| Korean                | `ko`      |                              |
| Russian               | `ru`      |                              |
| Thai                  | `th`      |                              |
| Indonesian            | `id`      |                              |
| Vietnamese            | `vi`      |                              |
| Hindi                 | `hi`      |                              |
| Turkish               | `tr`      |                              |
| Dutch                 | `nl-NL`   |                              |
| Polish                | `pl`      |                              |
| Swedish               | `sv`      |                              |

## Validation

```bash
pnpm metadata:check
```

This validates char limits, accent characters (for Latin-script languages), and forbidden patterns (trademarks, superlatives).

## Push to ASC

- **Automatic**: PR merged to `main` triggers `.github/workflows/push-app-store-metadata.yml`
- **Manual**: `gh workflow run "Push App Store Metadata"`

## Lessons (Repolog L-FL01〜FL07)

See `docs/how-to/workflow/app_store_localization.md` (if present).

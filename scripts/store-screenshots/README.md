# Store Screenshot Pipeline

Generates store-ready composite screenshots for Apple App Store and Google Play.

Each composite image consists of a white background, a marketing text caption at the top, and the app screenshot with rounded corners and a subtle shadow below.

## Pipeline Overview

### Phase 0 -- Marketing Text Generation

Claude Code reads `screenshot-config.ts` and generates `data/marketing-text.ts` containing localized marketing copy for each screen and locale.

**Input:** `screenshot-config.ts` (app info, persona, screen definitions, text guidelines)
**Output:** `data/marketing-text.ts`

### Phase 1 -- Raw Screenshot Capture

Maestro captures raw screenshots from the running app for each locale. Screenshots are saved to `screenshots/raw/<locale_dir>/`.

**Input:** Maestro flow files
**Output:** `screenshots/raw/<locale_dir>/<screen_id>.png`

### Phase 2 -- Composite Generation

The `generate.ts` script composes the final store images:

1. **Compose** -- Builds an HTML page with marketing text + cropped screenshot
2. **Render** -- Playwright renders the HTML at the exact store dimensions
3. **Postprocess** -- Sharp flattens alpha, embeds sRGB ICC, and verifies dimensions

**Input:** Raw screenshots + marketing text
**Output:** `screenshots/store/<store>/<locale_dir>/<screen_id>.png`

## Setup

### 1. Install dependencies

```bash
pnpm add -D playwright sharp tsx
npx playwright install chromium
```

### 2. Create screenshot-config.ts

```bash
cp scripts/store-screenshots/screenshot-config.ts.template \
   scripts/store-screenshots/screenshot-config.ts
```

Edit the file and fill in all TODO sections with your app-specific values.

### 3. Generate marketing text (Phase 0)

Ask Claude Code to read `screenshot-config.ts` and generate `data/marketing-text.ts`.

### 4. Add pnpm script

Add to `package.json`:

```json
{
  "scripts": {
    "store-screenshots": "npx tsx scripts/store-screenshots/generate.ts"
  }
}
```

## Usage

```bash
# Generate for all locales, both stores
pnpm store-screenshots

# Apple App Store only
pnpm store-screenshots --store apple

# Google Play, Japanese only
pnpm store-screenshots --store google --lang ja

# Multiple locales
pnpm store-screenshots --lang en,ja,fr
```

## Output Sizes

| Store  | Dimensions  | Notes                                    |
| ------ | ----------- | ---------------------------------------- |
| Apple  | 1320 x 2868 | iPhone 6.9" -- mandatory for App Store   |
| Google | 1080 x 1920 | Phone -- standard for Google Play (9:16) |

## Directory Structure

```
scripts/store-screenshots/
  generate.ts                    # CLI entry point
  screenshot-config.ts           # App-specific config (create from .template)
  screenshot-config.ts.template  # Template with TODOs
  data/
    marketing-text.ts            # Generated marketing copy
  lib/
    config.ts                    # Size constants and path resolution
    fonts.ts                     # Font management (@font-face generation)
    renderer.ts                  # Playwright rendering
    template.ts                  # HTML template generation
    postprocess.ts               # Sharp crop/flatten/verify

screenshots/
  raw/<locale_dir>/              # Maestro captures (Phase 1 input)
  store/<store>/<locale_dir>/    # Final composites (Phase 2 output)
```

## Fonts

By default, the pipeline uses Noto Sans variable fonts from `assets/fonts/`. The font module (`lib/fonts.ts`) automatically selects the correct font for each locale (e.g. Noto Sans JP for Japanese, Noto Sans SC for Simplified Chinese).

If your app uses different fonts, edit the `FONTS` map in `lib/fonts.ts`.

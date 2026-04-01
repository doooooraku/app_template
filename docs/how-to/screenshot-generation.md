# Store Screenshot Generation

## Overview

The screenshot pipeline generates store-ready composite images for Apple App Store and Google Play from raw Maestro captures.

## Pipeline Phases

### Phase 0: Marketing Text Generation

Use Claude Code to generate localized marketing copy:

1. Create `scripts/store-screenshots/screenshot-config.ts` from the template
2. Ask Claude Code to generate `data/marketing-text.ts`

### Phase 1: Raw Screenshot Capture

Use Maestro to capture raw screenshots in each locale:

```bash
# Run Maestro flows that capture screenshots
maestro test maestro/flows/screenshots.yml
```

Screenshots are saved to `screenshots/raw/<locale_dir>/`.

### Phase 2: Composite Generation

```bash
# All locales, both stores
npx tsx scripts/store-screenshots/generate.ts

# Apple only
npx tsx scripts/store-screenshots/generate.ts --store apple

# Specific locale
npx tsx scripts/store-screenshots/generate.ts --lang ja
```

## Setup

```bash
# 1. Install required tools
pnpm add -D playwright sharp tsx
npx playwright install chromium

# 2. Create config from template
cp scripts/store-screenshots/screenshot-config.ts.template \
   scripts/store-screenshots/screenshot-config.ts

# 3. Edit the config with your app's marketing text and screen definitions
```

## Store Requirements

| Store           | Phone            | Tablet            |
| --------------- | ---------------- | ----------------- |
| Apple App Store | 1290x2796 (6.7") | 2048x2732 (12.9") |
| Google Play     | 1290x2796        | 2048x2732         |

## Tips

- Run Phase 1 on a real device for the most accurate screenshots
- Keep marketing text short (2-3 words per line work best)
- Test with one locale first before generating all 19
- Screenshots are output to `screenshots/store/` (gitignored)

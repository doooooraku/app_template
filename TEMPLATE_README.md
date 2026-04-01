# App Factory Template

A batteries-included Expo template for building production-ready mobile apps.

## What's Included

| Category         | Details                                                       |
| ---------------- | ------------------------------------------------------------- |
| **Framework**    | Expo SDK 54, React Native 0.81.5, Expo Router v6              |
| **UI**           | Tamagui v1, Reanimated, Gesture Handler                       |
| **State**        | Zustand + AsyncStorage persist                                |
| **Data**         | expo-sqlite with migration pattern, Supabase client           |
| **i18n**         | 19 languages, auto-detection, Zustand-based                   |
| **Monetization** | RevenueCat (IAP), AdMob (ads), UMP consent                    |
| **CI/CD**        | GitHub Actions (verify, Maestro smoke, Dependabot)            |
| **Quality**      | ESLint, Prettier, lint-staged, pre-commit hooks               |
| **Testing**      | Jest (unit), Maestro (E2E)                                    |
| **Scripts**      | Debug toolkit, dev-start, i18n audit, config check, UMP check |
| **Screenshots**  | Playwright + Sharp store screenshot pipeline                  |
| **Docs**         | Diataxis structure (explanation, reference, how-to, ADR)      |

## Quick Start

```bash
# 1. Create a new repo from this template (GitHub UI: "Use this template")

# 2. Clone and run setup
git clone https://github.com/YOUR_USER/YOUR_APP.git
cd YOUR_APP
bash setup.sh

# 3. Start developing
pnpm dev
```

## Setup Script

`setup.sh` replaces all `{{PLACEHOLDER}}` values:

| Placeholder                 | Description          | Example             |
| --------------------------- | -------------------- | ------------------- |
| `{{APP_NAME}}`              | Display name         | `MyApp`             |
| `{{APP_SLUG}}`              | URL-safe slug        | `myapp`             |
| `{{ANDROID_PACKAGE}}`       | Android package      | `com.example.myapp` |
| `{{IOS_BUNDLE_IDENTIFIER}}` | iOS bundle ID        | `com.example.myapp` |
| `{{APP_SCHEME}}`            | Deep link scheme     | `myapp`             |
| `{{DESCRIPTION}}`           | One-line description | `A great app`       |
| `{{EAS_PROJECT_ID}}`        | EAS project ID       | `uuid`              |

## Key Commands

```bash
pnpm dev              # Start Metro bundler
pnpm verify           # Run all quality checks
pnpm dev:android      # ADB check + port forward + Metro
pnpm test             # Run unit tests
pnpm test:e2e         # Run Maestro E2E tests
pnpm i18n:audit       # Find unused/missing i18n keys
pnpm format:fix       # Auto-format all files
pnpm debug:start      # Start debug session
pnpm debug:stop       # Stop and collect debug artifacts
pnpm monitor          # Real-time crash/error monitor
```

## Project Structure

```
app/                  # Expo Router pages
src/
  core/               # Shared utilities (i18n, debug)
  db/                 # SQLite database layer
  features/           # Vertical feature slices
  services/           # Business logic services
  stores/             # Zustand state stores
  types/              # TypeScript type definitions
scripts/              # Development & build scripts
plugins/              # Expo config plugins
docs/                 # Documentation (Diataxis structure)
__tests__/            # Unit tests
maestro/              # E2E test flows
```

## Documentation

See `docs/README.md` for the full documentation map.

## After Setup

1. Fill in `.env` with your API keys (AdMob, RevenueCat, Sentry, EAS)
2. Remove example code in `src/features/example/` and `src/db/`
3. Update `docs/explanation/product_strategy.md` with your product vision
4. Update `docs/reference/functional_spec.md` with your features
5. Create your first ADR in `docs/adr/`

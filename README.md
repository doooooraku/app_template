# App Factory Template

Expo SDK 55 + React Native 0.83.4 template with batteries included.

> **Using this template?** See [TEMPLATE_README.md](TEMPLATE_README.md) for the full setup guide.

## Quick Start

```bash
# 1. Create a new repo from this template (GitHub: "Use this template")
# 2. Clone and run the setup script
bash setup.sh

# 3. Start development
pnpm dev
```

## What's Included

| Category         | Details                                                   |
| ---------------- | --------------------------------------------------------- |
| **Framework**    | Expo 55, React Native 0.83.4, New Architecture            |
| **UI**           | Tamagui v1, React Navigation                              |
| **State**        | Zustand + persist, React Query                            |
| **Data**         | expo-sqlite with migration pattern                        |
| **i18n**         | 19 languages (expo-localization + custom system)          |
| **Monetization** | RevenueCat (subscriptions), AdMob + UMP (ads)             |
| **CI/CD**        | GitHub Actions (verify, Maestro smoke, Dependabot)        |
| **Quality**      | ESLint, Prettier, lint-staged, pre-commit hooks           |
| **Testing**      | Jest (unit), Maestro (E2E)                                |
| **Scripts**      | Debug toolkit, dev-start, i18n audit, screenshot pipeline |
| **EAS**          | Build profiles (dev/preview/production), Submit, Update   |
| **Docs**         | Diataxis structure, ADR template, PR template             |

## Environment Variables

All app-specific values come from `.env`. See `.env.example` for the full list.

**Required** (fail fast if missing):

- `APP_NAME`, `APP_SLUG`, `IOS_BUNDLE_IDENTIFIER`, `ANDROID_PACKAGE`

**Optional** (service keys):

- AdMob IDs, RevenueCat keys, Sentry DSN, Legal URLs, EAS config

## Project Structure

```
app/              # Expo Router pages (file-based routing)
src/
  core/           # i18n, debug utilities
  db/             # SQLite database layer
  features/       # Vertical feature slices
  services/       # Business logic services
  stores/         # Zustand state stores
  types/          # TypeScript type definitions
scripts/          # Development & build scripts
plugins/          # Expo config plugins
docs/             # Documentation (Diataxis structure)
__tests__/        # Unit tests
maestro/          # E2E test flows
```

# App Factory Template

Expo SDK 54 + React Native 0.81.5 template with batteries included.

## Quick Start

```bash
# 1. Copy .env.example and fill in your app identity
cp .env.example .env

# 2. Install dependencies
pnpm install

# 3. Start development
pnpm dev
```

## What's Included

| Category         | Details                                                                 |
| ---------------- | ----------------------------------------------------------------------- |
| **Framework**    | Expo 54, React Native 0.81.5, New Architecture                          |
| **UI**           | Tamagui, React Navigation                                               |
| **State**        | Zustand, React Query                                                    |
| **i18n**         | 18 languages (expo-localization + custom system)                        |
| **Monetization** | RevenueCat (subscriptions), AdMob + UMP (ads)                           |
| **CI/CD**        | GitHub Actions (lint, type-check, test, iOS TestFlight)                 |
| **EAS**          | Build profiles (dev/preview/production), Submit (Android), Update (OTA) |
| **Docs**         | Diataxis structure, ADR template, PR template                           |
| **Quality**      | ESLint with hardcode detection, TypeScript strict                       |

## Environment Variables

All app-specific values come from `.env`. See `.env.example` for the full list.

**Required** (fail fast if missing):

- `APP_NAME`, `APP_SLUG`, `IOS_BUNDLE_IDENTIFIER`, `ANDROID_PACKAGE`

**Optional** (service keys):

- AdMob IDs, RevenueCat keys, Legal URLs, EAS config

## Project Structure

```
app/              # Expo Router pages (file-based routing)
src/
  core/           # i18n, debug utilities
  services/       # proService, adService, legalService, reviewService
  types/          # TypeScript type definitions
components/       # Shared UI components
docs/
  adr/            # Architecture Decision Records
  explanation/    # Product strategy, design rationale
  reference/      # Specs, constraints, glossary
  how-to/         # Guides and procedures
.claude/          # Claude Code configuration
.github/          # CI/CD workflows, PR/issue templates
maestro/          # E2E smoke tests
```

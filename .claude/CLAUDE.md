## Project

- **{{APP_NAME}}**: {{DESCRIPTION}}
- **Tech Stack**: Expo SDK 55+, React Native 0.83+, Tamagui, Zustand, expo-sqlite, expo-router (file-based routing)
- **iOS bundle ID**: {{IOS_BUNDLE_IDENTIFIER}}
- **Android package**: {{ANDROID_PACKAGE}}
- **Languages**: 19 (en, ja, fr, es, de, it, pt, ru, zh-Hans, zh-Hant, ko, hi, id, th, vi, tr, nl, pl, sv)
- **Source of truth**: `package.json` (deps), `docs/reference/constraints.md` (rules), `docs/adr/` (decisions)

## Commands

- `pnpm dev` — start Metro
- `pnpm verify` — full check (lint + type-check + format + test + i18n + config)
- `pnpm test` — Jest unit tests
- `pnpm test:e2e` — Maestro E2E
- `pnpm build:android:apk:local` — local APK build (requires API keys, or `SKIP_KEYS=1` for first build)
- `pnpm build:android:aab:local` — local AAB build for production
- `pnpm i18n:check` — verify all locale keys are present
- `pnpm metadata:check` — validate `fastlane/metadata/`

## Reference (read when relevant)

- Coding rules: `docs/how-to/coding_rules.md`
- Git workflow: `docs/how-to/git_workflow.md`
- Whole workflow (dev → release): `docs/how-to/whole_workflow.md`
- Architecture decisions: `docs/adr/`
- Constraints (immutable rules): `docs/reference/constraints.md`
- Lessons learned: `docs/reference/tasks/lessons.md`

---

## Workflow

### 1. Plan Mode First

- Tasks with 3+ steps or architectural impact MUST start in Plan mode
- If stuck, stop and re-plan immediately
- Write detailed specs before implementation

### 2. Lightweight Spec (before coding)

For non-trivial features, write a brief spec using this template:

```
## [Feature Name]
- Goal: (1 sentence)
- Affected files: (list)
- Steps:
  1. [ ] Step — checkpoint: how to verify
  2. [ ] Step — checkpoint: how to verify
- Risks: (what could go wrong)
```

### 3. Sub-Agent Strategy

- Keep main context window clean — delegate research to sub-agents
- 1 sub-agent = 1 task
- Use parallel sub-agents for independent queries

### 4. Self-Improvement Loop

- Record corrections in `docs/reference/tasks/lessons.md`
- Write rules to prevent repeating the same mistakes
- Review lessons at session start

### 5. Verify Before Done

- Prove it works before marking complete
- Run tests, check logs, diff against main
- Ask: "Would a staff engineer approve this?"

### 6. Autonomous Bug Fixing

- Fix bugs without hand-holding — read logs, errors, failing tests
- Zero context-switching for the user
- Fix failing CI proactively

---

## iOS Rules

- `app.json` ios section MUST have `"config": { "usesNonExemptEncryption": false }` and `privacyManifests`
- Re-evaluate `usesNonExemptEncryption` when adding encryption libraries (see ADR-0010 if exists)
- Block unnecessary iOS permissions (microphone, always-on location) explicitly in plugin config

---

## Environment Variables

- All app-specific values (name, slug, bundle ID, package, API keys, ad IDs) MUST come from `.env`
- NEVER hardcode `com.xxx.xxx`, `ca-app-pub-`, `appl_`, or `goog_` in `src/` files
- Use `app.config.ts` extra to pass env values to runtime
- ESLint `no-restricted-syntax` rules enforce this automatically

---

## Core Principles

- **Simple first**: Minimize change surface. Keep it minimal.
- **No shortcuts**: Find root causes. No temporary fixes. Senior engineer standard.
- **Minimize impact**: Change only what's needed. Don't introduce new bugs.

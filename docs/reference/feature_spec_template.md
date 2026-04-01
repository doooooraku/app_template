# Feature Spec: [Feature Name]

> Issue: #xxx
> Date: YYYY-MM-DD
> Status: Draft / Approved / Implemented

## Goal (Why)

<!-- 1-2 sentences: why this feature exists, what user value it delivers -->

## Acceptance Criteria

- [ ] AC-1:
- [ ] AC-2:
- [ ] AC-3:

## Scope

### In Scope

-

### Out of Scope (Non-goals)

-

## Design

### Affected Files

| File      | Change |
| --------- | ------ |
| `src/...` |        |
| `app/...` |        |

### State Changes

<!-- Zustand store / React Query cache changes -->

## Impact Checklist

### DB Schema

- [ ] No DB changes
- [ ] New table / column added
  - [ ] Migration is idempotent (column existence check before ALTER TABLE)
  - [ ] `PRAGMA user_version` is unconditionally set after migration
  - [ ] Backup types (`BackupXxx`) updated with new field (as optional `?`)
  - [ ] Export mapping in backupService updated
  - [ ] Import INSERT statement in backupService updated

### i18n

- [ ] No new translation keys
- [ ] New keys added to `en.ts`
  - [ ] All 18 locale files explicitly override new keys (do NOT rely on `...baseEn` fallback)
  - [ ] `pnpm i18n:check` passes

### Documents

- [ ] No doc changes needed
- [ ] Updated files:
  - [ ] `constraints.md` (if rules/limits changed)
  - [ ] `functional_spec.md` (if behavior changed)
  - [ ] `glossary.md` (if new terms introduced)
  - [ ] ADR created (if architectural decision made)

### User-Facing Text

- [ ] No technical jargon in user-visible strings (no filenames, JSON, schema references)

## Test Plan

### Unit Tests

- [ ]

### E2E (Maestro)

- [ ]

### Manual Verification

- [ ]

## Risks

<!-- What could go wrong? What's the rollback plan? -->

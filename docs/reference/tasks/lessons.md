# Lessons Learned

Record patterns and corrections here so the same mistakes are not repeated.

## Format

```
### [Date] Category: Short title
- What happened:
- Root cause:
- Rule: (what to do differently next time)
```

---

## Seed Lessons (from prior projects)

### Document Management

#### Doc map update on new file

- **Rule:** When adding a new document, always update the docs/README.md file map.
- **Root cause:** No checklist for "other files affected" when creating docs.

#### Feature inventory before replacement

- **Rule:** When replacing an existing feature with a new version, inventory all capabilities of the old version first. Distinguish intentional removals from oversights.
- **Root cause:** Old feature's capabilities were not documented externally, so they were missed during redesign.

#### Legacy reference update

- **Rule:** Definition of Done must include "cross-reference check for related documents."
- **Root cause:** New feature TODO did not include checking existing docs for stale references.

---

### DB / Data

#### Migration idempotency

- **Rule:** `PRAGMA user_version` must be set unconditionally (not inside an if-block). `ALTER TABLE ADD COLUMN` must check column existence first.
- **Root cause:** `CREATE TABLE IF NOT EXISTS` is idempotent, but `ALTER TABLE ADD COLUMN` is not. On app restart, version=0 triggers re-migration and "duplicate column" error.

#### Backup/export field coverage

- **Rule:** When adding a column to `reports` or `photos`, always update the corresponding Backup type, export mapping, and import INSERT in backupService.
- **Root cause:** No process to check backup impact when schema changes.

---

### i18n

#### Don't rely on baseEn fallback

- **Rule:** New translation keys must be explicitly overridden in all locale files. `...baseEn` spread makes keys "exist" but they remain untranslated.
- **Root cause:** The i18n:check script validates en.ts keys vs code usage, but doesn't detect locale files that silently inherit English via spread.

---

### UX / Copy

#### No technical jargon in user-facing text

- **Rule:** Never show filenames, directory names, JSON, schema, or other internal terms to users. Describe what something does, not what it is technically.
- **Root cause:** Developer described backup contents accurately (`manifest.json + photos/`) instead of describing their purpose.

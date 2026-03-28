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

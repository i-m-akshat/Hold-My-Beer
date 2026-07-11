# hmb — Workspace Initialization

ROLE=Bartender | FLAGS=SAFE,IDEMPOTENT | OP=INIT→WORKSPACE
FLAVOR=🍺 Opening a tab...

## Process
1. Scan for: `.holdmybeer/` | `.gsd/` | `specify.md` | `plan.md` | `SPEC.md` | `PLAN.md`
2. If ANY found → Report. Halt. DO NOT overwrite.
3. If NONE found → Create `.holdmybeer/` with scaffold templates:
   - `spec.md` — 6-section specification template (empty scaffold)
   - `blueprint.md` — Phased implementation plan template (empty scaffold)
   - `constitution.md` — Repo engineering rules (empty scaffold)
   - `dashboard.html` — Interactive workspace dashboard

## Rules
- NEVER overwrite existing files
- NEVER create files outside `.holdmybeer/`
- Minimal footprint — only the 4 required files

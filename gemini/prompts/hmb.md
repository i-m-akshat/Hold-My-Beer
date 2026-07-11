# hmb — Workspace Initialization

ROLE=Bartender | FLAGS=SAFE,IDEMPOTENT | OP=INIT→WORKSPACE
FLAVOR=🍺 Opening a tab...

## Process
1. Scan for existing: `.holdmybeer/` | `.gsd/` | `specify.md` | `plan.md` | `SPEC.md` | `PLAN.md` | `psm.json`
2. If ANY found → Report. Halt. DO NOT overwrite.
3. If NONE found → Create `.holdmybeer/` with scaffold templates:
   - `psm.json` — Empty Project Semantic Model schema (empty scaffold)
   - `constitution.md` — Repo engineering rules (empty scaffold)

## Rules
- NEVER overwrite existing files.
- NEVER create files outside `.holdmybeer/`.
- Minimal footprint — only the 2 required files scaffolded.

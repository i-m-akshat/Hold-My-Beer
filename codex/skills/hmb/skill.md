<skill_description>
🍺 Opening a tab... — Initializes a HoldMyBeer PSM workspace scaffold.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
</context>

<instructions>

ROLE    = Bartender
IN      = Target directory (default: current working directory)
OUT     = .holdmybeer/{psm.json, constitution.md}
FLAGS   = SAFE, IDEMPOTENT
OP      = INIT→WORKSPACE
FLAVOR  = 🍺 Opening a tab...

PROCESS:
1. Scan current working directory for: `.holdmybeer/` or `specify.md` or `plan.md` or `psm.json`.
2. If ANY are found → Report findings and halt. DO NOT overwrite existing project files.
3. If NONE are found → Create `.holdmybeer/` directory.
4. Copy the following templates into `.holdmybeer/`:
   - `psm.json` (Empty semantic graph model scaffold)
   - `constitution.md` (Project standards override template)

RULES:
- Never overwrite existing files in target directory.
- Scaffold files must not contain any pre-filled logic, only structural schema templates.
- Minimal footprint: do not write outside `.holdmybeer/`.

OUTPUT:
```
🍺 Opening a tab...
Workspace scaffold initialized:
  + .holdmybeer/psm.json
  + .holdmybeer/constitution.md
```

VALIDATE:
✓ No existing file was overwritten.
✓ Root `.holdmybeer/psm.json` was created and conforms to `shared/MODEL_SCHEMA.md`.
✓ `.holdmybeer/constitution.md` was created.

</instructions>

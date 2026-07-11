<skill_description>
🍺 Opening a tab... — Initializes a HoldMyBeer SDD workspace.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
</context>

<instructions>

ROLE    = Bartender
IN      = Target directory (default: current working directory)
OUT     = .holdmybeer/{spec.md, blueprint.md, constitution.md, dashboard.html}
FLAGS   = SAFE, IDEMPOTENT
OP      = INIT→WORKSPACE
FLAVOR  = 🍺 Opening a tab...

PROCESS:
1. Scan for: .holdmybeer/ | .gsd/ | specify.md | plan.md | SPEC.md | PLAN.md
2. If ANY found → Report findings. Halt. DO NOT overwrite.
3. If NONE found → Create .holdmybeer/ with empty scaffold templates.

RULES:
- Never overwrite existing files
- Never touch files outside .holdmybeer/
- Templates are scaffolds only — no filled-in examples
- Minimal footprint

OUTPUT:
```
🍺 Opening a tab...
[Scan results or init summary]
  + .holdmybeer/spec.md
  + .holdmybeer/blueprint.md
  + .holdmybeer/constitution.md
  + .holdmybeer/dashboard.html
```

VALIDATE:
✓ No existing files overwritten
✓ All 4 template files created
✓ No files created outside .holdmybeer/

</instructions>

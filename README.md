# 🍺 HoldMyBeer

A professional, Spec-Driven Development (SDD) toolkit for AI-assisted engineering. It provides a structured, adversarial pipeline of development gates to prevent context collapse, eliminate model hallucinations, and ensure codebase architectural integrity.

HoldMyBeer enforces zero-guess requirements gathering, reuse-first technical planning, multi-pass adversarial auditing, and strict security and test coverage verification before code is merged.

## Supported Platforms

| Platform | Status | Mechanism |
|---|---|---|
| Claude Code | ✅ | `SKILL.md` skills + slash commands |
| Gemini CLI | ✅ | `.toml` custom commands |
| Codex CLI | ✅ | `SKILL.md` skills (same open standard as Claude) |
| Cursor | 🚧 | `.mdc` rules (no argument-passing command layer yet) |

Claude Code is the primary, most complete target — the other adapters
port the same logic into each tool's own convention. See each platform's
own README (`gemini/README.md`, `codex/README.md`) for details and known
gaps.

## Install

```bash
git clone https://github.com/yourname/holdmybeer
cd holdmybeer
```

**Windows:**
```powershell
.\install.ps1                  # installs for Claude Code (default)
.\install.ps1 -Platform all    # installs for every auto-installable platform
```

**macOS/Linux:**
```bash
./install.sh                   # installs for Claude Code (default)
./install.sh --platform all    # installs for every auto-installable platform
```

The installer detects your existing `~/.claude` (or `~/.gemini`,
`~/.codex`) directory, copies in the skills/commands, and **never
overwrites an existing file** unless you pass `-Force` / `--force`. It
prints a summary of what was installed and what was skipped.

Cursor isn't auto-installed — its rules are project-scoped by convention,
not global, so copy `cursor/rules/*.mdc` into your project's own
`.cursor/rules/` directory manually.

To remove everything the installer added:
```powershell
.\uninstall.ps1
```
```bash
./uninstall.sh
```

## Workflow

```
Workspace / Project Root
 ↓
holdmybeer-init (Diagnostics & Initialization)
 ↓
Epic
 ↓
holdmybeer-craft        (HoldMyBeer: Spec Brewing)
 ↓
holdmybeer-audit        (HoldMyBeer: Spec Sniffing)
 ↓
holdmybeer-design         (HoldMyBeer: Plan Brewing)
 ↓
holdmybeer-stress        (HoldMyBeer: Plan Stress-Testing)
 ↓
holdmybeer-code          (HoldMyBeer: Implementation)
 ↓
holdmybeer-ship          (HoldMyBeer: Final Review)
 ↓
Merge
```

See [`docs/workflow.md`](docs/workflow.md) for the full stage-by-stage
breakdown and an example run.

## Available Commands

| Command | Mode | What it does |
|---|---|---|
| `/holdmybeer-init` | SDD Initialization | Checks for existing SDD structures (.holdmybeer, .gsd, etc.) or initializes standard templates. |
| `/holdmybeer-craft` | Spec Brewing | Brews a complete, implementation-ready specification from an Epic. |
| `/holdmybeer-audit` | Spec Sniffing | Sniffs out ambiguities, contradictions, hidden assumptions, and blockers until the spec is production ready. |
| `/holdmybeer-design` | Plan Brewing | Converts an approved specification into a phased implementation plan. |
| `/holdmybeer-stress` | Plan Stress-Testing | Stress-tests the implementation plan for architectural risk, missing work, and unnecessary complexity. |
| `/holdmybeer-code` | Implementation | Implements the approved plan while preserving existing architecture and coding conventions. |
| `/holdmybeer-ship` | Final Review | Performs the final production-readiness review before the feature merges. |

## Philosophy

Five rules, expanded in [`docs/philosophy.md`](docs/philosophy.md):

1. **Don't guess.** Ambiguity is a stop condition, not an invitation to
   invent business logic.
2. **Don't over-build.** Reuse existing code, existing architecture, and
   the standard library before writing anything new.
3. **Don't rubber-stamp.** Every review mode is adversarial and distrusts
   a clean pass until an independent one confirms it.
4. **Respect what's already there.** Existing architecture and layering
   are boundaries, not suggestions.
5. **Security, testing, and observability are not optional.** They're
   checked at every stage, not bolted on at the end.

## Examples

```
/holdmybeer-craft Add a "save for later" feature to the checkout flow, as described in TICKET-482.md
→ produces SPEC-save-for-later.md

/holdmybeer-audit SPEC-save-for-later.md
→ findings + APPROVED (or BLOCKED)

/holdmybeer-design SPEC-save-for-later.md
→ produces PLAN-save-for-later.md

/holdmybeer-stress PLAN-save-for-later.md SPEC-save-for-later.md
→ findings + APPROVED (or BLOCKED)

/holdmybeer-code PLAN-save-for-later.md
→ writes the code

/holdmybeer-ship SPEC-save-for-later.md PLAN-save-for-later.md src/checkout/
→ PASS (or FAIL with remaining issues)
```

## Best Practices

- **Don't skip stages.** `holdmybeer-code` assumes a plan that already survived
  `holdmybeer-stress`; running it against an unreviewed plan reintroduces the
  risk the pipeline exists to catch.
- **Treat BLOCKED/FAIL as a return trip, not a suggestion.** Fix the
  artifact one stage back and re-run the same gate — don't push forward
  with open blockers.
- **Feed real artifacts, not summaries.** Every review mode verifies
  against the literal text; a paraphrase hides the details it's designed
  to catch.
- **Let ambiguity stop the pipeline.** Resolve a logged "Needs
  Clarification" or open question with a human before moving forward.
- **Keep it generic.** These skills are intentionally
  language/framework/repo-agnostic. Specialize via your own project-level
  instructions, not by editing these files — see
  [`docs/customization.md`](docs/customization.md).

## Repository Layout

```
holdmybeer/
├── claude/      Claude Code skills + slash commands (primary platform)
├── gemini/      Gemini CLI .toml commands + source prompts
├── codex/       Codex CLI skills (same format as Claude)
├── cursor/      Cursor .mdc rules (🚧 in progress)
├── docs/        Philosophy, workflow, and customization guides
├── install.ps1 / install.sh      Installers
└── uninstall.ps1 / uninstall.sh  Uninstallers
```

## Contributing

New platform adapters, new modes, and rigor improvements to existing
modes are welcome. See [`docs/customization.md`](docs/customization.md)
for how each of those is structured, and keep changes generic — no
project-, language-, or framework-specific content belongs in this
repository.

## License

MIT — see [`LICENSE`](LICENSE).

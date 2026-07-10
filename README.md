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
holdmybeer-init   (Setup & Bootstrap)
 ↓
holdmybeer-spec   (Spec Distillation & Self-Audit)
 ↓
holdmybeer-plan   (Blueprint Design & Stress-Test)
 ↓
holdmybeer-code   (Code Implementation & Step Verification)
 ↓
holdmybeer-review (Quality & Validation Verification)
 ↓
Merge
```

See [`docs/workflow.md`](docs/workflow.md) for the full stage-by-stage
breakdown and an example run.

## Available Commands

| Command | Mode | What it does |
|---|---|---|
| `/holdmybeer-init` | Bootstrap | Checks for existing SDD structures or initializes templates in `.holdmybeer/`. |
| `/holdmybeer-spec` | Spec Distillation | Drafts and audits specification from requirements into `spec.md`. |
| `/holdmybeer-plan` | Blueprint Design | Converts approved spec into phased engineering roadmap `blueprint.md`. |
| `/holdmybeer-code` | Code Synthesis | Safely implements code modifications step-by-step from `blueprint.md`. |
| `/holdmybeer-review` | Quality Verification | Performs pre-merge quality and validation checks on implemented features. |

## Philosophy

Five rules, expanded in [`docs/philosophy.md`](docs/philosophy.md):

1. **Don't guess.** Ambiguity is a hard stop, not an invitation to invent requirements.
2. **Don't over-build.** Enforce YAGNI and reuse existing logic before building new.
3. **Don't rubber-stamp.** Self-audit and verify at every stage.
4. **Respect architectural boundaries.** Never bypass layers to shrink diff size.
5. **Security, testing, and observability are core constraints.** Build them in, don't bolt them on.

## Examples

```
/holdmybeer-spec Add a "save for later" feature to the checkout flow, as described in TICKET-482.md
→ produces spec.md

/holdmybeer-plan .holdmybeer/spec.md
→ produces blueprint.md

/holdmybeer-code .holdmybeer/blueprint.md
→ writes the code

/holdmybeer-review .holdmybeer/spec.md .holdmybeer/blueprint.md
→ PASS (or FAIL with issues checklist)
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

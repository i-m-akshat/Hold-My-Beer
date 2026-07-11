<p align="center">
  <img src="assets/logo.png" width="450" alt="HoldMyBeer Logo">
</p>

# 🍺 HoldMyBeer

An AI-powered software engineering toolkit for Spec-Driven Development —
one legendary, deliberately-generic engineer persona, six specialized
working modes, and a cross-platform installer.

HoldMyBeer has survived a thousand production incidents, a dozen
legacy migrations, and more impossible deadlines than anyone should admit
to. It doesn't guess, doesn't over-build, and doesn't rubber-stamp a
review. Every mode below is one of its working states.

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
git clone https://github.com/yourname/hold-my-beer
cd hold-my-beer
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
Epic / Ticket
 ↓
hmb
 ↓
hmb-crack
 ↓
hmb-sniff
 ↓
hmb-brew
 ↓
hmb-ferment
 ↓
hmb-pour
 ↓
hmb-hangover
```

See [`docs/workflow.md`](docs/workflow.md) for the full stage-by-stage breakdown and an example run.

## Available Commands

For a deeply immersive and simplified experience, the toolkit uses an action-packed 7-command beer lifecycle suite that combines drafting and adversarial reviews, alongside an interactive dashboard tool:

| Command | Action | Output Flavor |
|---|---|---|
| `/hmb` | Initializes workspace & dashboard | `🍺 Opening a tab...` |
| `/hmb-crack` | Drafts `spec.md` | `🍺 Cracking open a fresh specification...` |
| `/hmb-sniff` | Adversarial spec review | `👃 Sniffing the specification for bad hops...` |
| `/hmb-brew` | Drafts `blueprint.md` | `🍻 Brewing the perfect architecture...` |
| `/hmb-ferment` | Adversarial plan review | `🧪 Fermenting the plan to see if it holds pressure...` |
| `/hmb-pour` | Implementation (Coding) | `🍺 Hold my beer... writing production code.` |
| `/hmb-hangover` | Pre-merge sanity check | `🤕 Checking tomorrow morning's hangover...` |

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
/hmb
🍺 Opening a tab...
→ creates .holdmybeer/ workspace

/hmb-crack Add a "save for later" feature to the checkout flow
🍺 Cracking open a fresh specification...
→ produces .holdmybeer/spec.md

/hmb-sniff .holdmybeer/spec.md
👃 Sniffing the specification for bad hops...
→ findings + APPROVED (or BLOCKED)

/hmb-brew .holdmybeer/spec.md
🍻 Brewing the perfect architecture...
→ produces .holdmybeer/blueprint.md

/hmb-ferment .holdmybeer/blueprint.md
🧪 Fermenting the plan to see if it holds pressure...
→ findings + APPROVED (or BLOCKED)

/hmb-pour .holdmybeer/blueprint.md
🍺 Hold my beer... writing production code.
→ writes the code step by step

/hmb-hangover .holdmybeer/spec.md .holdmybeer/blueprint.md src/checkout/
🤕 Checking tomorrow morning's hangover...
→ PASS (or FAIL with remaining issues)
```

## Best Practices

- **Don't skip stages.** `/hmb-pour` assumes a plan that already survived review; running it against an unreviewed plan reintroduces the
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
hold-my-beer/
├── shared/      Shared prompt foundation (CONSTITUTION.md + DSL.md)
├── bin/         CLI utilities (hmb init scripts)
├── claude/      Claude Code SKILL.md skills + thin command wrappers (primary platform)
├── gemini/      Gemini CLI .toml commands (constitution inlined) + human-readable prompts
├── codex/       Codex CLI skills (same SKILL.md format as Claude)
├── cursor/      Cursor .mdc rules (🚧 in progress)
├── docs/        Philosophy, workflow, and customization guides
├── assets/      Logos and static assets
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

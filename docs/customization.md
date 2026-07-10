# Customization

HoldMyBeer ships generic and reusable on purpose — no skill or command
is tied to a specific language, framework, or repository. These are the
supported ways to adapt it without breaking that.

## Avoiding name collisions

The skill/command names (`brew-spec`, `sniff-spec`, `brew-plan`,
`stress-plan`, `hack-it`, `ship-it`) are distinctive by design, so
collisions with your own custom skills are unlikely. If you still want
extra insurance — e.g. you already have a skill literally named
`hack-it` — rename the folder under `claude/skills/` (or
`codex/skills/`) to `holdmybeer-hack-it` and update its frontmatter
`name:` field to match. You do **not** need to rename the command file
under `claude/commands/`; the command's job is just to invoke the skill by
name, so update the one line inside it that says which skill to invoke.

## Adjusting review rigor

`sniff-spec` and `stress-plan` both cap their repeat cycles at 3 to bound
runaway token spend. If your specs/plans are large enough that 3 cycles
routinely isn't enough to reach a quiet pass, raise the cap in the
skill's "Process" section — but raise it deliberately, not by removing the
cap entirely; an unbounded adversarial loop has no natural stopping point.

## Adding a new mode

To add a mode (the toolkit's own docs use `holdmybeer-debug` and
`holdmybeer-refactor` as hypothetical examples):

1. Copy the closest existing skill as a starting template — a new review
   mode should start from `sniff-spec` or `stress-plan`; a new
   build/transform mode should start from `hack-it` or `brew-plan`.
2. Keep the same section skeleton: Objective, Expected Input, Expected
   Output, Process, Guardrails, Completion Criteria, Stopping Conditions,
   Failure Conditions.
3. Open with the same HoldMyBeer persona paragraph, changing only the
   last sentence (the mode name and one-line purpose).
4. Add a matching command file, README entry, and workflow-diagram
   position.
5. If the new mode belongs in the main pipeline (not a standalone
   utility), update `docs/workflow.md` and the diagram in the root
   `README.md`.

## Adding a new platform

Each platform adapter is independent — none of them modify the others.
To add support for a new tool:

1. Research that tool's actual custom-command/skill mechanism before
   writing anything — file location, format (TOML/YAML/Markdown),
   argument-passing convention, and whether it supports automatic
   discovery or requires explicit invocation. Don't assume it matches
   Claude Code's format.
2. Create a new top-level folder (e.g. `windsurf/`) with its own README
   explaining the mapping from HoldMyBeer's six modes to that tool's
   mechanism, and note any features that don't have an equivalent (the
   way `gemini/README.md` and `codex/README.md` do).
3. Add an install/uninstall path for it in `install.ps1` / `install.sh`
   and `uninstall.ps1` / `uninstall.sh`, following the existing
   `--platform` flag pattern.
4. Mark it 🚧 in the root README's platform table until it's been
   used end-to-end at least once.

## Specializing for one project or stack

HoldMyBeer intentionally has no project- or language-specific content.
If you want a stack-specific variant (e.g. a `hack-it` that also enforces
your team's specific test-framework conventions), do it in your own
project-level instructions (`AGENTS.md`, `CLAUDE.md`, project-scoped
`.cursor/rules/`, etc.) that layer on top of HoldMyBeer, rather than
editing these files directly — that way you keep the ability to pull
upstream updates without a merge conflict with your own customizations.

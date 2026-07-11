# Customization

HoldMyBeer ships generic and reusable on purpose — no skill or command is tied to a specific language, framework, or repository. These are the supported ways to adapt it without breaking that.

## Avoiding Name Collisions

The skill/command names (`hmb`, `hmb-crack`, `hmb-sniff`, `hmb-brew`, `hmb-ferment`, `hmb-pour`, `hmb-hangover`) are distinctive by design. If you still want extra insurance, rename the folder under `claude/skills/` (or `codex/skills/`) and update the thin command wrapper under `claude/commands/` to reference the new folder name.

## Adjusting Review Rigor

`hmb-sniff` and `hmb-ferment` both run a structured audit checklist. To add more checks, extend the checklist in the skill's `AUDIT CHECKLIST` section. To require multiple independent passes before issuing a verdict, add an explicit `PASSES_REQUIRED=N` field to the skill's header.

## Adding a New Mode

1. Choose the closest existing skill as a template:
   - New **review mode** → start from `hmb-sniff` or `hmb-ferment`
   - New **build/transform mode** → start from `hmb-pour` or `hmb-brew`
2. Follow the exact skill skeleton from `shared/DSL.md`:
   ```
   ROLE / IN / OUT / FLAGS / OP / FLAVOR / SECTIONS / RULES / VALIDATE
   ```
3. Reference `shared/CONSTITUTION.md` and `shared/DSL.md` in the `<context>` block (Claude/Codex). Inline a compressed version for Gemini TOMLs and Cursor `.mdc` rules.
4. Add a thin command wrapper in `claude/commands/`, a `.toml` in `gemini/commands/`, and a `.mdc` in `cursor/rules/`.
5. Update `docs/workflow.md` and the pipeline diagram in `README.md`.

## Adding a New Platform

1. Research the tool's actual custom-skill mechanism (file location, format, argument-passing, auto-discovery).
2. Create a new top-level folder (e.g. `windsurf/`) with its own README explaining the mapping from HoldMyBeer's pipeline to that tool's convention, and note any unsupported features.
3. Add an install/uninstall path in `install.ps1` / `install.sh`, following the existing `--platform` flag pattern.
4. Mark it 🚧 in the root README's platform table until it's been run end-to-end at least once.

## Specializing for One Project or Stack

HoldMyBeer intentionally has no project- or language-specific content. For stack-specific variants (e.g., enforce your team's test framework conventions during `hmb-pour`), layer it on top via your own project-level instructions (`AGENTS.md`, `CLAUDE.md`, project-scoped `.cursor/rules/`, etc.) — don't edit these files directly, so you can pull upstream updates without merge conflicts.

## Editing the Engineering Constitution

The shared constitution lives in `shared/CONSTITUTION.md`. Edits there propagate automatically to Claude and Codex (which reference it via `<context>`). For Gemini and Cursor, update the inlined/compressed constitution blocks in the relevant `.toml` and `.mdc` files manually — or run the `install.ps1` installer after your edits to recompile.

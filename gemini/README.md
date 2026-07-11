# HoldMyBeer for Gemini CLI

Gemini CLI doesn't use Claude Code's `SKILL.md` format — its custom-command mechanism is a `.toml` file per command with a `description` and a `prompt` field, discovered from `~/.gemini/commands/` (global) or `<project>/.gemini/commands/` (project-scoped).

This directory has two parts:

- **`prompts/`** — The human-readable source of truth for each HoldMyBeer mode. Read these to understand or modify what each mode actually does. They are the reference format — clear, structured, and annotated.
- **`commands/`** — The installable `.toml` files. Each bakes a compressed version of the matching `prompts/*.md` into its `prompt` field, with the engineering constitution inlined. Gemini CLI runs it as a single self-contained prompt (no separate persistent skill layer). Arguments use the `{{args}}` placeholder.

## Architecture

Unlike Claude and Codex, Gemini commands cannot reference external files like `shared/CONSTITUTION.md`. The constitution is therefore compiled (compressed) into each `.toml`. If you modify `shared/CONSTITUTION.md`, mirror the relevant changes in the affected `.toml` files.

## Install

```bash
./install.sh --platform gemini
```

or manually:

```bash
cp gemini/commands/*.toml ~/.gemini/commands/
```

## Usage

```
gemini
> /hmb
> /hmb-crack Add a "save for later" feature to the checkout flow, described in TICKET-482.md
> /hmb-sniff .holdmybeer/spec.md
> /hmb-brew .holdmybeer/spec.md
> /hmb-ferment .holdmybeer/blueprint.md .holdmybeer/spec.md
> /hmb-pour .holdmybeer/blueprint.md
> /hmb-hangover .holdmybeer/spec.md .holdmybeer/blueprint.md src/checkout/
```

## Known Differences from Claude Code

- Gemini commands are single, self-contained prompts — there's no separate skill the model can reference by name; each `.toml` must bake in everything. If you edit a skill's logic in `claude/skills/`, mirror the change in `gemini/prompts/` and recompile into `gemini/commands/*.toml`.
- Gemini has no equivalent of Claude's automatic description-based skill discovery — commands must be invoked explicitly by name.
- The constitution is inlined/compressed in Gemini TOMLs rather than inherited from `shared/CONSTITUTION.md`.

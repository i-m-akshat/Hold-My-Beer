# Coffee Goblin for Gemini CLI

Gemini CLI doesn't use Claude Code's `SKILL.md` format — its custom-command
mechanism is a `.toml` file per command with a `description` and a `prompt`
field, discovered from `~/.gemini/commands/` (global) or
`<project>/.gemini/commands/` (project-scoped). See
[Gemini CLI custom commands](https://geminicli.com/docs/cli/custom-commands/).

This directory has two parts:

- **`prompts/`** — the human-readable source of truth for each Coffee
  Goblin mode (objective, process, guardrails, completion/failure
  conditions), mirroring the content in `claude/skills/`. Read these to
  understand or modify what each mode actually does.
- **`commands/`** — the installable `.toml` files, each with a condensed
  version of the matching `prompts/*.md` baked into its `prompt` field, so
  Gemini CLI can run it standalone as a single self-contained prompt (it
  has no separate persistent "skill" layer to load context from). Argument
  passing uses Gemini's `{{args}}` placeholder.

## Install

```
install.sh --platform gemini
```

or manually:

```
cp gemini/commands/*.toml ~/.gemini/commands/
```

## Usage

```
gemini
> /brew-spec Add a "save for later" feature to the checkout flow, described in TICKET-482.md
> /sniff-spec <paste the spec>
> /brew-plan <paste the approved spec>
> /stress-plan <paste the plan and spec>
> /hack-it <paste the approved plan>
> /ship-it <paste spec, plan, and a description of the implementation>
```

## Known differences from Claude Code

- Gemini commands are single, self-contained prompts — there's no
  separate "skill" the model can be told to invoke by name; each `.toml`
  bakes in everything the corresponding Claude skill would otherwise
  reference. If you edit a skill's logic in `claude/skills/`, mirror the
  change in `gemini/prompts/` and `gemini/commands/*.toml`.
- Gemini has no equivalent of Claude's automatic description-based skill
  discovery — commands must be invoked explicitly by name.

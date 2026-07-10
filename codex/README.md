# Coffee Goblin for Codex CLI

**A deliberate deviation from the layout you might expect:** Codex CLI's
older "custom prompts" mechanism (`~/.codex/prompts/*.md`) is deprecated —
recent Codex CLI releases (≥0.117.0) recommend **skills** instead, using
the same [Agent Skills Open Standard](https://developers.openai.com/codex/skills)
that Claude Code uses: a `SKILL.md` file per skill folder, discovered from
`~/.codex/skills/` (personal, global) or `.codex/skills/`/`.agents/skills/`
(project-scoped).

Because that standard is genuinely cross-compatible, the six files under
`codex/skills/*/SKILL.md` here are byte-for-byte identical to
`claude/skills/*/SKILL.md` — there is only one source of truth to
maintain. If you edit a skill, copy the same change to both locations (the
install scripts do this for you).

## Install

```
install.sh --platform codex
```

or manually:

```
cp -r codex/skills/* ~/.codex/skills/
```

## Notes

- Codex has no separate "commands" layer analogous to Claude Code's
  `commands/*.md` — skills are invoked by Codex deciding they're relevant
  (same description-matching mechanism as Claude), or by naming them
  explicitly in your prompt.
- Codex supports an optional `openai.yaml` file per skill folder for
  Codex-specific UI metadata and MCP tool dependencies. Coffee Goblin
  doesn't use one — the plain `SKILL.md` is enough for every mode here.
- If you're on an older Codex CLI version that only supports the
  deprecated `~/.codex/prompts/*.md` format, adapt a skill's content into
  that format yourself using `gemini/prompts/*.md` as a template (same
  idea: one self-contained prompt per mode) — the installer does not do
  this automatically since OpenAI has marked the format deprecated.

# Changelog

All notable changes to Coffee Goblin are documented here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.1.0] - Unreleased

### Added

- Initial six-mode pipeline: `brew-spec`, `sniff-spec`, `brew-plan`,
  `stress-plan`, `hack-it`, `ship-it`.
- Claude Code adapter: `SKILL.md` skills + slash commands under
  `claude/skills/` and `claude/commands/`.
- Gemini CLI adapter: `.toml` custom commands under `gemini/commands/`,
  with human-readable source prompts under `gemini/prompts/`.
- Codex CLI adapter: `SKILL.md` skills under `codex/skills/`, reusing the
  same Agent Skills Open Standard as Claude Code.
- Cursor adapter (🚧): `.mdc` rules under `cursor/rules/`, description-
  matched rather than always-applied.
- Cross-platform installers (`install.ps1`, `install.sh`) with
  `--platform` selection, no-overwrite-by-default behavior, and a
  `--force` override.
- Matching uninstallers (`uninstall.ps1`, `uninstall.sh`).
- Documentation: `docs/philosophy.md`, `docs/workflow.md`,
  `docs/customization.md`.

### Guardrails baked in from day one

- Security, concurrency, and observability requirements/checks present at
  every pipeline stage (spec, plan, and final review).
- Adversarial review modes (`sniff-spec`, `stress-plan`) cap at 3 repeat
  cycles to bound runaway token spend while still requiring an independent
  confirming pass before trusting a clean result.
- `hack-it` requires a test for any new or changed logic and never
  bypasses existing architectural layering, even under simulated deadline
  pressure (verified via adversarial pressure-testing during development).

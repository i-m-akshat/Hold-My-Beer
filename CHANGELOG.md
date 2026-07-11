# Changelog

All notable changes to HoldMyBeer are documented here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.2.0] - Unreleased

### Added

- **Shared prompt foundation**: `shared/CONSTITUTION.md` (engineering constitution) and `shared/DSL.md` (symbolic operation dictionary) — single sources of truth inherited by all skills.
- **Beer-themed 7-command pipeline**: renamed all commands to `hmb`, `hmb-crack`, `hmb-sniff`, `hmb-brew`, `hmb-ferment`, `hmb-pour`, `hmb-hangover` with output flavor messages.
- **`hmb-sniff`**: Dedicated adversarial spec review mode with structured audit checklist and BLOCKER/WARNING/SUGGESTION classification.
- **`hmb-ferment`**: Dedicated plan stress-test mode with requirement coverage matrix cross-referencing blueprint against spec.
- **`bin/hmb`** cross-platform CLI initializer: creates `.holdmybeer/` workspace scaffold.
- **`assets/`**: Logo and static assets directory.

### Changed

- Complete skill rewrite across all 4 platforms (Claude, Gemini, Codex, Cursor) from hollow one-liner prompts to production-grade, structured skill definitions with `ROLE/IN/OUT/FLAGS/OP/SECTIONS/RULES/VALIDATE` skeleton.
- Claude/Codex skills now inherit from `shared/CONSTITUTION.md` and `shared/DSL.md` via `<context>` blocks.
- Gemini TOMLs compile the constitution inline for full self-containment.
- Cursor `.mdc` rules use maximally compressed DSL encoding for token efficiency.
- All 4 platform adapters synchronized to identical behavior.
- `docs/workflow.md`, `docs/philosophy.md`, `docs/customization.md`, `gemini/README.md` fully rewritten to reflect beer pipeline.
- `uninstall.ps1` / `uninstall.sh` updated to target new `hmb-*` skill names.

### Removed

- Legacy command names: `brew-spec`, `sniff-spec`, `brew-plan`, `stress-plan`, `hack-it`, `ship-it`.
- Hollow one-liner prompt fragments replaced by structured skill definitions.

---

## [0.1.0] - Initial Release

### Added

- Initial six-mode pipeline: `brew-spec`, `sniff-spec`, `brew-plan`, `stress-plan`, `hack-it`, `ship-it`.
- Claude Code adapter: `SKILL.md` skills + slash commands.
- Gemini CLI adapter: `.toml` custom commands + human-readable source prompts.
- Codex CLI adapter: `SKILL.md` skills (Agent Skills Open Standard).
- Cursor adapter (🚧): `.mdc` description-matched rules.
- Cross-platform installers (`install.ps1`, `install.sh`) with `--platform` selection, no-overwrite-by-default, and `--force` override.
- Matching uninstallers (`uninstall.ps1`, `uninstall.sh`).
- Documentation: `docs/philosophy.md`, `docs/workflow.md`, `docs/customization.md`.

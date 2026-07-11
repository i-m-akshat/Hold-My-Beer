# Gemini CLI Platform Notes

Unlike Claude Code or Codex, Gemini CLI uses a different custom-command architecture. This document outlines the technical specifics, compilation patterns, and differences for development.

---

## 1. Single-Prompt Execution

In Gemini CLI:
- There is no persistent background skill layer (like Claude's auto-discoverable `SKILL.md`).
- Every command is defined as a `.toml` configuration file containing a `description` and a complete `prompt` field.
- Because the CLI runs each command as a fresh context prompt, the entire Project Semantic Model (PSM) schema instructions, role configuration, and validation rules must be compiled directly into the `.toml` prompt text.
- Standard inputs are passed directly to the configuration via the `{{args}}` tag.

---

## 2. Command Discovery

Gemini CLI searches for command configuration files at:
- Global: `~/.gemini/commands/*.toml`
- Project: `<project-root>/.gemini/commands/*.toml`

---

## 3. Maintenance and Synchronization

If you modify the shared foundation files (e.g. `shared/CONSTITUTION.md`, `shared/MODEL_SCHEMA.md`, or `shared/MODEL_VALIDATION.md`), you must re-compile or manually mirror those changes into the relevant command `.toml` prompt strings inside `gemini/commands/` so they take effect. Run the platform installer scripts (`install.ps1` or `install.sh`) to synchronize your workspace.

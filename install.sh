#!/usr/bin/env bash
#
# Installs HoldMyBeer into the config directory of one or more supported
# AI coding assistants (Claude Code, Gemini CLI, Codex CLI).
#
# Usage:
#   ./install.sh                       # installs for Claude Code (default)
#   ./install.sh --platform all        # installs for every auto-installable platform
#   ./install.sh --platform gemini --force
#   ./install.sh --target-home /custom/home
#
# Cursor is not installed by this script - its rules are project-scoped by
# convention; copy cursor/rules/*.mdc into your project's own
# .cursor/rules/ directory manually.

set -euo pipefail

PLATFORM="claude"
FORCE=0
TARGET_HOME="$HOME"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while [ $# -gt 0 ]; do
  case "$1" in
    --platform)
      PLATFORM="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --target-home)
      TARGET_HOME="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

case "$PLATFORM" in
  claude|gemini|codex|all) ;;
  *)
    echo "Invalid --platform '$PLATFORM'. Must be one of: claude, gemini, codex, all." >&2
    exit 1
    ;;
esac

INSTALLED=()
SKIPPED=()

copy_skill_folder() {
  # $1 = source dir, $2 = dest parent dir, $3 = name
  local dest="$2/$3"
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    SKIPPED+=("$dest (already exists, use --force to overwrite)")
    return
  fi
  mkdir -p "$2"
  rm -rf "$dest"
  cp -r "$1" "$dest"
  # Bundle the shared prompt foundations (CONSTITUTION.md, DSL.md, MODEL_*.md)
  # next to every skill so each skill's "<context> shared/..." references resolve.
  if [ -d "$REPO_ROOT/shared" ]; then
    cp -r "$REPO_ROOT/shared" "$dest/shared"
  fi
  INSTALLED+=("$dest")
}

copy_single_file() {
  # $1 = source file, $2 = dest dir
  local filename
  filename="$(basename "$1")"
  local dest="$2/$filename"
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    SKIPPED+=("$dest (already exists, use --force to overwrite)")
    return
  fi
  mkdir -p "$2"
  cp "$1" "$dest"
  INSTALLED+=("$dest")
}

install_claude() {
  echo "Installing HoldMyBeer for Claude Code..."
  local claude_dir="$TARGET_HOME/.claude"
  if [ ! -d "$claude_dir" ]; then
    echo "  Note: $claude_dir does not exist yet - creating it."
  fi

  for skill_dir in "$REPO_ROOT/claude/skills"/*/; do
    name="$(basename "$skill_dir")"
    copy_skill_folder "$skill_dir" "$claude_dir/skills" "$name"
  done
}

install_gemini() {
  echo "Installing HoldMyBeer for Gemini CLI..."
  local gemini_dir="$TARGET_HOME/.gemini"
  for cmd_file in "$REPO_ROOT/gemini/commands"/*.toml; do
    copy_single_file "$cmd_file" "$gemini_dir/commands"
  done

  # Copy prompt skills for Antigravity / Gemini UI integration
  for skill_dir in "$REPO_ROOT/claude/skills"/*/; do
    name="$(basename "$skill_dir")"
    copy_skill_folder "$skill_dir" "$gemini_dir/config/skills" "$name"
    if [ -d "$gemini_dir/antigravity-cli" ]; then
      copy_skill_folder "$skill_dir" "$gemini_dir/antigravity-cli/skills" "$name"
    fi
  done
}

install_codex() {
  echo "Installing HoldMyBeer for Codex CLI..."
  local codex_dir="$TARGET_HOME/.codex"
  for skill_dir in "$REPO_ROOT/codex/skills"/*/; do
    name="$(basename "$skill_dir")"
    copy_skill_folder "$skill_dir" "$codex_dir/skills" "$name"
  done
}

case "$PLATFORM" in
  claude) install_claude ;;
  gemini) install_gemini ;;
  codex) install_codex ;;
  all)
    install_claude
    install_gemini
    install_codex
    ;;
esac

echo ""
echo "===== HoldMyBeer install summary ====="
if [ ${#INSTALLED[@]} -gt 0 ]; then
  echo "Installed:"
  for item in "${INSTALLED[@]}"; do
    echo "  + $item"
  done
else
  echo "Nothing new installed."
fi
if [ ${#SKIPPED[@]} -gt 0 ]; then
  echo "Skipped (use --force to overwrite):"
  for item in "${SKIPPED[@]}"; do
    echo "  - $item"
  done
fi
echo ""
echo "Done. Restart your CLI session if it was already running so it picks up the new skills/commands."

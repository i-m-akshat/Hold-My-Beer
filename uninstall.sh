#!/usr/bin/env bash
#
# Removes HoldMyBeer's skills/commands from one or more supported AI
# coding assistants. Only removes the exact set of files/folders HoldMyBeer
# installs - never wipes an entire skills/commands directory.
#
# Usage:
#   ./uninstall.sh
#   ./uninstall.sh --platform all
#   ./uninstall.sh --target-home /custom/home

set -euo pipefail

PLATFORM="claude"
TARGET_HOME="$HOME"

while [ $# -gt 0 ]; do
  case "$1" in
    --platform)
      PLATFORM="$2"
      shift 2
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

SKILL_NAMES=(holdmybeer-init holdmybeer-spec holdmybeer-plan holdmybeer-code holdmybeer-review)
REMOVED=()

remove_known_folder() {
  # $1 = parent dir, $2 = name
  local target="$1/$2"
  if [ -e "$target" ]; then
    rm -rf "$target"
    REMOVED+=("$target")
  fi
}

remove_known_file() {
  # $1 = parent dir, $2 = filename
  local target="$1/$2"
  if [ -e "$target" ]; then
    rm -f "$target"
    REMOVED+=("$target")
  fi
}

uninstall_claude() {
  echo "Uninstalling HoldMyBeer from Claude Code..."
  local claude_dir="$TARGET_HOME/.claude"
  for name in "${SKILL_NAMES[@]}"; do
    remove_known_folder "$claude_dir/skills" "$name"
    remove_known_file "$claude_dir/commands" "$name.md"
  done
}

uninstall_gemini() {
  echo "Uninstalling HoldMyBeer from Gemini CLI..."
  local gemini_dir="$TARGET_HOME/.gemini"
  for name in "${SKILL_NAMES[@]}"; do
    remove_known_file "$gemini_dir/commands" "$name.toml"
  done
}

uninstall_codex() {
  echo "Uninstalling HoldMyBeer from Codex CLI..."
  local codex_dir="$TARGET_HOME/.codex"
  for name in "${SKILL_NAMES[@]}"; do
    remove_known_folder "$codex_dir/skills" "$name"
  done
}

case "$PLATFORM" in
  claude) uninstall_claude ;;
  gemini) uninstall_gemini ;;
  codex) uninstall_codex ;;
  all)
    uninstall_claude
    uninstall_gemini
    uninstall_codex
    ;;
esac

echo ""
echo "===== HoldMyBeer uninstall summary ====="
if [ ${#REMOVED[@]} -gt 0 ]; then
  echo "Removed:"
  for item in "${REMOVED[@]}"; do
    echo "  - $item"
  done
else
  echo "Nothing found to remove."
fi
echo ""
echo "Note: this only removes HoldMyBeer's own files by exact name - any other skills/commands you have installed are untouched."

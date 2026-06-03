#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/skills" && pwd)"
TARGET_DIR="$HOME/.claude/skills"

mkdir -p "$TARGET_DIR"

for skill_path in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_path")
  target="$TARGET_DIR/$skill_name"

  if [ -L "$target" ]; then
    rm "$target"
  fi

  ln -sf "$skill_path" "$target"
  echo "Linked: $skill_name -> $target"
done

echo "Done. Restart Claude Code for changes to take effect."

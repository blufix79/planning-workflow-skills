#!/usr/bin/env bash
set -euo pipefail

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_REPO="${1:-$(pwd)}"
TARGET_SKILLS_DIR="$TARGET_REPO/.agents/skills"

if [[ ! -d "$TARGET_REPO" ]]; then
  echo "Target repository does not exist: $TARGET_REPO" >&2
  exit 1
fi

mkdir -p "$TARGET_SKILLS_DIR"

for skill_dir in "$PACKAGE_DIR"/skills/*; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"
  rm -rf "$TARGET_SKILLS_DIR/$skill_name"
  cp -R "$skill_dir" "$TARGET_SKILLS_DIR/$skill_name"
  echo "Installed skill: $skill_name"
done

cat <<EOF

Done.

If the target repository does not already contain the planning workflow instructions,
merge this snippet into its AGENTS.md:

  $PACKAGE_DIR/snippets/AGENTS-planning-workflow.md
EOF

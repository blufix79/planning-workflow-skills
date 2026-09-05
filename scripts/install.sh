#!/usr/bin/env bash
set -euo pipefail

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_REPO="$(pwd)"
MERGE_AGENTS=false

usage() {
  cat <<EOF
Usage: $0 [TARGET_REPO] [--merge-agents]

Installs planning workflow skills into TARGET_REPO/.agents/skills.

Options:
  --merge-agents  Idempotently merge snippets/AGENTS-planning-workflow.md into TARGET_REPO/AGENTS.md.
  -h, --help      Show this help.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --merge-agents)
      MERGE_AGENTS=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      TARGET_REPO="$1"
      shift
      ;;
  esac
done

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

if [[ "$MERGE_AGENTS" == true ]]; then
  "$PACKAGE_DIR/scripts/merge-agents-snippet.sh" "$TARGET_REPO"
fi

cat <<EOF

Done.
EOF

if [[ "$MERGE_AGENTS" != true ]]; then
  cat <<EOF

To idempotently merge the planning workflow instructions into AGENTS.md, run:

  $PACKAGE_DIR/scripts/merge-agents-snippet.sh "$TARGET_REPO"

Or rerun this installer with --merge-agents.
EOF
fi

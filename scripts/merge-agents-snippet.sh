#!/usr/bin/env bash
set -euo pipefail

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_REPO="${1:-$(pwd)}"
AGENTS_FILE="$TARGET_REPO/AGENTS.md"
SNIPPET_FILE="$PACKAGE_DIR/snippets/AGENTS-planning-workflow.md"

if [[ ! -d "$TARGET_REPO" ]]; then
  echo "Target repository does not exist: $TARGET_REPO" >&2
  exit 1
fi

if [[ ! -f "$SNIPPET_FILE" ]]; then
  echo "Snippet does not exist: $SNIPPET_FILE" >&2
  exit 1
fi

python3 - "$AGENTS_FILE" "$SNIPPET_FILE" <<'PY'
import re
import sys
from pathlib import Path

agents_path = Path(sys.argv[1])
snippet_path = Path(sys.argv[2])

start_marker = "<!-- planning-workflow:start -->"
end_marker = "<!-- planning-workflow:end -->"

snippet = snippet_path.read_text(encoding="utf-8").strip() + "\n"
if start_marker not in snippet or end_marker not in snippet:
    raise SystemExit(f"Snippet must contain {start_marker!r} and {end_marker!r}")

if agents_path.exists():
    original = agents_path.read_text(encoding="utf-8")
else:
    original = "# Repository instructions\n"

text = original.rstrip() + "\n"
marker_pattern = re.compile(
    rf"{re.escape(start_marker)}.*?{re.escape(end_marker)}\n?",
    re.S,
)
heading_pattern = re.compile(
    r"^## Planning workflow\n.*?(?=^##\s|\Z)",
    re.M | re.S,
)

if marker_pattern.search(text):
    updated = marker_pattern.sub(snippet, text, count=1)
    action = "Updated managed planning workflow block"
elif heading_pattern.search(text):
    updated = heading_pattern.sub(snippet, text, count=1)
    action = "Replaced existing Planning workflow section with managed block"
else:
    separator = "\n" if text.endswith("\n\n") else "\n\n"
    updated = text.rstrip() + separator + snippet
    action = "Appended managed planning workflow block"

if not updated.endswith("\n"):
    updated += "\n"

if updated == original:
    print(f"AGENTS.md already up to date: {agents_path}")
else:
    agents_path.write_text(updated, encoding="utf-8")
    print(f"{action}: {agents_path}")
PY

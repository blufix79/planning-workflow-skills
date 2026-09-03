#!/usr/bin/env bash
set -euo pipefail

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$PACKAGE_DIR/skills"

python3 - "$SKILLS_DIR" <<'PY'
import re
import sys
from pathlib import Path

skills_dir = Path(sys.argv[1])
expected_assets = {
    "plan-roadmap": ["assets/roadmap-template.md"],
    "plan-milestone": ["assets/milestone-template.md"],
    "create-tasks": ["assets/task-template.md"],
    "implement-task": [],
    "close-milestone": ["assets/milestone-review-template.md"],
}

errors = []
found = {p.name for p in skills_dir.iterdir() if p.is_dir()}
missing = set(expected_assets) - found
extra = found - set(expected_assets)
if missing:
    errors.append(f"Missing skills: {', '.join(sorted(missing))}")
if extra:
    errors.append(f"Unexpected skills: {', '.join(sorted(extra))}")

for name in sorted(expected_assets):
    skill = skills_dir / name
    skill_md = skill / "SKILL.md"
    if not skill_md.exists():
        errors.append(f"{name}: missing SKILL.md")
        continue
    text = skill_md.read_text(encoding="utf-8")
    match = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not match:
        errors.append(f"{name}: missing YAML front matter")
        continue
    fields = {}
    for line in match.group(1).splitlines():
        if not line.strip():
            continue
        if ":" not in line:
            errors.append(f"{name}: invalid front matter line: {line}")
            continue
        key, value = line.split(":", 1)
        fields[key.strip()] = value.strip().strip('"')
    if set(fields) != {"name", "description"}:
        errors.append(f"{name}: front matter must contain only name and description, got {sorted(fields)}")
    if fields.get("name") != name:
        errors.append(f"{name}: front matter name mismatch: {fields.get('name')}")
    if not fields.get("description"):
        errors.append(f"{name}: missing description")
    for rel in expected_assets[name]:
        if not (skill / rel).exists():
            errors.append(f"{name}: missing asset {rel}")

if errors:
    print("Validation failed:")
    for error in errors:
        print(f"- {error}")
    sys.exit(1)

print("Validation passed for planning workflow skills.")
PY

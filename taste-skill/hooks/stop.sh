#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
project="${CLAUDE_PROJECT_DIR:-$PWD}"
active=""
if [ -f "$project/.taste-skill/build.json" ]; then
  active=1
else
  while IFS= read -r d; do
    if [ -f "$d/build.json" ]; then active=1; break; fi
  done < <(find "$project" -maxdepth 2 -type d -name .taste-skill 2>/dev/null)
fi
[ -z "$active" ] && exit 0
exec node "$root/scripts/gate.mjs" --hook claude

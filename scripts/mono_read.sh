#!/usr/bin/env bash
# Read mono focus mapping for a repo root from ~/.config/eidos/mono.yaml
# Usage: mono_read.sh [repo_root]
# Defaults to current git repo root (or pwd if not in a git repo).
# Outputs the subpath if mapped, empty string if not.

MONO_FILE="$HOME/.config/eidos/mono.yaml"
REPO_ROOT="${1:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"

if [ ! -f "$MONO_FILE" ]; then
    echo ""
    exit 0
fi

# Find line matching the repo root key
LINE=$(grep -E "^${REPO_ROOT}\s*:" "$MONO_FILE" 2>/dev/null | head -1)

if [ -z "$LINE" ]; then
    echo ""
    exit 0
fi

# Extract value after the colon, trim whitespace
VALUE=$(echo "$LINE" | sed 's/^[^:]*:\s*//' | sed 's/\s*#.*//' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')

echo "$VALUE"

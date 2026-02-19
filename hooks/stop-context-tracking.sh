#!/usr/bin/env bash
# Eidos stop hook — injects [context used: X%] after each AI message.
# Gated by context_tracking config key.

set -euo pipefail

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(dirname "$(dirname "$0")")}"
READ_CONFIG="$PLUGIN_ROOT/scripts/read_config.sh"

# Only activate if project has an eidos/ folder
if [ ! -d "eidos/" ]; then
    exit 0
fi

# Check config
if [ "$(bash "$READ_CONFIG" "context_tracking" "true")" != "true" ]; then
    exit 0
fi

input=$(cat)

# Prevent infinite loop: if stop hook already active, allow stop
stop_active=$(echo "$input" | jq -r '.stop_hook_active // false')
if [ "$stop_active" = "true" ]; then
    exit 0
fi

# Extract context window usage percentage
pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty' 2>/dev/null | cut -d. -f1)

if [ -n "$pct" ]; then
    echo "{\"decision\": \"block\", \"reason\": \"[context used: ${pct}%]\"}"
fi

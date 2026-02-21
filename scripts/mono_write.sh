#!/usr/bin/env bash
# Write or clear mono focus mapping in ~/.config/eidos/mono.yaml
# Usage:
#   mono_write.sh set <repo_root> <subpath>
#   mono_write.sh clear <repo_root>

MONO_FILE="$HOME/.config/eidos/mono.yaml"
ACTION="$1"
REPO_ROOT="$2"
SUBPATH="$3"

if [ -z "$ACTION" ] || [ -z "$REPO_ROOT" ]; then
    echo "Usage: mono_write.sh set <repo_root> <subpath>" >&2
    echo "       mono_write.sh clear <repo_root>" >&2
    exit 1
fi

case "$ACTION" in
    set)
        if [ -z "$SUBPATH" ]; then
            echo "Error: subpath required for set" >&2
            exit 1
        fi
        # Create directory and file if needed
        mkdir -p "$(dirname "$MONO_FILE")"
        if [ ! -f "$MONO_FILE" ]; then
            echo "# eidos mono mappings" > "$MONO_FILE"
        fi
        # Remove existing entry for this repo root (if any)
        if grep -qE "^${REPO_ROOT}\s*:" "$MONO_FILE" 2>/dev/null; then
            # Use a temp file to avoid sed -i portability issues
            grep -v "^${REPO_ROOT}\s*:" "$MONO_FILE" > "${MONO_FILE}.tmp"
            mv "${MONO_FILE}.tmp" "$MONO_FILE"
        fi
        # Append new mapping
        echo "${REPO_ROOT}: ${SUBPATH}" >> "$MONO_FILE"
        echo "Mono focus set: ${REPO_ROOT} → ${SUBPATH}"
        ;;
    clear)
        if [ ! -f "$MONO_FILE" ]; then
            echo "No mono mappings file found."
            exit 0
        fi
        if grep -qE "^${REPO_ROOT}\s*:" "$MONO_FILE" 2>/dev/null; then
            grep -v "^${REPO_ROOT}\s*:" "$MONO_FILE" > "${MONO_FILE}.tmp"
            mv "${MONO_FILE}.tmp" "$MONO_FILE"
            echo "Mono focus cleared for: ${REPO_ROOT}"
        else
            echo "No mapping found for: ${REPO_ROOT}"
        fi
        ;;
    *)
        echo "Unknown action: $ACTION (use 'set' or 'clear')" >&2
        exit 1
        ;;
esac

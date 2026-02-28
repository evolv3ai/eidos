---
tldr: Register a working subdirectory focus in a monorepo
category: utility
---

# /eidos:mono

Register which subdirectory you're actually working in when Claude Code opens at the repo root.
Stored per-user outside the repo, injected automatically at session start.

## Usage

```
/eidos:mono set <path>    # set focus to subdirectory
/eidos:mono clear         # remove focus for this repo
/eidos:mono list          # show all mappings
/eidos:mono               # show current mapping or usage
```

## Instructions

### 1. Determine Repo Root

Run `git rev-parse --show-toplevel` to get the repo root.
If not in a git repo, use the current working directory.

### 2. Route by Command

Parse the arguments to determine which command to run.

#### `set <path>`

1. Resolve `<path>` relative to the repo root
2. Check if the path exists as a directory:
   - **Exists:** proceed
   - **Doesn't exist:** check for close matches (partial name, typo). If a likely match is found, suggest it. Otherwise ask the user for clarification.
3. Run: `bash "$PLUGIN_ROOT/scripts/mono_write.sh" set "<repo_root>" "<path>"`
4. Confirm: `Mono focus set: **<path>** in \`<repo_root>\``

#### `clear`

1. Run: `bash "$PLUGIN_ROOT/scripts/mono_write.sh" clear "<repo_root>"`
2. Confirm: `Mono focus cleared for \`<repo_root>\``

#### `list`

1. Read `~/.config/eidos/mono.yaml`
2. If file doesn't exist or is empty: `No mono mappings set.`
3. Otherwise, list all mappings. Highlight the current repo's entry (if any):

```
Mono mappings (~/.config/eidos/mono.yaml):

→ /Users/omni/repos/mono: repo/eidos        ← current repo
  /Users/omni/repos/other: packages/core
```

#### No args

1. Run: `bash "$PLUGIN_ROOT/scripts/mono_read.sh" "<repo_root>"`
2. If mapping exists: `Mono focus: **<subpath>** (\`<repo_root>/<subpath>\`)`
3. If no mapping: show usage summary

### 3. Access

The `PLUGIN_ROOT` variable points to the eidos plugin directory.
Scripts are at `$PLUGIN_ROOT/scripts/mono_read.sh` and `$PLUGIN_ROOT/scripts/mono_write.sh`.

`PLUGIN_ROOT` is available as `CLAUDE_PLUGIN_ROOT` environment variable, or can be derived from the skill's own path.

## Output

- Reads/writes: `~/.config/eidos/mono.yaml` (external, user-specific)
- No repo files modified

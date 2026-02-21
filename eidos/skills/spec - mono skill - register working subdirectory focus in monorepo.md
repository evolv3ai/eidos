---
tldr: Skill to register a user-specific working subdirectory for monorepo focus — stored outside the repo, injected at session start
---

# Mono Skill — register working subdirectory focus in monorepo

When eidos launches from a parent repo but work focuses on a subdirectory, `eidos:mono` stores that focus externally so every session starts with the right context.

## Target

In monorepos, Claude Code opens at the repo root but the user works in a subdirectory.
Without context, every session starts with "I'm working in sub/repo" — manual, forgettable, tedious.
This skill stores that mapping once, outside the repo, and injects it automatically.

## Behaviour

### Commands

- `eidos:mono set <path>` — register a subdirectory focus for the current repo
  - `<path>` is relative to the repo root
  - Any depth: `c`, `c/d`, `c/d/e` are all valid
  - Resolution: try the literal path first, then check for typos or partial matches, then ask for clarification
  - Overwrites any existing mapping for this repo
- `eidos:mono clear` — remove the mapping for the current repo
- `eidos:mono list` — show all stored mappings, current repo highlighted first
- `eidos:mono` (no args) — show current mapping if set, or explain usage

### Storage

- Mappings live in `~/.config/eidos/mono.yaml` — user-specific, outside any repo
- Key: absolute path of the repo root (from `git rev-parse --show-toplevel` or working directory)
- Value: relative subpath within that repo
- Format:

```yaml
# eidos mono mappings
/Users/omni/repos/mono: repo/eidos
/Users/omni/repos/other: packages/core
```

- The file is created on first `set` if it doesn't exist
- The directory `~/.config/eidos/` is created on first `set` if it doesn't exist

### Config Toggle

- `.eidos-config.yaml` key: `mono_focus` (boolean, default `true`)
- When `false`: session-start skips the mapping check entirely, skill still works for set/clear/list
- Follows [[spec - config - toggleable project settings]] patterns

### Session-Start Injection

When both conditions are met:
1. `mono_focus` config is `true` (or absent — default on)
2. A mapping exists in `~/.config/eidos/mono.yaml` for the current repo root

Inject into session context:

```
## Mono Focus

**IMPORTANT:** You are in repo `<repo_root>` but the user is currently working in `<repo_root>/<subpath>`.
Prefer file operations, commands, and navigation relative to `<subpath>`.

**Say this at the very start of your first response (before anything else):**

> Mono focus: **<subpath>** (`<repo_root>/<subpath>`)
```

### Scripts

- `scripts/mono_read.sh` — reads the mapping for a given repo root from `~/.config/eidos/mono.yaml`
  - Usage: `mono_read.sh [repo_root]` (defaults to current repo root)
  - Outputs the subpath if mapped, empty string if not
- `scripts/mono_write.sh` — sets or clears a mapping
  - Usage: `mono_write.sh set <repo_root> <subpath>` or `mono_write.sh clear <repo_root>`
  - Creates file and directory if needed

## Design

### Why External Storage

The mapping is user-specific and repo-independent:
- Different users of the same repo may focus on different subdirectories
- The mapping shouldn't be committed (it's personal workflow state)
- `~/.config/eidos/` follows XDG conventions and groups with future user-level eidos config

### Separation from Nested Projects

This is the inverse of [[spec - nested projects - sub-project isolation with shared git]]:
- **Nested projects:** workspace is the sub-repo, parent handles git (bottom-up)
- **Mono focus:** workspace is the parent repo, focus on a sub-directory (top-down)

They're separate concerns that don't conflict.

### Injection Wording

The injection is inform + light guidance, not prescriptive.
Saying "prefer file operations relative to `<subpath>`" is enough — Claude already knows how to handle paths once it understands the focus.
The greeting line confirms the mapping is active so the user sees it immediately without needing to ask.

## Verification

- `eidos:mono set packages/core` → mapping stored in `~/.config/eidos/mono.yaml`
- `eidos:mono list` → shows mapping with current repo highlighted
- `eidos:mono clear` → mapping removed
- New session with mapping set → context includes mono focus section, first response starts with greeting
- `mono_focus: false` in config → no injection even when mapping exists
- Nonexistent subpath → skill asks for clarification before storing
- Multiple repos → each has independent mapping

## Interactions

- [[spec - config - toggleable project settings]] — adds `mono_focus` setting
- [[spec - session context - composable snippet based context injection]] — mono injects a context section
- [[spec - nested projects - sub-project isolation with shared git]] — inverse direction, separate concern

## Mapping

> [[skills/mono/mono.md]]
> [[scripts/mono_read.sh]]
> [[scripts/mono_write.sh]]
> [[hooks/session-start.sh]]

## Future

{[?] Auto-detect: if a repo has exactly one subdirectory with its own `eidos/` or `package.json`, suggest setting mono focus}
{[?] Per-branch focus: different branches might focus on different subdirectories}

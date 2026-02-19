---
tldr: Stop hook injects context window usage percentage after each AI message so Claude can plan around capacity
---

# Context Tracking

## Target

Claude has no built-in awareness of how much context window has been consumed.
Without this signal, it can start large tasks near the end of a session, hit the limit mid-work, and lose progress.
A stop hook that injects `[context used: X%]` after each message gives Claude the data to plan proactively.

## Behaviour

- A Stop hook fires after every AI message
- The hook reads `context_window.used_percentage` from the stop hook input
- If `stop_hook_active` is true (second invocation), the hook exits cleanly to prevent infinite loops
- Output: `{"decision": "block", "reason": "[context used: X%]"}` — Claude receives the percentage and stops
- If the percentage is unavailable, the hook allows the stop silently (safe fallback)
- Gated by `context_tracking` config key — disabled means the hook exits immediately
- Only activates when `eidos/` directory exists (standard eidos guard)

### Session Start Instruction

When `context_tracking` is enabled, a feature snippet injects guidance at session start:
- Claude is told to expect `[context used: X%]` updates after each message
- Claude should not produce visible output in response — just absorb the info and stop
- Thresholds guide proactive behaviour:
  - Below 50%: normal operation
  - 50–70%: mention context level if the user starts a large task
  - Above 70%: suggest compacting or clearing before large tasks
  - Above 85%: strongly recommend compacting or starting a new session

## Design

### Hook Flow

```
Claude responds → Stop hook fires
  → stop_hook_active? → yes → exit 0 (allow stop)
  → config enabled?   → no  → exit 0 (allow stop)
  → eidos/ exists?    → no  → exit 0 (allow stop)
  → extract percentage from stdin JSON
  → percentage found? → no  → exit 0 (allow stop)
  → output {"decision": "block", "reason": "[context used: X%]"}
  → Claude receives reason, produces no visible output, stops
  → Stop hook fires again (stop_hook_active = true) → exit 0
```

### Config Gating

Follows the standard feature snippet pattern:
- Hook script checks `context_tracking` via `read_config.sh`
- Feature snippet `inject/feature/context-tracking.md` maps to `context_tracking` config key automatically (filename hyphens → underscores)
- Both the hook and the session start instruction are gated by the same key

### Double-Invocation Pattern

The Stop hook blocks Claude's first stop attempt to deliver the context percentage.
Claude processes the reason, produces no user-visible output, and tries to stop again.
On the second invocation, `stop_hook_active` is true and the hook exits cleanly.
This is the standard Claude Code pattern for stop hooks that inject information.

## Verification

- Enable `context_tracking: true` in `.eidos-config.yaml`
- Send a message — after Claude responds, it should receive `[context used: X%]` and stop without extra visible output
- Disable `context_tracking: false` — no stop hook behaviour, Claude stops normally
- Remove `eidos/` directory — hook exits silently regardless of config

## Friction

- The double-invocation pattern means Claude processes two stop events per message (minor overhead)
- If `context_window.used_percentage` is not present in stop hook input, the feature is silently inactive — no error, but no tracking either
- Claude may occasionally produce minimal visible output despite instructions not to (model compliance varies)

## Interactions

- [[spec - config - toggleable project settings]] — adds `context_tracking` setting
- [[spec - session context - composable snippet based context injection]] — feature snippet follows the standard gating pattern
- [[spec - eidos - spec driven development loops]] — hooks are part of plugin infrastructure

## Mapping

> [[hooks/stop-context-tracking.sh]]
> [[hooks/hooks.json]]
> [[inject/feature/context-tracking.md]]

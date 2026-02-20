---
tldr: Quick snapshot of active plan progress mid-session
category: observation
---

# /eidos:status

Quick "where are we?" for the current session.
Shows plan progress, recent commits, and what's next — without loading full context or creating files.

## Usage

```
/eidos:status
```

## Instructions

### 1. Identify the Active Plan

Find the plan being worked on this session.
Check in order:

1. **Branch name** — if on `task/*`, grep `memory/` for a plan whose claim matches
2. **Recent commits** — check `git log` for plan file updates this session
3. **Memory files** — scan `memory/plan - *` for incomplete plans

If no active plan is found, say so and suggest `/eidos:next` or `/eidos:plan`.

### 2. Read Plan State

Read the plan file.
Extract:

- **Plan name** — wiki link
- **Phase progress** — which phase is active, how many actions done vs total per phase
- **Current action** — the next `[ ]` action (skip `[p]` postponed)
- **Open observations** — any non-FIXED observations
- **Blockers** — anything that looks stalled or waiting on input

### 3. Gather Branch Activity

```bash
# Commits on this branch since diverging from main
git log main..HEAD --oneline
```

Count only — don't list every commit unless there are fewer than 5.

### 4. Present

Keep it tight.
No numbered-list format — this isn't a selection prompt, it's a dashboard glance.

```
**Plan:** [[plan - YYMMDDHHMM - claim]]

**Progress:**
- Phase 1: done (3/3)
- Phase 2: in progress (2/5)
- Phase 3: pending (0/4)

**Current:** Implement login endpoint (Phase 2.3)

**Branch:** `task/add-auth` — 7 commits

**Observations:** 2 open (O1: styling issue, O3: error on empty input)

**Next:** Implement logout endpoint (Phase 2.4)
```

Omit sections that don't apply (e.g., no observations section if there are none).

If multiple incomplete plans exist, show the most recently touched one and mention the others in a line:
```
Also open: [[plan - YYMMDDHHMM - other plan]] (Phase 1, 1/3)
```

### 5. No File Output

This skill is read-only — it only reports.
No files created or modified.

## Output

No files created or modified.

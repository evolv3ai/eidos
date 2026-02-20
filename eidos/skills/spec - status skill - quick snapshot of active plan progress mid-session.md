---
tldr: Quick snapshot of active plan progress mid-session
---

# /eidos:status

## Target

Mid-session, you want a quick "where are we?" without re-loading context or creating files.
You're already working on a plan — you just need the dashboard view: phase progress, current action, what's next.

## Behaviour

- Identifies active plan from branch name, recent commits, or memory scan
- Reads plan file for phase/action progress
- Shows current action and next action (skips `[p]` postponed)
- Notes open observations if any
- Reports branch commit count
- Presents a tight, non-interactive summary

## Design

Read-only — creates no files, modifies nothing.
Not a selection prompt — a dashboard glance.

Distinct from adjacent skills:
- **status** = "where are we right now?" (mid-work snapshot)
- **next** = "what should I work on?" (scans everything, presents choices)
- **plan-continue** = "let's resume" (loads context and starts working)
- **compact** = "can I safely leave?" (pre-exit check)
- **pickmeup** = "what happened while I was away?" (re-entry after days)

## Interactions

- [[spec - plan-continue skill - resume work on existing plan]] — heavier alternative that loads context and resumes
- [[spec - next skill - aggregate actionable items across project]] — broader scope, interactive
- [[spec - compact skill - pre-compact readiness check]] — end-of-session counterpart
- [[spec - pickmeup skill - resurface recent activity for project re-entry]] — cross-session counterpart

## Mapping

> [[skills/status/status.md]]

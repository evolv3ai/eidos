---
tldr: Actions in plans and experiments carry two kinds of sub-bullets — plain bullets are input context (pre-action), arrow bullets are output context (post-action)
---

# Actions carry input and output context — plain bullets before, arrow bullets after

Every action (plan action, experiment step) accumulates context in two layers:

- **Input context** (plain bullets) — what we know going in: notes, constraints, instructions, references.
  Written when the action is created or before starting work.
- **Output context** (`=>` bullets) — what emerged coming out: observations, decisions, created files, follow-ups.
  Written during or after execution.

```
1. [x] Implement login endpoint
   - use bcrypt for password hashing          ← input
   - check existing middleware for patterns    ← input
   - => session tokens chosen over JWT        ← output
   - => [[spec - auth - ...]] created         ← output
   - => {[!] add rate limiting to login}      ← output
```

The two layers are visually distinct — plain vs `=>` — making it immediately clear what was planned vs what emerged, without reading timestamps or commit history.

## Where this applies

- **Plans:** action sub-bullets.
  Input notes are added when drafting the plan.
  `=>` notes are added as each action is completed.
  See [[template - plan - structured phases with actions and progress tracking]].
- **Experiments:** step sub-bullets and outcome lines.
  The Intent and Try sections are input; Outcome lines and `=>` markers are output.
  See [[spec - experiment skill - log based iterative exploration with emergent phases]].

## The `=>` prefix

The arrow syntax is defined in [[c - arrow prefix marks inline outcomes that emerged during execution]].
This claim is about the *principle* (actions have pre/post context); that claim is about the *syntax* (`=>` as the marker).

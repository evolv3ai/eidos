---
tldr: Generate structured summary for file or session
category: utility
---

# /eidos:summary

Summarise a file or session.

## Usage

```
/eidos:summary [file]
```

## Instructions

1. Read the target file
2. Extract: key points, decisions made, artifacts created, open questions
3. Run `date '+%y%m%d%H%M'` to get the current timestamp.
4. Create `memory/summary - <timestamp> - <claim>.md` (per [[spec - naming - prefixes structure filenames as prefix claim pairs]], e.g. `summary - 2602141030 - auth module overview.md`):

```markdown
---
tldr: Summary of [source]
category: utility
---

# Summary: [source]

## Key Points

- [Main takeaways]

## Decisions

- [Decisions made, with rationale]

## Created Artifacts

- [[links to files created]]

## Open Questions

- [Unresolved items]
```


## Output

- Creates: `memory/summary - <timestamp> - <claim>.md`

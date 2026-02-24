---
tldr: Export conversation to markdown
category: utility
---

# /eidos:tomd

Export the current conversation to markdown.

## Usage

```
/eidos:tomd [optional claim]
```

## Instructions

1. If no claim provided, derive one from the session's main topic
2. Run `date '+%y%m%d%H%M'` to get the current timestamp.
3. Create `memory/session - <timestamp> - <claim>.md` (per [[spec - naming - prefixes structure filenames as prefix claim pairs]], e.g. `session - 2602141030 - auth implementation session.md`)
4. Format the conversation as readable markdown:
   - Preserve human/assistant turns
   - Include code blocks
   - Omit tool call details (keep results if informative)

## Output

- Creates: `memory/session - <timestamp> - <claim>.md`

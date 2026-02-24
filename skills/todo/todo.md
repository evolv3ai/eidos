---
tldr: Create todo files quickly
category: utility
---

# /eidos:todo

Quickly capture a task.

## Usage

```
/eidos:todo [description]
```

## Instructions

1. If no description provided, ask what needs doing
2. Run `date '+%y%m%d%H%M'` to get the current timestamp.
3. Create `memory/todo - <timestamp> - <claim>.md` (per [[spec - naming - prefixes structure filenames as prefix claim pairs]], e.g. `todo - 2602101400 - audit error handling consistency.md`):

```markdown
---
tldr: [description]
category: utility
---

# Todo: [description]

[Optional context, links to related specs or files]
```


When a todo is completed, rename from `todo -` to `solved -` (preserving timestamp and claim), update wiki links, and commit.

## Output

- Creates: `memory/todo - <timestamp> - <claim>.md`

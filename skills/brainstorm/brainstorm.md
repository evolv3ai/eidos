---
tldr: Brainstorm ideas around a topic and capture them in a structured file
category: planning
---

# /eidos:brainstorm

Generate and structure ideas around a topic.
Starts broad, then clusters and selects standouts.

## Usage

```
/eidos:brainstorm [topic or question]
```

## Instructions

### 1. Orient

If the topic is broad or vague, use AskUserQuestion to focus:
- What are we brainstorming about?
- Any constraints or directions to favour?
- What would a good outcome look like?

If the topic is already clear, confirm and proceed.

### 2. Gather Context

Search for related artifacts:
- Specs in `eidos/` that touch the same domain
- Prior research, decisions, or brainstorms in `memory/`
- Code that relates

Note relevant context — it seeds better ideas.

### 3. Create Brainstorm File

Read the template: [[template - brainstorm - structured ideation around a topic]]

Run `date '+%y%m%d%H%M'` to get the current timestamp.
Create `memory/brainstorm - <timestamp> - <claim>.md` (per [[spec - naming - prefixes structure filenames as prefix claim pairs]], e.g. `brainstorm - 2602101400 - alternative auth approaches.md`) with the Seed filled in.
Commit immediately.

### 4. Generate Ideas

Produce an initial batch of ideas — aim for breadth.
Include both obvious and unconventional options.
Write them to the Ideas section as you go.

Then ask the user:
- What resonates?
- What's missing?
- Any directions to push further?

Add the user's ideas and any new ones sparked by the conversation.
Update the file and commit.

### 5. Cluster and Select

Group ideas into themed clusters.
Let themes emerge from the ideas — don't impose categories.

Highlight standouts with brief rationale.
Update the file and commit.

### 6. Offer Next Steps

```
Brainstorm captured: [[brainstorm - <timestamp> - <claim>]]

Options:
1 - Create specs from standouts with /eidos:spec
2 - Plan implementation with /eidos:plan
3 - Create a decision file to choose between options
4 - Done for now
```

## Output

- Creates: `memory/brainstorm - <timestamp> - <claim>.md`
- Status field starts as `active`, set to `complete` when done

---
tldr: Constructive pushback on a proposal — surface blind spots, alternatives, and risks without being adversarial
---

# /eidos:challenge

## Target

When proposing an idea, it's easy to miss risks, alternatives, or tensions with existing work.
This skill provides honest feedback — not adversarial pushback, but the things you'd want a thoughtful collaborator to surface before you commit.

## Behaviour

- Args: the proposal or idea to challenge
- Reads the proposal and assumes it has merit
- Surfaces feedback across applicable categories: blind spots, alternatives, risks, simplification, tension with existing specs/decisions
- Explains *why* each point matters, not just what it is
- Closes with an overall assessment and suggested next step
- Does not manufacture objections — if the idea is solid, says so

## Design

Challenge sits between brainstorm (divergent generation) and decision (convergent selection).
Brainstorm expands options; challenge stress-tests a specific one; decision records the choice.

The tone distinction matters: "have you considered..." not "this is wrong because...".
The skill should make the user feel informed, not defensive.

### Categories

Each is optional — skip any that don't apply:

1. **Blind spots** — things the proposal doesn't address that it probably should
2. **Alternatives** — other approaches that might achieve the same goal, with trade-offs
3. **Risks** — what could go wrong or become painful later
4. **Simplification** — is there a simpler version that captures 80% of the value?
5. **Tension** — does this conflict with existing specs, patterns, or decisions?

## Verification

- Feedback is specific to the proposal, not generic advice
- Each point explains why it matters
- Tone is collaborative, not combative
- Overall assessment is honest — doesn't hedge everything into "it depends"
- No manufactured objections just to fill categories

## Interactions

- [[spec - decision skill - record significant choices with rationale]] — challenge often precedes a decision
- [[spec - plan skill - structured plan for multi step work]] — challenge can evaluate a plan approach before committing
- [[c - agency in implementation not direction - surface reasoning for human steering]] — challenge is the skill form of this principle

## Mapping

> [[skills/challenge/challenge.md]]

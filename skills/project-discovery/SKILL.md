---
name: project-discovery
description: Turn a vague project or feature idea into verified requirements and a completed project profile. Use at project kickoff, when requirements are ambiguous or contradictory, when the user says "I want a site/app that..." without specifics, or when PROJECT.md has load-bearing [REQUIRES HUMAN INPUT] gaps blocking work.
---

# Project Discovery & Requirements

## Outcome

A truthful, filled-in [project profile → AGENTS.md](../../../AGENTS.md) plus a short requirements brief: users, journeys, scope, non-goals, constraints — enough that planning can start without guessing.

## When to use

- New project kickoff, or first session in an unfamiliar codebase
- "Build me a ___" with undefined audience, scope, or success criteria
- Conflicting or drifting requirements mid-project
- A `[REQUIRES HUMAN INPUT]` field in PROJECT.md is now blocking a decision

## When NOT to use

- Requirements are clear and PROJECT.md is current → go to [technical-planning](../technical-planning/SKILL.md)
- The unknown is technical ("which library?") not product ("for whom, to do what?") → [technical-planning](../technical-planning/SKILL.md) or an [ADR](../../docs/decisions.md)

## Required context & inputs

- Existing repo (if any): read code, README, configs — facts beat memory
- [project profile → AGENTS.md](../../../AGENTS.md) current state
- The human's availability to answer questions (this skill is a dialogue, not a monologue)

## Workflow

1. **Harvest what exists** — repo, docs, prior conversation. List KNOWN (with source) vs UNKNOWN. Never move an assumption into KNOWN.
2. **Ask, in batches, highest-leverage first** — audience & top 3 user journeys; the problem being solved (not the feature list); business constraints (deadline, budget, brand, legal/regulatory); data sensitivity (§ personal data? payments? → flags [security-review](../security-review/SKILL.md) later); explicit non-goals. Ask few, specific questions with recommended defaults; don't interrogate.
3. **Draft the profile** — fill [project profile → AGENTS.md](../../../AGENTS.md) sections; every remaining unknown stays visibly `[REQUIRES HUMAN INPUT]`, never silently defaulted.
4. **Write the requirements brief** — one page: users, journeys, must/should/won't scope, constraints, risks, open questions. Must/won't lines are testable statements, not vibes.
5. **Confirm** — human reviews the brief; corrections applied; only then does planning start.

## Deliverables

- Updated [project profile → AGENTS.md](../../../AGENTS.md)
- Requirements brief (in PROJECT.md or the task/PR description)
- Open-questions list with owners

## Quality checklist

- [ ] Every profile fact has a source (human said / found in repo) — zero invented facts
- [ ] Non-goals stated (scope has edges)
- [ ] Data sensitivity classified; regulated data flagged to [security-review](../security-review/SKILL.md)
- [ ] Remaining unknowns are visible, not papered over
- [ ] Gate D ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md)) — docs updated in this change

## Validation

Read the brief back to the human and get explicit confirmation. A silent human is not a confirmed brief.

## Common failure modes

- **Solutioning during discovery** — capturing "use Postgres" before knowing the data; park tech in "candidate decisions"
- **Happy-path journeys only** — ask what failure/edge cases matter (refunds? cancellations? offline?)
- **Invented personas** — audience claims must come from the human, analytics, or research — never imagination
- **Endless discovery** — timebox; ship the brief with open questions marked rather than stalling work

## Security considerations

Data-sensitivity classification happens HERE — it drives every later security decision ([SECURITY.md §7](../../standards/SECURITY.md)). Don't collect real user data during discovery; examples stay synthetic.

## Related

- Next: [technical-planning](../technical-planning/SKILL.md) · Profile: [project profile → AGENTS.md](../../../AGENTS.md) · Decisions: [decisions process](../../docs/decisions.md)

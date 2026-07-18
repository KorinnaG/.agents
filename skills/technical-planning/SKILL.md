---
name: technical-planning
description: Produce a short written implementation plan before non-trivial work — scope, touched files, data/API changes, risks, test plan, rollback. Use for any multi-file change, new feature, dependency, schema, auth surface, or when the approach is debatable. Required by AGENTS.md §5 for complex tasks.
---

# Technical Planning

## Outcome

A written, reviewable plan the human can approve in one read, and that implementation can be checked against afterwards.

## When to use

- Any complex task per [/AGENTS.md §5](../../../AGENTS.md): multi-file, new feature, dependency, schema, auth, public API
- Two+ plausible approaches exist and the choice matters
- Estimated work > ~1 hour or touches > ~3 files

## When NOT to use

- Simple tasks (single-file, cosmetic, no behavior change) — AGENTS.md simple workflow
- Product requirements themselves are unclear → [project-discovery](../project-discovery/SKILL.md) first
- The decision is architectural and long-lived → plan here, but record the choice as an [ADR](../../docs/decisions.md)

## Required context & inputs

- [project profile → AGENTS.md](../../../AGENTS.md) (stack, commands, constraints) + relevant [ADRs](../../docs/decisions.md)
- **The actual code** you'll touch — read it before planning; plans from imagination are fiction
- The requirement/brief; acceptance criteria if they exist

## Workflow

1. **Restate the goal** — one sentence: user-visible outcome + how we'll know it works. Mismatch with the request → clarify now.
2. **Survey** — read the code paths involved; list every file/module expected to change; note current patterns to follow ([STANDARDS.md](../../standards/STANDARDS.md), [ARCHITECTURE.md](../../standards/ARCHITECTURE.md)).
3. **Choose the approach** — if alternatives exist, 2–3 bullets each: what, cost, risk; pick one with a reason. ADR-trigger decisions get a drafted ADR.
4. **Write the plan** (≤ 1 page):
   - Scope: in / out
   - Steps in order, each small and verifiable
   - Data/API/schema changes (exact shapes)
   - UI states impacted ([DESIGN-UX.md §6](../../standards/DESIGN-UX.md))
   - Security surface touched → which [SECURITY.md](../../standards/SECURITY.md) sections apply
   - Test plan (what proves it, per [TESTING.md](../../standards/TESTING.md))
   - Risks & rollback (how we undo this)
   - Assumptions, explicitly
5. **Gate with the human** — required when the plan changes product behavior, cost, data handling, dependencies, or security posture ([/AGENTS.md §10](../../../AGENTS.md)). Otherwise present it and proceed.
6. **Track drift** — during implementation, when reality diverges, update the plan and say so; big divergence = stop and re-plan.

## Deliverables

- The written plan (task/PR description or working notes shown to the human)
- Drafted ADR(s) when triggered

## Quality checklist

- [ ] Every step is checkable ("add X to Y", not "improve Z")
- [ ] Touched files listed from reading code, not guessed
- [ ] Test plan and rollback exist before code is written
- [ ] Assumptions separated from facts
- [ ] Human approval obtained where §10 requires it

## Validation

After implementation, diff the outcome against the plan: every deviation gets one line of explanation in the final report.

## Common failure modes

- **Plan-as-essay** — pages of prose nobody reviews; keep ≤ 1 page, bullets
- **Planning the code you wish existed** — always read the real code first
- **Silent drift** — implementation quietly abandons the plan; update or re-plan out loud
- **Skipping rollback** — "how do we undo this" answered only during an incident

## Security considerations

The plan must name its security surface (auth? input? new endpoint? new dependency?) so [security-review](../security-review/SKILL.md) is scheduled, not discovered late. A plan that says "no security impact" must say why.

## Related

- Before: [project-discovery](../project-discovery/SKILL.md) · After: implementation skills per [/AGENTS.md §7](../../../AGENTS.md) routing · Decisions: [decisions process](../../docs/decisions.md)

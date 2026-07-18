---
name: ux-review
description: Judge whether a flow actually works for users — hierarchy, task completion, feedback, trust, friction — and produce prioritized, actionable findings. Use before redesigns, after building significant flows, when users report confusion, or when someone says "make it better/easier/cleaner" without a defect list.
---

# UX Review

## Outcome

A prioritized findings report — what blocks users, what erodes trust, what adds friction — each finding tied to evidence and a concrete recommendation, ready to route into implementation.

## When to use

- Kickoff of a redesign ([ui-redesign workflow](../../workflows/ui-redesign.md) step 1)
- A significant new flow just shipped and deserves a critical pass
- "Users are confused / drop off / it feels clunky" — symptoms without a diagnosis
- Periodic quality pass over a core journey

## When NOT to use

- Rendering defects (overflow, misalignment) → [visual-qa](../visual-qa/SKILL.md) — that's the mechanical sweep; this is judgment
- WCAG conformance → [accessibility-audit](../accessibility-audit/SKILL.md) (overlaps are noted, not duplicated)
- You already know the fix and it's small → just do it via [ui-implementation](../ui-implementation/SKILL.md)

## Required context & inputs

- The flow's purpose and its user ([project profile → AGENTS.md](../../../AGENTS.md) journeys) — you can't judge a flow without knowing what success is
- Working access to the flow (running app/staging), or at minimum full-state screenshots
- Analytics/user feedback if any exists (optional but gold)

## Workflow

1. **Walk it as the user** — perform the actual task start-to-finish (not a screen gallery): the primary journey, on mobile viewport first, then desktop. Note every hesitation: "where do I click?", "did that work?", "what does this error mean?".
2. **Judge against the standards** — for each screen in the flow, check [DESIGN-UX.md](../../standards/DESIGN-UX.md): ONE unmistakable primary action (§3)? hierarchy readable at a glance? all states present and humane (§6)? copy verbs-first and blame-free (§7)? feedback timing right (§6)?
3. **Stress the unhappy paths** — submit invalid input, go back mid-flow, refresh mid-task, lose connection where relevant: is work preserved? is recovery obvious?
4. **Check trust signals** — destructive actions confirmed proportionately; prices/consequences visible before commitment; no dark patterns (forced continuity, hidden costs, guilt copy) — flag any found as high severity.
5. **Write findings** — each: *severity (blocker / major / minor / polish) · where · what happens · why it hurts (which principle/evidence) · recommendation*. Concrete beats clever: "Submit gives no pending state → double submits" not "improve feedback".
6. **Prioritize & route** — blockers/majors → fixes via [ui-implementation](../ui-implementation/SKILL.md) (or [design-system](../design-system/SKILL.md) when systemic); systemic direction problems → redesign workflow with human decision.

## Deliverables

- Findings report, prioritized, with screenshots as evidence
- Routed follow-ups (fix list or redesign proposal) — a review that spawns no action items states explicitly that the flow passes

## Quality checklist

- [ ] Reviewed by *doing the task*, both mobile and desktop viewports
- [ ] Unhappy paths exercised, not imagined
- [ ] Every finding has severity + evidence + recommendation
- [ ] Dark patterns explicitly checked
- [ ] Report readable by a human who wasn't there

## Validation

The findings must be reproducible: another agent following "where + what happens" sees the same issue. Spot-check the top 3 before delivering.

## Common failure modes

- **Screen-by-screen aesthetics review** — UX lives in the task, not the screenshot
- **Vague findings** — "feels cluttered" without which elements and which principle
- **Rewriting the product** — findings must respect scope and [project profile → AGENTS.md](../../../AGENTS.md) non-goals; big ideas go in a separate "opportunities" note
- **Only the happy path** — the review's main value is where things go wrong

## Security considerations

UX and security meet at the seams: error messages that enumerate users, flows that leak other users' data in shared-screen situations, destructive actions without confirmation. Flag these as security findings too ([SECURITY.md §3, §6](../../standards/SECURITY.md)).

## Related

- [visual-qa](../visual-qa/SKILL.md) (mechanical counterpart) · [accessibility-audit](../accessibility-audit/SKILL.md) · [ui-implementation](../ui-implementation/SKILL.md) (where findings go) · [DESIGN-UX.md](../../standards/DESIGN-UX.md)

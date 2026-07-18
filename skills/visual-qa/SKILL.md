---
name: visual-qa
description: Mechanical screenshot-based inspection of rendered UI at mobile/tablet/desktop sizes — overflow, clipping, alignment, readability, layout shift, token consistency, missing states. Use after ANY UI change, before merging UI work, and as the verification step of redesigns.
---

# Visual QA (Screenshot Sweep)

## Outcome

Evidence-backed confirmation that the UI renders correctly at every supported size and state — or a concrete defect list with screenshots. Findings get fixed, not shipped-with-notes.

## When to use

- After any change that renders differently — always, even "tiny" CSS tweaks
- Pre-merge gate R/V for UI diffs ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))
- Before/after evidence for redesigns ([ui-redesign workflow](../../workflows/ui-redesign.md))

## When NOT to use

- Judging whether the flow *works for users* → [ux-review](../ux-review/SKILL.md)
- WCAG conformance beyond the visual overlaps → [accessibility-audit](../accessibility-audit/SKILL.md)
- No UI changed → skip; this gate is for rendered surfaces

## Required context & inputs

- A running app (dev server or preview) with the changed UI reachable
- The list of changed screens/components (from the diff)
- Theming scope (dark mode? both get swept) and supported breakpoints ([project profile → AGENTS.md](../../../AGENTS.md), default 375/768/1440)

## Workflow

1. **Enumerate surfaces** — every screen/component the diff touches, plus screens that share changed components (grep usages — the regression is usually where you didn't look).
2. **Screenshot matrix** — each surface × {375, 768, 1440} × {light, dark if themed} × key states (default + loading + empty + error at minimum; interactive states where feasible). Use the browser/preview tooling available; name shots `surface-breakpoint-state`.
3. **Inspect each shot deliberately** against the [DESIGN-UX.md §8](../../standards/DESIGN-UX.md) list:
   - overflow & clipping (incl. horizontal page scroll — instant fail)
   - alignment & spacing rhythm (accidental near-alignments, uneven gaps)
   - unreadable text (size, contrast, measure, truncation collisions)
   - layout shift on load/interaction (reserve space; watch fonts/images pop)
   - token consistency (rogue colors/radii/shadows vs [design-system](../design-system/SKILL.md))
   - missing/broken states; image fallbacks; long-content behavior
4. **Stress once** — resize through the range (not just the three points) for one key surface; zoom 200%; longest realistic content in the most constrained slot.
5. **Fix and re-sweep** — defects found are fixed now (route systemic ones to [design-system](../design-system/SKILL.md)); re-screenshot the fixed surfaces. Only unfixable-in-scope items get reported as open, with reasons.
6. **Attach evidence** — final screenshots accompany the done-report; before/after pairs for redesigns.

## Deliverables

- Screenshot set (final state) attached/linked in the report
- Defect list with per-item status: fixed / open-with-reason
- Gate R + V verdict for [QUALITY-GATES.md](../../standards/QUALITY-GATES.md)

## Quality checklist

- [ ] Full matrix covered (surfaces × breakpoints × themes × key states) — gaps named
- [ ] Zero horizontal page scroll anywhere
- [ ] Zero clipped/overlapping content at 320–1440
- [ ] No CLS on load in the swept flows
- [ ] Every defect fixed or explicitly open with a reason

## Validation

The screenshots ARE the validation — claims without attached images don't count. "Swept it, looks fine" with no evidence = gate not run ([/AGENTS.md §13](../../../AGENTS.md)).

## Common failure modes

- **Happy-state-only sweep** — error/empty/loading are where layouts break
- **Three perfect widths, broken between** — the 900px tablet-landscape gap; do the resize pass
- **Sweeping only the edited file's screen** — shared components regress elsewhere
- **Report-and-ship** — visual QA that files defects instead of fixing them defeats the gate

## Security considerations

Screenshots are artifacts that travel: never capture real personal data, tokens, or secrets in swept screens — use seeded/synthetic data ([SECURITY.md §1, §7](../../standards/SECURITY.md)). Redact anything sensitive before attaching.

## Related

- [DESIGN-UX.md §8](../../standards/DESIGN-UX.md) (the inspection list) · [ui-implementation](../ui-implementation/SKILL.md) (produces what this checks) · [ux-review](../ux-review/SKILL.md) (judgment counterpart) · [accessibility-audit](../accessibility-audit/SKILL.md)

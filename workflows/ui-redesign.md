# Workflow — UI redesign

Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — [ux-review](../skills/ux-review/SKILL.md) of the current UI: what actually fails (hierarchy? density? states? trust?); screenshot the "before" at 3 breakpoints.
2. **Plan** — updated art direction / tokens ([design-system](../skills/design-system/SKILL.md)); human approves direction **before** mass implementation; ADR if the design system changes materially.
3. **Implement** — tokens first, then components, then pages ([ui-implementation](../skills/ui-implementation/SKILL.md)); keep behavior changes out of the redesign diff.
4. **Validate** — full UI gates (A, R, St, V, P) at all breakpoints; before/after screenshots.
5. **Review** — [visual-qa](../skills/visual-qa/SKILL.md) sweep + anti-generic check ([DESIGN-UX.md §1](../standards/DESIGN-UX.md)).
6. **Document** — design tokens/direction recorded; before/after kept with the change.

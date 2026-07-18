---
name: design-system
description: Establish or evolve the project's visual language — art direction, design tokens (color, type, spacing, radius, elevation, motion), and the reusable component vocabulary. Use before the first UI is built, when visuals drift inconsistent, or when a redesign changes the visual direction.
---

# Design System & Tokens

## Outcome

A committed token layer and component vocabulary that make the intended art direction the path of least resistance — so every screen looks deliberately designed by the same hand.

## When to use

- Project has UI but no tokens (magic values everywhere), or is about to get its first UI
- Visual drift: three button styles, five grays, inconsistent radii
- Redesign changes direction ([ui-redesign workflow](../../workflows/ui-redesign.md)) — tokens move first
- Adding a component that will be reused (the second consumer just appeared)

## When NOT to use

- Building a screen with the existing system → [ui-implementation](../ui-implementation/SKILL.md)
- Judging whether a flow works for users → [ux-review](../ux-review/SKILL.md)
- One-off page polish that doesn't touch shared values

## Required context & inputs

- [DESIGN-UX.md](../../standards/DESIGN-UX.md) (binding standards, incl. anti-generic rules §1)
- Brand inputs from the human: existing brand? references they like? (required for direction; a made-up brand voice is a proposal, clearly labeled)
- Current UI inventory if one exists (screenshot sweep of what's live)

## Workflow

1. **Set the art direction** — with the human: 3 personality adjectives, typographic voice, color story, density, motion character ([DESIGN-UX.md §1](../../standards/DESIGN-UX.md)). Write it down; a direction that lives in one agent's context dies with the session. Material direction changes = ADR.
2. **Build the token layer** — per [DESIGN-UX.md §2](../../standards/DESIGN-UX.md): raw palette → semantic tokens (`--color-bg`, `--color-danger`); one type scale ≤2 families; one spacing scale; radius/elevation/motion/breakpoint sets. Implement in the stack's mechanism (CSS custom properties by default). Contrast-check every text/background pair NOW, not at audit time.
3. **Define the component vocabulary** — the ~10–20 primitives the product needs (button, input, select, card, dialog, toast, table, badge, skeleton…). For each: variants, sizes, and ALL states from [DESIGN-UX.md §6](../../standards/DESIGN-UX.md) designed in, incl. focus-visible.
4. **Document usage** — where a component gallery/storybook exists, use it; minimum: a doc listing each primitive, when to use which variant, and do/don't examples with realistic content.
5. **Enforce** — lint/stylelint against raw hex/px where tooling allows; review rule: **no magic values in component code** — a needed value that has no token becomes a token first.
6. **Evolve, don't fork** — new needs extend the system (new token, new variant) rather than one-off styles; deprecate old tokens with a migration note instead of leaving both.

## Deliverables

- Token files committed + wired into the build
- Primitive components with full states
- Direction + usage doc (and ADR when direction changed materially)

## Quality checklist

- [ ] Every token group from [DESIGN-UX.md §2](../../standards/DESIGN-UX.md) exists and is used by the primitives
- [ ] All text/bg pairs pass WCAG 2.2 AA contrast; focus states designed, visible, on-brand
- [ ] Anti-generic check passes — at least one deliberate distinctive element; no default-because-default choices
- [ ] Primitives ship all applicable states with realistic content
- [ ] Gates 1–5, A, V, D, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

- Contrast: run the checks (tooling or manual ratios) and record results
- Render the primitive set at 375/768/1440 ([visual-qa](../visual-qa/SKILL.md) pass) — consistent rhythm, zero rogue values
- Grep components for raw hex/px spacing outside token definitions — zero hits (or each justified)

## Common failure modes

- **Palette without semantics** — 40 raw colors, no meaning; components must consume semantic tokens
- **Token soup** — 9 grays and 14 spacing steps nobody can choose between; fewer, named, sufficient
- **States as afterthought** — primitives shipped with only default+hover; the eight states are the spec
- **Generic drift** — defaults accumulate until the product looks like every AI mock; re-run the §1 check on every evolution

## Security considerations

Minimal, but real: third-party fonts/icons are dependencies ([dependency-review](../dependency-review/SKILL.md)) — self-host where feasible (also a privacy + performance win); no external asset loaded from an untrusted CDN without a reason and CSP coverage ([SECURITY.md §5](../../standards/SECURITY.md)).

## Related

- [DESIGN-UX.md](../../standards/DESIGN-UX.md) (the standard) · [ui-implementation](../ui-implementation/SKILL.md) (consumes this) · [accessibility-audit](../accessibility-audit/SKILL.md) · [visual-qa](../visual-qa/SKILL.md)

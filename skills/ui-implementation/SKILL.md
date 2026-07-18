---
name: ui-implementation
description: Build production-quality UI — pages, components, layouts — from the design system: responsive at all breakpoints, all eight states, accessible semantics, purposeful motion, realistic content. Use for any task that renders something users see ("add a page/section/form/component", "implement this design").
---

# UI Implementation

## Outcome

Shipped UI that matches the design system, works at every supported size with every state handled, passes accessibility, and looks intentionally designed with realistic content — not a happy-path mock.

## When to use

- "Add/build/implement" any page, section, component, form, or layout
- Translating a design/mock/description into working UI
- Substantial visual rework of an existing screen (with [ux-review](../ux-review/SKILL.md) first if the *problem* is unclear)

## When NOT to use

- Shared tokens/primitives need to change → [design-system](../design-system/SKILL.md) first, then return here
- Diagnosing why a flow underperforms → [ux-review](../ux-review/SKILL.md)
- Logic/data-shape work behind the UI → [frontend-architecture](../frontend-architecture/SKILL.md) / [backend-api-design](../backend-api-design/SKILL.md)

## Required context & inputs

- [DESIGN-UX.md](../../standards/DESIGN-UX.md) (binding) + existing tokens/primitives (inventory them BEFORE building anything new)
- The content: real copy/data or realistic stand-ins — **never lorem ipsum** (§7)
- Data contract for dynamic UI (shapes, nullability, error cases) — drives the states

## Workflow

1. **Compose from the system** — reuse primitives/tokens; a missing piece goes into the system via [design-system](../design-system/SKILL.md), not as a local one-off. No magic values.
2. **Semantic structure first** — landmarks, heading order, `button` vs `a`, lists as lists, labels tied to inputs. Semantics are the skeleton; styling hangs on it.
3. **Layout mobile-first** — build 375px → enhance 768 → 1440 ([DESIGN-UX.md §4](../../standards/DESIGN-UX.md)); modern CSS (flex/grid/container queries as fits the stack); wide content scrolls in its own container; test ~320px for overflow.
4. **Implement ALL applicable states** — loading (layout-reserved, no CLS), empty (with next action), error (recoverable, input preserved), success, disabled, hover, active, focus-visible ([§6](../../standards/DESIGN-UX.md)). Forms: pending, double-submit guard, field-level errors announced.
5. **Wire interactions accessibly** — keyboard operability for everything; focus management on dialogs/menus (trap, restore); `prefers-reduced-motion` variant for any significant animation; touch targets ≥44px.
6. **Motion with meaning** — durations/easings from tokens; animation communicates (feedback, orientation) or it goes.
7. **Real content pass** — long names, long emails, 0 items, 1 item, 1000 items, missing images. Truncation/wrapping decided, not accidental.
8. **Verify** — run [visual-qa](../visual-qa/SKILL.md) (3 breakpoints, states, dark mode if themed) and the [accessibility-audit](../accessibility-audit/SKILL.md) quick pass; fix findings before reporting done.

## Deliverables

- The UI code, composed from the system
- Screenshots at 375/768/1440 (key states included) attached to the report
- New reusable pieces registered back into the design system docs

## Quality checklist

- [ ] Zero magic values; tokens only
- [ ] All eight states reachable and designed; forms recoverable
- [ ] Keyboard-only pass completed by actually tabbing through
- [ ] No horizontal page scroll at any supported width; no CLS on load
- [ ] Realistic content survives the extremes pass
- [ ] Gates 1–5, A, R, St, V, C (+P on public pages) — [QUALITY-GATES.md](../../standards/QUALITY-GATES.md)

## Validation

- Screenshot sweep per [visual-qa](../visual-qa/SKILL.md) — attach, don't describe
- Keyboard walk of the new UI; automated a11y scan zero serious/critical
- Build + lint + types green (paste results)

## Common failure modes

- **Happy-path UI** — states discovered by users in production; the states ARE the feature
- **Div-soup with click handlers** — unreachable by keyboard, invisible to screen readers
- **Desktop-first squish** — mobile as an afterthought that "mostly fits"
- **Local snowflake styles** — bypassing tokens "just this once"; drift starts here
- **Perfect with fake content** — breaks on the first real user name

## Security considerations

Render untrusted data as text, never raw HTML (sanitize if unavoidable — [SECURITY.md §2](../../standards/SECURITY.md)); no secrets in client code/props/data attributes (§1); user-generated URLs validated before becoming `href`; forms follow CSRF and validation rules (§2, §6) with the server as truth.

## Related

- [design-system](../design-system/SKILL.md) (vocabulary) · [visual-qa](../visual-qa/SKILL.md) + [accessibility-audit](../accessibility-audit/SKILL.md) (verification) · [DESIGN-UX.md](../../standards/DESIGN-UX.md)

---
name: accessibility-audit
description: Verify and fix WCAG 2.2 AA conformance — keyboard, screen reader semantics, contrast, focus, forms, motion. Use as the A-gate on any UI change, for full-page audits, or when accessibility issues are reported. Findings are fixed in place, not just listed.
---

# Accessibility Audit (WCAG 2.2 AA)

## Outcome

The audited UI conforms to WCAG 2.2 AA: fully keyboard-operable, correctly announced, sufficient contrast, visible focus, humane forms — verified by actual passes, with fixes applied.

## When to use

- Gate A on any UI change ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md)) — quick pass on the changed surface
- Full audit of a page/flow (periodic, pre-launch, or on report of an issue)
- New interactive pattern (dialog, combobox, drag) entering the design system

## When NOT to use

- Pure rendering defects → [visual-qa](../visual-qa/SKILL.md) (contrast overlaps: this skill owns it)
- Flow-logic confusion → [ux-review](../ux-review/SKILL.md)

## Required context & inputs

- Running app with the surface reachable; the diff (for gate-A scope)
- [DESIGN-UX.md §5](../../standards/DESIGN-UX.md) (the binding standard) and token contrast data from [design-system](../design-system/SKILL.md)
- Automated scanner availability (axe or equivalent) — use it, but it's ~30–40% of issues, never the whole audit

## Workflow

1. **Automated scan first** — axe (or stack equivalent) on every changed/audited page-state. Zero serious/critical is the floor, not the finish.
2. **Keyboard pass, hands off the mouse** — Tab/Shift-Tab through the whole surface: logical order; nothing unreachable; no traps; visible focus on EVERY stop (`:focus-visible` designed, never bare `outline: none`); Enter/Space/Escape/arrows work per pattern; skip link on full pages; focus managed on dialogs/menus (trap while open, restored on close).
3. **Semantics pass** — headings in order (one `h1`); landmarks; `button` vs `a` correct; lists as lists; images: meaningful alt or `alt=""` when decorative; icon-only controls have accessible names; ARIA only where semantics can't do it, and per the pattern spec (broken ARIA is worse than none).
4. **Forms pass** — every input programmatically labeled; errors linked via `aria-describedby` and announced (live region or focus move); required/invalid states exposed; instructions not color-only; error copy tells the fix.
5. **Visual conditions pass** — contrast: text ≥4.5:1 (large ≥3:1), UI components ≥3:1 (check custom controls, placeholders, disabled-but-readable); zoom 200% without loss; `prefers-reduced-motion` honored on significant animation; target sizes per [DESIGN-UX.md §4](../../standards/DESIGN-UX.md).
6. **Screen reader spot-check** — where a screen reader is available (NVDA/VoiceOver), walk the critical flow: is everything announced with name/role/state? Not available → say so in the report (gap named, not glossed).
7. **Fix now** — apply fixes; systemic issues (token contrast, primitive missing focus style) go to [design-system](../design-system/SKILL.md); re-run scan + keyboard pass on fixed surfaces.

## Deliverables

- Fixes applied; scan re-run clean
- Audit note: what was checked, tools used, results, gaps (e.g. no SR available)
- Systemic issues routed with links

## Quality checklist

- [ ] Automated scan zero serious/critical (result pasted)
- [ ] Keyboard-only walk actually performed, incl. dialogs/menus focus management
- [ ] All new/changed text-bg pairs contrast-verified with ratios
- [ ] Forms announce errors; labels programmatic
- [ ] Reduced-motion variant on significant animation
- [ ] Gate A recorded honestly, gaps named

## Validation

Paste scanner output; state the keyboard-walk route taken; list measured contrast ratios for anything near the line. Unverifiable claims are not conformance.

## Common failure modes

- **Scanner-clean declared "accessible"** — automation can't see focus order, name quality, or announcement UX
- **ARIA sprinkles** — `role`/`aria-*` added decoratively, breaking real semantics
- **Focus styling removed for aesthetics** — design a beautiful focus state instead
- **Modal without focus trap/restore** — keyboard users lost behind the overlay
- **Contrast checked only on body text** — placeholders, borders, charts, disabled states fail silently

## Security considerations

Accessible names/announcements must not leak data the UI hides visually (masked values announced raw, other users' data in live regions). Error announcements follow the same no-enumeration rules as visible errors ([SECURITY.md §3, §6](../../standards/SECURITY.md)).

## Related

- [DESIGN-UX.md §5](../../standards/DESIGN-UX.md) (standard) · [ui-implementation](../ui-implementation/SKILL.md) (builds it right first) · [design-system](../design-system/SKILL.md) (systemic fixes) · [visual-qa](../visual-qa/SKILL.md)

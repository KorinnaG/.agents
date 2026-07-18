---
name: frontend-architecture
description: Design or restructure the frontend's shape — feature boundaries, component hierarchy, state ownership, data flow, routing. Use when adding a significant frontend area, when components tangle (prop drilling, circular imports, god components), or when choosing state/data-fetching patterns.
---

# Frontend Architecture

## Outcome

A frontend structure with clean boundaries: features isolated behind public APIs, state owned at the right level, one-way data flow — enforceable, not aspirational.

## When to use

- New significant frontend area or app skeleton
- Symptoms of tangle: prop drilling >2 levels, circular imports, 500-line components, "everything imports everything"
- Choosing/standardizing state management or data-fetching patterns
- Deciding where a new piece of code should live

## When NOT to use

- Styling/visual work → [design-system](../design-system/SKILL.md) / [ui-implementation](../ui-implementation/SKILL.md)
- Single-component cleanup → [refactoring](../refactoring/SKILL.md)
- Server/API shape → [backend-api-design](../backend-api-design/SKILL.md)

## Required context & inputs

- [ARCHITECTURE.md](../../standards/ARCHITECTURE.md) (the layering and feature-first rules) + framework conventions from [project profile → AGENTS.md](../../../AGENTS.md)
- Current import graph reality: read the folders involved before proposing shape
- The feature list this structure must serve (near-term, not hypothetical)

## Workflow

1. **Map the domain** — list features as users would name them (checkout, profile, search). Features are nouns from the product, not technical layers.
2. **Draw boundaries** — per [ARCHITECTURE.md](../../standards/ARCHITECTURE.md): each feature gets `features/<name>/` with a single public `index.ts`; shared UI only in `components/`; shared logic in `lib/`. Write down what each boundary may import (`app → features → components/lib`, never sideways into internals).
3. **Place state deliberately** — for each piece of state, choose the narrowest owner: component-local → URL → server-state layer (loader/query cache) → global store *only* with a written reason. Server data is never copied into a global store "for convenience."
4. **Define data flow per feature** — where data enters (route loader? query hook?), where mutations happen, how loading/empty/error propagate to the UI states ([DESIGN-UX.md §6](../../standards/DESIGN-UX.md)).
5. **Component hierarchy** — containers wire data; presentational components receive props; extract when a component does layout AND data AND logic. No component reaches into another's internals.
6. **Enforce** — dependency-lint rules or import-boundary tooling where the stack allows; at minimum, document the rules in [STANDARDS.md](../../standards/STANDARDS.md) framework section. Circular imports = build error.
7. **Migrate incrementally** — restructuring existing code follows [refactoring](../refactoring/SKILL.md): green steps, no behavior change, no big-bang moves.

## Deliverables

- Structure decision written down (ARCHITECTURE.md project section or ADR when it shapes the app)
- The scaffolded/moved directories with public APIs
- Import-boundary enforcement (tooling or documented rule)

## Quality checklist

- [ ] Every feature importable only via its `index.ts`; zero cross-feature internal imports
- [ ] No import cycles (verified, not assumed)
- [ ] Each state piece has a named owner and a reason for its level
- [ ] Loading/empty/error paths defined for every data entry point
- [ ] Gates 1–5, D, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

- Run the cycle check (lint rule, `madge --circular`, or stack equivalent) — zero cycles
- Grep for deep imports (`features/*/(components|server)/` imported from outside that feature) — zero hits
- Build + tests green after any moves

## Common failure modes

- **Layer-first folders** (`components/`, `hooks/`, `utils/` as the whole world) — features become archaeology; organize by domain
- **Global store as default** — reach for local/URL/server-state first
- **Premature abstraction** — shared component extracted from ONE usage; wait for the second real consumer
- **"Temporary" cross-feature import** — it never leaves; block it at review

## Security considerations

Client code is public ([SECURITY.md §1](../../standards/SECURITY.md)): no secrets, no authorization decisions in the frontend — the server re-checks everything. Keep any HTML-injection surfaces (`dangerouslySetInnerHTML` etc.) centralized and sanitized.

## Related

- [ARCHITECTURE.md](../../standards/ARCHITECTURE.md) · [backend-api-design](../backend-api-design/SKILL.md) (the contract counterpart) · [refactoring](../refactoring/SKILL.md) (the migration mechanics)

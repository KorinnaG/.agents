---
name: refactoring
description: Restructure code without changing behavior — extract, rename, de-duplicate, untangle layers — in small always-green steps protected by tests. Use for tech debt, code smells, pre-feature cleanup, or applying a new standard to existing code. Never mixed with feature work.
---

# Refactoring

## Outcome

The code's structure improves (readability, boundaries, duplication, testability) while every test that passed before still passes — provably, because behavior never changed.

## When to use

- Code smell blocks work: god function/component, duplication, tangled imports, prop drilling
- Pre-feature cleanup: the next feature would be built on mud
- A new convention in [STANDARDS.md](../../standards/STANDARDS.md)/[ARCHITECTURE.md](../../standards/ARCHITECTURE.md) needs applying to old code
- Post-review structural findings from [code-review](../code-review/SKILL.md)

## When NOT to use

- Behavior must change → that's a feature/fix workflow (refactor separately, before or after)
- "Rewrite it" impulses — restructure incrementally; rewrites are ADR-level human decisions
- Performance work → [performance-optimization](../performance-optimization/SKILL.md) (measured, may change behavior characteristics)

## Required context & inputs

- The target smell, named, and the target shape ("extract pricing into `features/billing`" not "clean up")
- Test coverage status on the affected code — this decides step 0
- Consumers of the code being reshaped (grep for imports/usages first)

## Workflow

1. **Safety net first** — if the affected behavior lacks tests, write **characterization tests** capturing what it does NOW (bugs included — note them, fix separately). No net, no refactor.
2. **Declare the contract** — "no behavior change" in the plan; list the public surfaces that must stay stable (exports, props, API responses, DB shapes).
3. **Small always-green steps** — one mechanical move at a time: extract function/component → run tests → rename → run → move file & fix imports → run. Use the IDE/tooling's rename-symbol where available over regex. Commit at each green plateau so any step can be dropped.
4. **Untangle in the right order** — dependencies before structure: break import cycles first, then move code across boundaries ([ARCHITECTURE.md](../../standards/ARCHITECTURE.md) rules), then rename for clarity. De-duplicate only real duplication (same reason to change), not coincidental similarity.
5. **Keep the diff honest** — zero feature changes, zero "while I'm here" fixes (note them for follow-up), zero test weakening. Deleted tests only when the behavior they tested genuinely moved — and then their replacement is shown.
6. **Finish clean** — old paths removed (no `utils-old.ts` corpses), docs updated where structure is documented, new pattern recorded in [STANDARDS.md](../../standards/STANDARDS.md) if it's now the house style.

## Deliverables

- The restructured code, in reviewable steps
- Characterization tests (when added) kept as permanent tests
- Note of bugs found-but-not-fixed (routed to [debugging-rca](../debugging-rca/SKILL.md)) and follow-ups

## Quality checklist

- [ ] Tests green before, between steps, and after — same tests (none deleted/weakened without shown replacement)
- [ ] Public surfaces unchanged (or every consumer updated in the same change)
- [ ] No behavior/feature changes smuggled in
- [ ] No import cycles introduced; boundaries respected
- [ ] Gates 1–5, D, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

Test run before + test run after, same suite, both pasted. For risky moves: consumer grep results showing all usages updated. Behavior spot-check of the main flow when the code is UI/user-facing.

## Common failure modes

- **Refactor + feature in one diff** — unreviewable and un-bisectable; split ruthlessly
- **Big-bang restructure** — 60 files, red for a day; small green steps or it isn't refactoring
- **Testless refactor** — "it's obviously equivalent" is how regressions ship; characterize first
- **Abstraction addiction** — extracting a helper for one caller, generalizing for imagined futures; wait for the second real consumer
- **Rename-only-mostly** — half the codebase uses the new name, half the old; finish the sweep

## Security considerations

Behavior-preserving includes security behavior: don't relocate validation/authz to a layer where a new call path can skip it; keep security-relevant code paths intact and re-verify gate S when refactoring touches them ([SECURITY.md](../../standards/SECURITY.md)).

## Related

- [code-review](../code-review/SKILL.md) (finds the targets) · [testing-strategy](../testing-strategy/SKILL.md) (characterization) · [frontend-architecture](../frontend-architecture/SKILL.md) (target shapes) · [refactor workflow](../../workflows/refactor.md)

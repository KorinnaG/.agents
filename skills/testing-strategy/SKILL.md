---
name: testing-strategy
description: Decide what deserves tests at which level and write them well — unit, integration, E2E, regression. Use when adding tests for new behavior, fixing coverage gaps, setting up a project's test approach, or when tests are flaky, slow, or asserting nothing.
---

# Testing Strategy & Implementation

## Outcome

The behavior in scope is protected by the right tests at the right level: deterministic, readable, asserting real behavior — and actually executed, with results reported.

## When to use

- New/changed behavior needs tests (every feature and bug fix does — [workflows index](../../workflows/README.md))
- Critical path discovered untested; coverage gap on security-relevant behavior
- Test suite is flaky, slow, or full of assertion-free tests
- Project test setup: choosing levels, structure, and commands at [template setup](../../docs/TEMPLATE-SETUP.md)

## When NOT to use

- Diagnosing a failure → [debugging-rca](../debugging-rca/SKILL.md) (which then sends the regression test back here)
- Visual rendering checks → [visual-qa](../visual-qa/SKILL.md)
- Performance measurement → [performance-optimization](../performance-optimization/SKILL.md)

## Required context & inputs

- [TESTING.md](../../standards/TESTING.md) (the strategy this skill executes) + project test commands ([project profile → AGENTS.md](../../../AGENTS.md))
- The behavior contract: what should happen, incl. edge/failure cases (from the plan or the bug report)
- Existing test patterns in the repo — match them ([STANDARDS.md](../../standards/STANDARDS.md))

## Workflow

1. **Choose the level per behavior** — [TESTING.md](../../standards/TESTING.md) table: pure logic → unit; boundary behavior (handler+validation+authz, component+store) → integration (the default); money-path flows → E2E, sparingly. Write the *what proves this* sentence before any code.
2. **Cover the priority list** — security denials first, then money/data-loss paths, business-logic edges (empty/max/boundary/timezone/unicode), contracts, regressions ([TESTING.md](../../standards/TESTING.md) order). Explicitly skip what the doc says to skip.
3. **Write with the house rules** — behavior-named tests, Arrange-Act-Assert, one behavior each; factories/fixtures over copy-paste; public-API access; boundaries mocked, own logic never; realistic data, zero real personal data.
4. **Make them deterministic** — injected clocks, seeded randomness, faked network; wait on conditions, never sleep. A test that needs retries is broken — fix it now, don't quarantine it silently.
5. **Regression tests fail first** — for bug fixes: run the new test against the pre-fix code (stash the fix or assert on the old behavior) and show it fails, then passes with the fix.
6. **Run everything relevant** — new tests + the affected suite + full suite when risk warrants; paste actual output. Wire new commands into [project profile → AGENTS.md](../../../AGENTS.md) and CI when setting up.

## Deliverables

- The tests, colocated per [TESTING.md](../../standards/TESTING.md) structure
- Run output in the report (counts, timing)
- For setup work: chosen tools recorded in PROJECT.md + commands wired

## Quality checklist

- [ ] Every new/changed behavior has a test at a justified level
- [ ] Security-relevant paths: denial/rejection tests present
- [ ] Zero flake: suite passes twice in a row locally
- [ ] No assertion-free or mock-echo tests
- [ ] Gate 4 recorded with real output ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

Actual test runs, pasted. For regression tests: the fails-before/passes-after evidence. "Tests written" without a run is gate-not-passed.

## Common failure modes

- **Testing the mock** — assert the boundary was *used correctly*, not that the mock returned what you told it to
- **Implementation-detail assertions** — breaks on refactor; test through the public surface
- **E2E for everything** — slow, flaky suite nobody runs; push down to integration
- **Coverage-driven padding** — line % up, protection unchanged; delete tests that assert nothing
- **Shared mutable fixtures** — order-dependent suites; isolate state per test

## Security considerations

Test fixtures never contain real credentials or personal data ([SECURITY.md §1, §7](../../standards/SECURITY.md)); test env vars are fakes; the authz denial tests demanded here are themselves a security control — their absence is a gate-S finding.

## Related

- [TESTING.md](../../standards/TESTING.md) (strategy) · [debugging-rca](../debugging-rca/SKILL.md) (feeds regressions) · [backend-api-design](../backend-api-design/SKILL.md) (denial tests) · [code-review](../code-review/SKILL.md)

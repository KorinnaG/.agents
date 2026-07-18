# TESTING.md — Test Strategy

> How projects on this blueprint are tested. Concrete tools are chosen at setup and recorded in [AGENTS.md](../../AGENTS.md); the strategy below is tool-agnostic. Skill: [testing-strategy](../skills/testing-strategy/SKILL.md).

## Philosophy

- **Tests exist to let us change code without fear.** They assert behavior users and callers depend on — not implementation details that break on every refactor.
- Write tests **with** the change, not after "when there's time". A bug fix without a regression test is unfinished ([WORKFLOWS.md](../workflows/README.md)).
- Coverage is a signal, not a goal: 100% of critical paths beats 100% of lines. Chasing a percentage produces assertion-free tests — banned.
- An agent must never report tests as passing without having run them ([/AGENTS.md §13](../../AGENTS.md)).

## Test levels & when to use each

| Level | Scope | Use for | Keep in mind |
|---|---|---|---|
| **Unit** | one function/module, no I/O | pure logic: pricing, validation, formatting, state transitions | fast, many; colocate next to code |
| **Integration** | several units + real-ish boundaries (in-memory/test DB, test server route) | API handlers with validation+authz, data-access, component + store wiring | the default level for most web behavior — highest confidence per effort |
| **End-to-end** | real browser against a running app | the money paths only: signup/login, core flow, checkout/submit | few, stable, fast enough to run pre-merge; flaky E2E is a defect to fix, not retry |
| **Visual/screenshot** | rendered UI at set viewports | design-system components, complex layouts | see [visual-qa](../skills/visual-qa/SKILL.md); review diffs intentionally |
| **Static** | typecheck, lint, schema checks | everything, continuously | cheapest tests you own — keep them strict |

## What must be tested (priority order)

1. **Security-relevant behavior** — authz denials (the test that user B *cannot* read user A's data), validation rejections, rate limits.
2. **Money and data-loss paths** — payment flows, destructive actions, migrations (on a copy).
3. **Core business logic** — the rules the product exists for, including edge cases (empty, max, boundary, timezone, unicode).
4. **Contracts** — API request/response shapes, error envelopes, events.
5. **Regressions** — every fixed bug gets a test that fails on the old code.
6. **Critical UI states** — error/empty/loading render logic (unit/integration level), key flows (E2E).

Explicitly fine to skip: framework internals, third-party libraries' own behavior, trivial getters, styling minutiae (visual QA covers those).

## Writing good tests

- Name = behavior: `rejects expired tokens`, not `test auth 3`.
- Arrange–Act–Assert, one behavior per test; shared setup via factories/fixtures, not copy-paste blobs.
- Test through public APIs; reach into internals only when there's no honest alternative (then note why).
- Deterministic: control time, randomness, and network (inject clocks, seed rngs, fake fetch). No sleeps; wait on conditions.
- Mock **boundaries** (external APIs, email, payment), not your own logic. Over-mocked tests that re-assert the mock are worthless.
- Test data realistic (see [DESIGN-UX.md §7](DESIGN-UX.md)) and never real personal data or secrets.

## Structure & commands

- Unit/integration colocated: `feature/x.ts` + `feature/x.test.ts`; E2E in `tests/e2e/`; helpers in `tests/`.
- Commands are defined per-project in [AGENTS.md → Commands](../../AGENTS.md#project-specific-commands) and wired into the gates ([QUALITY-GATES.md](QUALITY-GATES.md)).
- CI runs static checks + unit + integration on every push; E2E + visual at least pre-merge/pre-release.

## Current status

This documentation-only repository has no test runner. On template adoption: choose runner + E2E tool at setup ([TEMPLATE-SETUP.md](../docs/TEMPLATE-SETUP.md)), record in [AGENTS.md](../../AGENTS.md), and wire the commands into CI.

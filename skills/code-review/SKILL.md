---
name: code-review
description: Structured review of a diff before it merges — correctness, security, tests, standards, maintainability — with findings verified against the actual code. Use as the self-review step of every workflow, when asked to review a change/PR, or before handing work to the human.
---

# Code Review

## Outcome

A verdict on the diff — ship / fix-first — backed by verified findings ranked by severity, each anchored to file:line with a concrete fix. Self-reviews end with the fixes applied.

## When to use

- Self-review step of every workflow ([workflows index](../../workflows/README.md) step 5) before reporting done
- "Review this PR/diff/change" requests
- Post-merge audit of a suspicious area

## When NOT to use

- Whole-codebase quality survey → [refactoring](../refactoring/SKILL.md) discovery instead (review is diff-scoped)
- Deep security pass on sensitive surfaces → [security-review](../security-review/SKILL.md) (review flags, that skill digs)
- Visual verification → [visual-qa](../visual-qa/SKILL.md)

## Required context & inputs

- The full diff AND enough surrounding code — review the change *in its context*, never the hunks alone
- The intent: plan/issue/description the diff claims to implement
- Project standards: [STANDARDS.md](../../standards/STANDARDS.md), [ARCHITECTURE.md](../../standards/ARCHITECTURE.md), [SECURITY.md](../../standards/SECURITY.md)

## Workflow

1. **Understand the intent first** — what is this diff supposed to do? Then judge: does it do that, all of that, and only that? Scope creep and silent extras are findings.
2. **Correctness pass (read like an attacker of assumptions)** — edge cases: empty/null/zero/max, unicode, timezone, concurrency; error paths: what happens when the await rejects, the API 500s, the list is huge; off-by-one and boundary conditions; state: can this run twice, out of order, or race?
3. **Security pass (gate S lens)** — inputs validated? authz on new operations? secrets? injection surfaces? errors leaking internals? For flagged territory ([/AGENTS.md §7](../../../AGENTS.md)) escalate to [security-review](../security-review/SKILL.md).
4. **Tests pass** — do tests exist for the new behavior, do they assert behavior (not mocks), do denial/failure cases exist, did they RUN ([TESTING.md](../../standards/TESTING.md))? Weakened/deleted tests are high-severity findings.
5. **Standards & maintainability pass** — naming, structure, layering ([ARCHITECTURE.md](../../standards/ARCHITECTURE.md) boundaries), duplication vs existing utilities, suppressions (`any`, `eslint-disable`) with reasons, dead/debug code, docs updated where behavior changed (gate D).
6. **Verify before reporting** — every finding gets re-checked against the code (does the "bug" actually reproduce? is the "missing check" really missing, or done upstream?). Plausible-but-wrong findings erode trust; drop what you can't verify or mark it explicitly as uncertain.
7. **Report ranked** — blocker → major → minor → nit, each: `file:line — what's wrong — why it matters — concrete fix`. Self-review: apply the fixes now and note them. External review: findings only, no unsolicited rewrites.

## Deliverables

- Findings list (or clean verdict) with severity, location, fix — most severe first
- Self-review: fixes applied + re-run gate results
- Explicit statement of what was NOT reviewed (e.g. "generated files skimmed only")

## Quality checklist

- [ ] Read the surrounding code, not just hunks
- [ ] Every finding verified against the actual code (or marked uncertain)
- [ ] Security-flagged territory escalated, not hand-waved
- [ ] Tests were run, not assumed run
- [ ] Verdict is explicit: ship / fix-first, no "looks mostly fine"

## Validation

For each blocker/major: cite the file:line and the failure scenario concretely enough that anyone can reproduce the concern. Findings without a failure scenario are style notes — label them so.

## Common failure modes

- **Hunk-tunnel-vision** — the bug is in the interaction with unchanged code
- **Nit flood, bug drought** — 20 style comments, missed the race condition; correctness first, in severity order
- **Unverified findings** — pattern-matched "this looks wrong" that isn't; verify or drop
- **Rubber stamp under pressure** — hotfix urgency never waives review ([emergency-hotfix workflow](../../workflows/emergency-hotfix.md))
- **Reviewing style the formatter owns** — machines format; humans review meaning

## Security considerations

Review is the last human-adjacent gate before code ships: the security pass (step 3) is mandatory on EVERY diff, not just flagged ones — most vulnerabilities merge inside "ordinary" changes ([SECURITY.md](../../standards/SECURITY.md)).

## Related

- [security-review](../security-review/SKILL.md) (deep pass) · [testing-strategy](../testing-strategy/SKILL.md) · [refactoring](../refactoring/SKILL.md) (when findings are structural) · [QUALITY-GATES.md](../../standards/QUALITY-GATES.md)

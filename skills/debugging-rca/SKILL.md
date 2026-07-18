---
name: debugging-rca
description: Systematic debugging to the root cause — reproduce, isolate, explain, fix, prove. Use for any bug, regression, flaky behavior, or "it works locally but not in prod". The fix isn't done until the mechanism is understood and a regression test exists.
---

# Debugging & Root-Cause Analysis

## Outcome

The defect is explained (mechanism, not vibes), fixed at the root, proven by a regression test that failed before the fix — and checked for siblings elsewhere in the codebase.

## When to use

- Any reported bug or regression; failing/flaky CI; error spikes in logs
- "Works on my machine" / environment-specific behavior
- Mysterious behavior during development that you're tempted to "work around"

## When NOT to use

- Behavior is understood and it's a missing feature → normal workflow ([new-feature workflow](../../workflows/new-feature.md))
- Systemic slowness → [performance-optimization](../performance-optimization/SKILL.md) (profiling ≠ debugging)
- Production incident bleeding NOW → stabilize via [emergency-hotfix workflow](../../workflows/emergency-hotfix.md) hotfix, then return here for the root cause

## Required context & inputs

- The failure evidence: exact error, logs, screenshots, affected env/versions, when it started
- Reproduction steps if known (getting them is step 1 if not)
- Access to run the app/tests locally ([project profile → AGENTS.md](../../../AGENTS.md) commands)

## Workflow

1. **Reproduce first** — a bug you can't reproduce is a bug you can't verify fixed. Minimize the repro (smallest input/steps). Truly unreproducible → gather instrumentation (targeted logging/monitoring), report the investigation honestly; do NOT ship a speculative fix as "fixed".
2. **Read the actual error** — full message, full stack, the first error not the loudest (later errors are often fallout). Check the obvious cheaply: recent diff (`git log` on the touched area), env vars, versions, caches.
3. **Form hypotheses, then bisect the space** — state 2–3 candidate mechanisms; split the system (frontend/API/DB; this commit range or that one — `git bisect` when history helps; this input or that one) and test the halves. Change ONE variable per experiment; write down what each experiment ruled out — that log is the RCA skeleton.
4. **Instrument surgically** — targeted logs/breakpoints/debugger at the suspected boundary beat print-everything. Remove every instrument afterwards (gate C).
5. **Explain the mechanism** — one paragraph: *X happens because Y under condition Z.* If you can't write it, you haven't found it — a fix without a mechanism is a coincidence that will return.
6. **Fix at the root** — smallest change that removes the mechanism (not the symptom, not a catch-and-ignore). If the true root is out of scope (framework bug, upstream), document the workaround AS a workaround with a link/condition for removal.
7. **Prove + sweep for siblings** — regression test that fails on the old code ([testing-strategy](../testing-strategy/SKILL.md)); then grep for the same pattern elsewhere — root causes rarely have one instance. Full relevant suite green.

## Deliverables

- The fix + regression test (failed-before evidence)
- RCA note in the report: mechanism, why it wasn't caught, sibling-sweep result
- Instrumentation removed; any workaround documented as such

## Quality checklist

- [ ] Reproduced before fixing (or explicitly reported unreproducible — then no "fixed" claim)
- [ ] Mechanism written in one clear paragraph
- [ ] Fix addresses cause; no swallowed errors, no `try/catch`-to-silence
- [ ] Regression test fails on old code, passes on new
- [ ] Sibling sweep done; gates 1–5, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

Show: the repro failing → the fix → the repro passing → the regression test output. That sequence IS the proof.

## Common failure modes

- **Shotgun debugging** — many simultaneous changes; something works, nobody knows what; one variable at a time
- **Fixing the symptom** — null-check silences the crash, corrupted state marches on
- **Blaming the framework early** — it's your code until proven otherwise (then it's an upstream issue to file)
- **Flaky = retry** — flake is a real bug in test or code; quarantining without a ticket is deletion with extra steps
- **Debug artifacts shipped** — leftover logs/localhost URLs; the C-gate diff read catches these

## Security considerations

Bugs are often security findings in disguise (authz miss, injection, data leak) — when the mechanism touches [SECURITY.md](../../standards/SECURITY.md) territory, escalate to [security-review](../security-review/SKILL.md) and treat logs/repros as sensitive (they may contain real user data — scrub before pasting anywhere).

## Related

- [testing-strategy](../testing-strategy/SKILL.md) (regression tests) · [bug-fix + hotfix workflows](../../workflows/README.md) · [performance-optimization](../performance-optimization/SKILL.md) (when "slow" is the bug)

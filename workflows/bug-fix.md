# Workflow — Bug fix

Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — reproduce first ([debugging-rca](../skills/debugging-rca/SKILL.md)); no reproduction → investigation task, not a fix. Identify root cause, not symptom.
2. **Plan** — smallest correct fix at the root; note blast radius; check for the same defect pattern elsewhere.
3. **Implement** — write the **regression test that fails on the old code**, then fix until green. No drive-by refactoring in the same diff.
4. **Validate** — gates 1–5, S, C; UI gates if UI touched.
5. **Review** — does the fix hold for the general case, not just the reported case?
6. **Document** — if the bug revealed a doc lie or a missing standard, fix that too.

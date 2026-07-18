# Workflow — Emergency hotfix

Production is bleeding; stop it fast without abandoning discipline. Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — confirm impact and scope fast; capture evidence (logs, repro) while mitigating.
2. **Plan** — smallest change that stops the bleeding; note the follow-up debt explicitly. Human approval for the deploy — mark clearly as hotfix.
3. **Implement** — fix on the production branch state, not on top of unreleased work.
4. **Validate** — gates 1–5 compressed but never skipped: lint/type/tests on touched scope + build + targeted regression test; security floor never bypassed.
5. **Review** — second look at the diff even under pressure (self-review minimum).
6. **Document** — same-week follow-up: root cause (via [bug-fix](bug-fix.md)), full test, and the proper fix if the hotfix was a patch.

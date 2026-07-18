# Workflow — Security-sensitive change

For anything touching auth, permissions, payments, PII, uploads, or headers. Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — read [SECURITY.md](../standards/SECURITY.md) sections in scope; inventory current controls on the surface.
2. **Plan** — lightweight threat model ([security-review](../skills/security-review/SKILL.md)); **human approval before implementation** ([/AGENTS.md §10](../../AGENTS.md)).
3. **Implement** — managed/maintained libraries only; deny-by-default; validation + authz server-side.
4. **Validate** — gates incl. S with the abuse tests from [TESTING.md](../standards/TESTING.md) (authz denial tests mandatory); verify controls by attempting to bypass them.
5. **Review** — dedicated [security-review](../skills/security-review/SKILL.md) pass, separate from general code review.
6. **Document** — ADR for the approach; update the auth/data sections of the project [AGENTS.md](../../AGENTS.md).

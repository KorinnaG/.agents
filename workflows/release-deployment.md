# Workflow — Release / deployment

Ship to an environment. Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md). Full skill: [release-deployment](../skills/release-deployment/SKILL.md).

1. **Discover** — what's shipping (diff vs last release); env config deltas.
2. **Plan** — order (migrations first?), feature flags, rollback trigger & method; **human approves any deploy** ([/AGENTS.md §10](../../AGENTS.md)).
3. **Implement** — through the pipeline only; no manual prod edits; version/tag per project convention.
4. **Validate** — full gates on the release candidate; post-deploy smoke of money paths; monitor error rates.
5. **Review** — deployment checklist complete; on-call/owner aware.
6. **Document** — changelog/release notes; env var changes recorded in `.env.example` (names only).

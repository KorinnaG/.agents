# Workflow — Dependency upgrade

Add, upgrade, or remove a dependency. Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — [dependency-review](../skills/dependency-review/SKILL.md): changelog/breaking changes, advisories, license, health.
2. **Plan** — one dependency (or one coherent group) per change; migration steps; rollback = lockfile revert. **Human approval required** ([/AGENTS.md §10](../../AGENTS.md)).
3. **Implement** — upgrade, apply migrations/codemods, fix deprecations properly (no suppressions).
4. **Validate** — full gates 1–5 + S (audit) + smoke of features using the dependency.
5. **Review** — lockfile diff sane (no surprise transitive jumps).
6. **Document** — note in the change; ADR only if the upgrade changes architecture (e.g. major framework version).

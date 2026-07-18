# Workflow — Database migration

Schema change or data backfill. Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — current schema, data volume, consumers of affected fields ([database-migrations](../skills/database-migrations/SKILL.md)).
2. **Plan** — expand→migrate→contract for anything breaking; backup + rollback plan; **human approval for shared/prod data** ([/AGENTS.md §10](../../AGENTS.md)).
3. **Implement** — migration files via the ORM/tool (never hand-edited snapshots); app code handles both shapes during transition.
4. **Validate** — run on fresh DB + on production-shaped copy; app tests green on both; rollback actually tested.
5. **Review** — destructive steps double-checked; long-running steps assessed for lock impact.
6. **Document** — schema docs updated; ADR for model changes.

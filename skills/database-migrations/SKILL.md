---
name: database-migrations
description: Model data and evolve schemas safely — new tables/collections, field changes, indexes, and the migrations that apply them. Use for any schema change, data backfill, or when query patterns demand remodeling. Production-affecting migrations always require human approval.
---

# Database Modelling & Migrations

## Outcome

A schema that fits the access patterns, changed via ordered, reversible, tested migration files — with zero surprise data loss and the app working before, during, and after.

## When to use

- New entity/table/collection; adding, renaming, retyping, or removing fields
- Index/constraint changes; data backfills
- Query patterns fighting the current model (N+1s, JSON-blob workarounds)

## When NOT to use

- Endpoint logic on an unchanged schema → [backend-api-design](../backend-api-design/SKILL.md)
- Choosing the database/ORM itself → ADR ([decisions process](../../docs/decisions.md))
- Query *performance* tuning without schema change → [performance-optimization](../performance-optimization/SKILL.md)

## Required context & inputs

- Current schema (from the ORM schema/migration history — the real one, not memory)
- Access patterns: who reads/writes this data, how often, filtered/sorted by what
- Data sensitivity classification ([project profile → AGENTS.md](../../../AGENTS.md)) — personal data changes have privacy implications
- Environment reality: is there production data? volume? (drives the strategy)

## Workflow

1. **Model from access patterns** — entities, relationships, cardinality; normalize by default, denormalize only for a measured reason (note it). Names follow the project's recorded DB convention ([STANDARDS.md](../../standards/STANDARDS.md)).
2. **Constraints in the database** — NOT NULL, unique, foreign keys, enums/checks at the DB layer, not only app code. The DB is the last line of integrity.
3. **Index deliberately** — for real query patterns (FKs, lookup fields, sort keys); every index has a reader, none is cargo-culted.
4. **Write the migration** — via the project's tool; never hand-edit generated snapshots ([/AGENTS.md §8](../../../AGENTS.md)). Include `down`/rollback when the tool supports it; when it can't be reversed, the plan must say so out loud.
5. **Breaking changes = expand → migrate → contract** — add new shape; dual-write/backfill in batches (rate-limited, resumable); switch readers; only later remove the old shape in a separate migration. Renames are expand/contract, not `RENAME` on a live table under load.
6. **Backfills & destructive steps** — backup verified BEFORE ([SECURITY.md §9](../../standards/SECURITY.md)); destructive migration on shared/prod data requires **explicit human approval** ([/AGENTS.md §10](../../../AGENTS.md)); assess lock behavior on large tables (online strategies where the engine needs them).
7. **Test the migration itself** — apply to a fresh DB (works from zero) AND to a production-shaped copy (works with data); run the app test suite against the migrated schema; test the rollback path, don't assume it.

## Deliverables

- Migration file(s) + updated schema/types
- Backfill script when needed (batched, resumable, logged)
- Rollback plan written where the reviewer sees it
- Schema docs/ADR updated when the model changes meaningfully

## Quality checklist

- [ ] Constraints live in the DB, not only the app
- [ ] Every index justified by a named query
- [ ] Breaking change staged expand→migrate→contract; app runs on both shapes mid-flight
- [ ] Backup + tested rollback before destructive steps; human approval recorded
- [ ] Gates 1–5, S, D, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

- Fresh-DB migration run: paste result
- Prod-shaped copy run incl. timing for large tables: paste result
- App suite green on migrated schema; rollback executed on the copy

## Common failure modes

- **Big-bang rename/retype** — instant breakage of running instances; always expand/contract
- **Backfill as one giant UPDATE** — locks the table; batch it
- **Untested `down`** — rollback that has never run is a wish
- **Modeling for imagined future queries** — YAGNI applies to columns and indexes too
- **Migration edited after being applied somewhere** — never; add a new migration

## Security considerations

Least-privilege DB credentials per environment; no production data copied into dev (use anonymized/seeded data); personal-data fields respect the retention rules in [project profile → AGENTS.md](../../../AGENTS.md); encrypt sensitive-at-rest fields where classification demands ([SECURITY.md §7, §9](../../standards/SECURITY.md)).

## Related

- [backend-api-design](../backend-api-design/SKILL.md) · [release-deployment](../release-deployment/SKILL.md) (migrations deploy first) · [database-migration workflow](../../workflows/database-migration.md)

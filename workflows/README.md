# Workflows

Per-scenario playbooks. Every workflow follows the same spine — **Discover → Plan → Implement → Validate → Review → Document** — tuned to the situation. Gates are referenced by ID from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md); the human-approval boundaries in [/AGENTS.md §10](../../AGENTS.md) always apply.

These files are shared and reusable. Project-specific steps (exact commands, environments) come from the project's root [AGENTS.md](../../AGENTS.md).

| # | Workflow | Use when |
|---|---|---|
| 1 | [new-feature](new-feature.md) | Adding new user-facing capability |
| 2 | [bug-fix](bug-fix.md) | Something is broken; reproduce → root-cause → fix |
| 3 | [security-change](security-change.md) | Auth, permissions, payments, PII, uploads, headers |
| 4 | [ui-redesign](ui-redesign.md) | Reworking how something looks/feels |
| 5 | [refactor](refactor.md) | Structure change, zero behavior change |
| 6 | [dependency-upgrade](dependency-upgrade.md) | Add/upgrade/remove a dependency |
| 7 | [database-migration](database-migration.md) | Schema change or data backfill |
| 8 | [release-deployment](release-deployment.md) | Ship to an environment |
| 9 | [emergency-hotfix](emergency-hotfix.md) | Production is bleeding; stop it fast |
| 10 | [add-skill](add-skill.md) | Grow the shared skills library |

> Only #10 edits the shared `.agents/` blueprint, and only when you are working on the blueprint repository itself. During normal project work, `.agents/` is a read-only submodule (see [/AGENTS.md](../../AGENTS.md) and [the blueprint README](../README.md)).

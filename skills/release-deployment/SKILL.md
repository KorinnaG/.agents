---
name: release-deployment
description: Ship safely — CI/CD pipeline work, environment configuration, release preparation, deploys, rollbacks, hotfix shipping, and post-deploy verification/monitoring readiness. Use for any "deploy/release/ship it", pipeline changes, env-var changes, or production incidents needing a rollback decision.
---

# Release & Deployment

## Outcome

The change reaches its environment through the pipeline, verified after deploy, with a tested way back — and the humans stayed in charge of the go/no-go.

## When to use

- Preparing or executing a release; "deploy this" / "ship it"
- CI/CD pipeline creation/changes; environment/env-var configuration
- Rollback decisions; hotfix shipping ([emergency-hotfix workflow](../../workflows/emergency-hotfix.md))
- Setting up monitoring/alerting basics for a service

## When NOT to use

- The migration itself → [database-migrations](../database-migrations/SKILL.md) (this skill sequences it)
- Writing the fix → the relevant skill; this one ships it
- Choosing the hosting platform → ADR ([decisions process](../../docs/decisions.md))

## Required context & inputs

- [project profile → AGENTS.md](../../../AGENTS.md): environments, deploy platform, who may approve deploys
- What's shipping: diff vs currently-released state (changelog basis)
- **Human approval for any deploy** — hard boundary ([/AGENTS.md §10](../../../AGENTS.md)); agents prepare, humans pull triggers unless explicitly delegated per-deploy

## Workflow

1. **Know what's shipping** — diff against the released version; flag risk classes: migrations? env-var changes? dependency jumps? auth/payment surfaces (→ was [security-review](../security-review/SKILL.md) done)?
2. **Gates on the release candidate** — full [QUALITY-GATES.md](../../standards/QUALITY-GATES.md) run on the exact artifact/commit shipping, not on "roughly main". CI is the enforcement home: format/lint/types/tests/build on every push; E2E + audit pre-release.
3. **Sequence the risky parts** — migrations deploy before code needing them (expand→contract discipline per [database-migrations](../database-migrations/SKILL.md)); env vars created in the platform BEFORE the code referencing them (names mirrored in `.env.example`); big/risky features behind flags with a kill switch where the project supports them.
4. **Plan the rollback before deploying** — written: how (previous artifact? lockfile revert? flag off?), what CANNOT roll back (applied destructive migrations, sent emails, third-party charges) and the mitigation, who decides, and the trigger threshold (error rate/broken money path).
5. **Deploy through the pipeline only** — no manual prod edits, no SSH-hotpatches; version/tag per project convention; deploy at a humane hour with someone watching unless truly unattended-safe.
6. **Verify in production** — post-deploy smoke of the money paths (login, core flow, checkout); watch error rates/logs for the first window; confirm new env config actually loaded. Silence is not success — check.
7. **Close the loop** — changelog/release notes; `.env.example` current; monitoring/alert basics exist for new surfaces (error reporting wired, alert on error-rate spike and on the money path); note what made this release scary and fix that for next time.

## Deliverables

- Release checklist run with results; changelog entry
- Written rollback plan (kept with the release)
- Pipeline/config changes committed; `.env.example` in sync
- Post-deploy verification evidence

## Quality checklist

- [ ] Full gate run on the shipped artifact (results pasted)
- [ ] Human go/no-go recorded before the deploy
- [ ] Rollback path exists, is written, and was tested at least once for this class of deploy
- [ ] Migrations/env-vars sequenced before dependent code
- [ ] Post-deploy smoke performed and reported

## Validation

Post-deploy smoke results + error-rate observation window + (for pipeline work) a green pipeline run on a real commit. "Deployed successfully" means verified working in the target env, not "command exited 0".

## Common failure modes

- **Deploying "main" instead of the validated artifact** — untested commits ride along; pin what you verified
- **Migration/code order inverted** — new code hits old schema for N seconds; sequence explicitly
- **Rollback theater** — a plan that's never been executed fails when finally needed; test it on staging
- **Missing env var found by production** — boot-time config validation ([ARCHITECTURE.md](../../standards/ARCHITECTURE.md)) turns this into a loud, instant failure
- **Friday-evening heroics** — deploy when someone can watch and respond

## Security considerations

Pipelines hold the keys: CI secrets scoped least-privilege and never echoed to logs; pinned action/tool versions ([SECURITY.md §8](../../standards/SECURITY.md)); prod/staging/dev credentials fully separated (§9); deploy permissions limited to named humans; artifacts free of `.env`/secrets (§1); dependency audit green before release.

## Related

- [release + hotfix workflows](../../workflows/README.md) · [database-migrations](../database-migrations/SKILL.md) (sequencing) · [dependency-review](../dependency-review/SKILL.md) · [security-review](../security-review/SKILL.md)

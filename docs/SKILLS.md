# SKILLS.md — Skill Registry

> Human-readable registry of every skill. The routing table in [/AGENTS.md §7](../../AGENTS.md) maps common tasks to these; this file is the full catalogue. Every entry's directory must exist and vice versa — keeping the two in sync is part of [skill-authoring](../skills/skill-authoring/SKILL.md).
> Statuses: `active` (use it) · `optional` (project-dependent) · `external` (lives outside this repo) · `deprecated` (don't start new work with it) · `needs-review` (may be stale).

## Overview

| Skill | Purpose | Status |
|---|---|---|
| [project-discovery](../skills/project-discovery/SKILL.md) | Vague idea → verified requirements + project profile | active |
| [technical-planning](../skills/technical-planning/SKILL.md) | Written plan before non-trivial work | active |
| [frontend-architecture](../skills/frontend-architecture/SKILL.md) | Feature boundaries, state ownership, data flow | active |
| [backend-api-design](../skills/backend-api-design/SKILL.md) | Endpoints: contracts, validation, authz, errors | active |
| [database-migrations](../skills/database-migrations/SKILL.md) | Data modelling + safe schema evolution | active |
| [design-system](../skills/design-system/SKILL.md) | Art direction, tokens, component vocabulary | active |
| [ui-implementation](../skills/ui-implementation/SKILL.md) | Production UI: responsive, all states, accessible | active |
| [ux-review](../skills/ux-review/SKILL.md) | Judge flows: hierarchy, friction, trust | active |
| [visual-qa](../skills/visual-qa/SKILL.md) | Screenshot sweep at 375/768/1440 | active |
| [accessibility-audit](../skills/accessibility-audit/SKILL.md) | WCAG 2.2 AA verification + fixes | active |
| [security-review](../skills/security-review/SKILL.md) | Threat model + adversarial security pass | active |
| [testing-strategy](../skills/testing-strategy/SKILL.md) | Right tests at the right level, actually run | active |
| [debugging-rca](../skills/debugging-rca/SKILL.md) | Reproduce → root cause → fix → regression test | active |
| [code-review](../skills/code-review/SKILL.md) | Verified findings on a diff, ranked | active |
| [refactoring](../skills/refactoring/SKILL.md) | Structure change, zero behavior change | active |
| [performance-optimization](../skills/performance-optimization/SKILL.md) | Measured CWV/bundle/latency wins | active |
| [seo-structured-data](../skills/seo-structured-data/SKILL.md) | Crawlability, metadata, valid schema.org | active |
| [release-deployment](../skills/release-deployment/SKILL.md) | CI/CD, env config, deploys, rollbacks | active |
| [dependency-review](../skills/dependency-review/SKILL.md) | Supply-chain-diligent dependency decisions | active |
| [skill-authoring](../skills/skill-authoring/SKILL.md) | Add/update/deprecate skills without overlap | active |
| [_template](../skills/_template/SKILL.md) | Copy-source for new skills (not invokable) | active |

## Full entries

### project-discovery
- **Location:** `.agents/skills/project-discovery/SKILL.md`
- **Purpose:** Turn vague project/feature ideas into verified requirements and a completed [AGENTS.md](../../AGENTS.md).
- **Triggers:** kickoff; "build me a ___" without specifics; contradictory requirements; load-bearing `[REQUIRES HUMAN INPUT]` gaps.
- **Not for:** clear requirements (→ technical-planning); technical choices (→ ADR).
- **Inputs:** repo facts, human answers. **Outputs:** filled PROJECT.md, requirements brief, open questions.
- **Depends on:** [AGENTS.md](../../AGENTS.md). **Related:** technical-planning, security-review (data sensitivity).
- **Done when:** human explicitly confirms the brief; zero invented facts.
- **Status:** active

### technical-planning
- **Location:** `.agents/skills/technical-planning/SKILL.md`
- **Purpose:** ≤1-page written plan (scope, steps, risks, tests, rollback) before complex work.
- **Triggers:** multi-file change; new feature/dependency/schema/auth/public API; debatable approach.
- **Not for:** simple tasks; product unknowns (→ project-discovery).
- **Inputs:** real code read, PROJECT.md, ADRs. **Outputs:** plan; drafted ADRs when triggered.
- **Depends on:** [ARCHITECTURE.md](../standards/ARCHITECTURE.md), [STANDARDS.md](../standards/STANDARDS.md). **Related:** all implementation skills.
- **Done when:** plan approved where required; implementation diffs explained against it.
- **Status:** active

### frontend-architecture
- **Location:** `.agents/skills/frontend-architecture/SKILL.md`
- **Purpose:** Feature-first frontend structure: boundaries, state ownership, one-way data flow.
- **Triggers:** new frontend area; prop drilling/cycles/god components; state-pattern decisions; "where does this live?".
- **Not for:** styling (→ design-system/ui-implementation); single-component cleanup (→ refactoring); API shape (→ backend-api-design).
- **Inputs:** import-graph reality, feature list. **Outputs:** structure + public APIs + boundary enforcement.
- **Depends on:** [ARCHITECTURE.md](../standards/ARCHITECTURE.md). **Related:** refactoring, backend-api-design.
- **Done when:** zero import cycles and zero cross-feature internal imports, verified.
- **Status:** active

### backend-api-design
- **Location:** `.agents/skills/backend-api-design/SKILL.md`
- **Purpose:** Endpoints/actions with schema-validated input, object-level authz, typed errors, abuse controls.
- **Triggers:** any new/changed endpoint, server action, webhook, server business logic.
- **Not for:** schema changes (→ database-migrations); auth-system selection (→ ADR + security-review).
- **Inputs:** consumer need, API-style ADR, [SECURITY.md](../standards/SECURITY.md) §§2–6. **Outputs:** contract, implementation, denial tests, docs.
- **Depends on:** [ARCHITECTURE.md](../standards/ARCHITECTURE.md), [SECURITY.md](../standards/SECURITY.md). **Related:** security-review, testing-strategy, database-migrations.
- **Done when:** integration tests incl. denials pass; malformed + forbidden requests answered safely (shown).
- **Status:** active

### database-migrations
- **Location:** `.agents/skills/database-migrations/SKILL.md`
- **Purpose:** Model data from access patterns; evolve schemas via reversible, tested, expand→contract migrations.
- **Triggers:** new entity; field add/rename/retype/drop; indexes; backfills.
- **Not for:** endpoint logic (→ backend-api-design); DB/ORM selection (→ ADR); pure query tuning (→ performance-optimization).
- **Inputs:** real schema, access patterns, data volume/sensitivity. **Outputs:** migrations, rollback plan, updated schema docs.
- **Depends on:** [SECURITY.md](../standards/SECURITY.md) §9, [WORKFLOWS.md](../workflows/README.md) §7. **Related:** backend-api-design, release-deployment.
- **Done when:** fresh-DB + prod-copy runs green; rollback tested; human approved destructive/prod steps.
- **Status:** active

### design-system
- **Location:** `.agents/skills/design-system/SKILL.md`
- **Purpose:** Art direction + token layer + primitive components that make consistency the default.
- **Triggers:** first UI; visual drift; direction change; a component's second consumer appears.
- **Not for:** building screens (→ ui-implementation); flow judgment (→ ux-review).
- **Inputs:** brand/direction input from human, UI inventory. **Outputs:** tokens, primitives with all states, usage doc, ADR on direction change.
- **Depends on:** [DESIGN-UX.md](../standards/DESIGN-UX.md). **Related:** ui-implementation, accessibility-audit, visual-qa.
- **Done when:** contrast verified, anti-generic check passes, zero magic values in primitives.
- **Status:** active

### ui-implementation
- **Location:** `.agents/skills/ui-implementation/SKILL.md`
- **Purpose:** Ship screens/components: token-based, mobile-first responsive, all eight states, semantic, realistic content.
- **Triggers:** "add/build/implement" anything users see.
- **Not for:** token/primitive changes (→ design-system); diagnosing flows (→ ux-review); data-layer work (→ frontend-architecture).
- **Inputs:** tokens/primitives, data contract, real-ish content. **Outputs:** UI code, breakpoint screenshots, system registrations.
- **Depends on:** [DESIGN-UX.md](../standards/DESIGN-UX.md). **Related:** design-system, visual-qa, accessibility-audit.
- **Done when:** visual-qa + a11y quick pass clean; states reachable; extremes survived.
- **Status:** active

### ux-review
- **Location:** `.agents/skills/ux-review/SKILL.md`
- **Purpose:** Prioritized, evidence-backed findings on whether flows work for users.
- **Triggers:** redesign kickoff; new flow shipped; "users are confused"; periodic core-journey pass.
- **Not for:** rendering defects (→ visual-qa); WCAG conformance (→ accessibility-audit); known small fixes (→ ui-implementation).
- **Inputs:** flow purpose + working access. **Outputs:** severity-ranked findings, routed follow-ups.
- **Depends on:** [DESIGN-UX.md](../standards/DESIGN-UX.md), [AGENTS.md](../../AGENTS.md) journeys. **Related:** visual-qa, ui-implementation.
- **Done when:** top findings reproducible by another agent; every finding has severity+evidence+recommendation.
- **Status:** active

### visual-qa
- **Location:** `.agents/skills/visual-qa/SKILL.md`
- **Purpose:** Mechanical screenshot inspection: overflow, clipping, alignment, readability, CLS, token drift, missing states.
- **Triggers:** any UI change; pre-merge gates R/V; redesign before/after evidence.
- **Not for:** flow judgment (→ ux-review); full WCAG (→ accessibility-audit).
- **Inputs:** running app, changed-surface list, breakpoints/themes. **Outputs:** screenshot set, fixed defects, gate verdict.
- **Depends on:** [DESIGN-UX.md](../standards/DESIGN-UX.md) §8, [QUALITY-GATES.md](../standards/QUALITY-GATES.md). **Related:** ui-implementation, design-system.
- **Done when:** full matrix swept with attached evidence; defects fixed or open-with-reason.
- **Status:** active

### accessibility-audit
- **Location:** `.agents/skills/accessibility-audit/SKILL.md`
- **Purpose:** WCAG 2.2 AA verification and fixes: keyboard, semantics, contrast, focus, forms, motion.
- **Triggers:** gate A on UI changes; full page/flow audits; new interactive patterns; reported issues.
- **Not for:** pure rendering defects (→ visual-qa); flow logic (→ ux-review).
- **Inputs:** running app, scanner availability, token contrast data. **Outputs:** fixes applied, audit note with tools/results/gaps.
- **Depends on:** [DESIGN-UX.md](../standards/DESIGN-UX.md) §5. **Related:** ui-implementation, design-system, visual-qa.
- **Done when:** scan zero serious/critical (pasted), keyboard walk done, ratios recorded, gaps named.
- **Status:** active

### security-review
- **Location:** `.agents/skills/security-review/SKILL.md`
- **Purpose:** Written threat model + adversarial verification of controls; fixes or human-accepted risk.
- **Triggers:** MANDATORY for auth/sessions/permissions/payments/PII/uploads/admin/integrations; audits; suspicious diffs.
- **Not for:** routine gate-S checklist (built into every task); first-pass endpoint building (→ backend-api-design).
- **Inputs:** diff/surface, data classification, [SECURITY.md](../standards/SECURITY.md). **Outputs:** threat model, severity-ranked findings, denial tests, acceptance records.
- **Depends on:** [SECURITY.md](../standards/SECURITY.md). **Related:** backend-api-design, dependency-review, database-migrations.
- **Done when:** four threat-model questions answered in writing; critical/high fixed; top attacks attempted where feasible.
- **Status:** active

### testing-strategy
- **Location:** `.agents/skills/testing-strategy/SKILL.md`
- **Purpose:** Right tests at the right level — deterministic, behavior-asserting, executed.
- **Triggers:** new/changed behavior; coverage gaps; flaky/slow/hollow suites; project test setup.
- **Not for:** diagnosing failures (→ debugging-rca); visual checks (→ visual-qa); perf measurement (→ performance-optimization).
- **Inputs:** behavior contract, [TESTING.md](../standards/TESTING.md), repo test patterns. **Outputs:** tests, run output, setup records.
- **Depends on:** [TESTING.md](../standards/TESTING.md). **Related:** debugging-rca, backend-api-design, code-review.
- **Done when:** suite passes twice; denial tests exist for security paths; output pasted.
- **Status:** active

### debugging-rca
- **Location:** `.agents/skills/debugging-rca/SKILL.md`
- **Purpose:** Reproduce → isolate → explain mechanism → root fix → regression test → sibling sweep.
- **Triggers:** any bug/regression; flaky CI; error spikes; env-specific behavior.
- **Not for:** understood missing features (→ feature workflow); systemic slowness (→ performance-optimization); live incidents (→ hotfix workflow first).
- **Inputs:** failure evidence, repro or the means to build one. **Outputs:** fix, failed-first regression test, RCA note.
- **Depends on:** [WORKFLOWS.md](../workflows/README.md) §2. **Related:** testing-strategy, security-review (when the bug is a vuln).
- **Done when:** mechanism written in one paragraph; repro-fail → fix → repro-pass shown.
- **Status:** active

### code-review
- **Location:** `.agents/skills/code-review/SKILL.md`
- **Purpose:** Verified, severity-ranked findings on a diff; explicit ship/fix-first verdict.
- **Triggers:** self-review step of every workflow; review requests; post-merge audits.
- **Not for:** codebase-wide surveys (→ refactoring discovery); deep security passes (→ security-review); visuals (→ visual-qa).
- **Inputs:** full diff + surrounding code + intent. **Outputs:** findings (file:line, fix), applied fixes on self-review.
- **Depends on:** [STANDARDS.md](../standards/STANDARDS.md), [QUALITY-GATES.md](../standards/QUALITY-GATES.md). **Related:** security-review, testing-strategy, refactoring.
- **Done when:** every finding verified or marked uncertain; verdict explicit.
- **Status:** active

### refactoring
- **Location:** `.agents/skills/refactoring/SKILL.md`
- **Purpose:** Structure improvement with provably unchanged behavior, in small always-green steps.
- **Triggers:** blocking smells; pre-feature cleanup; applying new standards; structural review findings.
- **Not for:** behavior changes (→ feature/fix workflows); rewrites (→ human + ADR); perf work (→ performance-optimization).
- **Inputs:** named smell + target shape, coverage status, consumer grep. **Outputs:** stepwise diffs, characterization tests, follow-up notes.
- **Depends on:** [ARCHITECTURE.md](../standards/ARCHITECTURE.md), [STANDARDS.md](../standards/STANDARDS.md). **Related:** code-review, testing-strategy, frontend-architecture.
- **Done when:** same tests green before/after; zero smuggled changes; sweep finished (no dual naming).
- **Status:** active

### performance-optimization
- **Location:** `.agents/skills/performance-optimization/SKILL.md`
- **Purpose:** Measured wins against budgets: LCP ≤2.5s, INP ≤200ms, CLS ≤0.1; bundle and server latency.
- **Triggers:** slow pages/interactions; gate-P failures; meaningful bundle growth; costly endpoints.
- **Not for:** functional bugs (→ debugging-rca); unprofiled micro-opts (don't); schema redesign (→ database-migrations).
- **Inputs:** measurement tooling, target metric, prod-like conditions. **Outputs:** before/after table, attributed optimizations, regression guard.
- **Depends on:** [QUALITY-GATES.md](../standards/QUALITY-GATES.md) gate P. **Related:** dependency-review, database-migrations, ui-implementation.
- **Done when:** after-numbers same methodology as baseline; budgets met or gap+plan stated.
- **Status:** active

### seo-structured-data
- **Location:** `.agents/skills/seo-structured-data/SKILL.md`
- **Purpose:** Crawlable, truthfully-represented public pages: metadata, canonicals, valid JSON-LD, sitemaps, redirects.
- **Triggers:** new public pages; launches; URL migrations; rich-result work; indexing problems.
- **Not for:** internal pages (noindex them); content strategy (human-owned); CWV (→ performance-optimization).
- **Inputs:** public-page list, canonical domain, framework metadata mechanism. **Outputs:** implementation, redirect map, validation results.
- **Depends on:** [QUALITY-GATES.md](../standards/QUALITY-GATES.md) gate SEO. **Related:** performance-optimization, accessibility-audit.
- **Done when:** validators clean, crawler-fetched HTML shows content, redirects tested.
- **Status:** active

### release-deployment
- **Location:** `.agents/skills/release-deployment/SKILL.md`
- **Purpose:** Pipeline-only shipping with sequenced migrations/env-vars, written+tested rollback, post-deploy verification.
- **Triggers:** deploys/releases; pipeline or env-var changes; rollbacks; hotfix shipping; monitoring setup.
- **Not for:** the migration itself (→ database-migrations); writing the fix; platform selection (→ ADR).
- **Inputs:** shipping diff, environments, human go/no-go. **Outputs:** checklist run, rollback plan, changelog, verification evidence.
- **Depends on:** [WORKFLOWS.md](../workflows/README.md) §8–9, [SECURITY.md](../standards/SECURITY.md) §8–9. **Related:** database-migrations, dependency-review, security-review.
- **Done when:** gates ran on the shipped artifact; human approved; smoke verified in target env.
- **Status:** active

### dependency-review
- **Location:** `.agents/skills/dependency-review/SKILL.md`
- **Purpose:** Supply-chain-diligent add/upgrade/remove decisions with fresh evidence and sane lockfiles.
- **Triggers:** BEFORE any dependency change; audit findings; abandonment signs; hygiene passes.
- **Not for:** using installed deps; executing framework migrations (→ workflows §6, ADR).
- **Inputs:** the need as a problem, lockfile, registry/advisory facts. **Outputs:** decision record, clean change, audit results.
- **Depends on:** [SECURITY.md](../standards/SECURITY.md) §8. **Related:** security-review, performance-optimization, release-deployment.
- **Done when:** human approved; lockfile diff read; gates + audit green.
- **Status:** active

### skill-authoring
- **Location:** `.agents/skills/skill-authoring/SKILL.md`
- **Purpose:** Grow/curate this library: create, update, deprecate, remove — without overlap or drift.
- **Triggers:** recurring uncovered task type; stale/overlapping skills; user asks for a skill.
- **Not for:** one-off tasks; conventions (→ [STANDARDS.md](../standards/STANDARDS.md)); near-covered needs (extend the existing skill).
- **Inputs:** this registry read in full, 2–3 example requests. **Outputs:** new/updated skill + registry row + proposed routing.
- **Depends on:** [`_template`](../skills/_template/SKILL.md), this file. **Related:** all.
- **Done when:** links resolve both ways; a context-free agent could execute the skill.
- **Status:** active

## External skills (tool-specific, not part of this repo)

When work happens inside **Claude Code** with the owner's plugins enabled, these session skills exist and may complement (never replace) the local library. They are unavailable in other tools — nothing in this blueprint depends on them.

| External skill | Complements | Notes |
|---|---|---|
| `code-review`, `security-review` (built-in commands) | [code-review](../skills/code-review/SKILL.md), [security-review](../skills/security-review/SKILL.md) | Local skills define the standard; the commands are a convenient executor |
| `verify`, `run` | [QUALITY-GATES.md](../standards/QUALITY-GATES.md) validation | Drive-the-app verification helpers |
| `dataviz`, `web-artifacts-builder`, `theme-factory` | [design-system](../skills/design-system/SKILL.md), [ui-implementation](../skills/ui-implementation/SKILL.md) | Chart/artifact styling guidance when producing visuals |

- **Status:** external · availability must be confirmed in-session before relying on them (`[/AGENTS.md §6]`: never fabricate access).

## Known gaps (deliberate)

Covered by docs today; promote to skills via [skill-authoring](../skills/skill-authoring/SKILL.md) when a project makes them recurring:

- **Internationalization** — rules in [STANDARDS.md](../standards/STANDARDS.md); add an `i18n` skill for multilingual projects.
- **Analytics & consent** — rules in [STANDARDS.md](../standards/STANDARDS.md) + [SECURITY.md](../standards/SECURITY.md) §7; add a skill when a project has real measurement needs.
- **Monitoring & incident response** — basics inside [release-deployment](../skills/release-deployment/SKILL.md); dedicated skill once ops load justifies it.
- **Forms** — split across [ui-implementation](../skills/ui-implementation/SKILL.md) (UX) and [backend-api-design](../skills/backend-api-design/SKILL.md) (validation) by design.
- **CMS / e-commerce / native** — per-project; author only when adopted.

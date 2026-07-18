<!--
  AGENTS.template.md — generic starting point for a project's root AGENTS.md.
  USAGE: copy this file to the PROJECT ROOT as `AGENTS.md`, then fill every {{FIELD}}
  and delete the [FILL / REQUIRES HUMAN INPUT] guidance you don't need.
  Links below are written relative to the PROJECT ROOT (where this copy lives),
  so they resolve once `.agents/` is present at the root as a submodule.
  Do NOT keep this template's comment blocks in the real AGENTS.md.
-->

# AGENTS.md — {{PROJECT_NAME}}

Entry point for every AI coding agent on this project. **Read this file completely before doing anything else.**

## 1. Project snapshot

- **Purpose:** {{ONE_LINE_PURPOSE}}
- **Users & primary journeys:** {{WHO_AND_TOP_JOURNEYS}}
- **Requirements / business constraints:** {{KEY_REQUIREMENTS_AND_CONSTRAINTS}}
- **Non-goals:** {{WHAT_THIS_PROJECT_DELIBERATELY_IS_NOT}}
- **Current limitations:** {{KNOWN_LIMITATIONS}}

## 2. Tech & architecture

- **Stack:** {{FRAMEWORK_LANGUAGE_PACKAGE_MANAGER_STYLING_DB}}
- **Architecture:** {{HIGH_LEVEL_SHAPE}} — follow [.agents/standards/ARCHITECTURE.md](.agents/standards/ARCHITECTURE.md).
- **Important directories:** {{DIR_MAP}}
- **Supported browsers/devices:** {{SUPPORT_MATRIX}}
- **Environments:** {{LOCAL_STAGING_PROD}}
- **External services:** {{SERVICES_AND_WHERE_KEYS_LIVE_env_var_names_only}}
- **Design direction:** {{THREE_ADJECTIVES_AND_TOKENS_LOCATION}} — standards in [.agents/standards/DESIGN-UX.md](.agents/standards/DESIGN-UX.md).

## 3. Commands

| Purpose | Command |
|---|---|
| Dev server | `{{DEV}}` |
| Format | `{{FORMAT}}` |
| Lint | `{{LINT}}` |
| Typecheck | `{{TYPECHECK}}` |
| Test | `{{TEST}}` |
| E2E | `{{E2E}}` |
| Build | `{{BUILD}}` |
| Dependency audit | `{{AUDIT}}` |

<a id="project-specific-commands"></a>These are the validation commands agents run as quality gates ([.agents/standards/QUALITY-GATES.md](.agents/standards/QUALITY-GATES.md)). Never report a command as run when it wasn't.

## 4. Deployment & security constraints

- **Deployment:** {{PLATFORM_TRIGGER_ROLLBACK_WHO_APPROVES}} — workflow: [.agents/workflows/release-deployment.md](.agents/workflows/release-deployment.md).
- **Data sensitivity:** {{PUBLIC_INTERNAL_PERSONAL_PAYMENT + regulation}}
- **Auth model:** {{APPROACH}}
- **Project-specific security rules:** {{EXTRA_RULES}} — the full policy is [.agents/standards/SECURITY.md](.agents/standards/SECURITY.md) (binding; never weaken a control to ship).

## 5. The shared blueprint (`.agents/` — READ-ONLY here)

`.agents/` is a **shared, read-only blueprint submodule** during normal project work. Do **not** edit anything under `.agents/` unless you are explicitly working on the blueprint's origin repository. Improvements to shared rules/skills are made there and pulled in.

- Standards: [.agents/standards/](.agents/standards/) · Workflows: [.agents/workflows/README.md](.agents/workflows/README.md) · Skills: [.agents/skills/](.agents/skills/) · Registry: [.agents/docs/SKILLS.md](.agents/docs/SKILLS.md) · Blueprint guide: [.agents/README.md](.agents/README.md)
- Project decisions (ADRs) live in this project's [decisions/](decisions/) — not in `.agents/`.

## 6. Instruction priority

1. Direct human instructions in the current conversation.
2. This file's project rules + the [security floor](.agents/standards/SECURITY.md).
3. Nested `AGENTS.md` files (scoped to their directory).
4. Shared standards in [.agents/standards/](.agents/standards/).
5. Skills in [.agents/skills/](.agents/skills/).

On any conflict that changes behavior, cost, or security posture: **stop and ask**. Never silently weaken security, accessibility, tests, or type safety.

## 7. Discovery, workflow & skill routing

- **Discovery:** read this file, then the relevant code, then the routed skill(s). Facts unknown here are marked `[REQUIRES HUMAN INPUT]` — ask, don't guess.
- **Simple task:** inspect → small change → run the gates for the touched surface → report honestly.
- **Complex task:** [technical-planning](.agents/skills/technical-planning/SKILL.md) → implement small → validate → [code-review](.agents/skills/code-review/SKILL.md) → document. Pick the workflow from [.agents/workflows/README.md](.agents/workflows/README.md).
- **Routing table (customize rows for this project):**

| Task | Skill(s) |
|---|---|
| Vague requirements | [project-discovery](.agents/skills/project-discovery/SKILL.md) |
| New UI | [design-system](.agents/skills/design-system/SKILL.md) → [ui-implementation](.agents/skills/ui-implementation/SKILL.md) → [visual-qa](.agents/skills/visual-qa/SKILL.md) + [accessibility-audit](.agents/skills/accessibility-audit/SKILL.md) |
| New endpoint | [backend-api-design](.agents/skills/backend-api-design/SKILL.md) → [security-review](.agents/skills/security-review/SKILL.md) → [testing-strategy](.agents/skills/testing-strategy/SKILL.md) |
| Schema change | [database-migrations](.agents/skills/database-migrations/SKILL.md) |
| Bug | [debugging-rca](.agents/skills/debugging-rca/SKILL.md) |
| Slow page | [performance-optimization](.agents/skills/performance-optimization/SKILL.md) |
| Dependency change | [dependency-review](.agents/skills/dependency-review/SKILL.md) |
| Deploy | [release-deployment](.agents/skills/release-deployment/SKILL.md) |

Full registry with triggers: [.agents/docs/SKILLS.md](.agents/docs/SKILLS.md).

## 8. Human approval boundaries

Stop and get explicit approval before: dependency add/upgrade/remove; deleting data/files/history; schema migrations on shared/prod data; changing auth/authorization/payment/privacy behavior; weakening any security/a11y/test/type control; deploying or any outward-facing action.

## 9. Definition of done

A task is done only when ALL apply (details: [.agents/standards/QUALITY-GATES.md](.agents/standards/QUALITY-GATES.md)):

- [ ] Formatted, lint-clean, type-checks; no new suppressions without a written reason.
- [ ] Tests for new/changed behavior; the relevant suite passes (actually run).
- [ ] Production build succeeds.
- [ ] UI changes: all states handled; responsive at {{BREAKPOINTS}}; accessibility pass; visual QA screenshots.
- [ ] Security checklist applied to every touched surface; no secrets, no debug code.
- [ ] Docs/ADRs updated where behavior or architecture changed.
- [ ] Validation commands were run and their real results reported. Never claim something works without validating it.

## 10. Project record

### User instructions
- {{STANDING_RULES_FROM_OWNER}}

### Infrastructure decisions
- See [decisions/](decisions/) (ADRs).

### Methods & patterns in use
- {{RECORD_AS_ADOPTED}}

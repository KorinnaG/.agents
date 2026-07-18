# `.agents/` — Shared AI Blueprint

This directory is a **reusable, tool-agnostic AI development blueprint** for professional web projects: the standards, workflows, skills, and templates every project should share. It is designed to become a **Git submodule** — maintained once in this origin repository and pulled into each web project read-only.

## What's in here

```
.agents/
├── README.md              ← this file
├── standards/             ← the rules: how work is done
│   ├── ARCHITECTURE.md    STANDARDS.md   SECURITY.md
│   ├── DESIGN-UX.md       TESTING.md     QUALITY-GATES.md
├── workflows/             ← per-scenario playbooks (new-feature, bug-fix, …)
│   └── README.md          ← workflow index
├── skills/                ← the how-to library, one dir per skill
│   ├── _template/SKILL.md ← copy this to create a new skill
│   └── <skill-name>/SKILL.md
├── templates/
│   ├── AGENTS.template.md ← starting point for a project's root AGENTS.md
│   └── adr.template.md    ← starting point for an ADR
└── docs/
    ├── SKILLS.md          ← skill registry (triggers, inputs, outputs, status)
    ├── TEMPLATE-SETUP.md  ← how to adopt the blueprint in a new project
    └── decisions.md       ← ADR process
```

## Shared vs project-specific

| Shared (lives here, in `.agents/`) | Project-specific (lives in the project root) |
|---|---|
| Standards, workflows, skills, templates, ADR process | Root `AGENTS.md` (purpose, stack, commands, deployment, constraints) |
| Reusable across every web project | The project's own `decisions/` ADRs, `.env.example`, source code |

The authority order: the project's root [`AGENTS.md`](../AGENTS.md) is the entry point and can reference or tighten these shared rules; the [security policy](standards/SECURITY.md) is a floor no agent may lower.

## Read-only boundary

**During normal project work, `.agents/` is read-only. Agents must not edit anything under it.** It is a shared submodule — local edits would diverge from the origin and be overwritten on update. Improvements to shared rules or skills are made in the **blueprint origin repository** (this repo) and pulled into projects via a submodule update. (This repository *is* that origin, so blueprint edits happen here; see [ADR-0002](../decisions/0002-shared-agents-submodule.md).)

## Where skills live & how agents use them

Every skill is `skills/<skill-name>/SKILL.md` — YAML frontmatter (`name`, `description`) plus a step-by-step playbook (Agent Skills format).

- **Selection:** the routing table in the project [`AGENTS.md`](../AGENTS.md) maps common tasks to skills; the full registry with triggers is [`docs/SKILLS.md`](docs/SKILLS.md).
- **Invocation (tool-agnostic):** tell the agent to use it (*"follow `skills/accessibility-audit/SKILL.md`"*) or describe the task and let it route. Tools with native Agent Skills support also load `SKILL.md` files automatically; nothing here depends on that.
- The agent follows the skill's workflow, quality checklist, and validation before calling the task done.

## Managing skills (blueprint origin only)

| Action | How |
|---|---|
| **Add** | Follow [skill-authoring](skills/skill-authoring/SKILL.md): copy [`skills/_template/SKILL.md`](skills/_template/SKILL.md) → new dir (kebab-case, `name` matches folder) → fill every section → register in [`docs/SKILLS.md`](docs/SKILLS.md) → add a routing row to the project `AGENTS.md` if common (approval required). |
| **Update** | Edit the `SKILL.md`; keep frontmatter `description` in sync; update its [`docs/SKILLS.md`](docs/SKILLS.md) entry. |
| **Disable** | Set status `deprecated` in [`docs/SKILLS.md`](docs/SKILLS.md) + add a `> DEPRECATED — use X` banner atop the `SKILL.md`. |
| **Remove** | Delete the dir, its registry entry, and routing rows; grep the repo for dangling links. |

## Using this blueprint in a new project

**Automated (one command):** run [`templates/new-project.ps1`](templates/new-project.ps1) (PowerShell) or [`templates/new-project.sh`](templates/new-project.sh) (bash) with a project name — it does every manual step below. Set your published blueprint URL inside the script once.

**Manual:**

1. Add `.agents/` to the project (Git submodule from this origin, or copy).
2. Copy [`templates/AGENTS.template.md`](templates/AGENTS.template.md) to the project root as `AGENTS.md` and fill every `{{FIELD}}`.
3. Follow the full checklist in [`docs/TEMPLATE-SETUP.md`](docs/TEMPLATE-SETUP.md): detect the stack, wire real commands, classify data sensitivity, enable/disable skills, validate links, run the first quality check.
4. Record project decisions as ADRs in the project's root `decisions/` (template [`templates/adr.template.md`](templates/adr.template.md), process [`docs/decisions.md`](docs/decisions.md)).

## Updating the blueprint

Make changes here in the origin repository, following [skill-authoring](skills/skill-authoring/SKILL.md) for skills and the [ADR process](docs/decisions.md) for structural decisions. Keep the registry ↔ skills ↔ routing in sync and validate every internal link (both directions) before publishing. Consuming projects then update their submodule pointer to pick up the change.

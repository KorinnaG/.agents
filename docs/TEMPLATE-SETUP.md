# TEMPLATE-SETUP.md — Reusing this Blueprint in a New Project

> Copy → configure → verify. Budget ~30–60 minutes with an agent's help. Until this checklist is done, agents must treat `[REQUIRES HUMAN INPUT]` fields as unknown.

## 1. Add the blueprint

- [ ] Add `.agents/` to the new project — as a **Git submodule** from the blueprint origin (recommended, so updates propagate) or by copying it. Also copy `.gitignore` and `.env.example` to the project root.
- [ ] Create the project's root `AGENTS.md` by copying [`../templates/AGENTS.template.md`](../templates/AGENTS.template.md) → `AGENTS.md` (do **not** copy the origin's project-specific `AGENTS.md`).
- [ ] If the project already has an `AGENTS.md`/`agent.md`: **merge, don't overwrite** — existing user rules win; add the template's structure around them; delete nothing that isn't safely merged.
- [ ] Keep `.agents/` read-only during project work; make blueprint improvements in the origin repo.

## 2. Complete the project profile

- [ ] Fill every `{{FIELD}}` in the project's copied [AGENTS.md](../../AGENTS.md): purpose, users, business requirements, data sensitivity, environments, constraints, non-goals.
- [ ] Delete the template's guidance comments once filled.

## 3. Detect / choose the stack

- [ ] Existing code: detect framework, language, package manager (lockfile!), styling, DB, tests — record in [AGENTS.md](../../AGENTS.md).
- [ ] New project: choose the stack (current stable versions — verify against the registry, don't assume) and record the choice as an ADR in the project's root `decisions/` (process [decisions.md](decisions.md), template [../templates/adr.template.md](../templates/adr.template.md)).
- [ ] Add framework-specific conventions to [STANDARDS.md → Framework-specific sections](../standards/STANDARDS.md#framework-specific-sections).

## 4. Update commands

- [ ] Fill [AGENTS.md → Project-specific commands](../../AGENTS.md#project-specific-commands) with the project's real format/lint/typecheck/test/build/audit commands.
- [ ] Run each once to prove it works; wire them into CI when CI exists.

## 5. Review security needs

- [ ] Classify data sensitivity + regulation in [AGENTS.md](../../AGENTS.md).
- [ ] Populate `.env.example` with the project's real variable **names** (placeholders only); confirm `.env*` ignored by git.
- [ ] Note auth approach + payment handling (if any) — each is an ADR and routes through [security-review](../skills/security-review/SKILL.md).

## 6. Enable or remove skills

- [ ] Walk [SKILLS.md](SKILLS.md): mark skills not relevant to this project (`optional` or `deprecated`), never silently delete rows.
- [ ] Add missing project-specific skills via [skill-authoring](../skills/skill-authoring/SKILL.md) (i18n? CMS? native app?).

## 7. Add project-specific rules

- [ ] Owner's standing instructions → `AGENTS.md → User Instructions` (respect the approval rule).
- [ ] Team conventions → [STANDARDS.md](../standards/STANDARDS.md); design direction → [DESIGN-UX.md §1](../standards/DESIGN-UX.md) reference in the project's design doc.
- [ ] Only create nested `AGENTS.md` files for directories that genuinely need different rules.

## 8. Validate links and paths

- [ ] Check every relative link in `AGENTS.md` and `.agents/` resolve (agents: script it — extract `](...)` targets, test existence).
- [ ] Every skill in `.agents/skills/` is registered in [SKILLS.md](SKILLS.md) and vice versa; routing table rows point at real skills.

## 9. Run the first quality check

- [ ] Version control initialized (`git init`), first commit of the blueprint + project.
- [ ] Run all configured gates once ([QUALITY-GATES.md](../standards/QUALITY-GATES.md)) and fix what fails — start green.
- [ ] Dry-run an agent: give it a small task and verify it reads `AGENTS.md`, routes to a skill, and reports gates honestly.

## Portability notes

- Nothing in the blueprint depends on one agent tool; skills are plain markdown any agent can follow. Tools with native Agent Skills support pick up `SKILL.md` files automatically; for others, the `AGENTS.md` routing table is the mechanism.
- Framework-specific content is quarantined in marked sections and per-project ADRs — the rest of the blueprint stays portable across stacks.

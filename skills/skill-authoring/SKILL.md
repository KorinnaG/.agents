---
name: skill-authoring
description: Create, update, deprecate, or remove a skill in this blueprint's library. Use when a recurring task type has no matching skill, when an existing skill is outdated or overlaps another, or when the user asks to add/change a skill. Keeps the library small, sharp, and non-overlapping.
---

# Skill Authoring

## Outcome

The skills library gains (or corrects) exactly one well-scoped skill: valid Agent Skills format, registered in the registry, discoverable via routing, overlapping nothing.

## When to use

- A task type keeps recurring with no matching skill in [SKILLS.md registry](../../docs/SKILLS.md)
- An existing skill no longer matches how the project actually works
- Two skills' triggers collide, or a skill must be deprecated/removed
- The user asks for a new skill

## When NOT to use

- A one-off task — just do the task under [/AGENTS.md §5](../../../AGENTS.md)
- The knowledge is a convention, not a workflow → record it in [STANDARDS.md](../../standards/STANDARDS.md)
- An existing skill covers ≥70% of the need → extend that skill instead

## Required context & inputs

- Read [SKILLS.md registry](../../docs/SKILLS.md) end to end (overlap check is mandatory)
- The task type's real shape: 2–3 concrete examples of requests it should catch
- From the human (required): confirmation the skill is wanted; (optional) tool/stack specifics

## Workflow

1. **Justify** — name the recurring task type and show no existing skill owns it. If one nearly does, extend it and stop here.
2. **Scope** — write the one-sentence Outcome and the trigger list first. If triggers need "and/or" chains across unrelated areas, split into two skills.
3. **Create** — copy [`_template/`](../_template/SKILL.md) to `.agents/skills/<kebab-name>/`; frontmatter `name` = directory name (lowercase, hyphens, ≤64 chars); `description` states what + when (≤1024 chars). Only `name` + `description` in frontmatter — no invented fields.
4. **Write the body** — every template section, real content: deterministic workflow steps, checkable quality items, honest validation, real failure modes, real security notes. Delete the template's comment block.
5. **Set boundaries** — add "When NOT to use" cross-links in this skill AND in adjacent skills so triggers can't collide.
6. **Register** — full row + entry in [SKILLS.md registry](../../docs/SKILLS.md) (name, location, purpose, triggers, anti-triggers, inputs, outputs, dependencies, related, validation, status).
7. **Route** — if the task type is common, propose a routing row for [/AGENTS.md §7](../../../AGENTS.md). **Editing AGENTS.md requires prior user approval** — state the exact row and wait.
8. **Deprecate/remove path** — deprecation: status `deprecated` in the registry + `> DEPRECATED — use X` banner in the SKILL.md. Removal: delete directory, registry row, routing rows; repo-wide search for dangling links.

## Deliverables

- `.agents/skills/<name>/SKILL.md` (or the updated/deprecated file)
- Updated [SKILLS.md registry](../../docs/SKILLS.md) registry entry
- Proposed AGENTS.md routing row when warranted (delivered as a proposal, not an edit)

## Quality checklist

- [ ] Frontmatter valid; `name` equals directory name
- [ ] Zero placeholder text or template comments left
- [ ] Triggers concrete; overlap check done against every `active` skill
- [ ] Registry row complete; all links resolve both directions
- [ ] Gates D and C from [QUALITY-GATES.md](../../standards/QUALITY-GATES.md) pass for the doc change

## Validation

- Link check: every `](path)` in the new/changed files resolves
- Registry ↔ directory diff: every skill dir registered, every registry row has a dir
- Read the skill cold: could an agent with no session context execute it? If not, fix.

## Common failure modes

- **Shallow skill inflation** — ten thin skills where two deep ones serve better; prefer consolidation
- **Trigger collision** — two skills both "own" a request; fixed by explicit anti-triggers
- **Registry drift** — skill edited, registry stale; always update both in one change
- **Tool-specific lock-in** — skill assumes one agent tool's features; keep steps executable by any agent

## Security considerations

Skills are executable instructions for agents — a malicious or careless skill is an injection vector. Never author steps that weaken [SECURITY.md](../../standards/SECURITY.md) controls, exfiltrate data, or bypass approval boundaries; flag any such request to the user instead of complying.

## Related

- [SKILLS.md registry](../../docs/SKILLS.md) (registry) · [add-skill workflow](../../workflows/add-skill.md) · [`_template/SKILL.md`](../_template/SKILL.md)

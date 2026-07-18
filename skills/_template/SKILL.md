---
name: skill-name-matching-directory
description: One or two sentences stating what this skill does AND the trigger conditions that should route a task here. This is what agents read to decide relevance — make triggers concrete. Max ~1024 characters.
---

<!--
HOW TO USE THIS TEMPLATE (delete this comment block in the real skill)

1. Copy this directory:  .agents/skills/_template/ → .agents/skills/<your-skill-name>/
2. `name` in frontmatter MUST equal the directory name: lowercase, hyphens, ≤64 chars.
   Keep frontmatter to `name` + `description` (Agent Skills standard). Don't invent metadata.
3. Fill EVERY section below with real, actionable content — no placeholders left behind.
4. Register the skill in .agents/docs/SKILLS.md (all columns) and, if it handles a common task type,
   propose a routing-table row in /AGENTS.md (user approval required for that edit).
5. Prevent overlap: before writing, read .agents/docs/SKILLS.md. If an existing skill covers ≥70% of
   the job, extend that skill instead. If scopes are adjacent, state the boundary explicitly
   in both skills' "When NOT to use" sections.
6. Validate: links resolve, name matches directory, registry row exists.
   (Full process: .agents/skills/skill-authoring/SKILL.md)
-->

# Skill Title

## Outcome

The end state this skill produces, in one or two sentences. What exists/is true after it runs that wasn't before.

## When to use

- Concrete trigger 1 (phrase the way tasks actually arrive: "add a page", "it's slow")
- Concrete trigger 2

## When NOT to use

- Adjacent situation that belongs to another skill → link the right one
- Situation where this skill is overkill

## Required context & inputs

- What the agent must read/know first (files, docs, decisions)
- Inputs from the human, marked required vs optional

## Workflow

1. **Step name** — what to do, concretely, including what to inspect and what to produce.
2. **Step name** — …
3. Keep steps ordered, deterministic, and checkable. Note human-approval points explicitly.

## Deliverables

- Artifact 1 (code, doc, report — where it goes)
- Artifact 2

## Quality checklist

- [ ] Objective, checkable statement tied to the deliverables
- [ ] Relevant gates from .agents/standards/QUALITY-GATES.md called out by ID

## Validation

Commands to run or checks to perform to prove the outcome, and what "pass" looks like. Never report these as run when they weren't.

## Common failure modes

- Known way this task goes wrong → how to detect/avoid it

## Security considerations

What in this task can create a vulnerability, and which .agents/standards/SECURITY.md sections apply. "None" is almost never true.

## Related

- .agents/ standards & docs this skill leans on
- Neighboring skills and the boundary between them

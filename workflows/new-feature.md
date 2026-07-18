# Workflow — New feature

Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — clarify the outcome and affected users ([project-discovery](../skills/project-discovery/SKILL.md) if requirements are vague); read the code you'll extend; check [AGENTS.md](../../AGENTS.md) constraints and existing [ADRs](../docs/decisions.md).
2. **Plan** — written plan via [technical-planning](../skills/technical-planning/SKILL.md): scope, touched files, data/API changes, states, risks, test plan. Confirm with the human if behavior/cost/data/security posture changes.
3. **Implement** — route through the skills in [/AGENTS.md §7](../../AGENTS.md); small commits; states and validation built in, not bolted on.
4. **Validate** — all applicable gates (1–5, S, D, C + UI/page gates as touched).
5. **Review** — [code-review](../skills/code-review/SKILL.md) self-pass on the full diff.
6. **Document** — update affected docs; ADR if an architectural choice was made.

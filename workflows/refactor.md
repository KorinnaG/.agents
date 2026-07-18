# Workflow — Refactor

Structure change, zero behavior change. Spine: **Discover → Plan → Implement → Validate → Review → Document**. Gates from [../standards/QUALITY-GATES.md](../standards/QUALITY-GATES.md).

1. **Discover** — define the smell and the target shape ([refactoring](../skills/refactoring/SKILL.md)); confirm test coverage exists on current behavior — **if not, add characterization tests first**.
2. **Plan** — mechanical steps, each keeping the build green; explicit "no behavior change" contract.
3. **Implement** — small steps, run tests between steps; no feature work mixed in.
4. **Validate** — gates 1–5; identical test results before/after (same tests pass, none deleted/weakened).
5. **Review** — diff shows structure change only; API consumers unbroken.
6. **Document** — update [ARCHITECTURE.md](../standards/ARCHITECTURE.md)/[STANDARDS.md](../standards/STANDARDS.md) if the refactor establishes a new pattern.

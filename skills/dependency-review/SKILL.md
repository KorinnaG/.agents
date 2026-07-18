---
name: dependency-review
description: Evaluate, add, upgrade, or remove dependencies with supply-chain diligence — health, security advisories, license, size, breaking changes. Use before ANY dependency change (human approval required), for audit findings, or periodic dependency hygiene. Prefer the platform over a package.
---

# Dependency & Supply-Chain Review

## Outcome

A deliberate dependency decision — added, upgraded, replaced, removed, or rejected — with the evidence recorded, the lockfile sane, and everything still green.

## When to use

- **Before any** `add`/`upgrade`/`remove` of a package ([/AGENTS.md §8](../../../AGENTS.md) — human approval required)
- Audit findings (`npm/pnpm audit` etc.) need triage; a dependency looks abandoned
- Periodic hygiene pass; bundle-size pressure from [performance-optimization](../performance-optimization/SKILL.md)

## When NOT to use

- The task is using an already-installed dependency — just use it
- Framework major-version migrations — this skill evaluates; the migration itself is a planned workflow ([dependency-upgrade workflow](../../workflows/dependency-upgrade.md)) possibly ADR-level

## Required context & inputs

- The need, stated as a problem ("we need date-tz math"), not a package name — the best dependency is often none
- Package manager + lockfile from [project profile → AGENTS.md](../../../AGENTS.md)
- Registry/advisory access for facts (versions verified, never assumed "latest")

## Workflow

1. **Challenge the need** — can the platform (modern JS/CSS/framework built-ins) or an existing dependency do it? A dependency saving <~50 lines of maintainable code is usually net-negative risk. Write the one-line justification.
2. **Evaluate the candidate** (for adds/replacements):
   - *Health*: recent releases/commits, active maintainers (bus factor), open critical issues
   - *Security*: known advisories, history of response to CVEs, install scripts (suspicious?), maintainer-takeover red flags
   - *Fit*: TypeScript support, ESM/tree-shaking, docs quality
   - *Cost*: install size + bundle impact (measure, don't vibe), transitive dependency count (each is a supply-chain edge)
   - *License*: compatible with the project (permissive vs copyleft vs proprietary constraints)
   - *Name check*: exact spelling against typosquats
   Compare 2–3 candidates briefly when the space has real options.
3. **Get approval** — present: need, candidate, evidence summary, alternatives rejected and why, blast radius. Human decides ([/AGENTS.md §10](../../../AGENTS.md)). Major/architectural dependencies also get an [ADR](../../docs/decisions.md).
4. **Upgrades: read before bumping** — changelog/release notes between current and target; breaking changes listed; migration steps/codemods planned; one dependency (or coherent group) per change. Security patches jump the queue; majors get their own change.
5. **Execute cleanly** — exact install via the project's package manager; lockfile committed; deprecations fixed properly (no suppressions); dead dependencies removed while you're accurate about it (unused = uninstalled).
6. **Verify** — full gates 1–5 + audit; smoke the features using the package; **lockfile diff read**: no surprise transitive jumps, no unexpected new packages, registry URLs sane.

## Deliverables

- Decision record (in the PR/report; ADR when architectural) with the evidence
- The dependency change + lockfile, gates green
- For removals/rejections: the alternative implemented or the need re-scoped

## Quality checklist

- [ ] Need challenged; platform/existing options ruled out in writing
- [ ] Candidate evidence collected fresh (registry/advisories), not from memory
- [ ] Human approval before the change landed
- [ ] Lockfile diff reviewed and sane; audit green (or triaged with reasons)
- [ ] Gates 1–5, S, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

Paste: audit output, install/build/test results, bundle-impact numbers for frontend deps. For upgrades: the app's affected features smoked, with what was exercised.

## Common failure modes

- **Package-first thinking** — installing a 2MB library for `leftPad`; challenge the need
- **"Latest" from memory** — versions hallucinated; read the registry
- **Upgrade batching** — twelve bumps in one diff; the breakage is unattributable
- **Lockfile blindness** — the direct dep looks fine, a transitive dep got hijacked; read the diff
- **Audit fatigue** — `audit` permanently red so nobody looks; triage to zero-or-accepted, keep it meaningful

## Security considerations

This IS supply-chain security ([SECURITY.md §8](../../standards/SECURITY.md)): every package executes in your build or ships to your users. Treat install scripts, postinstall hooks, and maintainer changes as attack surface; pin CI tooling; never `--force` past integrity errors — investigate them.

## Related

- [SECURITY.md §8](../../standards/SECURITY.md) · [performance-optimization](../performance-optimization/SKILL.md) (bundle cost) · [release-deployment](../release-deployment/SKILL.md) (shipping upgrades) · [dependency-upgrade workflow](../../workflows/dependency-upgrade.md)

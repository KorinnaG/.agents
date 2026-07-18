# QUALITY-GATES.md — Measurable Definition of Done

> The gates below decide whether work ships. They are **measurable**: each has a check and a pass condition. Gates run in order (cheap → expensive). "Ran the gate" means executed and observed, never inferred ([/AGENTS.md §13](../../AGENTS.md)).
> Commands: per-project in [AGENTS.md → Commands](../../AGENTS.md#project-specific-commands). **This docs-only repo has none configured yet** — the commands column shows recommended defaults to adapt at [setup](../docs/TEMPLATE-SETUP.md); documented ≠ executed.

## Gate table

| # | Gate | Check | Passes when | Typical command (adapt) |
|---|---|---|---|---|
| 1 | **Format** | auto-formatter in check mode | zero diffs | `pnpm format:check` (Prettier or stack equivalent) |
| 2 | **Lint** | linter, zero-warning policy | zero errors & warnings; no new suppressions without written reason | `pnpm lint` |
| 3 | **Types** | typechecker, strict config | zero errors; no new `any`/`@ts-ignore` without written reason | `pnpm typecheck` / `tsc --noEmit` |
| 4 | **Tests** | unit + integration (+ E2E when flows touched) | all pass; new/changed behavior has tests; fixed bugs have regression tests | `pnpm test`, `pnpm test:e2e` |
| 5 | **Build** | production build | succeeds with zero errors; warnings triaged | `pnpm build` |
| S | **Security** ⛔ | checklist vs [SECURITY.md](SECURITY.md) for every touched surface + secret scan + dependency audit | no findings; no secrets in diff (`git diff` reviewed + scan); audit has no new critical/high | `pnpm audit`; grep/scanner for key patterns |
| A | **Accessibility** | on any UI change: keyboard pass + automated scan + contrast | WCAG 2.2 AA items in [DESIGN-UX.md §5](DESIGN-UX.md) hold; zero serious/critical scanner findings | axe (browser/CLI), manual keyboard run |
| R | **Responsive** | screenshots at 375/768/1440 | no overflow, clipping, broken alignment, unreadable text, layout shift ([DESIGN-UX.md §8](DESIGN-UX.md)) | browser tooling / [visual-qa](../skills/visual-qa/SKILL.md) |
| B | **Browser compat** | verify on the support matrix in [AGENTS.md](../../AGENTS.md); no APIs outside it without fallback | feature works on matrix; graceful degradation noted | manual / cross-browser runner |
| St | **States** | walk the eight states ([DESIGN-UX.md §6](DESIGN-UX.md)) + offline where relevant | every applicable state implemented and reachable | manual walk of the flow |
| P | **Performance** | Core Web Vitals on changed pages (throttled, mobile) + bundle impact | **LCP ≤ 2.5s · INP ≤ 200ms · CLS ≤ 0.1** (lab, p75-representative); no unjustified bundle growth; images sized/optimized | Lighthouse/devtools; bundle analyzer |
| SEO | **SEO** (public pages) | title/description, canonical, status codes, structured data validity, sitemap/robots | per [seo-structured-data](../skills/seo-structured-data/SKILL.md) checklist | crawler/validator tools |
| V | **Visual consistency** | diff against design tokens & art direction | no rogue colors/spacing/radii/shadows; consistent with [DESIGN-UX.md](DESIGN-UX.md) | review + screenshots |
| D | **Docs** | affected `.agents/` docs, root `AGENTS.md`, ADRs, README, comments | updated in the same change; no doc now lies | review |
| C | **Cleanliness** | final diff read | no debug code/`console.log`, no commented-out corpses, no leftover TODOs, no accidental files, no unrelated reformatting | `git diff` read end-to-end |

## Which gates apply

- **Every change:** 1–5, S, D, C.
- **UI touched:** + A, R, St, V (and B for new platform APIs).
- **Public page touched:** + SEO, P.
- **Performance-sensitive or dependency change:** + P.
- Docs-only change: 1, D, C (+ link validation).

## Honest reporting format

Report per gate: `gate → command → actual result` (or `NOT RUN — reason`). Example:

```
✔ lint      pnpm lint          0 errors, 0 warnings
✔ types     pnpm typecheck     0 errors
✔ tests     pnpm test          142 passed (3 new)
✘ e2e       NOT RUN — no staging DB available; needs human to provision
```

A gate that cannot run is reported, never silently skipped — and never reported as passed.

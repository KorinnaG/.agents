---
name: performance-optimization
description: Measure and improve real performance — Core Web Vitals (LCP/INP/CLS), bundle size, server latency, query cost. Use when pages feel slow, budgets are exceeded, the P-gate fails, or a change risks meaningful bundle/latency growth. Measurement first, always.
---

# Performance & Core Web Vitals

## Outcome

Measured performance improvement against the budgets — **LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1** (mobile, throttled, p75-representative) — with before/after numbers, and no correctness or accessibility sacrificed.

## When to use

- Slow page/interaction reported, or gate P fails on a public page ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))
- Bundle grew meaningfully (new dependency, new route)
- Server endpoint/query latency worth real money or UX
- Periodic budget check on core pages

## When NOT to use

- Functional bugs that happen to be slow → [debugging-rca](../debugging-rca/SKILL.md)
- Micro-optimizing code that no profile says is hot — don't
- Schema redesign for query patterns → [database-migrations](../database-migrations/SKILL.md)

## Required context & inputs

- Access to run the app + measurement tooling (Lighthouse/devtools/profiler/bundle analyzer per stack)
- The target: which page/flow, which metric, current vs budget
- Real-world conditions to emulate: mobile CPU throttle, slow-4G-class network, production build (dev builds lie)

## Workflow

1. **Measure first, in prod-like conditions** — production build, throttled mobile profile, repeated runs (report median, not best). Capture the baseline per metric. Field data (CrUX/RUM) when available beats lab-only.
2. **Attribute before optimizing** — what IS the LCP element? What handler blocks INP? What shifts (CLS source)? Which bundles ship to this route (analyzer)? Which queries dominate the endpoint (server timing/EXPLAIN)? No fix without a named culprit.
3. **Apply the highest-leverage fix class first:**
   - *Ship less JS*: route/component code-splitting, drop/replace heavy deps ([dependency-review](../dependency-review/SKILL.md)), no polyfills for supported browsers, tree-shake-friendly imports
   - *LCP*: preload/priority-hint the hero resource, right-sized modern-format images (`srcset`), server-render above-the-fold, cut render-blocking chains
   - *INP*: break long tasks, debounce/virtualize heavy UI, move work off the interaction path (idle/worker)
   - *CLS*: reserve space (dimensions on media/embeds/ads), font loading without swap-jank
   - *Server/data*: cache with explicit invalidation, kill N+1s (batch/join), index per real query ([database-migrations](../database-migrations/SKILL.md)), stream/paginate large payloads
   - *Delivery*: CDN/static where possible, compression on, sane cache headers
4. **One change class at a time, re-measure** — same conditions as baseline; keep what pays, revert what doesn't. Numbers, not adjectives.
5. **Guard the win** — bundle-size check/budget in CI where tooling allows; note the budget in [project profile → AGENTS.md](../../../AGENTS.md); document any pattern now house-style in [STANDARDS.md](../../standards/STANDARDS.md).

## Deliverables

- Before/after measurements table (conditions stated) in the report
- The optimization diff (each change attributable to a culprit)
- Regression guard (budget/CI check) where feasible

## Quality checklist

- [ ] Baseline captured before any change; after-numbers same methodology
- [ ] Every optimization tied to an attributed culprit, not a hunch
- [ ] Budgets met or the gap + plan stated honestly
- [ ] No caching bug introduced (stale-data check); no a11y/UX sacrificed (lazy-loading still keyboard/SR-reachable)
- [ ] Gates 1–5, P, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

Paste the measurement outputs (baseline + after, tool + conditions). A performance claim without numbers under stated conditions is gate-not-run ([/AGENTS.md §13](../../../AGENTS.md)).

## Common failure modes

- **Optimizing unprofiled code** — effort spent where no time is; attribute first
- **Dev-build measurements** — 10× off; always production build
- **Cache as a blindfold** — hides the slow path and serves stale data; cache *with* invalidation design
- **Best-run cherry-picking** — report medians of repeated runs
- **Perf at UX's expense** — skeleton-flash, lazy-loaded content that never loads on slow links, removed animations that carried feedback

## Security considerations

Caching is a security surface: never cache per-user/authenticated responses publicly (`Cache-Control` correctness, no user data in shared CDN caches); timing changes shouldn't create user-enumeration oracles on auth paths ([SECURITY.md §3, §5](../../standards/SECURITY.md)).

## Related

- [QUALITY-GATES.md](../../standards/QUALITY-GATES.md) (gate P budgets) · [dependency-review](../dependency-review/SKILL.md) (bundle-heavy deps) · [database-migrations](../database-migrations/SKILL.md) (indexes) · [ui-implementation](../ui-implementation/SKILL.md) (CLS-safe patterns)

# ARCHITECTURE.md — Application Architecture

> Recommended architecture for web projects built on this blueprint. This repo contains no application code yet; nothing here has been migrated or imposed. When a stack is chosen, record it in [AGENTS.md](../../AGENTS.md) + an [ADR](../docs/decisions.md), then mark the relevant sections below as **adopted**.

## Principles

1. **Boundaries over cleverness.** Modules communicate through explicit interfaces; nothing reaches into another module's internals. This is the structural enforcement of "no spaghetti code."
2. **Feature-first organization.** Group code by feature/domain, not by technical kind. A feature's UI, logic, and tests live together and can be found — and deleted — as a unit.
3. **One-way data flow.** UI renders state → events trigger logic → logic updates state. No circular dependencies; import cycles are treated as build errors.
4. **Server is the authority.** Validation, authorization, and business rules execute server-side; the client is a projection, never the enforcement point ([SECURITY.md](SECURITY.md)).
5. **Boring and current.** Prefer the current stable, well-documented mainstream option over novel or deprecated ones. Verify versions against the registry/lockfile — never assume "latest".

## Recommended structure (feature-first)

Adapt names to the chosen framework's conventions; keep the shape:

```
src/
├── app/            # routes/pages/layouts (framework-owned entry points, thin)
├── features/       # one directory per feature/domain
│   └── <feature>/
│       ├── components/   # feature-private UI
│       ├── server/       # feature server logic (actions/handlers/services)
│       ├── model.ts      # types, schemas (single source of validation truth)
│       └── index.ts      # PUBLIC API of the feature — only import point
├── components/     # shared, generic UI (design-system components only)
├── lib/            # shared utilities, API clients, config access
├── styles/         # design tokens, global styles
└── tests/          # cross-feature test helpers/fixtures (unit tests live next to code)
```

**Dependency direction:** `app → features → components/lib`. Features never import other features' internals — only their `index.ts` public API. Shared `components/` and `lib/` never import from `features/`.

## Layering rules

| Layer | May contain | Must never contain |
|---|---|---|
| Route/page | composition, data wiring | business rules, direct DB calls sprawled inline |
| Component | rendering, local UI state | fetch logic buried in leaf components, authorization decisions |
| Server logic (actions/services) | validation, authorization, business rules, persistence calls | HTML/UI concerns, secrets in literals |
| Data access | queries, migrations, mapping | authorization decisions implied "because the UI hides the button" |

## State management

- Default order: **local component state → URL state → server state via a query/cache layer → global client store (last resort)**.
- Server data belongs in a server-state layer (framework loader or query library) with explicit loading/error/empty handling — not copied into global stores.
- Introduce a global store only with a written reason; record it in an ADR if it shapes the app.

## Error handling architecture

- Fail loudly in development, gracefully in production.
- Every server boundary returns typed, intentional errors; clients map them to the UX states defined in [DESIGN-UX.md](DESIGN-UX.md).
- One error-reporting path (logger/monitoring) — no scattered `console.log` left in code ([QUALITY-GATES.md](QUALITY-GATES.md)).
- Never swallow errors; never show stack traces or internals to users ([SECURITY.md](SECURITY.md)).

## Configuration

- All config through environment variables, read in **one** typed, validated config module — the only place `process.env` (or equivalent) is touched.
- Missing/invalid required env vars fail the build/boot with a clear message, not at first use in production.
- Client-exposed variables use the framework's explicit public prefix and contain nothing sensitive.

## API architecture

Defaults (see [backend-api-design](../skills/backend-api-design/SKILL.md)): resource-oriented routes, JSON in/out, schema validation at the boundary, consistent error envelope, authentication + authorization on every protected route, rate limiting on public writes. Choosing REST vs RPC vs GraphQL for a project is an ADR.

## Decision triggers

Any of these requires an [ADR](../docs/decisions.md) **before** implementation: framework choice; auth approach; database/storage change; API architecture; payment provider; caching/CDN strategy; major design-system change; any irreversible or expensive migration.

## Current status

- **Adopted here:** the blueprint structure itself ([ADR-0001](../../decisions/0001-adopt-ai-blueprint.md)).
- **Everything else:** recommended, awaiting a real stack — do not scaffold `src/` in this repository.

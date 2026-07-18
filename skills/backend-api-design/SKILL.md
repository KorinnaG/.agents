---
name: backend-api-design
description: Design and implement server endpoints, actions, and services — request/response contracts, validation, authorization, error handling, rate limiting. Use for any new or changed API route, server action, webhook, or server-side business logic.
---

# Backend & API Design

## Outcome

Server endpoints with explicit contracts: schema-validated input, authorization on every protected operation, consistent typed errors, and tests proving both the happy path and the denials.

## When to use

- New/changed API endpoint, server action, RPC, or webhook handler
- Server-side business logic, background jobs touching shared data
- Standardizing error envelopes or API conventions

## When NOT to use

- Pure schema/table changes → [database-migrations](../database-migrations/SKILL.md)
- Auth *system* selection or a security audit → [security-review](../security-review/SKILL.md) (this skill implements per-endpoint auth checks; the system design is an ADR)
- Client-side data fetching shape → [frontend-architecture](../frontend-architecture/SKILL.md)

## Required context & inputs

- [ARCHITECTURE.md → API architecture](../../standards/ARCHITECTURE.md) + API-style ADR if one exists; existing endpoints as convention reference
- [SECURITY.md](../../standards/SECURITY.md) §§2–6 (binding here)
- The consumer's need: which client/screen calls this, with what data, expecting what

## Workflow

1. **Contract first** — write the shape before the code: method/route (or action name), request schema, response schema, error cases with codes. Resource-oriented naming; no verbs-in-URLs unless the project's ADR says RPC-style.
2. **Validate at the boundary** — one schema (shared with the client when possible, per [STANDARDS.md](../../standards/STANDARDS.md)) parses the input; anything unparseable → 400-class with field-level details. Nothing downstream touches raw input.
3. **Authenticate, then authorize** — identify the caller; check permission for **this operation on this object** ([SECURITY.md §4](../../standards/SECURITY.md)). Deny by default; write the denial tests in the same change.
4. **Implement the logic** — thin handler → service/domain function ([ARCHITECTURE.md](../../standards/ARCHITECTURE.md) layering); transactions around multi-write operations; idempotency for anything retryable (webhooks, payments).
5. **Errors as contract** — consistent envelope project-wide; safe messages out, details to logs ([SECURITY.md §6–7](../../standards/SECURITY.md)); correct status codes (401 vs 403 vs 404-to-hide-existence chosen deliberately).
6. **Abuse controls** — rate limit public/auth/expensive endpoints; size limits on bodies/uploads; timeout + failure behavior for outbound calls (no unbounded hangs).
7. **Test** — per [TESTING.md](../../standards/TESTING.md): integration tests for happy path, validation rejections, **authz denials (user B cannot touch user A's resource)**, and error envelope shape.
8. **Document** — contract recorded where the project keeps API docs; `.env.example` updated with any new variable names.

## Deliverables

- Endpoint(s) + schemas + typed errors
- Integration tests incl. denial cases
- Contract documentation

## Quality checklist

- [ ] Zero fields read from input without schema validation
- [ ] Authz check present and object-level on every protected op
- [ ] Error envelope consistent; no internals/stack traces in responses
- [ ] Rate limiting on public writes; idempotency where retries exist
- [ ] Gates 1–5, S, D, C ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md))

## Validation

- Run the integration tests; paste real results
- Exercise one malformed request and one forbidden request against a running dev server and show the safe responses

## Common failure modes

- **Validation only where bugs were reported** — every boundary, every time
- **Authn mistaken for authz** — logged-in ≠ allowed; object-level checks missing is the classic breach
- **Fat handlers** — business logic welded into the route function; unservicable and untestable
- **Leaky errors** — ORM/stack messages sent to clients
- **Webhooks without signature verification or idempotency** — double-processing money events

## Security considerations

This skill IS a security surface: [SECURITY.md](../../standards/SECURITY.md) §2 (injection, SSRF, redirects), §3–4 (auth), §5 (CORS/headers), §6 (input/uploads/rate limits), §7 (logging). Payments/PII additionally route through [security-review](../security-review/SKILL.md) before merge.

## Related

- [database-migrations](../database-migrations/SKILL.md) · [security-review](../security-review/SKILL.md) · [testing-strategy](../testing-strategy/SKILL.md) · [ARCHITECTURE.md](../../standards/ARCHITECTURE.md)

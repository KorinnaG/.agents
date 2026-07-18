---
name: security-review
description: Adversarial security pass over a change or surface — threat modelling, OWASP-aligned checks, auth/authz verification, secret hygiene. MANDATORY for anything touching auth, sessions, permissions, payments, personal data, uploads, or new external integrations; also for periodic audits.
---

# Security Review & Threat Modelling

## Outcome

The reviewed surface has been attacked on paper (and where possible, in practice): threats enumerated, controls verified against [SECURITY.md](../../standards/SECURITY.md), gaps fixed or explicitly accepted by the human — in writing.

## When to use

- **Mandatory:** auth/session/permission changes; payments; personal or sensitive data; file uploads; admin capabilities; new external integration/webhook ([/AGENTS.md §7](../../../AGENTS.md) routing)
- Pre-launch or periodic audit of the whole app
- Gate S escalation: something in a normal change smells (new headers, CORS edits, raw SQL, HTML injection surface)

## When NOT to use

- Routine gate-S checklist on an ordinary diff — that's built into every task ([QUALITY-GATES.md](../../standards/QUALITY-GATES.md)); this skill is the deep pass
- Building the endpoint correctly in the first place → [backend-api-design](../backend-api-design/SKILL.md) (this skill verifies)

## Required context & inputs

- The diff/surface + data-sensitivity classification ([project profile → AGENTS.md](../../../AGENTS.md))
- [SECURITY.md](../../standards/SECURITY.md) end to end — it is the checklist source
- Auth model and trust boundaries as they actually exist in code (read, don't assume)

## Workflow

1. **Threat model (lightweight, written)** — four questions: *What are we building?* (one-paragraph description + data flows crossing trust boundaries: user→server, server→third-party, admin paths). *What can go wrong?* (walk STRIDE informally per flow: spoofing, tampering, repudiation, info disclosure, DoS, elevation). *What do we do about it?* (map each credible threat to a control). *Did we do it?* (steps 2–5 verify).
2. **Secrets & config sweep** — grep the diff/surface for hard-coded credentials, tokens in logs, secrets client-side; verify env-var handling via the config module; `.env.example` names only ([SECURITY.md §1](../../standards/SECURITY.md)).
3. **AuthN/AuthZ verification** — for every protected operation: server-side check present? object-level? deny-by-default? Try the bypasses on paper *and in tests*: direct object reference (user B → user A's id), missing-role access, expired/absent session, privilege escalation via mass-assignment. The denial tests must exist and pass ([TESTING.md](../../standards/TESTING.md) priority 1).
4. **Input/output audit** — every input path schema-validated? injection surfaces (SQL/command/HTML) using safe primitives? SSRF on any user-supplied URL? redirects allowlisted? uploads per [SECURITY.md §6](../../standards/SECURITY.md)? rate limits on abuse-able endpoints?
5. **Platform config** — headers present and strict (CSP!), CORS allowlist sane, cookies flagged, HTTPS/HSTS, error responses generic, logs scrubbed ([§5–7](../../standards/SECURITY.md)).
6. **Dependencies touched?** — audit results current; new packages through [dependency-review](../dependency-review/SKILL.md).
7. **Verdict & fixes** — findings by severity (critical/high/medium/low) with exploit scenario + fix. Critical/high: fixed before merge, full stop. Anything accepted-not-fixed requires the human's explicit written acceptance. Record material decisions as [ADRs](../../docs/decisions.md).

## Deliverables

- Written threat model (kept with the change/PR)
- Findings report with severities, exploit scenarios, and fix status
- Denial/abuse tests added where missing
- Human risk-acceptance record for anything left open

## Quality checklist

- [ ] Threat model answers all four questions in writing
- [ ] Every protected op has a verified server-side object-level check AND a denial test
- [ ] Zero secrets in diff/logs/client (swept, not assumed)
- [ ] All critical/high findings fixed; residual risk human-acknowledged
- [ ] Gate S recorded with evidence

## Validation

Attempt the top 3 attacks against a running dev instance where feasible (forged id, malformed payload, missing auth header) and paste the safe responses. Paper-only review must say it was paper-only.

## Common failure modes

- **Checklist theater** — boxes ticked without reading the code; every "present" claim needs a file/line
- **Authn/authz conflation** — logged-in-therefore-allowed; object-level is where breaches live
- **Reviewing the diff, missing the context** — a safe change can complete an unsafe whole; review the surface, not just the lines
- **Silent risk acceptance** — "probably fine" without the human's written sign-off
- **Fix-by-obscurity** — hiding endpoints/ids instead of enforcing authorization

## Security considerations

This skill's own outputs are sensitive: threat models and findings describe how to attack the system — keep them in the repo/PR, never in public artifacts. Never build working exploits beyond what's needed to demonstrate the finding to the owner.

## Related

- [SECURITY.md](../../standards/SECURITY.md) (policy) · [backend-api-design](../backend-api-design/SKILL.md) · [database-migrations](../database-migrations/SKILL.md) · [dependency-review](../dependency-review/SKILL.md) · [security-change workflow](../../workflows/security-change.md)

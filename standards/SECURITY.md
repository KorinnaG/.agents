# SECURITY.md — Security Policy

> **Security is a mandatory quality gate on every task, not an optional skill.** The floor in [/AGENTS.md §3](../../AGENTS.md) is binding; this document is the full policy. An agent must never weaken a security control to make a feature work — if a task seems to require it, stop and ask the human.
> Deep audits and threat modelling: [security-review](../skills/security-review/SKILL.md) skill.

## 1. Secrets & credentials

- **Never hard-code** API keys, tokens, passwords, connection strings, signing keys, or any credential — in code, config, tests, fixtures, docs, comments, commit messages, screenshots, or logs.
- All secrets come from environment variables (or the platform's secret manager), read only via the single typed config module ([ARCHITECTURE.md](ARCHITECTURE.md)).
- [` .env.example`](../../.env.example) documents variable **names and placeholders only**. All real `.env*` files are gitignored — verify before every commit.
- Client bundles are public. Nothing secret behind a "public" env prefix; API calls needing a secret go through the server.
- Suspected leak → treat as compromised: tell the human immediately, rotate the credential, purge it from history. Deleting the line is not remediation.

## 2. OWASP-aligned development

Apply the current OWASP Top 10 and, for depth, the OWASP ASVS as the review lens. The recurring classes, with required defenses:

| Risk | Required defense |
|---|---|
| Injection (SQL/NoSQL/command) | Parameterized queries / maintained ORM; never string-build queries or shell commands from input |
| XSS | Framework auto-escaping; no `dangerouslySetInnerHTML`/`v-html`/`innerHTML` with untrusted data — if unavoidable, sanitize with a maintained library; CSP as backstop |
| CSRF | Framework CSRF protection or same-site token pattern on every state-changing request; `SameSite` cookies |
| SSRF | Never fetch user-supplied URLs raw: allowlist hosts, block private IP ranges, no redirect-following into internal networks |
| Broken auth | Managed provider or maintained framework library; never hand-rolled hashing/sessions/JWT handling |
| Broken access control | Authorization server-side on **every** protected operation (§4) |
| Insecure redirects | Only redirect to allowlisted/relative paths; never to a raw query-param URL |
| Path traversal | Never build filesystem paths from user input; resolve + verify prefix |
| Vulnerable dependencies | §8 |
| Security misconfiguration | §5 headers, §9 environments |

## 3. Authentication & sessions

- Use a managed identity provider or the framework's maintained auth library — chosen via ADR. **Never roll your own** password hashing, session tokens, or crypto.
- Passwords (if self-managed): current best-practice hashing (argon2id/bcrypt via maintained lib), minimum length over composition rules, no max length below 64, rate-limited attempts, no user enumeration in error messages ("invalid credentials", same timing).
- Sessions: httpOnly + Secure + SameSite cookies; rotate session on privilege change; server-side revocation on logout/password change; sensible expiry.
- MFA support for anything handling money or sensitive personal data.

## 4. Authorization

- Every protected route/action/query re-checks permission **server-side**. UI hiding is UX, never enforcement.
- Deny by default; least privilege; object-level checks (user can access *this* invoice, not just "invoices").
- Multi-tenant: tenant scoping in the data-access layer itself, not per-callsite discipline.

## 5. Web platform protections

- **HTTPS everywhere**, HSTS in production.
- Headers on all responses (adapt per framework): `Content-Security-Policy` (start strict, no `unsafe-inline` where avoidable), `X-Content-Type-Options: nosniff`, `Referrer-Policy: strict-origin-when-cross-origin`, `X-Frame-Options`/`frame-ancestors`, minimal `Permissions-Policy`.
- **CORS:** explicit origin allowlist; never `*` with credentials.
- **Cookies:** `Secure`, `HttpOnly` (unless JS genuinely needs it), `SameSite=Lax` or stricter.

## 6. Input, output, uploads, abuse

- Validate **all** input server-side against a schema (type, length, range, format); allowlist over blocklist. Client validation is UX only.
- Encode/escape output for its context (HTML, attribute, URL, SQL — via the tools above).
- **File uploads:** allowlist types by content sniffing not extension; enforce size limits; randomize stored names; store outside the web root or in object storage; never execute; scan when risk warrants.
- **Rate limiting** on auth endpoints, public forms, and expensive operations; add CAPTCHA/proof-of-work only when abuse is observed or expected.
- Error messages to users are generic; details go to server logs (§7).

## 7. Data, privacy, logging

- **Minimize:** collect only data the product needs; define retention in [AGENTS.md](../../AGENTS.md).
- Classify data sensitivity in [AGENTS.md](../../AGENTS.md); personal/payment data always routes through [security-review](../skills/security-review/SKILL.md).
- **Never log** secrets, tokens, passwords, full card numbers, or unnecessary personal data. Scrub structured logs; no personal data in URLs or query strings (they leak via logs/referrers).
- Analytics: consent-gated where required; privacy-preserving defaults; IP handling appropriate to jurisdiction.
- Payments: use a payment provider's hosted/tokenized flow; card data never touches project servers.

## 8. Dependencies & supply chain

- Every new dependency: maintained? popular enough to be reviewed? license compatible? scope minimal? — via [dependency-review](../skills/dependency-review/SKILL.md), human approval required.
- Lockfile always committed; audit (`npm/pnpm/yarn audit` or equivalent) is a quality gate; known critical/high vulns block release.
- No install scripts from untrusted packages; pin CI actions; beware typosquats (check exact names).

## 9. Environments, backups, migrations

- Strict separation dev / staging / production: separate credentials, separate data, separate keys. Development never uses production secrets or personal data (use seeded/anonymized data).
- Backups for any stateful store; restore path tested, not assumed.
- Migrations: reversible when possible, backed up before destructive steps, never run against production without explicit human approval ([database-migrations](../skills/database-migrations/SKILL.md)).

## 10. Threat modelling

Required (lightweight, written) for any feature touching: auth, payments, personal data, file upload, admin capability, or new external integration. Answer four questions — *What are we building? What can go wrong? What do we do about it? Did we do it?* — see [security-review](../skills/security-review/SKILL.md).

## 11. Agent conduct

- Security gates run on every change (see [QUALITY-GATES.md](QUALITY-GATES.md) — gate S).
- Weakening any control (removing a header, widening CORS, skipping validation, disabling audit) requires explicit human approval with the risk acknowledged — and is almost always the wrong fix.
- Report security-relevant observations (exposed key in history, missing authz check) immediately, even when out of task scope.

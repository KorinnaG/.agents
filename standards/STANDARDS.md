# STANDARDS.md — Code Standards & Conventions

> How code is written in projects governed by this blueprint. Framework-agnostic unless a section says otherwise. New conventions adopted during work must be recorded here (AGENTS.md §11).

## Baseline

- **Language:** TypeScript in `strict` mode for application code. No `any` unless truly unavoidable — then a narrow type assertion with a one-line justification comment.
- **Modern methods only:** current stable language/framework features; no deprecated APIs, no legacy patterns (e.g. class components where functions are standard, callback pyramids where async/await exists).
- **Formatting & linting are law:** one auto-formatter + one linter, config committed, zero warnings policy. Agents never disable a rule to make code pass; fix the code. Rule exceptions need an inline justification and reviewer (human) awareness.
- **No suppression creep:** `@ts-ignore`, `eslint-disable`, `.skip`, `--force` are red flags; each use requires a written reason in the diff.

## Naming

| Thing | Convention | Example |
|---|---|---|
| Directories & files | kebab-case | `user-profile/`, `format-date.ts` |
| Components (and their files, if framework convention) | PascalCase | `UserCard`, `UserCard.tsx` |
| Variables, functions | camelCase, verb-first for functions | `fetchInvoices()`, `isExpired` |
| Constants | SCREAMING_SNAKE only for true constants | `MAX_UPLOAD_BYTES` |
| Types/interfaces | PascalCase, no `I` prefix | `Invoice`, `PaymentStatus` |
| Booleans | `is/has/can/should` prefix | `hasAccess` |
| Env vars | SCREAMING_SNAKE, grouped by service | `STRIPE_SECRET_KEY` |
| Database | follow the chosen ORM/DB convention consistently; record it here once chosen | — |

Names say **what**, comments say **why**. If a name needs a comment to be understood, rename it.

## Functions & modules

- Small units with one job; extract when a function does "and".
- Prefer pure functions; isolate side effects at the edges.
- Early returns over nested conditionals; max ~2 levels of nesting before extracting.
- No dead code, no commented-out code, no speculative "we might need it" abstractions (build for today, design for change).
- Module size is a smell threshold, not a rule: a file past ~300 lines deserves a split-or-justify look.

## Comments & docs

- Comment the *why* (constraints, gotchas, business rules), never the *what* the code already says.
- Public utilities and non-obvious modules get a short doc comment.
- `TODO` is banned in delivered work — finish it, or track it as a real task/issue and reference it. (AGENTS.md forbids placeholder implementations.)

## Errors & async

- Never swallow an error. Catch only where you can handle, translate, or intentionally degrade.
- Async: `async/await`; every awaited call has a failure story (propagate typed error → UI state).
- User-facing error messages are humane and safe ([SECURITY.md](SECURITY.md) — no internals leaked).

## Forms & user input (web)

- Every form: client-side validation for UX, **server-side validation for truth** — same schema shared when possible.
- Every submit: pending state, disabled double-submit, success feedback, recoverable error state with preserved input.
- Labels tied to inputs, errors announced accessibly ([DESIGN-UX.md](DESIGN-UX.md)).

## Internationalization (when in scope)

- Decide at setup ([AGENTS.md](../../AGENTS.md)) whether i18n is in scope; retrofitting is expensive.
- If in scope: no hard-coded user-facing strings — all copy through the i18n layer from day one; ICU-style pluralization; dates/numbers via `Intl`; layouts tolerant of ±40% text length; `lang` attribute correct.
- If out of scope: still avoid concatenated sentence fragments; keep copy centralized enough to extract later.

## Analytics, consent & privacy (when in scope)

- Analytics only with a consent mechanism appropriate to the audience's jurisdiction; default to the privacy-preserving option.
- No personal data in analytics events, URLs, or logs ([SECURITY.md](SECURITY.md)). Prefer privacy-respecting analytics tools.

## Version control

- Small, focused commits in imperative mood: `Add newsletter signup endpoint`.
- Conventional Commits (`feat:`, `fix:`, `chore:`…) recommended once CI/changelog tooling exists — record the choice here when adopted.
- Never commit: secrets, `.env*` (except `.env.example`), build output, editor junk. `.gitignore` at repo root is the enforcement seed.
- Agents never push, tag, or force-push without explicit human approval (AGENTS.md §10).

## Framework-specific sections

> Add a subsection per adopted framework at template setup — keep framework rules out of the agnostic sections above.

- *(none adopted yet — this repository is documentation-only)*

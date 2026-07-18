# Architecture Decision Records (ADRs) — Process

Lightweight, numbered records of decisions that shape a project. An ADR captures **context → decision → consequences** in under a page, so future humans and agents understand *why* things are the way they are.

> **Where ADRs live:** This file (in the shared `.agents/` blueprint) describes the *process*. A project's actual ADRs are **project-specific** and live in a root-level `decisions/` directory **outside** `.agents/` — because `.agents/` is a shared, read-only submodule you cannot write project records into. Copy the [ADR template](../templates/adr.template.md) to `decisions/NNNN-title.md` in the project root.

## When an ADR is required

- Major dependency or framework choices
- Authentication / authorization approach
- Data storage changes (database, schema philosophy, caching layer)
- API architecture (REST/RPC/GraphQL, versioning strategy)
- Significant security decisions (session model, secret management, payment handling)
- Major design-system changes (art direction, token system overhaul)
- Irreversible or expensive migrations
- Anything the team would otherwise re-litigate in six months

## When NOT to write one

Trivial implementation details, naming choices, one-file patterns, reversible experiments. If it's cheap to change and nobody will ask "why is it like this?", it's not an ADR. Record small conventions in [STANDARDS.md](../standards/STANDARDS.md) instead.

## Process

1. Copy [`../templates/adr.template.md`](../templates/adr.template.md) into the project's root `decisions/` as `NNNN-short-kebab-title.md` (next number, zero-padded).
2. Status flow: `proposed` → `accepted` (human approves) → later possibly `superseded by ADR-XXXX` or `deprecated`. Never rewrite history — supersede.
3. Link it: from the project root [AGENTS.md → Infrastructure Decisions](../../AGENTS.md#infrastructure-decisions) and from any doc it affects.
4. Agents may **draft** ADRs freely; **accepting** one that binds the project is a human decision ([/AGENTS.md §10](../../AGENTS.md)).

## Index

The project's own ADR index lives at [`decisions/README.md`](../../decisions/README.md) in the project root.

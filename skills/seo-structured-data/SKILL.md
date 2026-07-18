---
name: seo-structured-data
description: Make public pages findable and correctly represented — metadata, canonical URLs, structured data (schema.org), sitemaps, robots, social cards, and the crawlability/performance basics search engines reward. Use for new public pages, launches, SEO audits, or rich-result work.
---

# SEO & Structured Data

## Outcome

Public pages that crawlers can fetch, understand, and represent correctly: accurate metadata, valid structured data, clean indexing signals — with zero deceptive tactics.

## When to use

- New public page/route/section (gate SEO — [QUALITY-GATES.md](../../standards/QUALITY-GATES.md))
- Pre-launch SEO pass; migration/URL-structure changes (redirect planning)
- Rich results wanted (articles, products, events, FAQs…)
- Diagnosing indexing/traffic problems

## When NOT to use

- Internal/authenticated pages — they get `noindex`, not optimization
- Copywriting/content strategy — humans own the message; this skill ensures the machinery represents it
- Core Web Vitals work → [performance-optimization](../performance-optimization/SKILL.md) (SEO-adjacent, separately owned)

## Required context & inputs

- Which pages are public + the site's canonical domain/URL scheme ([project profile → AGENTS.md](../../../AGENTS.md))
- The content's real subject matter (metadata must describe truthfully)
- Framework's metadata/sitemap mechanisms (use them, don't hand-roll duplicates)

## Workflow

1. **Crawlability first** — public pages return 200 as server-rendered/prerendered HTML where feasible (don't hide primary content behind client-only JS); `robots.txt` allows what should index, blocks what shouldn't; `noindex` on auth/thin/duplicate pages; sitemap generated and referenced.
2. **Per-page metadata** — unique, truthful `<title>` (~50–60 chars, subject-first) and `meta description` (~150–160); canonical URL on every page (self-referencing by default, deliberate for variants/pagination); correct `lang`; one `h1` matching the subject (heading structure is shared with [accessibility-audit](../accessibility-audit/SKILL.md)).
3. **URL & redirect hygiene** — stable, readable, lowercase, hyphenated URLs; one URL per content (www/non-www, trailing-slash policy picked and enforced by 301); changed URLs get permanent redirects, no chains; 404s return 404 (not soft-200).
4. **Structured data** — JSON-LD, schema.org types matching the actual content (Organization/WebSite site-wide; Article/Product/Event/FAQ/BreadcrumbList as applicable). Only claims visible on the page — invented ratings/prices are deceptive and penalized. Validate every block.
5. **Social cards** — Open Graph + Twitter/X card tags with real title/description/image (right dimensions, absolute URLs); verify the preview renders.
6. **Verify** — validate structured data (Rich Results/schema validator), fetch pages as a crawler would (curl the HTML: is the content there?), check sitemap freshness, confirm redirects with real requests.

## Deliverables

- Metadata/canonical/robots/sitemap implementation via the framework's mechanism
- Valid JSON-LD blocks per content type
- Redirect map when URLs changed
- Verification results in the report

## Quality checklist

- [ ] Every public page: unique title/description, canonical, correct status code
- [ ] Structured data validates with zero errors and matches visible content
- [ ] No index leaks (staging/auth pages) and no accidental `noindex` on money pages
- [ ] Redirects permanent, chain-free, tested
- [ ] Gate SEO recorded with evidence; gate P noted (CWV affects ranking — route to [performance-optimization](../performance-optimization/SKILL.md) if failing)

## Validation

Paste: validator results for JSON-LD, the fetched HTML snippet proving server-rendered content, redirect curl outputs, sitemap URL sample. Claims without fetch evidence don't count.

## Common failure modes

- **Client-only content** — crawler sees an empty shell; render on the server or prerender
- **Copy-pasted metadata** — every page "Home | Brand"; uniqueness is the point
- **Schema wishful thinking** — marking up reviews that don't exist on-page; penalty territory
- **Staging indexed / prod noindexed** — the classic launch disaster; check both directions at every deploy
- **Redirect chains after migrations** — old→older→current; flatten to one hop

## Security considerations

SEO surfaces leak: sitemaps/robots must not enumerate private routes; structured data must not embed personal data; social-card image endpoints that render user content need the same input validation as any endpoint ([SECURITY.md §6–7](../../standards/SECURITY.md)). No cloaking or deceptive markup — it's both policy-violating and dishonest.

## Related

- [performance-optimization](../performance-optimization/SKILL.md) (CWV) · [accessibility-audit](../accessibility-audit/SKILL.md) (shared semantics) · [ui-implementation](../ui-implementation/SKILL.md) · [QUALITY-GATES.md](../../standards/QUALITY-GATES.md)

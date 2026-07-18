# DESIGN-UX.md — Visual & UX Standards

> The bar: **visually exceptional, intentional, modern work — never generic AI-generated interfaces.** Distinctive visuals must never cost accessibility, clarity, speed, or maintainability; when in tension, usability wins and the design gets smarter, not weaker.
> Related skills: [design-system](../skills/design-system/SKILL.md), [ui-implementation](../skills/ui-implementation/SKILL.md), [ux-review](../skills/ux-review/SKILL.md), [visual-qa](../skills/visual-qa/SKILL.md), [accessibility-audit](../skills/accessibility-audit/SKILL.md).

## 1. Art direction

- Every project defines a short **art direction** before UI work: personality (3 adjectives), typographic voice, color story, spatial density, motion character. Record it in the project's design-system doc; it's an ADR-level decision when it changes.
- The direction must fit the *product and audience* — a law firm and a skate brand don't share a vibe.
- **Anti-generic rules:** no defaults-because-defaults (framework-default fonts/colors/shadows must be a choice, not an accident); no purple-gradient-on-white "AI slop" aesthetic, no emoji-as-design-system, no three-cards-with-icons filler sections, no meaningless stock illustration; at least one deliberate distinctive element (type pairing, grid rhythm, color use, motion signature) per project.

## 2. Design tokens

All visual values flow from named tokens (CSS custom properties or the framework's token system) — **no magic values in component code.**

| Token group | Rule |
|---|---|
| Color | Semantic layer (`--color-bg`, `--color-text-muted`, `--color-danger`) over raw palette; both light/dark themes if theming is in scope; every text/bg pair passes contrast (§5) |
| Typography | One scale (e.g. 1.2–1.333 ratio), ≤2 families; body ≥16px; line-height ~1.5 body, tighter for headings; measure 45–75ch |
| Spacing | One scale (4px or 8px base) used for ALL margins/paddings/gaps |
| Radius | Small fixed set (e.g. sm/md/lg/full) applied consistently by component role |
| Elevation | Defined shadow steps; shadows imply layering, not decoration |
| Motion | Duration tokens (~120–300ms UI), standard easings; motion means something (feedback, orientation), never ambient noise |
| Breakpoints | Named tokens; see §4 |

## 3. Information hierarchy & layout

- Each screen has ONE primary action, visually unmistakable. Secondary/tertiary actions look subordinate.
- Hierarchy through size, weight, spacing, and color **in that order**; if everything is bold, nothing is.
- Whitespace is a design material: dense where users scan (tables), generous where users decide (forms, checkout).
- Grid-aligned: consistent gutters and column rhythm; no accidental near-alignments (things are aligned or clearly not).
- Avoid clutter: every element earns its place; decoration that carries no meaning is removed.

## 4. Responsive behavior

- Mobile-first CSS where appropriate; layouts designed—not merely squished—at each breakpoint.
- Validated breakpoints: **375px, 768px, 1440px** (+ project-specific ones from analytics; test ~320px for overflow robustness).
- No horizontal page scroll ever; wide content (tables, code) scrolls inside its own container.
- Touch targets ≥ 44×44px with adequate spacing; hover-only affordances have touch/keyboard equivalents.
- Test with realistic long content: long names, long emails, empty lists, 1000-row tables, RTL if i18n in scope, ±40% text length.

## 5. Accessibility (WCAG 2.2 AA — mandatory)

- Contrast: text ≥ 4.5:1 (large text ≥ 3:1), UI components/graphics ≥ 3:1.
- Full keyboard operability: logical tab order, no traps, skip link, **visible focus states** on everything interactive (design them; never `outline: none` without a better replacement).
- Semantic HTML first (landmarks, headings in order, buttons vs links correct); ARIA only when semantics can't do it.
- Forms: programmatic labels, described errors (`aria-describedby`), errors announced; instructions not color-only.
- Media: alt text that carries meaning (or empty alt when decorative); captions for video.
- **Reduced motion:** respect `prefers-reduced-motion` — significant animation gets a reduced variant, never just removed feedback.
- Zoom to 200% without loss of content or function.
- Full checklist and audit workflow: [accessibility-audit](../skills/accessibility-audit/SKILL.md).

## 6. States & feedback — the non-negotiable eight

Every interactive component and every data view ships with ALL applicable states, designed on purpose:

**loading** (skeleton/spinner + layout reserved, no CLS) · **empty** (helpful, with a next action — never a blank void) · **error** (humane copy, what happened + how to recover, input preserved) · **success** (clear confirmation) · **disabled** (visibly + programmatically) · **hover** · **active/pressed** · **focus** (§5).

Offline/degraded behavior defined for anything users may lose work in (preserve drafts; warn before data loss).
Feedback timing: perceived-instant (<100ms) for interactions; progress indication past ~400ms; optimistic UI only with rollback UX.

## 7. Content

- Realistic content in every mockup and test — real-length names, prices, paragraphs. **No lorem ipsum, no `[placeholder]`** in delivered UI.
- Microcopy: verbs on buttons ("Save invoice", not "OK"), sentence case, error copy that blames the situation not the user.
- Copy is part of design review; sloppy copy fails visual QA.

## 8. Visual QA protocol

After ANY UI change ([visual-qa](../skills/visual-qa/SKILL.md) skill): screenshot at 375 / 768 / 1440 px (light + dark if theming; key states, not just happy path) and inspect for: overflow & clipping · broken alignment & spacing rhythm · unreadable text (size/contrast/measure) · layout shift on load/interaction · inconsistent token usage (rogue colors/radii/shadows) · missing states (§6) · content collisions at long-content extremes.
Findings are fixed, not reported-and-shipped.

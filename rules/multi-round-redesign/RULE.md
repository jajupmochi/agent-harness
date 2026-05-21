---
name: multi-round-redesign
description: For substantial UI / dashboard / page redesigns (triggers like "重新设计 X", "redesign X", "再迭代 N 轮", "完整迭代"), apply a structured N-round protocol with date-stamped outputs (00-plan.md, 00-research.md, round-N.html + round-N.png + round-N-notes.md), per-round lens discipline, validation gates, and final implementation in real code.
scope: ui-project
rationale: Open-ended "make it look better" requests fail by drift. Anchoring each round to a single design lens (editorial-Swiss / high-end visual / industrial-brutalist density / synthesis / production-lock) prevents lens-mixing mush. Date-stamped outputs and a final spec lock create reviewable artifacts.
---

# multi-round-redesign

> For substantial UI / dashboard / page redesigns, apply an N-round protocol with date-stamped outputs and per-round lens discipline.

## Master TOC

- [Triggers](#triggers)
- [Outputs (mandatory artifacts)](#outputs-mandatory-artifacts)
- [Round count](#round-count)
- [Per-round lens discipline](#per-round-lens-discipline)
- [Validation gates per round](#validation-gates-per-round)
- [Implementation phase](#implementation-phase)
- [Bug-from-screenshot triage](#bug-from-screenshot-triage)
- [Companion](#companion)

## Triggers

Apply when the user requests a non-trivial UI / dashboard / page redesign. Typical:

- "重新设计 X 页面"
- "redesign X"
- "X 不够产品化, 重做"
- "再迭代 N 轮" / "我们再做 N 轮"
- "进行 N 轮 / N rounds"
- "完整迭代" / "彻底重做"

Inside autorun, this protocol auto-applies on redesign requests **without explicit re-confirmation** when round count is specified. Outside autorun, surface the protocol summary first (one line) and wait for the user's "go".

## Outputs (mandatory artifacts)

Under a date-stamped sub-folder of the project's strategy / specs path (e.g. `docs/strategy/redesign-YYYY-MM-DD/`):

- **`00-plan.md`** — N-round plan, lenses per round, module inventory, design rules, validation gates, references (project docs + web research).
- **`00-research.md`** — web + doc research synthesis when redesign touches conventions the user can't be expected to have memorized (dashboard UX, chart-picker patterns, accessibility laws). Cite sources.
- **`round-N.html` + `round-N.png` + `round-N-notes.md`** — ONE self-contained HTML mock per round, rendered to PNG via playwright, with critique + UI_AUDIT compliance table + handoff items to N+1. **Every round renders the FULL design — never a partial / "this round just changes X" file.**
- **Final spec lock** at `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`: tokens, typography, information architecture, panel id contract, agent protocol (if relevant), keyboard map, a11y, implementation file map, out-of-scope list, self-audit, approval.
- **`DELIVERY.md`** — one-page summary: what got built, what was left, how to view, known gaps, file map.

## Round count

- **Default 3 rounds.**
- **4-5 rounds** when (a) the lens contrast between rounds is large (minimalist → density → editorial → synthesis is 4 rounds), or (b) the user explicitly asks for more.
- Each round = ONE major lens shift, not a tiny CSS tweak.

## Per-round lens discipline

Each round is anchored to a SINGLE lens. Choose from:

| Lens | Anchor |
|---|---|
| editorial-Swiss | typographic print, restrained palette, generous whitespace |
| high-end visual | premium agency feel, custom imagery, sophisticated palette |
| industrial-brutalist density | rigid mechanical interface, dense information, military terminal aesthetics |
| synthesis | blend the strongest 2-3 elements from prior rounds |
| production-lock | final round — convert mock into real code with no design drift |

**Mixing lenses within a round produces mush.** The round's `notes.md` explicitly names the lens and the 5-7 items it attacks vs the previous round.

## Validation gates per round

- Re-invoke `impeccable` (absolute bans) and `minimalist-ui` (premium utilitarian) skills' compliance tables.
- Apply the 4 standard tests from `conventions/UI_AUDIT_CHECKLIST.md` (if the project has one): AI-slop · category-reflex · project-copy · cross-check-with-prior-baseline.
- Render PNG via playwright at the canonical viewport (1440×980 by default).
- **Hard-fail** any round that introduces: gradient text · glassmorphism · hero-metric-template · side-stripe-as-accent · emoji · em-dash in user copy · generic SaaS clichés.

## Implementation phase

Always conclude with implementation in real code, not HTML mocks:

- Every distinctive surface from the locked round must have a corresponding component file in the production codebase.
- Wire to real backend data (not synthetic) when a real data path exists.
- Smoke-test in browser at 1440×980; verify 0 console errors / 0 warnings before claiming done.

## Bug-from-screenshot triage

When the user flags a layout / visual issue based on a screenshot:

1. Take a **fresh viewport-only** screenshot (`fullPage: false`) at the canonical viewport — fullPage screenshots can mislead users into thinking content is centered / missing when it's just below the fold.
2. Inspect the DOM via playwright snapshot if needed.
3. Only if reproducible in viewport → fix the layout; otherwise note the screenshot artifact and continue.

## Companion

- Pairs with `ui-iteration-loop` rule (single-iteration 8-step loop for small UI changes; `multi-round-redesign` for full N-round redesigns).
- Uses `impeccable`, `minimalist-ui`, `playwright` (or `chrome-devtools` MCP) plugins extensively.
- The `frontend-design@claude-plugins-official` plugin provides additional design heuristics.

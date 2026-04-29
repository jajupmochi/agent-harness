---
name: verify-visual
description: Use chrome-devtools MCP to screenshot a target URL/element and visually verify it matches a reference. Auto-fires when the user requests a UI change with a visual reference (paired with the ui-iteration-loop rule).
---

# /verify-visual

Visually verify a UI change against a reference using chrome-devtools MCP.

## Pre-flight

- Confirm `chrome-devtools` MCP plugin is installed and not deprecated (per `plugin-preflight` rule)
- Confirm the dev server is running (use `/preview` first if not)

## Steps

1. **Acknowledge** what you're verifying — re-state the change and the reference (1 line).
2. **Navigate** to the target page using `chrome-devtools` MCP (`navigate` / `navigate_page`).
3. **Screenshot** the relevant element (or full page) via `take_screenshot` / `take_snapshot`.
4. **Self-critique** against the reference on the 4 axes (per `ui-iteration-loop` rule):
   - **Color** — palette, contrast, accent
   - **Typography** — font, weight, size, line-height
   - **Spacing** — padding, margin, gap, rhythm
   - **Ornamentation** — borders, shadows, decorative elements
5. **Show user** the screenshot + 1-line verdict (match / off / specific axis to retry).

## Output format

```
Verifying <change> against <reference> — 4 axes:
- Color: ✓ matches reference accent
- Typography: ✓ font + weight align
- Spacing: ⚠ slightly tighter than reference (~2 px less rhythm)
- Ornamentation: ✓ no shadow drift

Screenshot: <path-or-url>
Verdict: 80% match. Tighten rhythm next, or ship as-is?
```

## When NOT to use

- Micro-edits (single property tweak, copy fix) — skip per `output-brevity` companion rule
- No reference provided — there's nothing to verify against
- chrome-devtools MCP unavailable — ask the user how to proceed rather than fall back to blind edits

## Lighthouse integration

When the visual concern includes performance / SEO / accessibility (not just look):

- chrome-devtools MCP also exposes Lighthouse via `lighthouse_audit` (Chrome's built-in version)
- No npm install of `lighthouse` needed for ad-hoc audits
- For CI / scheduled audits, install `@lhci/cli` separately (see `recommendations/web-auditing.md`)

## Companion rules

- `ui-iteration-loop` — when running an autonomous 8-iteration loop, this skill is invoked at each iteration's "screenshot + critique" step
- `plugin-preflight` — verify chrome-devtools MCP installed before first invocation in a session
- `tool-proactivity` — fire this skill automatically when the task involves visual verification, with a one-line announcement

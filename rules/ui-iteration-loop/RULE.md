---
name: ui-iteration-loop
description: When the user provides a visual reference for a UI/CSS change, run an autonomous up-to-8-iteration loop with chrome-devtools screenshots and 4-axis self-critique.
scope: ui-project
rationale: Visual changes are open-ended — "make it look like X" can take 5-30 iterations of small tweaks. Pre-authorizing a bounded loop avoids confirmation cost per iteration while keeping a safety net (3-iteration check, 8-iteration cap).
---

# ui-iteration-loop

> When the user provides a visual reference for a UI/CSS change, run a bounded autonomous iteration loop with screenshots and self-critique.

## Master TOC

- [Rule](#rule)
- [When this triggers](#when-this-triggers)
- [Iteration steps](#iteration-steps)
- [Self-critique axes](#self-critique-axes)
- [Stop conditions](#stop-conditions)
- [Pre-flight](#pre-flight)
- [Override](#override)

## Rule

When the user provides a **visual reference** (screenshot, image, mockup, "make it look like X", precise visual spec) for a UI / CSS / styling change, run an **autonomous iteration loop** instead of single-shot guessing.

## When this triggers

- A visual reference is provided (image, URL to screenshot, or precise visual spec)
- The user wants a UI / CSS / animation / spacing / typography change
- Contrast: when there's NO visual reference, use single-shot edit + `pre-edit-confirmation` instead

## Iteration steps

1. **Acknowledge** the reference (re-state the key visual features you'll target — color, typography, spacing, ornamentation).
2. **Iterate up to 8 times**, each iteration being:
   1. Make ONE focused CSS / style change.
   2. Use `chrome-devtools` MCP (or equivalent browser automation) to navigate to the target element + take a screenshot.
   3. Self-critique against the reference on the **4 axes** (below) — name them explicitly.
   4. Show the user the screenshot + a **1-line rationale** for the next iteration's change (or "match achieved, stopping").

## Self-critique axes

Each iteration must explicitly evaluate:

1. **Color** — palette, contrast, accent
2. **Typography** — font choice, weight, size, line-height
3. **Spacing** — padding, margin, gap, rhythm
4. **Ornamentation** — borders, shadows, decorative elements

Skip axes that aren't relevant to the reference, but say so explicitly.

## Stop conditions

- **Match achieved** — stop early when ~80% match. Don't burn iterations chasing pixel-perfect.
- **Not converging** — stop and ask if after 3 iterations you're not converging. The reference may be ambiguous or the target element wrong.
- **Hard cap** — 8 iterations maximum; never silently exceed.

## Pre-flight

Before iteration 1, confirm:

- `chrome-devtools` MCP (or your browser automation tool) is available (use `plugin-preflight`)
- The target page is accessible

If not, ask the user how to proceed instead of falling back to blind CSS edits.

## Override

This rule overrides `pre-edit-confirmation` **inside the loop only** — the user pre-authorized the loop by providing the reference, and confirming each iteration would defeat the purpose. The 1-line rationale per screenshot keeps the user in the loop without a full plan-and-confirm cycle.

`pre-edit-confirmation` still applies BEFORE the loop starts (the initial commitment to enter the loop).

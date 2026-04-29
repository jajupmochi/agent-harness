## UI design tasks with a visual reference

When the user provides a **visual reference** (screenshot, image, mockup, "make it look like X", precise visual spec) for a UI / CSS / styling change, run an **autonomous iteration loop** instead of single-shot guessing:

1. **Acknowledge** the reference — re-state the key visual features you'll target (color, typography, spacing, ornamentation).
2. **Iterate up to 8 times**. Each iteration:
   - Make ONE focused CSS / style change
   - Use `chrome-devtools` MCP (or equivalent) to navigate + screenshot
   - Self-critique against reference on the **4 axes** (color, typography, spacing, ornamentation) — name them explicitly
   - Show user screenshot + 1-line rationale
3. **Stop early** when match is excellent (~80%). Don't chase pixel-perfect.
4. **Stop and ask** if after 3 iterations you're not converging — the reference may be ambiguous or the target element wrong.

**Pre-flight**: confirm `chrome-devtools` MCP (or browser automation tool) is available and target page is accessible. If not, ask before falling back to blind CSS edits.

This rule overrides per-edit confirmation **inside the loop only** — the user pre-authorized the loop by providing the reference. Per-edit confirmation still applies BEFORE entering the loop.

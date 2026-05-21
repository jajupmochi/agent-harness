# Reference Projects

> Standalone demos / template projects worth studying for technique — not libraries to install. Browse the source, learn the patterns, port what fits. **Context:** `optional`.

## Master TOC

- [How to use this list](#how-to-use-this-list)
- [Canvas 2D / isometric builders](#canvas-2d--isometric-builders)
- [Companion](#companion)

## How to use this list

Each entry is a **project to study**, not a package to install. The link goes to the GitHub repo (and live demo when available). When reaching for a technique demonstrated here, clone or browse the source rather than re-deriving from scratch.

Entry shape:

- **Project name** — one-line purpose
- **Link**: GitHub repo · live demo (if any)
- **License** · **Author**
- **Stack**: key technologies
- **Why study it**: what specific technique / pattern it demonstrates
- **When to reach for it**: which task would benefit from porting its ideas

## Canvas 2D / isometric builders

### mykonos-island-voxels — isometric island builder, zero-dependency Canvas 2D

- **Link**: [github.com/boona13/mykonos-island-voxels](https://github.com/boona13/mykonos-island-voxels) · live demo: [mykonos-island-voxels.netlify.app](https://mykonos-island-voxels.netlify.app)
- **License**: MIT (code + PNG asset pack)
- **Author**: `boona13`
- **Stack**: pure vanilla JavaScript ES modules + HTML5 Canvas 2D. **Zero external frameworks / bundlers / dependencies.**
- **Why study it**:
  - **Painterly asset pipeline** — 75+ PNG assets pre-rendered at 6× resolution, tasteful Mediterranean / Mykonos aesthetic; shows how to ship a visually rich app without a 3D engine.
  - **Layered cache rendering** — the rendering pipeline caches layers to keep redraw cheap as the grid grows.
  - **Spatial occupancy indexing** — efficient hit-testing and placement on a 14×14 grid; portable pattern for any tile/grid editor.
  - **Touch-first mobile UI** — gesture controls (pan, pinch, place) designed for phone, with desktop as the secondary target. Few demos take touch seriously.
  - **Debounced audio overlap** — sound design that doesn't get cacophonous when many actions happen quickly.
  - **Auto-save to `localStorage`** — minimal persistence pattern, no backend.
  - **Zero deps + ES modules + HTTP-served `index.html`** — the entire app loads as ES modules; no build step. Demonstrates that "modern, polished, performant" doesn't require a bundler.
- **When to reach for it**:
  - Building an isometric grid editor / city builder / map tool (the obvious case).
  - Need a **visually rich Canvas 2D demo** without taking on Three.js / R3F / WebGL complexity.
  - Designing a **touch-first** browser tool — the gesture handling is worth porting.
  - Showing what's achievable in **zero-dep ES-modules-only** form — useful when prototyping or when you can't add a build pipeline.
- **Local install / run**:

  ```bash
  git clone https://github.com/boona13/mykonos-island-voxels.git
  cd mykonos-island-voxels
  # Serve via any local HTTP server (file:// breaks ES module imports):
  python3 -m http.server 8000
  # or:
  npx serve .
  # Then open http://localhost:8000/index.html
  ```

## Companion

- `recommendations/js-animation-and-3d.md` — for actual 3D / WebGL libraries (Three.js, R3F) when you need GPU rendering instead of Canvas 2D.
- `recommendations/js-ui-and-design.md` — for component libraries when you want UI primitives instead of building from Canvas.
- `skills/general/preview-template/SKILL.md` — `/preview` skill includes the `python3 -m http.server` pattern used here.

## Adding a new reference project

When you find another standalone demo worth studying, append an entry to the matching subsection above (or add a new subsection if none fit). Keep the entry shape consistent so future you can scan quickly.

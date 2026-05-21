# JS UI + Design Libraries

> Component libraries, icons, design tokens, data-viz primitives. **Context:** `ui-project` (lazy install when project needs UI).

## Master TOC

- [Icons](#icons)
- [Icon explorers / brand SVG](#icon-explorers--brand-svg)
- [Design tokens / colors](#design-tokens--colors)
- [Component libraries](#component-libraries)
- [Data viz](#data-viz)
- [Other UI primitives](#other-ui-primitives)
- [Smooth scroll / scroll behavior](#smooth-scroll--scroll-behavior)

## Icons

| Lib | When to use | Install |
|---|---|---|
| `lucide-react` | React icons (de-facto standard, used with shadcn-ui) | `npm i lucide-react` |
| `lucide-vue-next` | Vue icons | `npm i lucide-vue-next` |
| `@radix-ui/react-icons` | Radix-aligned 15×15 icon set (alternative to lucide for Radix users) | `npm i @radix-ui/react-icons` |

## Icon explorers / brand SVG

Catalogues for when you need to find an icon or a logo by name (no install required — browse + download).

| Resource | When to use | Link |
|---|---|---|
| **yesicon.app** | Large multi-pack icon explorer — search across multiple icon sets, one-click copy SVG / JSX / CDN | [yesicon.app](https://yesicon.app/) |
| **svgl.app** | Repository of brand + logo SVGs for products, frameworks, tools — per-logo download SVG / PNG | [svgl.app](https://svgl.app/) |

Both are browse-only (no npm install).

## Design tokens / colors

| Lib | When to use | Install |
|---|---|---|
| `@radix-ui/colors` | Accessible color tokens (semantic ramps, dark-mode aware) | `npm i @radix-ui/colors` |
| `culori` | Color manipulation / conversion / interpolation | `npm i culori` |
| `tailwindcss` | Utility-first CSS framework | `npm i -D tailwindcss@latest` |

## Component libraries

| Lib | When to use | Install |
|---|---|---|
| `@radix-ui/themes` | Pre-styled accessible components — alternative to "build it yourself" with shadcn | `npm i @radix-ui/themes` |
| `@radix-ui/react-<primitive>` | Headless primitives (popover, dialog, dropdown, tooltip) — used to build a custom design system | `npm i @radix-ui/react-popover @radix-ui/react-dialog @radix-ui/react-dropdown-menu @radix-ui/react-tooltip` |
| `@chakra-ui/react` | Themeable, accessible React component system — broad component coverage, design tokens, dark mode out of the box | `npm i @chakra-ui/react @emotion/react @emotion/styled framer-motion` |
| **shadcn-ui** (via skill bundle) | Component generator — copies code into your repo so you fully own it | `npx skills add shadcn/ui` (then `npx shadcn@latest add <component>`) |
| `class-variance-authority` (`cva`) + `clsx` + `tailwind-merge` | Tailwind class composition trio — used by shadcn-ui | `npm i class-variance-authority clsx tailwind-merge` |

**Decision tree**:

- **shadcn-ui**: full control over component code (it generates files into your repo). Best for "design system from scratch."
- **Radix Themes**: quick start with sensible defaults. Best for "ship a UI fast."
- **Chakra UI**: broadest pre-built coverage + theming. Best for "rich app UI with dark mode + a11y out of the box."

The `npx skills add shadcn/ui` bundle (see [cc-marketplaces-and-skill-bundles.md](cc-marketplaces-and-skill-bundles.md)) gives you `/shadcn:add <component>` slash command for component installation.

## Data viz

| Lib | When to use | Install |
|---|---|---|
| `d3` | Bespoke charts; full control | `npm i d3` |
| `@visx/visx` | React + D3 building blocks (Airbnb's visx) | `npm i @visx/visx` |
| `recharts` | High-level React charts; simpler than visx for common cases | `npm i recharts` |

**Decision**: `recharts` for "ship a chart now"; `@visx` when you need more control; `d3` direct when nothing high-level fits.

## Other UI primitives

| Lib | When to use | Install |
|---|---|---|
| `@monaco-editor/react` | In-app code editor (VS Code's editor) | `npm i @monaco-editor/react` |
| `@tanstack/react-table` | Headless table primitives — composable, type-safe | `npm i @tanstack/react-table` |

## Smooth scroll / scroll behavior

| Lib | When to use | Install |
|---|---|---|
| `lenis` | Smooth-scroll library (Studio Freight) — high-quality scroll feel | `npm i lenis` |

**Pair with**: `gsap-scrolltrigger` (see [js-animation-and-3d.md](js-animation-and-3d.md)) for scroll-driven animations.

## Companion files

- [js-animation-and-3d.md](js-animation-and-3d.md) — animation libraries (motion, gsap, lottie) + 3D (three, R3F)
- [js-build-test-style.md](js-build-test-style.md) — Tailwind ecosystem, build tools, testing
- [js-state-data.md](js-state-data.md) — state management, data fetching

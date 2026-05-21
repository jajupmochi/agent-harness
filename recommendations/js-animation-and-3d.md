# JS Animation + 3D

> Animation libraries and 3D / WebGL stack. **Context:** `ui-project` + `3d-or-animation` (lazy install when motion / 3D enters scope).

## Master TOC

- [Animation libraries](#animation-libraries)
- [Animated icon catalogues / micro-interactions](#animated-icon-catalogues--micro-interactions)
- [3D / WebGL](#3d--webgl)
- [MediaPipe (specialized)](#mediapipe-specialized)
- [HTML → video pipelines](#html--video-pipelines)
- [React Native motion](#react-native-motion)
- [Decision tree](#decision-tree)

## Animation libraries

| Lib | When to use | Install |
|---|---|---|
| `motion` | Production-grade React/Vue animation, hybrid GPU engine. **Successor to `framer-motion`** — use `motion` going forward | `npm i motion` |
| `gsap` | Timeline-based, scroll-driven, complex sequencing. Best for advanced motion (vs. component-level animations) | `npm i gsap` |
| `animejs` (`anime.js`) | Lightweight JS animation engine for CSS / SVG / DOM / JS objects. Use for vanilla-JS or framework-agnostic motion | `npm i animejs` |
| `lottie-react` | Render After Effects → Bodymovin JSON animations | `npm i lottie-react` |
| `tailwindcss-animate` | Animation utilities aligned with Tailwind (used in shadcn-ui template) | `npm i tailwindcss-animate` |
| `math-curve-loaders` | Rose-curve / Lissajous / cardioid loading spinners — HTML+CSS+JS, no deps. Use when a default spinner feels generic | Browse [GitHub](https://github.com/Paidax01/math-curve-loaders) / [demo](https://paidax01.github.io/math-curve-loaders/), copy CSS+JS into project |

**`framer-motion`** is the deprecated package name — install `motion` instead. Existing projects using `framer-motion` still work but should migrate.

**`gsap` skills** are available as a bundle: `npx skills add https://github.com/greensock/gsap-skills`. Adds `/gsap-core`, `/gsap-timeline`, `/gsap-scrolltrigger`, `/gsap-utils`, `/gsap-react`, `/gsap-frameworks`, `/gsap-plugins`, `/gsap-performance` slash commands.

## Animated icon catalogues / micro-interactions

For icons that *move* (not just static), use these catalogues instead of building animations from scratch.

| Lib / Resource | When to use | Install / how |
|---|---|---|
| **itshover** | Animated icon library (React + Motion); icons that "move with intent, not decoration" | `npx shadcn@latest add https://itshover.com/r/<icon-name>.json` — see [itshover.com/icons](https://itshover.com/icons) |
| **useanimations** | Catalogue of Lottie / SVG micro-interactions (e.g., menu icon morphs, like-button bounce) — free + paid tiers | Browse [useanimations.com](https://useanimations.com/) per-asset download |

Both pair well with `motion` or `gsap` for the surrounding animation context.

## 3D / WebGL

| Lib | When to use | Install |
|---|---|---|
| `three` | Three.js — WebGL workhorse. Use directly or via React wrapper | `npm i three` |
| `@react-three/fiber` | React renderer for Three.js (R3F) | `npm i three @react-three/fiber` |
| `@react-three/drei` | Helpers + abstractions for R3F (cameras, controls, loaders) | `npm i @react-three/drei` |
| `@types/three` | TS types for three (auto-installs with TS projects) | `npm i -D @types/three` |

**Decision**: use R3F unless you have a non-React stack. Plain `three.js` for Vue / Svelte / vanilla.

## MediaPipe (specialized)

For real-time hand / face / pose tracking. **Context:** `optional` (specialized to interactive / camera-based UIs).

| Lib | Install |
|---|---|
| `@mediapipe/hands` | `npm i @mediapipe/hands` |
| `@mediapipe/camera_utils` | `npm i @mediapipe/camera_utils` |
| `@mediapipe/control_utils` | `npm i @mediapipe/control_utils` |
| `@mediapipe/drawing_utils` | `npm i @mediapipe/drawing_utils` |

Bundled install:

```bash
npm i @mediapipe/hands @mediapipe/camera_utils @mediapipe/control_utils @mediapipe/drawing_utils
```

## HTML → video pipelines

For programmatic video generation from HTML / CSS / web tech:

| Tool | When to use | Install |
|---|---|---|
| **HyperFrames** | "Write HTML, render video" — HTML → MP4 pipeline designed for AI agents. Use when an LLM needs to generate animated marketing / explainer videos | `npx hyperframes init my-video` (Apache-2.0) |
| **Remotion** (via skill bundle) | React-based video creation; programmable in JSX | `npx skills add remotion-dev/skills` (then per Remotion docs) |

## React Native motion

For React Native projects (out of scope of web `motion` / `gsap`):

| Lib | Purpose | Install |
|---|---|---|
| `react-native` `Animated` | Declarative animation API bundled with React Native | Ships with `react-native` |
| `react-native-reanimated` | Worklet-based animation that runs on the UI thread for smoother gestures | `npm i react-native-reanimated` (+ platform setup per [docs](https://docs.swmansion.com/react-native-reanimated/)) |

## Decision tree

```
Need motion?
├─ Component-level (entry/exit, hover, gestures)
│   └─ motion (formerly framer-motion)
├─ Timeline-based / scroll-driven / complex sequencing
│   └─ gsap (+ ScrollTrigger plugin)
├─ Pre-designed in After Effects?
│   └─ lottie-react (render the AE JSON)
└─ Lightweight Tailwind utilities?
    └─ tailwindcss-animate

Need 3D?
├─ React stack
│   └─ @react-three/fiber + @react-three/drei
└─ Other framework or vanilla
    └─ three (direct)

Need real-time hand/face tracking?
└─ @mediapipe/* (no good alternatives)
```

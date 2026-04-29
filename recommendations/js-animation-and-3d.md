# JS Animation + 3D

> Animation libraries and 3D / WebGL stack. **Context:** `ui-project` + `3d-or-animation` (lazy install when motion / 3D enters scope).

## Master TOC

- [Animation libraries](#animation-libraries)
- [3D / WebGL](#3d--webgl)
- [MediaPipe (specialized)](#mediapipe-specialized)
- [Decision tree](#decision-tree)

## Animation libraries

| Lib | When to use | Install |
|---|---|---|
| `motion` | Production-grade React/Vue animation, hybrid GPU engine. **Successor to `framer-motion`** — use `motion` going forward | `npm i motion` |
| `gsap` | Timeline-based, scroll-driven, complex sequencing. Best for advanced motion (vs. component-level animations) | `npm i gsap` |
| `lottie-react` | Render After Effects → Bodymovin JSON animations | `npm i lottie-react` |
| `tailwindcss-animate` | Animation utilities aligned with Tailwind (used in shadcn-ui template) | `npm i tailwindcss-animate` |

**`framer-motion`** is the deprecated package name — install `motion` instead. Existing projects using `framer-motion` still work but should migrate.

**`gsap` skills** are available as a bundle: `npx skills add https://github.com/greensock/gsap-skills`. Adds `/gsap-core`, `/gsap-timeline`, `/gsap-scrolltrigger`, `/gsap-utils`, `/gsap-react`, `/gsap-frameworks`, `/gsap-plugins`, `/gsap-performance` slash commands.

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

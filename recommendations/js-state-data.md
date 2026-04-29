# JS State + Data Fetching

> State management and data-fetching libraries. **Context:** `ui-project`.

## Master TOC

- [State management](#state-management)
- [Data fetching](#data-fetching)
- [Routing + i18n](#routing--i18n)
- [Theming](#theming)

## State management

| Lib | When to use | Framework | Install |
|---|---|---|---|
| `pinia` | Vue state management — official successor to Vuex | Vue | `npm i pinia` |
| `zustand` | React state management — lightweight, hooks-based | React | `npm i zustand` |

**Decision**: `zustand` for new React projects (simpler than Redux for typical apps). `pinia` for Vue (it's the standard).

For complex Redux-like patterns, layer Redux Toolkit on top of zustand only when needed.

## Data fetching

| Lib | When to use | Install |
|---|---|---|
| `swr` | React data fetching with cache + revalidation. Stale-while-revalidate pattern | `npm i swr` |
| `@vueuse/core` | Vue composables — includes `useFetch`, `useAsyncState`, etc. | `npm i @vueuse/core` |

**`@tanstack/react-query`** is the heavier alternative to `swr`. SWR for simple cases; React Query when you need mutation queues, optimistic updates, infinite queries.

## Routing + i18n

| Lib | When to use | Install |
|---|---|---|
| `vue-router` | Vue routing | `npm i vue-router` |
| `vue-i18n` | Vue i18n | `npm i vue-i18n` |

For React, Next.js's file-based router covers most cases. For Vite + React, use `react-router-dom`.

## Theming

| Lib | When to use | Install |
|---|---|---|
| `next-themes` | Next.js light/dark theme switching | `npm i next-themes` |

For non-Next.js, theme switching is typically done via Tailwind's `dark:` variants + `localStorage` toggle (no library needed).

## Companion files

- [js-ui-and-design.md](js-ui-and-design.md) — components + icons + tokens
- [js-build-test-style.md](js-build-test-style.md) — Tailwind, build, testing

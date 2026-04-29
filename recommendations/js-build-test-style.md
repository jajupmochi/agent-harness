# JS Build + Test + Styling

> Build tools, testing frameworks, styling pipelines for frontend projects. **Context:** `ui-project`.

## Master TOC

- [Build tools / scaffolds](#build-tools--scaffolds)
- [Testing frameworks](#testing-frameworks)
- [Styling pipeline](#styling-pipeline)
- [Formatting](#formatting)

## Build tools / scaffolds

| Tool | When to use | Install / scaffold |
|---|---|---|
| `vite` | Fast dev server + build for Vue / React / Svelte | `npx create-vite@latest` (interactive scaffold) |
| `next` (Next.js) | React app framework (SSR, RSC, file routing) | `npx create-next-app@latest <name> --typescript --tailwind --eslint --app --src-dir --use-npm` |
| `electron` + `electron-builder` | Desktop app shell + packaging | `npm i -D electron electron-builder` |
| `bun` | Fast JS runtime / bundler / pkg-mgr (Node alternative) | `curl -fsSL https://bun.sh/install \| bash` |
| `@vitejs/plugin-vue` | Vite + Vue integration | `npm i -D @vitejs/plugin-vue` |
| `@vitejs/plugin-react` | Vite + React integration | `npm i -D @vitejs/plugin-react` |
| `puppeteer` | Headless Chrome via Node — useful for one-off screenshot scripts | `npm i puppeteer --no-save` (or `npx puppeteer`) |

**Decision**: use Vite for everything except Next.js-specific apps. Vite + Vue, Vite + React, Vite + Svelte all faster than their framework-native alternatives.

## Testing frameworks

| Tool | When to use | Install |
|---|---|---|
| `vitest` | Vite-native test runner — replaces Jest for Vite projects | `npm i -D vitest jsdom` |
| `@playwright/test` + `playwright` | E2E browser testing | `npm i -D @playwright/test && npx playwright install --with-deps chromium firefox webkit` |
| `@testing-library/react` + `dom` + `user-event` + `jest-dom` | React component testing (DOM-level assertions) | `npm i -D @testing-library/react @testing-library/dom @testing-library/user-event @testing-library/jest-dom` |
| `@vue/test-utils` | Vue component testing | `npm i -D @vue/test-utils` |
| `storybook` | Component dev environment + visual testing | `npx storybook@latest init --yes --type <nextjs\|vue3\|react>` |
| `@vitest/coverage-v8` | Vitest coverage with v8 | `npm i -D @vitest/coverage-v8` |

**Decision**:

- Unit / component → vitest + testing-library
- Integration / E2E → playwright
- Visual regression / design review → storybook + chromatic (optional)

**Pair with**: chrome-devtools MCP plugin (see [cc-plugins.md](cc-plugins.md)) for Lighthouse audits.

## Styling pipeline

| Tool | When to use | Install |
|---|---|---|
| `tailwindcss` (v4) | Utility-first CSS framework | `npm i -D tailwindcss@latest` |
| `@tailwindcss/postcss` | Tailwind v4 PostCSS plugin (for Vite v4 + or any PostCSS pipeline) | `npm i -D @tailwindcss/postcss@latest` |
| `@tailwindcss/vite` | Tailwind v4 Vite plugin (preferred for Vite projects) | `npm i @tailwindcss/vite@latest` |
| `autoprefixer` | Auto vendor-prefix CSS | `npm i -D autoprefixer` |
| `postcss` | CSS post-processing (transitive in most cases) | `npm i -D postcss` |
| `tailwindcss-animate` | Animation utilities aligned with Tailwind | `npm i tailwindcss-animate` |

**Tailwind v4 setup (Vite)**:

```bash
npm i -D tailwindcss@latest @tailwindcss/vite@latest
# Add `@tailwindcss/vite` plugin to vite.config.ts
# Add `@import "tailwindcss";` to your CSS entry
```

## Formatting

| Tool | When to use | Install |
|---|---|---|
| `prettier` | Formatter (canonical for JS/TS/JSON/CSS/MD) | `npx --yes prettier --write .` (no install) or `npm i -D prettier` |

**Decision**: prefer `npx prettier` (no install) for one-shot formatting. Install as devDep when you want pre-commit / IDE integration.

For Python projects, **use `ruff format` instead of prettier** (see [cli-tools.md](cli-tools.md)).

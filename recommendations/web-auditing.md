# Web Auditing

> Performance, SEO, accessibility audits. **Context:** `static-site` or `web-perf`.

## Master TOC

- [Default: Chrome DevTools (zero-install)](#default-chrome-devtools-zero-install)
- [CLI / CI tools](#cli--ci-tools)
- [Decision tree](#decision-tree)
- [Companion: SEO audit plugin](#companion-seo-audit-plugin)

## Default: Chrome DevTools (zero-install)

For ad-hoc audits during development, the **Chrome DevTools built-in Lighthouse** (and the chrome-devtools MCP plugin) is the right answer:

- **No install** — Lighthouse ships with every Chrome / Chromium browser
- Triggered via the `chrome-devtools` MCP plugin (see [cc-plugins.md](cc-plugins.md))
- Covers performance, SEO, accessibility, best-practices, PWA in one report

**Install (the plugin only, not Lighthouse itself):**

```bash
/plugin install chrome-devtools-mcp@claude-plugins-official
```

This is the **default** path for most projects. The npm CLI version (below) is for CI / batch / scripting only.

## CLI / CI tools

For automated CI runs or batch audits across many URLs:

| Tool | When to use | Install |
|---|---|---|
| `lighthouse` (CLI) | Headless / scriptable Lighthouse for CI | `npm i -g lighthouse` (or `npx lighthouse <url> --view`) |
| `@lhci/cli` (Lighthouse CI) | Run Lighthouse across builds with assertions, GitHub Actions integration | `npm i -g @lhci/cli` |
| `pa11y` | CLI accessibility checker (lightweight) | `npx pa11y <url>` (no install) or `npm i -g pa11y` |
| `pa11y-ci` | CI-friendly pa11y runner | `npm i -g pa11y-ci` |
| `axe-core` | Industry-standard a11y engine — Lighthouse uses ~50 axe rules underneath | `npm i -g axe-core puppeteer` |
| `html-validate` | HTML validation with ARIA awareness | `npm i -g html-validate` |

**Context note**: All these are **`optional`** — install only when adding CI gates or doing scripted audits. Default workflow uses Chrome DevTools.

## Decision tree

```
What are you auditing?
├─ Single URL, ad-hoc, during development
│   └─ Use chrome-devtools MCP plugin (Lighthouse built-in, zero install)
├─ Multiple URLs / on every PR / want assertions and budgets
│   └─ Install @lhci/cli + add GitHub Actions workflow
├─ Stricter accessibility than Lighthouse provides (WCAG-AAA, etc.)
│   ├─ Quick: npx pa11y <url>
│   └─ Thorough: install axe-core + puppeteer
└─ HTML validity (semantic, ARIA, structural)
    └─ Install html-validate
```

## Companion: SEO audit plugin

The `searchfit-seo@claude-plugins-official` plugin (see [cc-plugins.md](cc-plugins.md)) provides:

- `/searchfit-seo:seo-audit` — comprehensive SEO audit
- `/searchfit-seo:on-page-seo`, `/keyword-cluster`, `/generate-schema`, `/internal-linking`, etc.

**Important**: per `tool-proactivity` rule, ALWAYS ask before running an SEO audit — long reports bloat context. Audits should be deliberate, not auto-fired.

## Author's actual workflow

The author runs Lighthouse via Chrome DevTools (chrome-devtools MCP plugin) during personal-site iterations. The site has hit "Lighthouse all-green" (>90 across all 5 categories) per its `docs/PLAN.md`. **Has NOT installed** the npm `lighthouse` CLI — Chrome's built-in version is sufficient for personal-site scale.

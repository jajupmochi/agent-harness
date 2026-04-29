# Inventory

> Master index of everything currently catalogued in this library. Updated on every add / remove / rename.

> **Language:** English | [中文](INVENTORY.zh.md)

## Master TOC

- [Status](#status)
- [Rules](#rules)
- [Skills](#skills)
- [Hooks](#hooks)
- [Recommendations](#recommendations)
- [Tooling](#tooling)
- [Templates](#templates)
- [Setup](#setup)

## Status

**Current Phase:** P1.5 Discovery completed (draft `docs/DISCOVERY.md` is gitignored, pending Linlin's review). P2 next. No public content modules populated yet. See [docs/PHILOSOPHY.md](docs/PHILOSOPHY.md) and the README's status table for the full build plan.

## Rules

✅ Populated in P2 (2026-04-29). 9 rules + index README.

| Rule | Scope | One-line |
|---|---|---|
| [`chinese-output`](rules/chinese-output/RULE.md) | personal | Final user-facing output in Chinese; intermediate stays English |
| [`pre-edit-confirmation`](rules/pre-edit-confirmation/RULE.md) | universal | List exact targets + 1-line plan + wait for explicit "go" before any Edit / Write |
| [`phased-planning`](rules/phased-planning/RULE.md) | universal | Break tasks (3+ files OR > ~5 tool calls OR multi-step) into numbered phases with per-phase pause |
| [`plugin-preflight`](rules/plugin-preflight/RULE.md) | universal | Verify plugin / skill / command is installed AND not deprecated before invoking |
| [`ui-iteration-loop`](rules/ui-iteration-loop/RULE.md) | ui-project | Autonomous 8-iteration UI redesign loop with chrome-devtools screenshots and 4-axis self-critique |
| [`output-brevity`](rules/output-brevity/RULE.md) | personal | No end-of-batch recap, don't echo tool output, prefer Edit over Write |
| [`tool-proactivity`](rules/tool-proactivity/RULE.md) | personal | Installed plugin / skill / MCP fires without asking when matched (with explicit-approval exceptions) |
| [`no-reread-files`](rules/no-reread-files/RULE.md) | personal | Trust your in-session memory of file contents; re-read only on actual change |
| [`bilingual-docs`](rules/bilingual-docs/RULE.md) | optional | `NAME.md` + `NAME.zh.md` convention (consumer-side opt-in via `setup/init-claude-config`) |

See [`rules/README.md`](rules/README.md) for usage details and scope-tag definitions.

## Skills

✅ Populated in P4 (2026-04-29). 5 general-bucket skills + index README.

| Skill | Bucket | Trigger | Purpose |
|---|---|---|---|
| [`verify-template`](skills/general/verify-template/SKILL.md) | general | `/verify` | Run CI gates locally; customize per project |
| [`preview-template`](skills/general/preview-template/SKILL.md) | general | `/preview` | Start local dev server; customize per project type |
| [`long-running-tasks`](skills/general/long-running-tasks/SKILL.md) | general | auto / `/long-running-tasks` | Decision tree: background subagent vs Monitor vs explicit timeout |
| [`verify-visual`](skills/general/verify-visual/SKILL.md) | general | auto on UI changes | chrome-devtools MCP screenshot + 4-axis self-critique against reference |
| [`privacy-redact`](skills/general/privacy-redact/SKILL.md) | general | `/privacy-redact <file>` | Scan + redact usernames, absolute paths, secrets, codenames |

Future buckets (populated in P7 with templates):

- `research-pkg/` — skills for Python research packages (`new-adapter`, `new-experiment`, …)
- `static-site/` — skills for static personal sites (`new-round`, `deploy-round`, `i18n-sync`)

See [`skills/README.md`](skills/README.md) for usage details.

## Hooks

✅ Populated in P3 (2026-04-29). 2 hooks + index README.

| Hook | Event | Matcher | Context | One-line |
|---|---|---|---|---|
| [`ruff-format-on-edit`](hooks/ruff-format-on-edit/README.md) | `PostToolUse` | `Write\|Edit` | research-pkg / any Python | Auto-format Python files with ruff after Claude edits |
| [`jq-validate-json`](hooks/jq-validate-json/README.md) | `PostToolUse` | `Write\|Edit` | static-site / JSON-config | Block next tool call if Claude wrote invalid JSON to configured paths |

See [`hooks/README.md`](hooks/README.md) for install instructions.

## Recommendations

✅ Populated in P5 (2026-04-29). 12 active files + 2 reference tables + index README.

| File | Context | Coverage |
|---|---|---|
| [cc-plugins.md](recommendations/cc-plugins.md) | always | 37 Claude Code plugins (workflow, integrations, specialized) |
| [cc-marketplaces-and-skill-bundles.md](recommendations/cc-marketplaces-and-skill-bundles.md) | always | 4 third-party marketplaces + 9 skill bundles via `npx skills add` |
| [cli-tools.md](recommendations/cli-tools.md) | always (selectively) | System CLIs (jq, gh, ripgrep, fd, …) + Python user CLIs (uv, ruff, mkdocs, hf, …) |
| [js-ui-and-design.md](recommendations/js-ui-and-design.md) | ui-project | Lucide, Radix full set, lenis, d3, visx, recharts, monaco, tanstack/table, shadcn |
| [js-animation-and-3d.md](recommendations/js-animation-and-3d.md) | ui-project + 3d-or-animation | motion, gsap, lottie-react, tailwindcss-animate; three, R3F, drei, mediapipe |
| [js-build-test-style.md](recommendations/js-build-test-style.md) | ui-project | vite, next, electron, vitest, playwright, storybook, tailwindcss, prettier |
| [js-state-data.md](recommendations/js-state-data.md) | ui-project | pinia, zustand, swr, vueuse, vue-i18n, vue-router, next-themes |
| [web-auditing.md](recommendations/web-auditing.md) | static-site / web-perf | chrome-devtools MCP (default), lighthouse CLI, lhci, pa11y, axe-core |
| [image-video-pdf.md](recommendations/image-video-pdf.md) | image-or-video-work | sharp, svgo, imagemin, ffmpeg (apt), puppeteer |
| [docs-tools.md](recommendations/docs-tools.md) | docs-site | mkdocs + material, ghp-import, latexmk (apt) |
| [ml-research.md](recommendations/ml-research.md) | ml-research | huggingface_hub[cli], datasets, gpustat, kaleido, selenium |
| [orchestra-ml-skills.md](recommendations/orchestra-ml-skills.md) | ml-research | 21-category ML skill stack incl. `0-autoresearch-skill` meta-orchestrator |
| [reference/apt-packages.md](recommendations/reference/apt-packages.md) | always (lookup) | apt-installed packages — knowledge table only, never auto-install |
| [reference/vscode-extensions.md](recommendations/reference/vscode-extensions.md) | always (lookup) | VS Code extensions — knowledge table only, CC-friendly defaults flagged |

See [`recommendations/README.md`](recommendations/README.md) for context tags and how `setup/init-claude-config` (P8) decides what to install per project type.

## Tooling

*(empty — to be populated in Phase 6)*

Anticipated entries:

- `tooling/python-uv-ruff/` — `pyproject.template.toml` + `ruff.template.toml` + README with **agent-executable install commands**
- `tooling/node-nvm/` — Node toolchain bootstrap with **agent-executable install commands**
- `tooling/permissions-allowlist/` — common `Bash(...)` allowlist entries from real projects' `settings.local.json`

## Templates

*(empty — to be populated in Phase 7)*

Anticipated entries:

- `templates/research-package-py/` — full scaffold based on `liulian-python` / `AI_Mur4Cast` patterns
- `templates/personal-cite-static/` — based on `jajupmochi.github.io` (HTML/CSS/JS, bilingual docs, i18n)

## Setup

*(empty — to be populated in Phase 8)*

Anticipated entry:

- `setup/init-claude-config/SKILL.md` — the install / scaffold skill. Asks the user about: project type, bilingual policy, primary language, which rules / hooks / skills / templates apply. Then composes a project's `CLAUDE.md`, `.claude/settings.json`, and starter `.claude/skills/` from the library.

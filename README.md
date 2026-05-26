# claude-config

> Linlin Jia's curated Claude Code configuration: **workflow rules, skills, hooks, plugin recommendations, tooling preferences, and project templates**. Install once, then `/init-claude-config` in any new project to scaffold it with the relevant subset.

> **Language:** English | [中文](README.zh.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![GitHub](https://img.shields.io/badge/GitHub-jajupmochi%2Fclaude--config-181717?logo=github)](https://github.com/jajupmochi/claude-config) [![Privacy Scan](https://github.com/jajupmochi/claude-config/actions/workflows/privacy-scan.yml/badge.svg)](https://github.com/jajupmochi/claude-config/actions/workflows/privacy-scan.yml) [![Install Matrix](https://github.com/jajupmochi/claude-config/actions/workflows/install-verify.yml/badge.svg)](https://github.com/jajupmochi/claude-config/actions/workflows/install-verify.yml)

## Master TOC

- [TL;DR](#tldr)
- [What this is](#what-this-is)
- [Quick Start](#quick-start)
- [Repository structure](#repository-structure)
- [The 14 workflow rules](#the-14-workflow-rules)
- [The 7 reusable skills](#the-7-reusable-skills)
- [The 2 hook recipes](#the-2-hook-recipes)
- [Recommendations (15 curated lists)](#recommendations-15-curated-lists)
- [Project templates](#project-templates)
- [The setup skill `/init-claude-config`](#the-setup-skill-init-claude-config)
- [For maintainers](#for-maintainers)
- [Publishing to external directories](#publishing-to-external-directories)
- [Build history](#build-history)
- [Contributing](#contributing)
- [License](#license)

## TL;DR

Quickest install — **`npx` (no clone, no Claude Code restart needed)**:

```bash
npx github:jajupmochi/claude-config
```

Then in any project root, open Claude Code and run:

```
/init-claude-config
```

Answer 6 questions → project gets scaffolded with the right rules + hooks + skills + tooling for its type.

**6 install methods** (npx / interactive `/plugin` / direct `/plugin install` / local clone / raw URL @imports / copy-paste prompt to CC) — see **[USAGE.md §0](USAGE.md#0-install-claude-config-once-per-machine)** for all paths.

## What this is

Three years of accumulated Claude Code conventions — rules to apply to every new project, hooks worth trusting, skills worth reusing, plugins worth installing — pulled out of half a dozen real research and web projects (`liulian-python`, `swiss-river-network-benchmark`, `AI_Mur4Cast`, `jajupmochi.github.io`, plus several frontends) and turned into a single composable library.

**Four aims:**

1. **One source of truth.** Every new project starts from the same baseline. No more copy-paste drift between `CLAUDE.md` files.
2. **Per-project picking.** A static-site project doesn't need ML training rules. The `/init-claude-config` skill asks which context tags apply (`research-pkg`, `ui-project`, `static-site`, `ml-research`, `web-perf`, etc.) and only installs the matching subset.
3. **Human-readable.** Each rule, hook, and skill explains *why* it exists, not just *what* it does. Someone reading without Claude still gets value.
4. **Agent-executable.** Every tooling and install entry includes copy-paste-able commands so an agent can bootstrap a new machine end-to-end without hand-holding.

## Quick Start

For the impatient, here's the local-clone path:

```bash
# 1. Clone the lib (one time per machine)
git clone https://github.com/jajupmochi/claude-config.git ~/.claude/claude-config

# 2. Open Claude Code in your new project root
cd /path/to/new-project
claude

# 3. Run the scaffold skill
/init-claude-config
```

The skill will ask:

| Question | Options |
|---|---|
| Project type | Python research / static personal site / frontend / custom |
| Bilingual policy | EN+zh / EN-only / zh-only / decide later |
| Final-output language | Chinese / English / decide later |
| Context tags (multi-select) | always, research-pkg, ui-project, static-site, ml-research, web-perf, image-or-video-work, docs-site, electron-or-desktop |
| Consumption mode | raw URL / local clone / plugin |
| Personal-preference rules | output-brevity / tool-proactivity / no-reread-files |

After answering, your project gets:

- `CLAUDE.md` with `@import` lines for the chosen rules
- `.claude/settings.json` with the matching format-on-edit hooks
- `.claude/skills/` populated with relevant general + project-type skills
- A starter scaffold (`pyproject.toml`, `index.html`, etc.) if you picked a template

For step-by-step walkthroughs of common scenarios, see **[USAGE.md](USAGE.md)**.

## Repository structure

```
claude-config/
├── README.md / README.zh.md          ← you are here
├── USAGE.md / USAGE.zh.md            ← step-by-step walkthroughs
├── INVENTORY.md / .zh.md             ← master index of catalogued items
├── CLAUDE.md                         ← rules for editing the lib itself
├── LICENSE                           ← MIT
├── docs/
│   ├── PHILOSOPHY.md / .zh.md        ← the "why" behind the rules
│   ├── CONSUMPTION.md / .zh.md       ← three downstream consumption modes
│   └── CONTRIBUTING.md               ← how to add new content
├── rules/                            ← workflow rules + index
│   └── <rule-name>/RULE.md + snippet.md
├── skills/                           ← general skills + index
│   └── general/<skill-name>/SKILL.md
├── hooks/                            ← 2 hook recipes + index
│   └── <hook-name>/{README.md, settings.snippet.json}
├── recommendations/                  ← recommendation lists + reference tables
│   ├── cc-plugins.md
│   ├── cc-marketplaces-and-skill-bundles.md
│   ├── cli-tools.md
│   ├── js-{ui-and-design, animation-and-3d, build-test-style, state-data}.md
│   ├── web-auditing.md
│   ├── image-video-pdf.md
│   ├── docs-tools.md
│   ├── {ml-research, orchestra-ml-skills}.md
│   └── reference/{apt-packages, vscode-extensions}.md
├── tooling/                          ← 3 toolchain preferences + index
│   ├── python-uv-ruff/
│   ├── node-nvm/
│   └── permissions-allowlist/
├── templates/                        ← 2 project starters + index
│   ├── research-package-py/
│   └── personal-cite-static/
├── setup/                            ← the /init-claude-config skill
│   └── init-claude-config/SKILL.md
├── .claude/
│   ├── skills/                       ← meta-skills for editing the lib
│   │   ├── new-rule/, new-skill/, new-hook/, publish/SKILL.md
│   └── (no settings.json — content-only repo)
└── .claude-plugin/
    └── plugin.json                   ← plugin manifest
```

## The 14 workflow rules

Each ships as `RULE.md` (full content, rationale, examples, exceptions) + `snippet.md` (drop-in for downstream `CLAUDE.md` via `@import`).

| Rule | Scope | When applies |
|---|---|---|
| [`pre-edit-confirmation`](rules/pre-edit-confirmation/RULE.md) | universal | List exact targets + 1-line plan + wait for explicit "go" before any Edit / Write |
| [`phased-planning`](rules/phased-planning/RULE.md) | universal | Tasks touching 3+ files / >5 tool calls / multi-step → numbered phases with per-phase pause |
| [`plugin-preflight`](rules/plugin-preflight/RULE.md) | universal | Verify plugin / skill / command is installed AND not deprecated before invoking |
| [`ui-iteration-loop`](rules/ui-iteration-loop/RULE.md) | ui-project | When user provides a visual reference: 8-iteration loop with chrome-devtools screenshots + 4-axis self-critique |
| [`output-brevity`](rules/output-brevity/RULE.md) | personal | No end-of-batch recap, don't echo tool output, prefer Edit over Write |
| [`tool-proactivity`](rules/tool-proactivity/RULE.md) | personal | Installed plugin / skill / MCP fires without asking when matched (with explicit-approval exceptions) |
| [`no-reread-files`](rules/no-reread-files/RULE.md) | personal | Trust your in-session memory of file contents; re-read only on actual change |
| [`chinese-output`](rules/chinese-output/RULE.md) | personal | Final user-facing output in Chinese; intermediate stays English |
| [`bilingual-docs`](rules/bilingual-docs/RULE.md) | optional | `NAME.md` + `NAME.zh.md` convention for human-facing docs (consumer opt-in) |
| [`end-of-turn-marker`](rules/end-of-turn-marker/RULE.md) | personal | Every turn ends with `[END:FINAL]` / `[END:WAIT]` / `[END:NEEDS_USER]` on its own line |
| [`always-on-verification`](rules/always-on-verification/RULE.md) | research-pkg | Before any code / test / results claim, invoke `code-verifier` + `research-critic` |
| [`autorun-mode`](rules/autorun-mode/RULE.md) | personal | "autorun" / "全力跑" / "think a lot" + scope → higher-autonomy cadence + multi-pass review + branch hygiene |
| [`multi-round-redesign`](rules/multi-round-redesign/RULE.md) | ui-project | N-round UI redesign protocol with date-stamped outputs + per-round lens discipline + final spec lock |
| [`latex-edit-policy`](rules/latex-edit-policy/RULE.md) | research-pkg | Editing `.tex`/`.sty`/`.cls`/`.bib`: hard fixes direct; soft (content) edits comment-don't-delete with `% [orig YYYY-MM-DD]` inline backup |

## The 7 reusable skills

| Skill | Bucket | Trigger | Purpose |
|---|---|---|---|
| [`verify-template`](skills/general/verify-template/SKILL.md) | general | `/verify` | Run CI gates locally (ruff + mypy + pytest); customize per project |
| [`preview-template`](skills/general/preview-template/SKILL.md) | general | `/preview` | Start local dev server (HTTP, Vite, Next.js, MkDocs, Storybook) |
| [`long-running-tasks`](skills/general/long-running-tasks/SKILL.md) | general | auto / `/long-running-tasks` | Decision tree: background subagent vs Monitor vs explicit timeout |
| [`verify-visual`](skills/general/verify-visual/SKILL.md) | general | auto on UI changes | chrome-devtools MCP screenshot + 4-axis self-critique against reference |
| [`privacy-redact`](skills/general/privacy-redact/SKILL.md) | general | `/privacy-redact <file>` | Scan file for usernames, absolute paths, tokens, codenames; redact with placeholders |
| [`code-verifier`](skills/general/code-verifier/SKILL.md) | general | auto / `/code-verifier` | Three-layer gate before any "tests pass" / "code works" / "results show X" claim — detects FAKE-RUN patterns |
| [`research-critic`](skills/general/research-critic/SKILL.md) | general | auto / `/research-critic` | Six-question audit on every research claim (falsifiability, design, fair comparison, leakage, proportional conclusion, alternatives) |

Plus: the **`/init-claude-config`** setup skill (Phase 8 entry point).

## The 2 hook recipes

Each ships as `README.md` (what / why / install / variants) + `settings.snippet.json` (drop-in JSON).

| Hook | Event | Matcher | Context | Purpose |
|---|---|---|---|---|
| [`ruff-format-on-edit`](hooks/ruff-format-on-edit/README.md) | `PostToolUse` | `Write\|Edit` | research-pkg / Python | Auto-format `*.py` with ruff after every Claude edit |
| [`jq-validate-json`](hooks/jq-validate-json/README.md) | `PostToolUse` | `Write\|Edit` | static-site / JSON-config | Block next tool call if Claude wrote invalid JSON to `*/locales/*.json` or `*/data/*.json` |

## Recommendations (15 curated lists)

Each list has agent-executable install commands, context tags, and "why use this" rationale.

| File | Context | Coverage |
|---|---|---|
| [cc-plugins.md](recommendations/cc-plugins.md) | always | 37 Claude Code plugins (workflow, integrations, specialized) |
| [cc-marketplaces-and-skill-bundles.md](recommendations/cc-marketplaces-and-skill-bundles.md) | always | 4 third-party marketplaces + 9 skill bundles via `npx skills add` (GSAP, shadcn, impeccable, Remotion, baoyu, etc.) |
| [cli-tools.md](recommendations/cli-tools.md) | always (selectively) | System CLIs (jq, gh, ripgrep, fd, …) + Python user CLIs (uv, ruff, mkdocs, hf, …) |
| [js-ui-and-design.md](recommendations/js-ui-and-design.md) | ui-project | Lucide, Radix full set, **Chakra UI**, lenis, d3, visx, recharts, monaco, tanstack/table, shadcn; icon explorers (**yesicon.app**, **svgl.app**) |
| [js-animation-and-3d.md](recommendations/js-animation-and-3d.md) | 3d-or-animation | motion, gsap, **anime.js**, lottie-react, tailwindcss-animate, **math-curve-loaders**; three, R3F, drei, mediapipe; animated icon catalogues (**itshover**, **useanimations**); HTML→video (**HyperFrames**, Remotion); React Native motion |
| [js-build-test-style.md](recommendations/js-build-test-style.md) | ui-project | vite, next, electron, vitest, playwright, storybook, tailwindcss, prettier |
| [js-state-data.md](recommendations/js-state-data.md) | ui-project | pinia, zustand, swr, vueuse, vue-i18n, vue-router, next-themes |
| [web-auditing.md](recommendations/web-auditing.md) | static-site / web-perf | chrome-devtools MCP (zero-install default), lighthouse CLI, lhci, pa11y, axe-core |
| [image-video-pdf.md](recommendations/image-video-pdf.md) | image-or-video-work | sharp, svgo, imagemin, ffmpeg (apt), puppeteer |
| [docs-tools.md](recommendations/docs-tools.md) | docs-site | mkdocs + material, ghp-import, latexmk (apt) |
| [ml-research.md](recommendations/ml-research.md) | ml-research | huggingface_hub[cli], datasets, gpustat, kaleido, selenium; **experiment tracking** (MLflow, Weights & Biases, ClearML) |
| [orchestra-ml-skills.md](recommendations/orchestra-ml-skills.md) | ml-research | 21-category ML skill stack incl. `0-autoresearch-skill` meta-orchestrator |
| [ai-coding-tools.md](recommendations/ai-coding-tools.md) | optional | Spec-driven scaffolding (**OpenSpec**) + paper review (**paperreview.ai**) |
| [cluster-hpc.md](recommendations/cluster-hpc.md) | optional | SLURM patterns, free-tier rules, rsync conventions for HPC clusters |
| [reference-projects.md](recommendations/reference-projects.md) | optional | Standalone demos / template projects to study (e.g. **`mykonos-island-voxels`** — zero-dependency Canvas 2D isometric builder with painterly assets, layered cache rendering, touch-first UI) |
| [reference/apt-packages.md](recommendations/reference/apt-packages.md) | always (lookup) | Apt packages reference table — never auto-install |
| [reference/vscode-extensions.md](recommendations/reference/vscode-extensions.md) | always (lookup) | VS Code extensions reference table — never auto-install |

## Project templates

Minimal-but-complete starters that the setup skill composes with the right rules / hooks / skills.

| Template | Type | Includes |
|---|---|---|
| [research-package-py/](templates/research-package-py/TEMPLATE_README.md) | Python research pkg | `CLAUDE.template.md` + `pyproject.template.toml` (research extras: torch / data / logging) + `.gitignore` + `.claude/settings.template.json` (ruff hook) + project `verify` skill |
| [personal-cite-static/](templates/personal-cite-static/TEMPLATE_README.md) | Static personal site (HTML/CSS/JS, i18n, bilingual) | `CLAUDE.template.md` + `index.template.html` (i18n-aware) + `locales/{en,zh}.template.json` + `.claude/settings.template.json` (jq hook) + project `preview` / `verify-visual` / `i18n-sync` skills |

## The setup skill `/init-claude-config`

[`setup/init-claude-config/SKILL.md`](setup/init-claude-config/SKILL.md) is the entry point. Reads project state, asks 6 questions, composes the right subset:

1. **Detect** — empty dir vs existing project; manifest files present?
2. **Ask** — project type, bilingual, final language, context tags, consumption mode, personal preferences
3. **Compose** — copy template, substitute placeholders, generate `CLAUDE.md` with filtered `@import` lines, set up `.claude/settings.json` + `.claude/settings.local.json`, install relevant skills
4. **Verify** — `jq empty` on JSON files, `pyproject.toml` parse check, `git status`
5. **Report** — show what was composed + next steps

Idempotent — safe to re-run when adding new context tags later.

## For maintainers

To extend `claude-config` itself, four meta-skills under `.claude/skills/`:

| Meta-skill | Purpose |
|---|---|
| [`/new-rule`](.claude/skills/new-rule/SKILL.md) | Scaffold a new workflow rule with frontmatter + RULE.md + snippet.md, update INVENTORY |
| [`/new-skill`](.claude/skills/new-skill/SKILL.md) | Scaffold a new skill with proper frontmatter, update INVENTORY |
| [`/new-hook`](.claude/skills/new-hook/SKILL.md) | Scaffold a new hook recipe (8-step construction flow: dedup → pipe-test → wrap → validate → live-proof → cleanup → handoff) |
| [`/publish`](.claude/skills/publish/SKILL.md) | Tag a new SemVer version + push + GitHub release with notes from git log |

Plus [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) — formal spec for adding rules / skills / hooks / recommendations / tooling / templates, including the inventory-stay-in-sync requirement.

## Publishing to external directories

The repo is also being published to community directories so people can discover it. Status of each channel is tracked in **[PUBLISHING.md](PUBLISHING.md)**:

| Channel | Status |
|---|---|
| GitHub Topics (`claude-code`, `claude-skills`, `claude-config`, `claude-plugin`, `scaffold`, `workflow-rules`, `ai-coding`, `developer-tools`) | ✅ done — repo is discoverable via GitHub topic pages |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) PR | 🟡 fork + branch ready — one-click PR creation: see [PUBLISHING.md §1](PUBLISHING.md#1-awesome-claude-code-pr--almost-auto-one-click-left-for-you) |
| Anthropic plugin marketplace ([clau.de/plugin-directory-submission](https://clau.de/plugin-directory-submission)) | ⚪ manual form — content prepared in [PUBLISHING.md §2](PUBLISHING.md#2-anthropic-plugin-marketplace-manual-form) |
| [claudemarketplaces.com](https://claudemarketplaces.com/) / [buildwithclaude.com](https://buildwithclaude.com/) | ⚪ likely auto-aggregated (~24h after topics set) |
| npm registry (`npx claude-config`) | ⚪ requires `npm login` + `npm publish` — see [PUBLISHING.md §4](PUBLISHING.md#4-npm-registry-manual-npm-login--npm-publish). Currently usable as `npx github:jajupmochi/claude-config` |

## Build history

`claude-config` was built in 11 phases on 2026-04-29 (single-day v0.1.0):

| Phase | Focus | Commit |
|---|---|---|
| P1 | Foundation (README, CLAUDE.md, docs, structure) | `1e94686` |
| P1.5 | Discovery scan: local tools inventory → draft `docs/DISCOVERY.md` (gitignored) | `f4cc5eb` |
| P2 | 9 workflow rules distilled from `~/.claude/CLAUDE.md` and personal-site `CLAUDE.local.md` | `314e292` |
| P3 | 2 reusable hooks (ruff format-on-edit, jq JSON validate) | `61e5261` |
| P4 | 5 general-purpose skills (verify, preview, long-running-tasks, verify-visual, privacy-redact) | `5ed2b45` |
| P5 | 12 active recommendation lists + 2 reference tables | `b328c84` |
| P6 | 3 tooling categories with agent-executable install steps (python-uv-ruff, node-nvm, permissions-allowlist) | `f8e2042` |
| P7 | 2 project templates (research-package-py, personal-cite-static) | `5722a88` |
| P8 | `/init-claude-config` setup skill | `b97b8b7` |
| P9 | LICENSE + 4 meta-skills + GitHub publish | `1673f37` + push |
| P10 | Plugin packaging (`.claude-plugin/plugin.json`) + final docs polish | (this commit) |

Total surface area: 9 rules + 5 + 4 meta skills + 2 hooks + 12 recommendation lists + 3 tooling templates + 2 project templates + 1 setup skill + bilingual docs + 1 plugin manifest.

## Contributing

PRs welcome. Open an issue first to align on scope and which category (rule / skill / hook / recommendation / tooling / template) the change belongs to.

See [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) for:

- Formal frontmatter conventions
- The "inventory must stay in sync" rule
- Bilingual policy for the lib's own docs
- Conventional Commits style

## License

MIT — see [LICENSE](LICENSE).

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

*(empty — to be populated in Phase 5)*

Anticipated entries:

- `recommendations/plugins.md` — 35+ Claude Code plugins (curated subset from `~/.claude/settings.json`) with one-line "why use this" per entry
- `recommendations/marketplaces.md` — superpowers, minimax-skills, garden-skills, ui-ux-pro-max-skill, …
- `recommendations/mcp-servers.md` — chrome-devtools, microsoft-docs, sourcegraph, …
- `recommendations/cli-tools.md` — uv, gh, ripgrep, fd, …
- `recommendations/ui-design-tools.md` — npm/npx-installed UI / animation / design tools (planned scope expansion)
- `recommendations/animation-tools.md` — GSAP, Framer Motion, Lottie tooling, …

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

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

**Current Phase:** P1 — foundation. No content modules populated yet. See [docs/PHILOSOPHY.md](docs/PHILOSOPHY.md) and the README's status table for the build plan.

## Rules

*(empty — to be populated in Phase 2)*

Anticipated entries (distilled from `~/.claude/CLAUDE.md`):

- `chinese-output` — final user-facing output in Chinese; intermediate stays English
- `pre-edit-confirmation` — list exact targets + 1-line plan + wait for explicit "go" before any Edit / Write
- `phased-planning` — break medium / large tasks (3+ files OR > ~5 tool calls OR multi-step) into numbered phases with deliverables
- `plugin-preflight` — verify plugin / skill / command is installed AND not deprecated before invoking
- `ui-iteration-loop` — autonomous 8-iteration UI redesign loop with chrome-devtools screenshots and 4-axis self-critique
- `output-brevity` — no end-of-batch recap, don't echo tool output, don't re-read the same file, prefer Edit over Write
- `tool-proactivity` — installed plugin / skill / MCP fires without asking when matched (with explicit-approval exceptions)
- `no-reread-files` — trust your in-session memory of file contents; re-read only on actual change
- `bilingual-docs` — `NAME.md` + `NAME.zh.md` convention (consumer-side opt-in via `setup/init-claude-config`)

## Skills

*(empty — to be populated in Phase 4 and later)*

Anticipated entries:

- `skills/general/verify-template/` — parametrized "run CI gates locally" skill (ruff + mypy + pytest)
- `skills/general/preview-template/` — local dev-server starter
- `skills/general/long-running-tasks/` — agent-timeout decision tree (background subagent vs Monitor vs explicit timeout)
- `skills/general/verify-visual/` — chrome-devtools MCP visual verification pattern

## Hooks

*(empty — to be populated in Phase 3)*

Anticipated entries:

- `hooks/ruff-format-on-edit/` — `PostToolUse:Write|Edit` hook formatting Python files. Standardizes `uv run` / `uv tool run` / `uvx` variants seen across user projects.
- `hooks/jq-validate-json/` — `PostToolUse:Write|Edit` hook validating JSON files (i18n parity, config integrity).

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

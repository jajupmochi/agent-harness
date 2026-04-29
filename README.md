# claude-config

> Linlin Jia's curated configuration for Claude Code: workflow rules, skills, hooks, plugin recommendations, and tooling preferences extracted from real research and web projects. Loadable into any new project so a fresh `/init` can pick the relevant subset.

> **Language:** English | [中文](README.zh.md)

## Master TOC

- [What this is](#what-this-is)
- [Repository structure](#repository-structure)
- [How to consume](#how-to-consume)
- [Status](#status)
- [Contributing](#contributing)
- [License](#license)

## What this is

Three years of accumulated Claude Code conventions — rules I want every new project to follow, hooks I trust, skills I reuse, plugins I rely on — pulled out of half a dozen research and web projects (`liulian-python`, `swiss-river-network-benchmark`, `AI_Mur4Cast`, `jajupmochi.github.io`, etc.) and turned into a single library.

The aims:

1. **One source of truth.** When I want a new project to "behave like the old ones," I point Claude here.
2. **Per-project picking.** A static-site project doesn't need ML-training rules. The `setup/init-claude-config` skill asks which categories apply.
3. **Human-readable.** Each rule, hook, and skill explains *why* it exists, not just *what* it does. Useful even without an AI agent.
4. **Agent-executable.** Tooling and install entries include copy-paste-able commands so an AI agent can bootstrap a new machine end-to-end without hand-holding.

## Repository structure

```
claude-config/
├── README.md / README.zh.md           Bilingual entry point
├── CLAUDE.md                          CC instructions for editing this lib itself
├── INVENTORY.md / .zh.md              Master index of catalogued items
├── docs/
│   ├── PHILOSOPHY.md / .zh.md         The "why" behind the rules
│   ├── CONSUMPTION.md / .zh.md        Three ways to use the lib
│   └── CONTRIBUTING.md                How to add new content
├── rules/                             Workflow rules (Chinese output, pre-edit confirmation, …)
│   └── <name>/RULE.md + snippet.md
├── skills/                            On-demand skills, mattpocock-style buckets
│   └── <bucket>/<name>/SKILL.md
├── hooks/                             Reusable hook recipes (ruff format-on-edit, …)
│   └── <name>/README.md + settings.snippet.json
├── recommendations/                   Curated plugin / MCP / CLI tool lists
├── tooling/                           Toolchain preferences (uv+ruff, nvm, allowlists, …)
├── templates/                         Full project starters
└── setup/                             The install / scaffold skill (init-claude-config)
```

Empty directories carry a `.gitkeep` until populated. Phase 1 ships only the foundation; later phases fill the content directories. See `INVENTORY.md` for current state.

## How to consume

Three options, design intentionally left open:

1. **Raw URL imports** — your project's `CLAUDE.md` adds `@https://raw.githubusercontent.com/jajupmochi/claude-config/main/rules/<rule>/snippet.md`. Always live, no clone.
2. **Local clone** — `git clone` into `~/.claude/claude-config/`, then global CLAUDE.md adds `@~/.claude/claude-config/...`. Faster, offline-friendly, manual `git pull` to update.
3. **Plugin install** — once Phase 10 ships `.claude-plugin/plugin.json`: `/plugin install jajupmochi/claude-config`. Most native; gives the setup skill as a slash command.

See [docs/CONSUMPTION.md](docs/CONSUMPTION.md) for the full comparison and gotchas.

## Status

Currently at **Phase 1 — foundation**. The 10-phase build plan:

| Phase | Focus | State |
|---|---|---|
| P1 | Foundation (README, CLAUDE.md, docs, structure) | done |
| P1.5 | Discovery scan: local tools inventory (zsh_history, npx cache, project deps, web research) → draft `docs/DISCOVERY.md` (gitignored) | done; awaiting Linlin's review |
| P2 | Workflow rules distilled from `~/.claude/CLAUDE.md` | done |
| P3 | Reusable hooks (ruff format, jq validate, …) | done |
| P4 | General-purpose skills (verify, preview, long-running-tasks, verify-visual, privacy-redact) | done |
| P5 | Recommendations (12 active files: CC plugins, marketplaces+skill-bundles, CLI tools, JS UI, JS animation+3D, JS build/test/style, JS state, web auditing, image/video/PDF, docs, ML/research, orchestra ML skills + 2 reference tables) — populated from reviewed `DISCOVERY.md` | done |
| P6 | Tooling preferences with **agent-executable install steps** (python-uv-ruff, node-nvm, permissions-allowlist) | done |
| P7 | Project templates (research-pkg-py, personal-cite-static) | done |
| P8 | `setup/init-claude-config` install skill (interactive scaffold from template + selected rules/hooks/tooling) | done |
| P9 | Repo meta (LICENSE, meta-skills, GitHub publish) | pending |
| P10 | Plugin packaging (optional) | pending |

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md). PRs welcome; please open an issue first to align on scope.

## License

MIT — `LICENSE` file lands in Phase 9.

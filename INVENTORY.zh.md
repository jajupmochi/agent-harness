# 内容总目（Inventory）

> 库中已收录条目的主索引。每次新增 / 删除 / 重命名都需更新。

> **语言：** [English](INVENTORY.md) | 中文

## Master TOC

- [当前状态](#当前状态)
- [Rules](#rules)
- [Skills](#skills)
- [Hooks](#hooks)
- [Recommendations](#recommendations)
- [Tooling](#tooling)
- [Templates](#templates)
- [Setup](#setup)

## 当前状态

**当前 Phase：** P1.5 Discovery 已完成（草稿 `docs/DISCOVERY.md` 已 gitignore，待林林 review）。P2 待开始。公开内容模块尚未填充。建设计划见 [docs/PHILOSOPHY.zh.md](docs/PHILOSOPHY.zh.md) 与 README 中的状态表。

## Rules

✅ 已在 P2 填充（2026-04-29）。9 条规则 + 索引 README。

| 规则 | Scope | 一句话 |
|---|---|---|
| [`chinese-output`](rules/chinese-output/RULE.md) | personal | 最终面向用户的输出用中文；中间过程保持英文 |
| [`pre-edit-confirmation`](rules/pre-edit-confirmation/RULE.md) | universal | 任何 Edit / Write 前列出精确目标 + 一句话计划，等用户 explicit "go" |
| [`phased-planning`](rules/phased-planning/RULE.md) | universal | 中大任务（3+ 文件 / > ~5 次工具调用 / 多步骤）分阶段编号，每阶段后暂停 |
| [`plugin-preflight`](rules/plugin-preflight/RULE.md) | universal | 调用插件 / skill / 命令前先验证已安装且未弃用 |
| [`ui-iteration-loop`](rules/ui-iteration-loop/RULE.md) | ui-project | 自动 8 轮 UI 迭代循环，配 chrome-devtools 截图与四轴自评 |
| [`output-brevity`](rules/output-brevity/RULE.md) | personal | 不在末尾复述、不回显工具输出、优先 Edit 而非 Write |
| [`tool-proactivity`](rules/tool-proactivity/RULE.md) | personal | 已安装的插件 / skill / MCP 匹配场景时主动调用（含若干"必须先确认"的例外） |
| [`no-reread-files`](rules/no-reread-files/RULE.md) | personal | 信任本 session 内对文件内容的记忆；除非真的变了不再重读 |
| [`bilingual-docs`](rules/bilingual-docs/RULE.md) | optional | `NAME.md` + `NAME.zh.md` 双语文档约定（消费方 opt-in via `setup/init-claude-config`） |

详见 [`rules/README.md`](rules/README.md)（用法说明 + scope 标签定义）。

## Skills

*（空——将在 Phase 4 及之后填充）*

预计条目：

- `skills/general/verify-template/` —— 参数化的"本地跑一遍 CI 门禁"技能（ruff + mypy + pytest）
- `skills/general/preview-template/` —— 本地 dev-server 启动器
- `skills/general/long-running-tasks/` —— Agent 超时决策树（后台 subagent vs Monitor vs 显式超时）
- `skills/general/verify-visual/` —— chrome-devtools MCP 视觉验证模式

## Hooks

✅ 已在 P3 填充（2026-04-29）。2 个钩子 + 索引 README。

| 钩子 | Event | Matcher | Context | 一句话 |
|---|---|---|---|---|
| [`ruff-format-on-edit`](hooks/ruff-format-on-edit/README.md) | `PostToolUse` | `Write\|Edit` | research-pkg / 任何 Python 项目 | Claude 编辑 `*.py` 后用 ruff 自动格式化 |
| [`jq-validate-json`](hooks/jq-validate-json/README.md) | `PostToolUse` | `Write\|Edit` | static-site / JSON 配置项目 | Claude 写入指定路径下无效 JSON 时拦截下次工具调用 |

详见 [`hooks/README.md`](hooks/README.md)（安装方式）。

## Recommendations

*（空——将在 Phase 5 填充）*

预计条目：

- `recommendations/plugins.md` —— 35+ Claude Code 插件（从 `~/.claude/settings.json` 精选）每条一行"为什么用"
- `recommendations/marketplaces.md` —— superpowers、minimax-skills、garden-skills、ui-ux-pro-max-skill 等
- `recommendations/mcp-servers.md` —— chrome-devtools、microsoft-docs、sourcegraph 等
- `recommendations/cli-tools.md` —— uv、gh、ripgrep、fd 等
- `recommendations/ui-design-tools.md` —— npm/npx 安装的 UI / 动画 / 设计工具（按你新加的需求扩展范围）
- `recommendations/animation-tools.md` —— GSAP、Framer Motion、Lottie 工具链等

## Tooling

*（空——将在 Phase 6 填充）*

预计条目：

- `tooling/python-uv-ruff/` —— `pyproject.template.toml` + `ruff.template.toml` + README 带 **agent 可直接执行的安装命令**
- `tooling/node-nvm/` —— Node 工具链 bootstrap，**agent 可直接执行的安装命令**
- `tooling/permissions-allowlist/` —— 来自真实项目 `settings.local.json` 的常见 `Bash(...)` 白名单

## Templates

*（空——将在 Phase 7 填充）*

预计条目：

- `templates/research-package-py/` —— 基于 `liulian-python` / `AI_Mur4Cast` 模式的完整脚手架
- `templates/personal-cite-static/` —— 基于 `jajupmochi.github.io`（HTML/CSS/JS、双语文档、i18n）

## Setup

*（空——将在 Phase 8 填充）*

预计条目：

- `setup/init-claude-config/SKILL.md` —— 安装 / scaffold 技能。询问用户：项目类型、双语策略、主语言、应用哪些 rules / hooks / skills / templates。然后从库里组合出项目的 `CLAUDE.md`、`.claude/settings.json` 和初始 `.claude/skills/`。

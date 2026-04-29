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

✅ 已在 P4 填充（2026-04-29）。general 桶 5 个技能 + 索引 README。

| 技能 | 桶 | 触发 | 用途 |
|---|---|---|---|
| [`verify-template`](skills/general/verify-template/SKILL.md) | general | `/verify` | 本地跑 CI 门禁；按项目定制内容 |
| [`preview-template`](skills/general/preview-template/SKILL.md) | general | `/preview` | 启动本地 dev server；按项目类型定制 |
| [`long-running-tasks`](skills/general/long-running-tasks/SKILL.md) | general | 自动 / `/long-running-tasks` | 决策树：后台 subagent vs Monitor vs 显式超时 |
| [`verify-visual`](skills/general/verify-visual/SKILL.md) | general | UI 改动时自动 | chrome-devtools MCP 截图 + 四轴对比参考 |
| [`privacy-redact`](skills/general/privacy-redact/SKILL.md) | general | `/privacy-redact <file>` | 扫描并 redact 用户名、绝对路径、密钥、代号 |

后续桶（将在 P7 模板里填充）：

- `research-pkg/` —— Python 研究包专用（`new-adapter`、`new-experiment` 等）
- `static-site/` —— 静态主页专用（`new-round`、`deploy-round`、`i18n-sync`）

详见 [`skills/README.md`](skills/README.md)。

## Hooks

✅ 已在 P3 填充（2026-04-29）。2 个钩子 + 索引 README。

| 钩子 | Event | Matcher | Context | 一句话 |
|---|---|---|---|---|
| [`ruff-format-on-edit`](hooks/ruff-format-on-edit/README.md) | `PostToolUse` | `Write\|Edit` | research-pkg / 任何 Python 项目 | Claude 编辑 `*.py` 后用 ruff 自动格式化 |
| [`jq-validate-json`](hooks/jq-validate-json/README.md) | `PostToolUse` | `Write\|Edit` | static-site / JSON 配置项目 | Claude 写入指定路径下无效 JSON 时拦截下次工具调用 |

详见 [`hooks/README.md`](hooks/README.md)（安装方式）。

## Recommendations

✅ 已在 P5 填充（2026-04-29）。12 个 active 文件 + 2 个 reference table + 索引 README。

| 文件 | Context | 覆盖 |
|---|---|---|
| [cc-plugins.md](recommendations/cc-plugins.md) | always | 37 个 Claude Code 插件（workflow / 集成 / specialized） |
| [cc-marketplaces-and-skill-bundles.md](recommendations/cc-marketplaces-and-skill-bundles.md) | always | 4 个第三方 marketplace + 9 个 `npx skills add` 装的 skill bundle |
| [cli-tools.md](recommendations/cli-tools.md) | always（按需） | 系统 CLI（jq、gh、ripgrep、fd 等）+ Python 用户级 CLI（uv、ruff、mkdocs、hf 等） |
| [js-ui-and-design.md](recommendations/js-ui-and-design.md) | ui-project | Lucide、Radix 全套、lenis、d3、visx、recharts、monaco、tanstack/table、shadcn |
| [js-animation-and-3d.md](recommendations/js-animation-and-3d.md) | ui-project + 3d-or-animation | motion、gsap、lottie-react、tailwindcss-animate；three、R3F、drei、mediapipe |
| [js-build-test-style.md](recommendations/js-build-test-style.md) | ui-project | vite、next、electron、vitest、playwright、storybook、tailwindcss、prettier |
| [js-state-data.md](recommendations/js-state-data.md) | ui-project | pinia、zustand、swr、vueuse、vue-i18n、vue-router、next-themes |
| [web-auditing.md](recommendations/web-auditing.md) | static-site / web-perf | chrome-devtools MCP（默认）、lighthouse CLI、lhci、pa11y、axe-core |
| [image-video-pdf.md](recommendations/image-video-pdf.md) | image-or-video-work | sharp、svgo、imagemin、ffmpeg（apt）、puppeteer |
| [docs-tools.md](recommendations/docs-tools.md) | docs-site | mkdocs + material、ghp-import、latexmk（apt） |
| [ml-research.md](recommendations/ml-research.md) | ml-research | huggingface_hub[cli]、datasets、gpustat、kaleido、selenium |
| [orchestra-ml-skills.md](recommendations/orchestra-ml-skills.md) | ml-research | 21 类 ML 技能栈，含 `0-autoresearch-skill` 元编排器 |
| [reference/apt-packages.md](recommendations/reference/apt-packages.md) | always（查询） | apt 包知识表——绝不自动安装 |
| [reference/vscode-extensions.md](recommendations/reference/vscode-extensions.md) | always（查询） | VS Code 扩展知识表——绝不自动安装；CC-friendly 默认值已标注 |

详见 [`recommendations/README.md`](recommendations/README.md)（context 标签 + `setup/init-claude-config` 如何按项目类型决定安装哪些）。

## Tooling

✅ 已在 P6 填充（2026-04-29）。3 个工具类目 + 索引 README。

| 目录 | Context | 给出什么 |
|---|---|---|
| [python-uv-ruff/](tooling/python-uv-ruff/README.md) | research-pkg | `uv` + `ruff` 安装步骤 + 标准 `pyproject.template.toml`（extras、ruff 配置、mypy、pytest） |
| [node-nvm/](tooling/node-nvm/README.md) | ui-project、electron-or-desktop | nvm 安装 + Node 22 LTS + 最小化全局包哲学 + scaffold 指引 |
| [permissions-allowlist/](tooling/permissions-allowlist/README.md) | always（按需） | `settings.local.snippet.json`：从真实项目里提炼的常见安全 Bash 白名单 |

详见 [`tooling/README.md`](tooling/README.md)。

## Templates

*（空——将在 Phase 7 填充）*

预计条目：

- `templates/research-package-py/` —— 基于 `liulian-python` / `AI_Mur4Cast` 模式的完整脚手架
- `templates/personal-cite-static/` —— 基于 `jajupmochi.github.io`（HTML/CSS/JS、双语文档、i18n）

## Setup

*（空——将在 Phase 8 填充）*

预计条目：

- `setup/init-claude-config/SKILL.md` —— 安装 / scaffold 技能。询问用户：项目类型、双语策略、主语言、应用哪些 rules / hooks / skills / templates。然后从库里组合出项目的 `CLAUDE.md`、`.claude/settings.json` 和初始 `.claude/skills/`。

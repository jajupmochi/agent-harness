# claude-config

> Linlin 为 Claude Code 整理的配置库：**工作流规则、技能（skills）、钩子（hooks）、插件推荐、工具偏好和项目模板**。每台机器装一次，然后在任何新项目里跑 `/init-claude-config`，按项目类型 scaffold 出对应子集。

> **语言：** [English](README.md) | 中文

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![GitHub](https://img.shields.io/badge/GitHub-jajupmochi%2Fclaude--config-181717?logo=github)](https://github.com/jajupmochi/claude-config) [![Privacy Scan](https://github.com/jajupmochi/claude-config/actions/workflows/privacy-scan.yml/badge.svg)](https://github.com/jajupmochi/claude-config/actions/workflows/privacy-scan.yml) [![Install Matrix](https://github.com/jajupmochi/claude-config/actions/workflows/install-verify.yml/badge.svg)](https://github.com/jajupmochi/claude-config/actions/workflows/install-verify.yml)

## Master TOC

- [TL;DR](#tldr)
- [这是什么](#这是什么)
- [快速上手](#快速上手)
- [仓库结构](#仓库结构)
- [13 条工作流规则](#13-条工作流规则)
- [7 个可复用技能](#7-个可复用技能)
- [2 个钩子配方](#2-个钩子配方)
- [推荐清单（15 类）](#推荐清单15-类)
- [项目模板](#项目模板)
- [安装技能 `/init-claude-config`](#安装技能-init-claude-config)
- [给维护者](#给维护者)
- [发布到外部目录](#发布到外部目录)
- [构建历程](#构建历程)
- [贡献](#贡献)
- [许可](#许可)

## TL;DR

最快的安装方式 —— **`npx`（不用 clone，不用重启 Claude Code）**：

```bash
npx github:jajupmochi/claude-config
```

然后在任何项目根目录打开 Claude Code 跑：

```
/init-claude-config
```

回答 6 个问题 → 项目按类型 scaffold 出相应规则 + 钩子 + 技能 + 工具链。

**6 种安装方式**（npx / 交互式 `/plugin` / 直接 `/plugin install` / 本地 clone / raw URL @imports / 复制粘贴提示词给 CC）—— 见 **[USAGE.zh.md §0](USAGE.zh.md#0-安装-claude-config每台机器一次)** 看所有路径。

## 这是什么

三年积累的 Claude Code 用法约定——给每个新项目都用的规则、值得信任的钩子、复用的技能、依赖的插件——从六七个真实研究/Web 项目（`liulian-python`、`swiss-river-network-benchmark`、`AI_Mur4Cast`、`jajupmochi.github.io` 加几个前端）里抽出来，做成一个组合式库。

**四个目标：**

1. **唯一权威。** 每个新项目从同一基线出发。CLAUDE.md 之间不再 copy-paste 漂移。
2. **按需选取。** 静态主页项目不需要 ML 训练规则。`/init-claude-config` 技能问哪些 context 标签适用（`research-pkg`、`ui-project`、`static-site`、`ml-research`、`web-perf` 等），只装匹配的子集。
3. **人类可读。** 每条规则、钩子、技能都解释*为什么*存在，而不只是*做什么*。即使没有 AI agent，看的人也能受益。
4. **Agent 可直接执行。** 每条工具/安装条目都附可复制粘贴的命令，agent 读完即可在新机器上从零启动，不用人工兜底。

## 快速上手

急用版（本地 clone 路径）：

```bash
# 1. clone 库（每台机器一次）
git clone https://github.com/jajupmochi/claude-config.git ~/.claude/claude-config

# 2. 在新项目根目录打开 Claude Code
cd /path/to/new-project
claude

# 3. 跑 scaffold 技能
/init-claude-config
```

技能问：

| 问题 | 选项 |
|---|---|
| 项目类型 | Python 研究 / 静态个人主页 / frontend / 自定义 |
| 双语策略 | EN+zh / 仅英文 / 仅中文 / 暂定 |
| 终端输出语言 | 中文 / 英文 / 暂定 |
| Context 标签（多选） | always、research-pkg、ui-project、static-site、ml-research、web-perf、image-or-video-work、docs-site、electron-or-desktop |
| 消费方式 | raw URL / 本地 clone / plugin |
| 个人偏好规则 | output-brevity / tool-proactivity / no-reread-files |

回答完后，项目得到：

- `CLAUDE.md` 含所选规则的 `@import` 行
- `.claude/settings.json` 含匹配的格式化-on-编辑钩子
- `.claude/skills/` 填了相关通用技能 + 项目类型专属技能
- 选了模板的话还有起步脚手架（`pyproject.toml`、`index.html` 等）

详细分步走查见 **[USAGE.zh.md](USAGE.zh.md)**。

## 仓库结构

```
claude-config/
├── README.md / README.zh.md          ← 你在这里
├── USAGE.md / USAGE.zh.md            ← 分步走查
├── INVENTORY.md / .zh.md             ← 已收录条目主索引
├── CLAUDE.md                         ← 编辑库本身的规则
├── LICENSE                           ← MIT
├── docs/
│   ├── PHILOSOPHY.md / .zh.md        ← 规则背后的"为什么"
│   ├── CONSUMPTION.md / .zh.md       ← 三种下游消费方式
│   └── CONTRIBUTING.md               ← 如何新增内容
├── rules/                            ← 9 条工作流规则 + 索引
│   └── <rule-name>/RULE.md + snippet.md
├── skills/                           ← 5 个通用技能 + 索引
│   └── general/<skill-name>/SKILL.md
├── hooks/                            ← 2 个钩子配方 + 索引
│   └── <hook-name>/{README.md, settings.snippet.json}
├── recommendations/                  ← 12 个 active 清单 + 2 个 reference 表
│   ├── cc-plugins.md
│   ├── cc-marketplaces-and-skill-bundles.md
│   ├── cli-tools.md
│   ├── js-{ui-and-design, animation-and-3d, build-test-style, state-data}.md
│   ├── web-auditing.md
│   ├── image-video-pdf.md
│   ├── docs-tools.md
│   ├── {ml-research, orchestra-ml-skills}.md
│   └── reference/{apt-packages, vscode-extensions}.md
├── tooling/                          ← 3 个工具链偏好 + 索引
│   ├── python-uv-ruff/
│   ├── node-nvm/
│   └── permissions-allowlist/
├── templates/                        ← 2 个项目脚手架 + 索引
│   ├── research-package-py/
│   └── personal-cite-static/
├── setup/                            ← /init-claude-config 技能
│   └── init-claude-config/SKILL.md
├── .claude/
│   └── skills/                       ← 编辑库本身用的元技能
│       └── new-rule/, new-skill/, new-hook/, publish/SKILL.md
└── .claude-plugin/
    └── plugin.json                   ← Plugin manifest
```

## 9 条工作流规则

每条规则有 `RULE.md`（完整内容、rationale、例子、例外）+ `snippet.md`（下游 `CLAUDE.md` 通过 `@import` 引入的紧凑版）。

| 规则 | Scope | 触发场景 |
|---|---|---|
| [`pre-edit-confirmation`](rules/pre-edit-confirmation/RULE.md) | universal | 任何 Edit / Write 前列出精确目标 + 一句话计划，等用户 explicit "go" |
| [`phased-planning`](rules/phased-planning/RULE.md) | universal | 任务涉及 3+ 文件 / >5 次工具调用 / 多步骤 → 编号阶段 + 阶段间暂停 |
| [`plugin-preflight`](rules/plugin-preflight/RULE.md) | universal | 调用插件 / skill / 命令前先验证已安装且未弃用 |
| [`ui-iteration-loop`](rules/ui-iteration-loop/RULE.md) | ui-project | 用户给视觉参考时：8 轮自动迭代循环 + chrome-devtools 截图 + 四轴自评 |
| [`output-brevity`](rules/output-brevity/RULE.md) | personal | 末尾不复述、不回显工具输出、优先 Edit 而非 Write |
| [`tool-proactivity`](rules/tool-proactivity/RULE.md) | personal | 已装的插件 / skill / MCP 匹配场景时主动调用（含若干"必须先确认"的例外） |
| [`no-reread-files`](rules/no-reread-files/RULE.md) | personal | 信任本 session 内对文件内容的记忆；除非真的变了不再重读 |
| [`chinese-output`](rules/chinese-output/RULE.md) | personal | 终端面向用户输出用中文；中间过程保持英文 |
| [`bilingual-docs`](rules/bilingual-docs/RULE.md) | optional | 面向人类的 doc 用 `NAME.md` + `NAME.zh.md` 双语约定（消费方 opt-in） |
| [`end-of-turn-marker`](rules/end-of-turn-marker/RULE.md) | personal | 每轮以 `[END:FINAL]` / `[END:WAIT]` / `[END:NEEDS_USER]` 单行结束 |
| [`always-on-verification`](rules/always-on-verification/RULE.md) | research-pkg | 任何 code / test / 结果声明前调用 `code-verifier` + `research-critic` |
| [`autorun-mode`](rules/autorun-mode/RULE.md) | personal | "autorun" / "全力跑" / "think a lot" + scope → 高自主 cadence + 多轮 review + 分支卫生 |
| [`multi-round-redesign`](rules/multi-round-redesign/RULE.md) | ui-project | N 轮 UI 重设计协议——日期戳子目录里 `00-plan.md` + `round-N.html`/`.png` + 最终 spec lock |

## 7 个可复用技能

| 技能 | 桶 | 触发 | 用途 |
|---|---|---|---|
| [`verify-template`](skills/general/verify-template/SKILL.md) | general | `/verify` | 本地跑 CI 门禁（ruff + mypy + pytest）；按项目定制 |
| [`preview-template`](skills/general/preview-template/SKILL.md) | general | `/preview` | 启动本地 dev server（HTTP、Vite、Next.js、MkDocs、Storybook） |
| [`long-running-tasks`](skills/general/long-running-tasks/SKILL.md) | general | 自动 / `/long-running-tasks` | 决策树：后台 subagent vs Monitor vs 显式超时 |
| [`verify-visual`](skills/general/verify-visual/SKILL.md) | general | UI 改动时自动 | chrome-devtools MCP 截图 + 四轴自评对比参考 |
| [`privacy-redact`](skills/general/privacy-redact/SKILL.md) | general | `/privacy-redact <file>` | 扫描文件中的用户名、绝对路径、token、代号；用占位符 redact |
| [`code-verifier`](skills/general/code-verifier/SKILL.md) | general | 自动 / `/code-verifier` | "tests pass" / "code works" / "结果是 X" 前的三层门禁——检测 FAKE-RUN 模式 |
| [`research-critic`](skills/general/research-critic/SKILL.md) | general | 自动 / `/research-critic` | 六问审计：可证伪 · 设计与假设匹配 · 公平比较 · 泄漏 · 结论与证据匹配 · 替代解释排除 |

外加：**`/init-claude-config`** 安装技能（Phase 8 入口）。

## 2 个钩子配方

每个钩子有 `README.md`（什么 / 为什么 / 安装 / 变体）+ `settings.snippet.json`（drop-in JSON）。

| 钩子 | Event | Matcher | Context | 用途 |
|---|---|---|---|---|
| [`ruff-format-on-edit`](hooks/ruff-format-on-edit/README.md) | `PostToolUse` | `Write\|Edit` | research-pkg / Python | Claude 编辑后用 ruff 自动格式化 `*.py` |
| [`jq-validate-json`](hooks/jq-validate-json/README.md) | `PostToolUse` | `Write\|Edit` | static-site / JSON 配置 | Claude 写入 `*/locales/*.json` 或 `*/data/*.json` 无效 JSON 时拦截下次工具调用 |

## 推荐清单（15 类）

每条都有 agent 可执行的安装命令、context 标签、"为什么用"理由。

| 文件 | Context | 覆盖 |
|---|---|---|
| [cc-plugins.md](recommendations/cc-plugins.md) | always | 37 个 Claude Code 插件（workflow、集成、specialized） |
| [cc-marketplaces-and-skill-bundles.md](recommendations/cc-marketplaces-and-skill-bundles.md) | always | 4 个第三方 marketplace + 9 个 `npx skills add` skill bundle（GSAP、shadcn、impeccable、Remotion、baoyu 等） |
| [cli-tools.md](recommendations/cli-tools.md) | always（按需） | 系统 CLI（jq、gh、ripgrep、fd 等）+ Python 用户级 CLI（uv、ruff、mkdocs、hf 等） |
| [js-ui-and-design.md](recommendations/js-ui-and-design.md) | ui-project | Lucide、Radix UI 全套、**Chakra UI**、lenis、d3、visx、recharts、monaco、tanstack/table、shadcn；图标浏览器（**yesicon.app**、**svgl.app**） |
| [js-animation-and-3d.md](recommendations/js-animation-and-3d.md) | 3d-or-animation | motion、gsap、**anime.js**、lottie-react、tailwindcss-animate、**math-curve-loaders**；three、R3F、drei、mediapipe；动效图标库（**itshover**、**useanimations**）；HTML→视频（**HyperFrames**、Remotion）；React Native motion |
| [js-build-test-style.md](recommendations/js-build-test-style.md) | ui-project | vite、next、electron、vitest、playwright、storybook、tailwindcss、prettier |
| [js-state-data.md](recommendations/js-state-data.md) | ui-project | pinia、zustand、swr、vueuse、vue-i18n、vue-router、next-themes |
| [web-auditing.md](recommendations/web-auditing.md) | static-site / web-perf | chrome-devtools MCP（默认零安装）、lighthouse CLI、lhci、pa11y、axe-core |
| [image-video-pdf.md](recommendations/image-video-pdf.md) | image-or-video-work | sharp、svgo、imagemin、ffmpeg（apt）、puppeteer |
| [docs-tools.md](recommendations/docs-tools.md) | docs-site | mkdocs + material、ghp-import、latexmk（apt） |
| [ml-research.md](recommendations/ml-research.md) | ml-research | huggingface_hub[cli]、datasets、gpustat、kaleido、selenium；**实验跟踪平台**（MLflow、Weights & Biases、ClearML） |
| [orchestra-ml-skills.md](recommendations/orchestra-ml-skills.md) | ml-research | 21 类 ML 技能栈，含 `0-autoresearch-skill` 元编排器 |
| [ai-coding-tools.md](recommendations/ai-coding-tools.md) | optional | Spec-driven 脚手架（**OpenSpec**）+ 论文 review（**paperreview.ai**） |
| [cluster-hpc.md](recommendations/cluster-hpc.md) | optional | SLURM 模式、free-tier 规则、HPC 集群 rsync 约定 |
| [reference-projects.md](recommendations/reference-projects.md) | optional | 值得学习的 standalone demo / template 项目（如 **`mykonos-island-voxels`** —— 零依赖 Canvas 2D 等距岛屿生成器，painterly 资产、分层缓存渲染、触屏 UI） |
| [reference/apt-packages.md](recommendations/reference/apt-packages.md) | always（查询） | apt 包参考表——绝不自动安装 |
| [reference/vscode-extensions.md](recommendations/reference/vscode-extensions.md) | always（查询） | VS Code 扩展参考表——绝不自动安装 |

## 项目模板

最小但完整的脚手架，安装技能将其与所选 rules / hooks / skills 组合。

| 模板 | 类型 | 包含 |
|---|---|---|
| [research-package-py/](templates/research-package-py/TEMPLATE_README.md) | Python 研究包 | `CLAUDE.template.md` + `pyproject.template.toml`（research extras：torch / data / logging）+ `.gitignore` + `.claude/settings.template.json`（ruff 钩子）+ 项目 `verify` 技能 |
| [personal-cite-static/](templates/personal-cite-static/TEMPLATE_README.md) | 静态个人主页（HTML/CSS/JS、i18n、双语） | `CLAUDE.template.md` + `index.template.html`（i18n 支持）+ `locales/{en,zh}.template.json` + `.claude/settings.template.json`（jq 钩子）+ 项目 `preview` / `verify-visual` / `i18n-sync` 技能 |

## 安装技能 `/init-claude-config`

[`setup/init-claude-config/SKILL.md`](setup/init-claude-config/SKILL.md) 是入口。读项目状态、问 6 个问题、组合相应子集：

1. **检测**——空目录 vs 现有项目；有无 manifest 文件
2. **询问**——项目类型、双语、终端语言、context 标签、消费方式、个人偏好
3. **组合**——复制模板、替换占位符、生成 `CLAUDE.md`（按 context 过滤的 `@import` 行）、设置 `.claude/settings.json` + `settings.local.json`、安装相关 skills
4. **验证**——`jq empty` 校验 JSON、`pyproject.toml` 解析、`git status`
5. **报告**——展示组合结果 + 后续步骤

幂等——添加新 context 标签时可重跑。

## 给维护者

扩展 `claude-config` 本身用 `.claude/skills/` 下的四个元技能：

| 元技能 | 用途 |
|---|---|
| [`/new-rule`](.claude/skills/new-rule/SKILL.md) | scaffold 新规则（frontmatter + RULE.md + snippet.md），同 batch 更新 INVENTORY |
| [`/new-skill`](.claude/skills/new-skill/SKILL.md) | scaffold 新技能（正确的 frontmatter），更新 INVENTORY |
| [`/new-hook`](.claude/skills/new-hook/SKILL.md) | scaffold 新钩子配方（8 步构造流程：dedup → 管道测试 → JSON 包装 → 校验 → 实战验证 → 清理 → 交付） |
| [`/publish`](.claude/skills/publish/SKILL.md) | 打 SemVer tag + push + GitHub release（notes 从 git log 生成） |

加上 [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md)——新增 rules / skills / hooks / recommendations / tooling / templates 的正式规范，含 inventory-同步要求。

## 发布到外部目录

仓库同时正在发布到社区目录方便发现。各渠道状态记录在 **[PUBLISHING.md](PUBLISHING.md)**：

| 渠道 | 状态 |
|---|---|
| GitHub Topics（`claude-code`、`claude-skills`、`claude-config`、`claude-plugin`、`scaffold`、`workflow-rules`、`ai-coding`、`developer-tools`） | ✅ 已设置——可通过 GitHub topic 页面发现 |
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) PR | 🟡 Fork + 分支已推——一键开 PR：见 [PUBLISHING.md §1](PUBLISHING.md#1-awesome-claude-code-pr--almost-auto-one-click-left-for-you) |
| Anthropic 官方 plugin marketplace（[clau.de/plugin-directory-submission](https://clau.de/plugin-directory-submission)） | ⚪ 需手动填表——表单内容已准备好，见 [PUBLISHING.md §2](PUBLISHING.md#2-anthropic-plugin-marketplace-manual-form) |
| [claudemarketplaces.com](https://claudemarketplaces.com/) / [buildwithclaude.com](https://buildwithclaude.com/) | ⚪ 大概率自动聚合（topics 设好后 ~24h） |
| npm registry（`npx claude-config`） | ⚪ 需 `npm login` + `npm publish`——见 [PUBLISHING.md §4](PUBLISHING.md#4-npm-registry-manual-npm-login--npm-publish)。当前可用 `npx github:jajupmochi/claude-config` |

## 构建历程

`claude-config` 在 2026-04-29 单日里分 11 个阶段构建（v0.1.0）：

| Phase | 聚焦 | Commit |
|---|---|---|
| P1 | 基础骨架（README、CLAUDE.md、docs、结构） | `1e94686` |
| P1.5 | Discovery 扫描：本机工具盘点 → 草稿 `docs/DISCOVERY.md`（gitignore） | `f4cc5eb` |
| P2 | 9 条工作流规则（从 `~/.claude/CLAUDE.md` 和 personal-site `CLAUDE.local.md` 蒸馏） | `314e292` |
| P3 | 2 个可复用钩子（ruff format-on-edit、jq JSON 校验） | `61e5261` |
| P4 | 5 个通用技能（verify、preview、long-running-tasks、verify-visual、privacy-redact） | `5ed2b45` |
| P5 | 12 个 active 推荐清单 + 2 个 reference 表 | `b328c84` |
| P6 | 3 个工具链类目带 agent 可执行安装步骤（python-uv-ruff、node-nvm、permissions-allowlist） | `f8e2042` |
| P7 | 2 个项目模板（research-package-py、personal-cite-static） | `5722a88` |
| P8 | `/init-claude-config` 安装技能 | `b97b8b7` |
| P9 | LICENSE + 4 个元技能 + GitHub publish | `1673f37` + push |
| P10 | Plugin packaging（`.claude-plugin/plugin.json`）+ 文档收尾 | `71b11a9` |

总规模：9 规则 + 5 + 4 元技能 + 2 钩子 + 12 推荐清单 + 3 工具偏好 + 2 项目模板 + 1 安装技能 + 双语文档 + 1 plugin manifest。

## 贡献

欢迎 PR。请先开 issue 对齐范围 + 内容类目（rule / skill / hook / recommendation / tooling / template）。

[`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) 含：

- 正式 frontmatter 约定
- "inventory 必须同步"规则
- 库自身文档的双语策略
- Conventional Commits 风格

## 许可

MIT —— 见 [LICENSE](LICENSE)。

# claude-config

> 贾林林为 Claude Code 整理的配置库：从真实的研究项目和 Web 项目（`liulian-python`、`swiss-river-network-benchmark`、`AI_Mur4Cast`、`jajupmochi.github.io` 等）中提取出的工作流规则、技能（skills）、钩子（hooks）、插件推荐和工具偏好，可被任何新项目按需载入，让一次 `/init` 自动配好相关子集。

> **语言：** [English](README.md) | 中文

## Master TOC

- [这是什么](#这是什么)
- [仓库结构](#仓库结构)
- [如何使用](#如何使用)
- [当前状态](#当前状态)
- [贡献](#贡献)
- [许可](#许可)

## 这是什么

三年积累的 Claude Code 用法约定——我希望每个新项目都遵守的规则、信任的钩子、复用的技能、依赖的插件——从六七个研究/Web 项目里抽出来，做成一个库。

目标：

1. **唯一权威。** 想让新项目"像老项目那样运转"时，让 Claude 指向这里即可。
2. **按需选取。** 静态主页项目不需要 ML 训练规则。安装技能 `setup/init-claude-config` 会询问适用类目。
3. **人类可读。** 每条规则、钩子、技能都解释*为什么*存在，而不只是*做什么*。即使没有 AI agent，看的人（我自己或合作者）也能受益。
4. **Agent 可直接执行。** 工具与安装条目包含可复制粘贴的命令，AI agent 读完即可在新机器上从零起步，不用人工兜底。

## 仓库结构

```
claude-config/
├── README.md / README.zh.md           双语入口
├── CLAUDE.md                          编辑本仓库时的 CC 规则
├── INVENTORY.md / .zh.md              已收录条目的总目
├── docs/
│   ├── PHILOSOPHY.md / .zh.md         规则背后的"为什么"
│   ├── CONSUMPTION.md / .zh.md        三种消费方式
│   └── CONTRIBUTING.md                如何新增内容
├── rules/                             工作流规则（中文输出、预编辑确认……）
│   └── <name>/RULE.md + snippet.md
├── skills/                            按需技能，mattpocock 桶式组织
│   └── <bucket>/<name>/SKILL.md
├── hooks/                             可复用钩子配方（ruff 格式化、JSON 校验……）
│   └── <name>/README.md + settings.snippet.json
├── recommendations/                   精选 Plugin / MCP / CLI 工具清单
├── tooling/                           工具链偏好（uv+ruff、nvm、权限白名单……）
├── templates/                         完整项目脚手架
└── setup/                             安装/scaffold 技能（init-claude-config）
```

空目录用 `.gitkeep` 占位，待后续 Phase 填充。Phase 1 仅交付骨架；详见 `INVENTORY.md`。

## 如何使用

设计上留出三种方式：

1. **Raw URL 引用** —— 项目的 `CLAUDE.md` 加 `@https://raw.githubusercontent.com/jajupmochi/claude-config/main/rules/<rule>/snippet.md`。永远是最新的，不用 clone。
2. **本地 clone** —— `git clone` 到 `~/.claude/claude-config/`，然后全局 CLAUDE.md 加 `@~/.claude/claude-config/...`。更快、离线可用、手动 `git pull` 更新。
3. **作为 Plugin 安装** —— Phase 10 交付 `.claude-plugin/plugin.json` 后，`/plugin install jajupmochi/claude-config`。最原生；安装技能直接挂为斜杠命令。

详见 [docs/CONSUMPTION.zh.md](docs/CONSUMPTION.zh.md)。

## 当前状态

当前处于 **Phase 1（基础骨架）**。10 阶段计划：

| Phase | 聚焦 | 状态 |
|---|---|---|
| P1 | 基础骨架（README、CLAUDE.md、docs、结构） | 已完成 |
| P1.5 | Discovery 扫描：本机工具盘点（zsh_history、npx 缓存、项目依赖、Web 研究）→ 生成草稿 `docs/DISCOVERY.md`（已 gitignore） | 已完成；待林林 review |
| P2 | 从 `~/.claude/CLAUDE.md` 蒸馏出的工作流规则 | 已完成 |
| P3 | 可复用钩子（ruff 格式化、jq 校验……） | 已完成 |
| P4 | 通用技能（verify、preview、long-running-tasks、verify-visual、privacy-redact） | 已完成 |
| P5 | 精选推荐（12 个 active：CC 插件 / marketplace+skill bundle / CLI / JS UI / JS 动画+3D / JS build·test·style / JS state / web 审计 / 图像视频 PDF / docs / ML 研究 / orchestra ML 技能栈 + 2 个 reference table）—— 由审阅后的 `DISCOVERY.md` 填充 | 已完成 |
| P6 | 工具偏好 + **可被 Agent 直接执行的安装步骤** | 待开始 |
| P7 | 项目模板（research-pkg-py、personal-cite-static） | 待开始 |
| P8 | `setup/init-claude-config` 安装技能 | 待开始 |
| P9 | 仓库元配置（LICENSE、元技能、GitHub 发布） | 待开始 |
| P10 | 包装为 Plugin（可选） | 待开始 |

## 贡献

见 [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)。欢迎 PR，请先开 issue 对齐范围。

## 许可

MIT —— `LICENSE` 文件在 Phase 9 加入。

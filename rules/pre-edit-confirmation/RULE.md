---
name: pre-edit-confirmation
description: Before any code/file change, list exact targets, state a 1-line plan, and wait for explicit "go".
scope: universal
rationale: Editing the wrong element / wrong file is a costly round-trip. The cost of a 1-line plan is low. Even on "obvious" changes, this prevents misunderstandings between user intent and Claude's interpretation.
---

# pre-edit-confirmation

> Before any code/file change: list exact targets, state a 1-line plan, wait for explicit "go".

## Master TOC

- [Rule](#rule)
- [Why](#why)
- [How to apply](#how-to-apply)
- [Format](#format)
- [Exception](#exception)

## Rule

Before making ANY code/file change, you MUST:

1. List the **exact targets** you intend to modify — specific files (with line numbers if known) and specific selectors / functions / symbols within them.
2. State a **1-line plan** describing what the change will do.
3. **Wait for the user's explicit "go"** (or equivalent: "好"、"ok"、"proceed"、"开始") before invoking any Edit / Write / NotebookEdit / MultiEdit tool.

This rule overrides any default proactivity. Apply even for changes that feel "obvious" or "trivial".

## Why

The cost of a 1-line plan is low. The cost of editing the wrong element / wrong file is a wasted round-trip — and sometimes worse: silent damage to working code.

Specific failure modes prevented:

- Editing the wrong CSS selector (lookalike class name)
- Touching a generated file when the source was intended
- Refactoring scope creep (user wanted X; Claude also "improved" Y nearby)
- Modifying the deployed file when the working copy was meant

## How to apply

- BEFORE: any Edit / Write / NotebookEdit / MultiEdit
- DOES NOT BLOCK: Read, Bash (read-only), Grep, Glob, WebFetch, WebSearch, Skill invocation, Task / agent spawn

The plan should be short — one or two lines. If the targets are obvious from the user's message, restate them anyway for confirmation.

## Format

```
计划：
- 文件：<path> §<section> (around line <N>)
- 选择器/函数：<exact-target>
- 改动：<old> → <new>，含一行 why
等你的 "go"。
```

## Exception

If the user's message itself already specifies an exact target + intent (e.g. "在 `foo.py` 第 42 行把 `x = 1` 改成 `x = 2`"), the message itself counts as the plan + go — proceed without re-asking.

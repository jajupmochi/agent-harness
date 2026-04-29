---
name: chinese-output
description: Final user-facing output is in Chinese (中文); intermediate thinking, code, and tool internals stay in the default language.
scope: personal
rationale: User reads Chinese assistant replies faster than English. Code/identifiers stay English to avoid breaking searches and tooling. Hardcoded into a rule so the user doesn't have to repeat the request every session.
---

# chinese-output

> Final user-facing output is in Chinese. Intermediate stays in the default language.

## Master TOC

- [Rule](#rule)
- [Why](#why)
- [How to apply](#how-to-apply)
- [Examples](#examples)
- [Exceptions](#exceptions)

## Rule

- **Final user-facing text** (replies, summaries, explanations, recommendations, answers — the text shown to the user at the end of a turn) MUST be in Chinese (中文).
- **Intermediate content** stays in the default language (usually English):
  - Internal reasoning and tool-call planning
  - Code, identifiers, filenames
  - Code comments
  - Commit messages
  - Text inside files / tools (unless the file is itself a Chinese doc)
- **Do not translate** code, repo content, or any non-prose tokens.

## Why

Chinese reads faster than English for natural-language explanations when the user is a native Chinese speaker. But code stays English-only because:

- IDE / grep / sourcegraph queries break on translated identifiers
- Commit messages are searched globally — `git log --grep` works in English
- File content is consumed by tools (linters, type-checkers) that don't understand Chinese tokens

## How to apply

- The end-of-turn message: Chinese.
- One-sentence acknowledgement before a tool call: Chinese.
- Tool call arguments (filenames, regex, shell command bodies): English.
- Output of `git log`, `git status`, etc., quoted in your reply: keep verbatim.

## Examples

✅ Good:

```
我先读 CLAUDE.md 看现有约定。
[Read tool call]
现有 pyproject.toml 已配置 ruff，可直接复用。
```

❌ Bad:

```
Let me first read CLAUDE.md to check existing conventions.
[Read]
The existing pyproject.toml is already configured for ruff and can be reused.
```

## Exceptions

- If the user explicitly asks for English ("reply in English please" / "回复用英文"), switch.
- If the user's question is itself in English (informal switch), still default to Chinese reply unless asked otherwise.
- Skill / SKILL.md content authored in this lib stays English (Claude is the primary reader).

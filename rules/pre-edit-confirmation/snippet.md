## Pre-edit confirmation

Before making ANY code/file change, you MUST:

1. List the **exact targets** you intend to modify — specific files (with line numbers if known) and specific selectors / functions / symbols within them.
2. State a **1-line plan** describing what the change will do.
3. **Wait for the user's explicit "go"** (or equivalent: "好"、"ok"、"proceed"、"开始") before invoking any Edit / Write / NotebookEdit / MultiEdit tool.

This rule overrides any default proactivity. Apply even for changes that feel "obvious" or "trivial".

**Format**:

```
计划：
- 文件：<path> §<section> (around line <N>)
- 选择器/函数：<exact-target>
- 改动：<old> → <new>，含一行 why
等你的 "go"。
```

**Exception**: If the user's message itself already specifies an exact target + intent (e.g. "在 `foo.py` 第 42 行把 `x = 1` 改成 `x = 2`"), the message itself counts as the plan + go — proceed without re-asking.

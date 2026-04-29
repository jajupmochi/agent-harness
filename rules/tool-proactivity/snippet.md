## Tool proactivity

- **Invoke installed skills, plugins, subagents, and MCP tools proactively** when they match the task. Don't wait for the user to type the slash command. Briefly announce which tool you're using and why (one sentence) before firing, so the user can veto.
- **"I don't remember my tools" is not a valid reason to skip them.** Before picking an approach, check the current skill / plugin / agent list. If something better than raw tool calls exists, prefer it.
- This rule still respects `plugin-preflight` for first-time-this-session invocations.

**Always-ask exceptions** (override the proactivity default):

1. **Destructive git / file ops** (`git reset --hard`, `rm -rf`, force-push, branch deletion) — explicit approval only.
2. **SEO audit skills/plugins** — produce long reports that bloat context. Always ask "要不要跑一次 SEO audit？" first.
3. **Long-running expensive ops** (full-repo scan, multi-page WebFetch sequence, large model invocation) — flag estimated cost first.

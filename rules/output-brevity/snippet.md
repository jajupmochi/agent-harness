## Output brevity & context frugality

Rules that take priority over default verbosity:

- **Don't echo tool output back.** `git status`, `jq .`, `rg` output already lands in the user's terminal — don't re-summarize "the file now has X lines" when they can see the diff.
- **No end-of-batch recap paragraphs.** Two sentences max: "done with batch N" + next step. Not a bullet list (`git diff --stat` shows that).
- **No "plan rewrite" after every sub-step.** If you got OK on a plan, don't reprint after every Edit. Just execute.
- **Prefer Edit over Write** (only-diff write) for existing files — avoids shipping the whole file through context.
- **Inline clarifying questions get one-sentence answers** in Chinese, not numbered Q1/Q2/Q3 menus. Only build a menu when decision branches are genuinely complex or irreversible.

When context gets heavy, tell the user "context is heavy, consider `/compact`" rather than silently letting auto-compaction fire.

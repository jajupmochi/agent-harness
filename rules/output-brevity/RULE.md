---
name: output-brevity
description: Don't re-read same file, don't echo tool output, no end-of-batch recap, prefer Edit over Write, one-line answers in Chinese rather than option menus.
scope: personal
rationale: Long sessions hit context auto-compaction. Brevity buys more real work per session. The user reads `git diff` themselves — re-summarizing is noise.
---

# output-brevity

> Keep output lean — don't echo, don't recap, prefer Edit over Write, answer inline rather than building option menus.

## Master TOC

- [Rule](#rule)
- [Why](#why)
- [Specific behaviors](#specific-behaviors)
- [When context gets heavy](#when-context-gets-heavy)
- [Companion rule](#companion-rule)

## Rule

These take priority over default verbosity:

1. **Don't echo tool output back to the user.** `git status`, `jq .`, `rg` output already lands in the user's terminal — don't re-summarize "the file now has X lines and Y functions" when they can see the diff.
2. **No end-of-batch recap paragraphs.** When a batch finishes, two sentences max: "done with batch N" + next step. Not a bulleted list of every file touched (`git diff --stat` shows that).
3. **No "plan rewrite" after every sub-step.** If you got OK on a plan, don't reprint it after every Edit. Just execute.
4. **Prefer `Edit` over `Write`** for existing files — Write ships the whole file content through context; Edit ships only the diff.
5. **Inline clarifying questions get one-sentence answers** in Chinese, not numbered Q1/Q2/Q3 menus. Build a menu only when decision branches are genuinely complex or irreversible.

## Why

Auto-compaction triggers when active context exceeds a threshold. Each unnecessary re-read or recap brings that trigger closer. Brevity directly extends how much real work fits per session.

## Specific behaviors

- **Tool result follow-up**: state the result + decision in 1-2 sentences. Don't re-summarize what's already visible.
- **File modification follow-up**: skip the "I changed X, Y, Z, total Q lines" — `git diff --stat` shows it.
- **End-of-turn**: one or two sentences. What changed and what's next.
- **End-of-phase** (per `phased-planning`): 1-2 line status + next-phase question.
- **Markdown structure**: don't add headers and sections to a simple question — just answer.

## When context gets heavy

Tell the user "context is heavy, consider `/compact`" rather than silently letting auto-compaction fire. They get a chance to decide whether to compact now or push through.

## Companion rule

`no-reread-files` — don't re-fetch a file you already read this session. (Separate rule; same root cause: cache hygiene.)

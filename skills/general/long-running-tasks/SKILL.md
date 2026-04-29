---
name: long-running-tasks
description: Decision tree for handling long-running operations in Claude Code — when to use background subagents, Monitor tool, explicit timeouts, or refactor the task. Auto-fires when a task duration estimate exceeds typical bounds.
---

# /long-running-tasks

Choose the right mechanism when a task will take more than a few minutes.

## Decision tree

```
Task duration estimate?
├─ < 30 seconds → run synchronous (default)
├─ 30s – 2 min  → run synchronous, watch for timeout
├─ 2 – 10 min   → Bash with `run_in_background: true`, then Monitor for completion
├─ 10 min – 1h  → background subagent (`Task` with `run_in_background: true`); main agent continues with other work
└─ > 1 hour     → consider refactoring; or use a CronCreate for scheduled recurrence; consider whether the model session itself will reach context limits before completion
```

## Tool reference

### `Bash` with `run_in_background: true`

For shell commands > 2 min:

```python
Bash(command="<long-running-cmd>", run_in_background=True, timeout=600000)
```

Returns control immediately. Use `Monitor` (or `BashOutput`) to check status.

### `Monitor` tool

Watches a background process for events. **Costs no tokens while waiting** (event-driven, not polled):

```python
Monitor(...)
```

Wakes the agent only when an event of interest occurs. Use for "wait for build to finish" / "watch a log file for an error pattern".

### Background subagent (`Task` with `run_in_background: true`)

For tasks needing reasoning + tool use, not just shell:

```python
Task(
  description="<one-line>",
  subagent_type="general-purpose",
  prompt="<self-contained prompt — the agent has no context from this conversation>",
  run_in_background=True,
)
```

Subagent runs independently. You receive a notification on completion. Async subagents can continue running even after the main agent finishes its turn (very recent feature; verify availability per CC version).

### Explicit timeout in subagent prompts

For any subagent that might hang (e.g., one that runs tests), add to the prompt:

> If this hasn't completed in 10 minutes, interrupt and report the current status.

Without an explicit timeout instruction, a hung process leaves the agent waiting indefinitely (GitHub issue #4744 in `anthropics/claude-code`).

## Anti-patterns

- ❌ Looping `sleep 60; check_status; sleep 60; ...` — burns context cache. Use `Monitor` instead.
- ❌ Foreground bash with `timeout: 600000` (10 min) — blocks the entire session. Use background.
- ❌ Sequential 4 × 5min tasks — try to parallelize via 4 background subagents.
- ❌ Polling a long-running task with `BashOutput` every 30s — `Monitor` does the same thing without burning tokens.

## When the task is fundamentally too long

If a task realistically takes > 1 hour:

- **Split it** — break into checkpointable sub-tasks that can survive a session restart
- **Use a cron** — schedule via `CronCreate` for periodic execution
- **Document the manual step** — tell the user "this needs to run for X hours; here's the command, run it yourself and let me know when done"

## Companion

Pair with `output-brevity` rule (no polling-loop output) and `tool-proactivity` rule (announce before firing a long-running task so the user can interrupt).

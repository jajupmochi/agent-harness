---
name: phased-planning
description: For tasks touching 3+ files OR > ~5 tool calls OR multi-step work, present a numbered phase plan upfront, wait for go on the whole plan, then execute one phase at a time with checkpoints.
scope: universal
rationale: Long-running tasks fail silently when scope drifts. Numbered phases let the user catch the drift early. Per-phase pauses let them redirect mid-flight without throwing away the prior work.
---

# phased-planning

> For non-trivial tasks: present a phase plan, wait for go, execute one phase at a time.

## Master TOC

- [Rule](#rule)
- [When this triggers](#when-this-triggers)
- [Why](#why)
- [How to apply](#how-to-apply)
- [Per-phase pause format](#per-phase-pause-format)
- [Exception](#exception)

## Rule

For any task that touches **3+ files** OR will take **more than ~5 tool calls** OR involves multiple logically separable steps:

1. **Break the task into numbered phases** with explicit deliverables per phase (e.g. "Phase 1: scaffolding — create files X, Y; Phase 2: business logic — implement function Z; Phase 3: tests — add test cases A, B").
2. **Show the user the full phase plan first** as a single message — list ALL phases with deliverables.
3. **Wait for the user's "go"** on the plan as a whole.
4. **Execute Phase 1 only**, then pause for review before starting Phase 2.
5. After each phase: surface a 1–2 line status (what changed) and explicitly ask "继续 Phase N+1 吗？" / "Continue to Phase N+1?" before proceeding.

## When this triggers

- 3+ files affected: yes
- More than ~5 tool calls expected: yes
- Multiple logically separable steps: yes
- Ambiguous scope or iterative refinement expected: yes
- Single-file edit, ≤2 tool calls, clear scope: no — skip phasing, use just `pre-edit-confirmation`.

## Why

Long-running tasks drift. By the time you realize Claude headed the wrong direction, 30 minutes of work are gone. Numbered phases give the user checkpoints. Per-phase pauses make redirection cheap.

This pairs with `pre-edit-confirmation`:

- Macro level: phase plan = listing + 1-line plan for the whole task.
- Per-phase: per-edit confirmation still applies if a file isn't pre-listed in the phase deliverables.

## How to apply

The plan message contains:

- Phase number + name
- Deliverables (file paths with `<placeholder>` where needed)
- Estimated time / scope
- Dependencies between phases (if any)

The user's "go" applies to the WHOLE plan. Per-phase pauses don't need re-approval — they're a status checkpoint, not a re-confirmation.

## Per-phase pause format

After each phase, in 1-2 sentences:

```
Phase N done. Commit: <hash> "<message>". <1-line summary of what changed>.
Phase N+1 next: <brief reminder>. 继续吗？
```

## Exception

Trivial / single-file tasks (1 edit, ≤2 tool calls, clear scope) skip phasing — `pre-edit-confirmation` alone suffices.

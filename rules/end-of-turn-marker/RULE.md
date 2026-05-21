---
name: end-of-turn-marker
description: Every user-facing turn ends with exactly one of three markers on its own line — [END:FINAL], [END:WAIT], or [END:NEEDS_USER] — telling the user (and downstream automation) what kind of pause this is.
scope: personal
rationale: Without a marker, the user can't tell from text alone whether to expect background events, whether to provide input, or whether the task is fully done. Markers let chat-UI hooks / notifications behave correctly and make session logs scannable.
---

# end-of-turn-marker

> Every user-facing turn ends with exactly one marker on its own line.

## Master TOC

- [Rule](#rule)
- [The three markers](#the-three-markers)
- [Format](#format)
- [Examples](#examples)
- [Why](#why)
- [Companion](#companion)

## Rule

Every turn's final user-facing line MUST end with exactly one of:

- **`[END:FINAL]`** — Task / session fully complete. No further autonomous work pending. Waiting for a new user instruction.
- **`[END:WAIT]`** — Turn ends but background work continues (cluster jobs, monitors, `run_in_background` tasks, subagents). User is auto-notified when the background event fires. Specify what's being awaited in one short clause before the marker.
- **`[END:NEEDS_USER]`** — Turn ends because input / decision / authorisation is required from the user before you can proceed. Specify the question before the marker.

The marker is on its own line. Exactly one marker per turn.

## The three markers

| Marker | When to use |
|---|---|
| `[END:FINAL]` | Task fully done; no follow-up needed; waiting for next user instruction |
| `[END:WAIT]` | Background process running (cluster job, `run_in_background` bash, async subagent, monitor) — user is notified on event |
| `[END:NEEDS_USER]` | Hard blocker — credentials missing, ambiguous intent, irreversible action awaiting approval |

## Format

End-of-turn message + blank line + marker on its own line.

## Examples

✅ Good:

```
4-fold ensemble committed. Paper draft updated.

[END:FINAL]
```

```
Cluster SFT job 3690151 running, ETA ~12h. Monitor armed.

[END:WAIT]
```

```
Migration to v3 schema would drop column `x`. Confirm OK to proceed?

[END:NEEDS_USER]
```

❌ Bad — missing marker (user doesn't know if task is done or if more is coming):

```
Done. Commit pushed.
```

❌ Bad — multiple markers:

```
Done.
[END:FINAL]
[END:WAIT]
```

## Why

- **For chat UIs**: hooks can react differently to `[END:WAIT]` (don't notify yet) vs `[END:NEEDS_USER]` (raise alert) vs `[END:FINAL]` (mark thread done).
- **For session logs**: the marker is a single-line anchor for "what kind of pause is this".
- **For the user reading the message**: clear expectation of what happens next.

## Companion

- Pairs with `autorun-mode` rule — inside autorun, `[END:NEEDS_USER]` is reserved for true blockers only.
- Pairs with `tool-proactivity` — when firing a background tool, the next pause is `[END:WAIT]`, not `[END:FINAL]`.

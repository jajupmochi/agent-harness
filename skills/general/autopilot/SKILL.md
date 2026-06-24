---
name: autopilot
description: Set up or manage the autopilot daily autonomous project-driver — a system-level timer that, once a day, runs a fresh ≥30-min autorun Claude session to advance a project (features, bug fixes, refactors, design, docs) as an industrial-grade deployable product, passing review-gate, re-planning, estimating time formally, and self-healing when stuck. Use when the user wants to "set up autopilot", "auto-drive project X daily", schedule autonomous daily work, or configure/inspect the autopilot tool. Full design: docs/autopilot/README.md; the run prompt: docs/autopilot/PROMPT.md.
version: 0.1.0
license: MIT
tags: [autopilot, autonomous, daily-driver, autorun, scheduling, project-management]
---

# autopilot — intake & setup

You configure and install the **autopilot** daily autonomous project-driver. Design + every sub-tool
spec: `docs/autopilot/README.md`. The per-run prompt (what the timer feeds a fresh `claude -p` autorun
session): `docs/autopilot/PROMPT.md`. Scripts: `tooling/autopilot/`.

## Intake flow (do this in order)

1. **Ask** the user for:
   - **Long-term work / requirements** — what should autopilot drive (the `[ROLE & SCOPE]` block of `PROMPT.md`)?
   - **Daily auto-run time** (e.g. `03:00`).
   - **Minimum duration per run** (default **30 min**, no upper cap).
   - Project path (repo root) and model (default the session model).
2. **Summarize the inputs back and ask for explicit confirmation** — restate everything you captured
   so there is no misreading. Wait for a clear "yes" before installing.
3. **Offer optimization suggestions** — based on the project + the design doc, propose improvements
   (e.g. better run time to avoid peak hours, scoping the first MVP, enabling the STRICT review layer,
   watchdog interval) and ask whether to accept each.
4. **On confirm, install:**
   - Write config: `~/.claude/autopilot/<proj>/config.yaml` (role/scope, time, floor, model, repo).
   - Seed the plan root under the project's `docs/<plan-root>/` (per the neobanker structure) if absent.
   - Install timers: `bash tooling/autopilot/install.sh <proj>` → systemd `--user` units
     `autopilot-daily` (run time), `autopilot-watch` (every 10 min), `autopilot-summary`.
   - Confirm with `systemctl --user list-timers 'autopilot-*'`.

## What it then does (autonomously, no human input)

Each day the timer runs `tooling/autopilot/run.sh <proj>`, which loops a **fresh** `claude -p`
**autorun** session seeded with `PROMPT.md` until the **≥30-min floor** (`floor.py`, agent-independent)
is met and the current unit is committed + review-gate-passed. It then re-plans, updates formal time
estimates, writes a per-run doc, and emits an in-session markdown-table summary (with the 7-day concat
rule). The **watchdog** (`watch.py`) detects stuck/crashed/paused sessions and self-heals (Ralph-loop),
recording problems→fixes to the playbook.

## Manage
- Pause: `systemctl --user disable --now autopilot-daily.timer`
- Status: `systemctl --user list-timers 'autopilot-*'` · run-state under `~/.claude/autopilot/<proj>/`
- Run once now (test): `bash tooling/autopilot/run.sh <proj>`

## Guarantees it relies on
review-gate (mandatory on every code turn) · code discipline (minimal module/change/impact, modular,
tests + commits + docs, git per increment) · claude-config skills + Chrome/visual tools as needed ·
system-level crash-proofing (systemd Persistent + watchdog).

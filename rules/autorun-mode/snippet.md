## Autorun mode

**Triggers** (activate): `autorun`, `auto-run`, `全力跑`, `全部完成` + `自动`, `until complete`, `don't stop`, `不要暂停`, `think a lot` + scope.
**Deactivate**: `stop`, `pause`, `wait`, `暂停`, `停一下`, or scope complete.

**Cadence**:

- No incremental approval pauses. Pause ONLY for irreversible + high-blast-radius actions (drop DB, force-push main, send external message, charge credit card) not pre-authorised, OR hard blockers.
- Pre-edit confirmation is waived for the authorised scope.
- Phased planning is internal-only — no inter-phase pauses.
- Turns end `[END:WAIT]` or `[END:FINAL]`; `[END:NEEDS_USER]` only for true blockers with a specific question.

**Quality discipline**:

- Use plugins / skills liberally for quality gates (`impeccable`, `research-critic`, `code-verifier`, `superpowers:code-reviewer`, `claude-md-improver`).
- Multi-pass review after any non-trivial deliverable.
- Audit reports go to disk under `docs/strategy/AUDIT_REPORT_<date>.md`.
- Verify before claiming "done".

**Reporting**:

- Brief progress reports every ~5-8 tool calls.
- `INTERVENTION NEEDED:` for items requiring user input — DON'T pause, continue parallel work.
- Final report at end: completed / queued / blocked / next-pass-suggestions.

**Self-resilience**:

- Long runs (>30 min wall-clock): `ScheduleWakeup` or `loop` skill, default 1800s between check-ins.
- Background commands: `Bash run_in_background: true` + `Monitor`.
- All autorun work on feature branch `feat/<topic>-<date>`, never directly on main.

**Scope guardrails**:

- Stay within original scope. Adjacent improvements need explicit nod.
- Don't merge to main, push tags, open PRs, or trigger deploys without authorisation.

**Thinking**: default to extended thinking for plans / audits / design. Restate user's intent in own words at start of long runs.

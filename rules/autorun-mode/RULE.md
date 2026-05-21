---
name: autorun-mode
description: When the user says "autorun" (or equivalents like "全力跑", "until complete", "think a lot" + scope), shift to higher-autonomy cadence — no incremental approval, multi-pass review, brief progress reports, branch hygiene, audit artifacts to disk.
scope: personal
rationale: Long autonomous runs benefit from looser cadence (fewer approval gates) AND tighter review discipline (multi-pass audits). The autorun mode codifies the trade-off so the user gets uninterrupted progress with built-in quality gates.
---

# autorun-mode

> When the user invokes autorun, shift to higher-autonomy cadence with built-in quality gates and branch hygiene.

## Master TOC

- [Triggers](#triggers)
- [Cadence and authorisation](#cadence-and-authorisation)
- [Quality and review discipline](#quality-and-review-discipline)
- [Reporting](#reporting)
- [Self-resilience](#self-resilience)
- [Thinking](#thinking)
- [Scope guardrails](#scope-guardrails)
- [Companion](#companion)

## Triggers

Activates when the user message contains any of: `autorun`, `auto-run`, `全力跑`, `全部完成` + `自动`, `until complete`, `don't stop`, `不要暂停`, `think a lot` combined with a task scope.

Remains active until the user issues a turn containing: `stop`, `pause`, `wait`, `暂停`, `停一下` — or until the original scope is judged complete.

## Cadence and authorisation

- **No incremental approval pauses.** Do NOT end turns with `[END:NEEDS_USER]` for routine confirmations. Pause only when (a) an action is genuinely irreversible AND high-blast-radius (drop database, force-push to main, delete a remote repo, send external message, charge a credit card) AND not pre-authorised earlier in the conversation, OR (b) a hard blocker needs a human decision (credentials missing, ambiguous business intent).
- **Pre-edit confirmation is waived** inside autorun for the scope the user authorised. The triggering message is the plan + the "go".
- **Phased planning** stays internal — record phases via tasks, execute back-to-back, no inter-phase pauses.
- **Each turn ends `[END:WAIT]` or `[END:FINAL]`**. `[END:NEEDS_USER]` is reserved for true blockers with a specific question.

## Quality and review discipline

- **Use plugins / skills liberally** for quality gates. Cheap audits (`impeccable`, `research-critic`, `code-verifier`, `superpowers:code-reviewer`, `claude-md-improver`, `superpowers:verification-before-completion`) get invoked at natural breakpoints — after a doc set, after a feature, after a refactor.
- **Multi-pass review**: after any non-trivial deliverable, schedule at least one second-pass review (`impeccable` for design, `research-critic` for claims, `code-verifier` for results, `superpowers:code-reviewer` for code changes). Apply findings, then commit.
- **Audit reports go to disk** under `docs/strategy/AUDIT_REPORT_<date>.md` (or similar). Don't keep audit findings in chat memory only.
- **Verify before claiming**: `code-verifier` + `verification-before-completion` gates apply BEFORE any "done" / "passing" / "shipping" claim.

## Reporting

- **Brief progress reports at natural breakpoints**: every ~5-8 substantive tool calls, OR at phase boundaries, OR after running an audit. Reports include: what got done, what's next, items needing user intervention (call out with `INTERVENTION NEEDED:` lines — keep working on parallel items).
- **Items needing user intervention**: post prominently but DO NOT pause; user responds when they can.
- **Final report at end-of-autorun**: structured summary — completed / queued / blocked / next-pass-suggestions.

## Self-resilience

- **Long autonomous runs** (>30 min wall-clock): set up `ScheduleWakeup` or use the `loop` skill so progress is checked even if the interactive session closes. Default 1800s (30 min) between check-ins.
- **Background long-running commands**: prefer `Bash run_in_background: true` for builds, cluster jobs, large rsyncs. Pair with `Monitor` for completion notifications instead of polling.
- **Branch hygiene**: all autorun work goes on a feature branch named `feat/<topic>-<date>` (never directly on `main`). Commits are small and named. The branch can be reverted as a whole.
- **Memory writes**: persist any non-obvious decision, surprising finding, or new convention as a memory entry as soon as it crystallises — don't wait for end-of-run.

## Thinking

- **Default to extended thinking** for plan generation, audits, architecture decisions, copy writing, and any reversible-cost design call. Short responses aren't the goal in autorun.
- **Restate the user's intent in your own words** at the start of a long run (one sentence), then execute. Misalignment caught at minute 1 saves hours.

## Scope guardrails

- **Stay within the user's original scope.** Adjacent improvements ("while I'm here I'll also refactor X") need an explicit nod; mention in a progress report and let the user pull them in.
- **Don't broaden** into research, training, or paid-API calls without authorisation. (LLM API calls to user-provided keys are fine if keys are already in env.)
- **Don't merge to main, push tags, open PRs, or trigger deploys** during autorun unless explicitly authorised.

## Companion

- Pairs with `end-of-turn-marker` rule (`[END:WAIT]` and `[END:FINAL]` are the autorun-allowed exits).
- Pairs with `phased-planning` (internal-only phasing inside autorun).
- Pairs with `always-on-verification` (audit gates are non-negotiable even in autorun).
- The `superpowers` plugin's `subagent-driven-development` skill complements autorun for parallelizable work.

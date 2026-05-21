## Multi-round redesign protocol

For substantial UI / dashboard / page redesigns (triggers: `重新设计 X`, `redesign X`, `再迭代 N 轮`, `完整迭代`, `彻底重做`):

**Outputs** (under `docs/strategy/redesign-YYYY-MM-DD/`):

- `00-plan.md` — N-round plan, lenses per round, module inventory, validation gates, references.
- `00-research.md` — web + doc research synthesis when needed; cite sources.
- `round-N.html` + `round-N.png` + `round-N-notes.md` per round (full design each round, not partial).
- Final spec lock at `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`.
- `DELIVERY.md` one-page summary.

**Round count**: default 3 rounds; 4-5 if lens contrast is large or user requests.

**Per-round lens** (one per round, no mixing): editorial-Swiss · high-end visual · industrial-brutalist density · synthesis · production-lock.

**Validation gates per round**:

- Re-invoke `impeccable` + `minimalist-ui` compliance tables.
- Render PNG via playwright at 1440×980.
- **Hard-fail**: gradient text · glassmorphism · hero-metric-template · side-stripe-as-accent · emoji · em-dash in user copy · generic SaaS clichés.

**Implementation phase**: conclude with real code, not HTML mocks. Smoke-test at 1440×980, 0 console errors / 0 warnings.

**Bug-from-screenshot**: take a fresh viewport-only screenshot (`fullPage: false`); inspect DOM via playwright if needed; only fix if reproducible in viewport.

Inside autorun, this protocol auto-applies on redesign requests without explicit re-confirmation when round count is specified.

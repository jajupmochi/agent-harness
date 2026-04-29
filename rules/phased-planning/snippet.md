## Phased planning for medium / big tasks

For any task that touches **3+ files** OR > ~5 tool calls OR multiple logically-separable steps:

1. **Break into numbered phases** with explicit deliverables per phase.
2. **Show the user the full phase plan first** as a single message — list ALL phases with deliverables.
3. **Wait for the user's "go"** on the plan as a whole.
4. **Execute Phase 1 only**, then pause for review before starting Phase 2.
5. After each phase: surface a 1-2 line status (what changed) and explicitly ask "继续 Phase N+1 吗？" / "Continue to Phase N+1?" before proceeding.

This pairs with the pre-edit confirmation rule: the phase plan satisfies "list targets + 1-line plan" at the macro level; per-phase Edit calls still respect per-edit confirmation when targets weren't pre-listed in the phase deliverables.

**Trivial / single-file tasks** (1 edit, ≤2 tool calls) skip phasing — pre-edit confirmation alone suffices.

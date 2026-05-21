---
name: always-on-verification
description: For any task involving code execution, test claims, scripts producing numbers, or research-result claims, two always-on skills (code-verifier + research-critic) are mandatory gates before any "done" / "tests pass" / "results show X" / "method A beats B" claim.
scope: research-pkg
rationale: ML / research code is full of plausible-looking but unverifiable claims — tests that assert True, scripts that hardcode results, comparisons that aren't fair. Two cheap text-only audit skills catch most failure modes before they enter a paper draft, a commit message, or a results doc.
---

# always-on-verification

> For any code / test / results claim, run `code-verifier` and/or `research-critic` BEFORE the claim.

## Master TOC

- [Rule](#rule)
- [The two gates](#the-two-gates)
- [Workflow integration](#workflow-integration)
- [Why](#why)
- [Companion](#companion)

## Rule

For ANY task involving:

- code execution
- test claims ("tests pass", "build works")
- scripts producing numbers ("training converges", "mAP = 0.85")
- research-result claims ("method A beats B", "we observe X", "transfer ratio is Z%")

The following two skills are **always-on gates**. Invoke (via the `Skill` tool) BEFORE making the claim:

| Skill | Audits | Catches |
|---|---|---|
| `code-verifier` | Whether the RUN itself is genuine | hardcoded results, `assert True`, mocks-only tests, swallowed exceptions, fabricated numbers, dead-code short-circuits |
| `research-critic` | Whether the INFERENCE chain is sound | confirmation bias, p-hacking, leakage, weak baselines, ungrounded claims, ad-hoc thresholds, survivorship bias |

Both are TEXT-only audits (no code re-execution). Cheap to invoke. Use generously, not sparingly.

## The two gates

### `code-verifier` — artifact authenticity

Invoke BEFORE any "tests pass" / "build works" / "training converges" / "code runs" claim.

Three layers:

1. **Did it really run?** (Layer 1 — defer to `superpowers:verification-before-completion` if available; run the exact command in-turn)
2. **Is the run genuine?** (Layer 2 — scan for FAKE-RUN patterns: tests-that-pass-without-testing, scripts-that-fabricate-results, pipelines-that-short-circuit, ML-specific traps like training-loop-without-backward)
3. **Does the run exercise the claim?** (Layer 3 — artifact scope vs claim scope)

See `skills/general/code-verifier/SKILL.md` (in this lib) for the full skill content.

### `research-critic` — inferential soundness

Invoke AT EVERY RESEARCH STEP (hypothesis design, experiment setup, result interpretation, conclusion writing) and BEFORE any "method A beats B" / "results show X" / "we observe Y" claim.

Six-question audit:

1. Is the hypothesis falsifiable?
2. Does the experiment design test the hypothesis?
3. Is the comparison fair?
4. Could the result be explained by leakage / artifact?
5. Is the conclusion proportional to the evidence?
6. Does the result survive plausible alternative explanations?

See `skills/general/research-critic/SKILL.md` (in this lib) for the full skill content.

## Workflow integration

| About to claim... | Invoke... |
|---|---|
| "tests pass" / "build works" | `code-verifier` |
| "training converges" / "loss decreased" | `code-verifier` |
| "results show X" / "we observe Y" | `code-verifier` AND `research-critic` |
| "method A beats B" / "transfer ratio is Z%" | `research-critic` |
| Closing an experiment ticket / commit / PR | both |
| Writing a paper claim / RESULTS.md line | `research-critic` |

## Why

ML / research code has high incidence of "fake-genuine" results — code that produces a number, but the number isn't supported by the code. Examples:

- A test that asserts `True` always passes — proves nothing.
- A script that prints `mAP = 0.85` from a hardcoded literal — proves nothing.
- A comparison "Method A: 60%, Method B: 65%" where A used 4 folds and B used 1 fold — not a fair comparison.

The two audits catch most of these before they enter a paper draft or get committed.

## Companion

- `code-verifier` and `research-critic` are skills, not rules. See `skills/general/{code-verifier,research-critic}/SKILL.md` in this lib.
- Pairs with `phased-planning` (don't claim "phase done" without running these audits at the phase boundary).
- The `superpowers:verification-before-completion` skill (Anthropic-managed) is a complementary layer focusing on real-run discipline — `code-verifier` audits whether THAT run is genuine.

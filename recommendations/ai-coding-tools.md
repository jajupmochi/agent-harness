# AI Coding Tools

> Tools that complement the AI-coding loop — spec-driven scaffolding, paper review, agent-friendly tooling. **Context:** `optional` — install when the workflow calls for them.

## Master TOC

- [Spec-driven scaffolding](#spec-driven-scaffolding)
- [Paper / research review](#paper--research-review)
- [Companion](#companion)

## Spec-driven scaffolding

### OpenSpec — spec-first workflow for AI agents

[OpenSpec](https://github.com/Fission-AI/OpenSpec) is a spec-driven workflow tool so humans and AI agents agree on the spec **before** code is generated.

- **Why use it**: prevents the "agent generates 500 lines, then we discover the wrong feature" failure mode. Spec lock first; code second.
- **License**: MIT
- **Install**:

  ```bash
  npm install -g @fission-ai/openspec
  openspec init
  ```

- **Workflow**: write a spec (or have the agent draft one) → review + refine spec → agent generates code aligned to spec → review against the spec, not against vibes.
- **Pairs with**: any agent platform (Claude Code, Cursor, etc.) — the spec is plain markdown.

## Paper / research review

### paperreview.ai — Andrew Ng's paper review service

[paperreview.ai](https://paperreview.ai/tech-overview) is a service that scores paper drafts against a structured rubric (clarity, evidence quality, claim defensibility, etc.).

- **Why use it**: soft second-opinion reviewer for your paper drafts before submission. Catches structural issues a human reviewer would flag.
- **How to use**: paste a draft section → get scored against the rubric.
- **Caveat**: treat its rubric as a **soft second-opinion**, not an authority. Use alongside `research-critic` (in this lib) and a human collaborator.

**Pairs with**:

- `research-critic` skill (in this lib) — runs the six-question soundness audit on your claims before submission.
- `code-verifier` skill (in this lib) — audits whether the numbers in your draft are produced by genuine runs.
- `ml-paper-writing` skill (in the `orchestra-ml-skills` collection) — drafts/refines paper sections.

## Companion

- `recommendations/orchestra-ml-skills.md` (in this lib) — the broader research skill stack (ml-paper-writing, brainstorming-research-ideas, creative-thinking-for-research, presenting-conference-talks, systems-paper-writing).
- `rules/always-on-verification/RULE.md` — when to invoke `code-verifier` + `research-critic` BEFORE making any claim that ends up in a paper.

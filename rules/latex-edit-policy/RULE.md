---
name: latex-edit-policy
description: When editing LaTeX source (.tex/.sty/.cls/.bib), distinguish hard fixes (direct delete/replace) from soft edits (content changes) — for soft edits, comment out the original instead of deleting it, place the new version adjacent, tag with % [orig YYYY-MM-DD].
scope: research-pkg
rationale: LaTeX papers go through many wording iterations; silently overwriting a sentence loses the prior phrasing that the author may want to restore, compare, or partially revert. Keeping the original as an inline commented backup makes every soft edit reversible without git archaeology — important during fast multi-round paper revision.
---

# latex-edit-policy

> When editing LaTeX source: direct-fix for hard (mechanical) fixes; comment-don't-delete for soft (content) edits.

## Master TOC

- [Rule](#rule)
- [Hard fixes vs soft edits](#hard-fixes-vs-soft-edits)
- [How to comment-out a soft edit](#how-to-comment-out-a-soft-edit)
- [Why](#why)
- [When this triggers](#when-this-triggers)
- [Cleanup](#cleanup)
- [Companion](#companion)

## Rule

When modifying ANY LaTeX source (`.tex`, `.sty`, `.cls`, `.bib`, etc.), distinguish two kinds of change:

- **Hard fixes** — apply by direct replacement / deletion, **no backup needed**: compile errors, syntax errors, typos, punctuation, whitespace, malformed or duplicated commands, broken refs / labels / citations.
- **Soft edits** — any change to *content* (rewording a word / phrase / sentence / paragraph, restructuring, shortening, replacing wording, or removing a sentence / paragraph): **do NOT delete the original. Comment it out** (`%` line comments, or a commented block) and place the new version immediately adjacent (normally right below).

The commented original is an inline backup for future restoration, comparison, or partial revert.

## Hard fixes vs soft edits

| Change | Kind | Action |
|---|---|---|
| Fix `\citep{foo}` → `\citep{bar}` (broken citation key) | hard | direct replace |
| Remove a duplicated `\end{figure}` | hard | direct delete |
| Fix typo "teh" → "the" | hard | direct replace |
| Normalize whitespace / indentation | hard | direct |
| Reword "We show that X" → "We demonstrate X" | **soft** | comment original, add new adjacent |
| Shorten a 3-sentence paragraph to 1 | **soft** | comment original, add new adjacent |
| Delete a whole paragraph | **soft** | comment original, leave commented |
| Restructure section order | **soft** | comment original blocks, add new |

When unsure whether a change is hard or soft: **treat it as soft** (comment-don't-delete is the safe default).

## How to comment-out a soft edit

Place the commented original immediately adjacent to the replacement (normally right above the new version), tagged with a short dated marker:

```latex
% [orig 2026-05-21] We show that our method improves retrieval by a large margin.
We demonstrate that our method lifts mAP by 1.8 pp over the Chamfer baseline.
```

For a multi-line block:

```latex
% [orig 2026-05-21]
% \begin{abstract}
%   Old abstract text spanning
%   several lines ...
% \end{abstract}
\begin{abstract}
  New abstract text ...
\end{abstract}
```

- **Tag** the commented original with `% [orig YYYY-MM-DD]` so stale backups can be located and cleaned later.
- **Keep** the commented original next to its replacement; do not relocate it elsewhere.

## Why

LaTeX papers go through many wording iterations. Silently overwriting a sentence loses the prior phrasing that the author may want to:

- **Restore** — "actually the old wording was better"
- **Compare** — "let me see both side by side"
- **Partially revert** — "keep the new structure but the old second half"

Git history captures this too, but inline commented originals are *immediately visible while editing* — no `git log -p` archaeology, no context switch. During fast multi-round paper revision, this is the difference between a 2-second restore and a 5-minute hunt.

## When this triggers

- Editing any `.tex`, `.sty`, `.cls`, `.bib` file (or other LaTeX source) — **the trigger is the file type, not the project type**. Although the rule's `scope` is `research-pkg` (papers live in research packages), import it into any project that contains LaTeX sources.
- Holds **even inside autorun or multi-round iteration loops**, and **even when rewriting a whole file** — preserve prior content as commented blocks rather than silently overwriting.

This rule **overrides `output-brevity`** (which favors minimal diffs) for LaTeX *content* edits specifically — the inline backup is worth the extra lines.

## Cleanup

The commented originals are intentional clutter. When the user confirms a new version is final, they may ask for a **cleanup pass** to strip the commented-original blocks. Grep for the marker to find them all:

```bash
grep -rn '% \[orig ' --include='*.tex' --include='*.sty' --include='*.cls' --include='*.bib' .
```

Do NOT strip them proactively — wait for the user's explicit "clean up the orig comments" / "这版定了，清掉备份注释".

## Companion

- Pairs with `pre-edit-confirmation` — for a soft edit, the 1-line plan should note "comment original + add new version".
- **Overrides** `output-brevity` for LaTeX content edits (inline backup > minimal diff).
- For paper-writing workflow skills, see `recommendations/orchestra-ml-skills.md` §20 (ml-paper-writing, systems-paper-writing, presenting-conference-talks) and `recommendations/ai-coding-tools.md` (paperreview.ai).

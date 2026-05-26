## LaTeX edit policy (comment-don't-delete for soft edits)

When modifying ANY LaTeX source (`.tex`, `.sty`, `.cls`, `.bib`, etc.), distinguish two kinds of change:

- **Hard fixes** — apply by direct replacement / deletion, no backup needed: compile errors, syntax errors, typos, punctuation, whitespace, malformed or duplicated commands, broken refs / labels / citations.
- **Soft edits** — any change to *content* (rewording a word / phrase / sentence / paragraph, restructuring, shortening, replacing wording, or removing a sentence / paragraph): **do NOT delete the original. Comment it out** (`%` line comments, or a commented block) and place the new version immediately adjacent (normally right below). The commented original is an inline backup for future restoration, comparison, or partial revert.
  - Tag the commented original with a short marker such as `% [orig YYYY-MM-DD]` so stale backups can be located and cleaned later.
  - Keep the commented original next to its replacement; do not relocate it elsewhere.

This holds even inside autorun or multi-round iteration loops, and even when rewriting a whole file (preserve prior content as commented blocks rather than silently overwriting). When unsure whether a change is hard or soft, treat it as soft. When the user confirms a new version is final, they may ask for a cleanup pass to strip the commented-original blocks (`grep -rn '% \[orig '`).

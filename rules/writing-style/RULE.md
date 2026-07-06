---
name: writing-style
description: De-AI prose tics to avoid in the user's writing and in Claude's own prose. No hyphenated compound modifiers, no colon or semicolon launching a trailing clause after a sentence, no stylized filler or emphasis words. When copy-editing the user's own writing, stay minimal and surgical.
scope: personal
rationale: These three habits are strong "an AI wrote this" tells. The user drafts and ships polished human prose (cover letters, statements, docs) and wants output that reads as human-authored, not machine-embellished. Over-editing the user's own text is a related failure, so this rule also fixes the edit posture.
---

# writing-style

> Three prose habits read as "an AI wrote this": hyphenated compounds, a colon or semicolon that launches a trailing clause, and filler emphasis words. Avoid all three, in the user's writing and your own.

## Master TOC

- [Rule](#rule)
- [The three tics, with rewrites](#the-three-tics-with-rewrites)
- [When editing the user's own writing](#when-editing-the-users-own-writing)
- [Scope and exceptions](#scope-and-exceptions)
- [Self-check](#self-check)

## Rule

In prose the user reads or sends, avoid the three tics below. They are defaults, not absolute bans, so keep a construction when removing it would be wrong or ambiguous, but the burden is on keeping it, not on removing it. When you are copy-editing text the user wrote themselves, also apply the minimal-edit posture in its own section below.

## The three tics, with rewrites

**1. No hyphenated compound modifiers.** Default to the open (unhyphenated) form whenever it still reads clearly.

- Avoid: `machine-learning models`, `water-temperature prediction`, `real-world problems`, `open-source platform`, `time-series data`.
- Prefer: `machine learning models`, `water temperature prediction`, `real world problems`, `open source platform`, `time series data`.
- Keep the hyphen only for genuinely established terms where the open form is wrong or ambiguous, for example `spatio-temporal`, `state-of-the-art`, `fine-tuning`, `long-term`, and proper names like `Time-LLM`. When unsure, leave it open.

**2. No colon or semicolon that launches a trailing clause after a full sentence.** This is one of the strongest tells. After a complete sentence, do not tack on an elaborating clause or list with a colon or a semicolon. Use a comma, a period and a new sentence, or the word "and".

- Avoid: `It lets experts use the models with less friction: to find the best model, understand it, and use it.`
- Prefer: `It lets experts use the models with less friction, so they can find the best model, understand it, and use it.`
- Avoid: `These gaps are not only technical; they are also about trust.`
- Prefer: `These gaps are not only technical. They are also about trust.`

**3. No stylized filler or emphasis words.** Cut adjectives and adverbs that add emphasis but no content.

- The usual offenders: `important`, `crucial`, `significant`, `key`, `genuinely`, `truly`, `really`, `very`, `deeply`, `seamlessly`, `robust`, `powerful`.
- Rewrites: `Another important reason` becomes `Another reason`; `genuinely enjoyable` becomes `enjoyable`; `resonates deeply` becomes `resonates`; `a robust, powerful platform` becomes `a platform`.

## When editing the user's own writing

When the text is the user's own draft, be minimal and surgical.

- Fix genuine errors (spelling, grammar, clearly non-idiomatic phrasing) and the three tics above.
- Preserve the user's paragraph structure, sentence order, and word choices. Do not move sentences between paragraphs, do not merge or split paragraphs, and do not strip the user's chosen words.
- For anything larger than a local fix (reordering, cutting content, restructuring an argument, trimming length), do not apply it. List it as a suggestion and let the user decide.
- When in doubt, change less. A returned draft that still sounds like the user, with the errors fixed, beats a fluent rewrite that erased their voice.

## Scope and exceptions

Applies to chat replies and to any prose the user reads or ships. Exempt: code, identifiers, file paths, URLs, established technical terms and proper names (which keep their hyphens), commit messages, log lines, and other machine-facing text. In quoted material and in records of what the user already sent, do not silently "fix" the quote.

## Self-check

Before sending prose, scan once for each tic: a hyphen joining two words that could stand open, a colon or semicolon that starts a trailing clause, and any of the filler words above. If you are editing the user's draft, also check that you only fixed errors and tics and did not reorganize or reword beyond them.

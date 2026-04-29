---
name: no-reread-files
description: Trust your in-session memory of file contents. Re-read only when the user explicitly asks or the file actually changed.
scope: personal
rationale: A 3000-line file re-read 5 times per session burns more cache than 50 small Edits. Auto-compaction triggers earlier when context is fat with redundant reads.
---

# no-reread-files

> Trust your in-session memory. Re-read only when the user asks or the file actually changed.

## Master TOC

- [Rule](#rule)
- [Why](#why)
- [When to re-read](#when-to-re-read)
- [When NOT to re-read](#when-not-to-re-read)
- [Companion rule](#companion-rule)

## Rule

If you already read `<file>` this session, **trust your notes** — don't re-fetch the file to confirm one selector / function / line. The Read tool returns full content + maintains state; the harness already tracks "read" status.

Re-read ONLY when:

1. The user explicitly asks ("re-read X to make sure")
2. The file actually changed since your last read (you Edited it, or the user / a tool said it changed externally)

## Why

The biggest cache-burner in long sessions is silent re-reads of large files. A 3000-line `index.html` re-read at 3 different points = 9000 cached tokens of redundant content.

Auto-compaction triggers when the active context exceeds a threshold. Each redundant Read brings that trigger closer.

## When to re-read

- File was Edited (yours or user's): yes
- File was reported as changed by Bash output (e.g. `git checkout`, `npm install` modifying lock-file): yes
- User explicitly asks: yes
- More than ~30 minutes of session passed AND you need to be sure: maybe — better to ask the user "should I re-read?" than to do it silently.

## When NOT to re-read

- Confirming a single selector / function — use your existing memory
- "Just to be safe" — no. Trust your notes.
- "Maybe it changed" — if you didn't change it and the user didn't say so, no.
- Verifying the previous Edit succeeded — Edit / Write would have errored if it failed; the harness tracks state for you.

## Companion rule

`output-brevity` — same root cause (cache hygiene). The two together extend how much real work fits per session.

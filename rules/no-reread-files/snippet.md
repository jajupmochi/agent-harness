## No re-read of files

If you already read `<file>` this session, **trust your notes** — don't re-fetch to confirm one selector / function / line.

Re-read ONLY when:

- The user explicitly asks ("re-read X to make sure")
- The file actually changed since your last read (you Edited it, or the user / a tool said it changed externally)

**Don't re-read** for:

- "Just to be safe" — no. Trust your notes.
- "Maybe it changed" — if you didn't change it and the user didn't say so, no.
- Verifying the previous Edit succeeded — Edit / Write would have errored if it failed; the harness tracks state for you.

Reason: redundant reads burn context cache and trigger auto-compaction earlier than necessary.

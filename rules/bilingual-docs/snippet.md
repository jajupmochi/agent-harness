## Bilingual docs

Every repo-level human-facing doc ships in both English and Chinese as **two separate files**:

- `NAME.md` — English, canonical
- `NAME.zh.md` — Chinese mirror
- One-line language switcher at the top:
  - In `NAME.md`: `> **Language:** English | [中文](NAME.zh.md)`
  - In `NAME.zh.md`: `> **语言：** [English](NAME.md) | 中文`

**Translate**: prose, headings, ordinary text.

**Don't translate**: code, identifiers, filenames, JSON / YAML keys, URLs, hierarchy IDs (`H1.M2.G3.T4`), status markers (`[✓][~][ ]`).

**Exceptions** (English-only): `CLAUDE.md`, `CLAUDE.local.md`, `SKILL.md`, `RULE.md`, hook READMEs — Claude is the primary reader.

Adding a new top-level human-facing doc → MUST add both files in the same edit batch.

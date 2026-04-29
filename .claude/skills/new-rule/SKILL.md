---
name: new-rule
description: Scaffold a new workflow rule under rules/<kebab-name>/. Creates RULE.md (frontmatter + body template) and snippet.md (drop-in for downstream CLAUDE.md), plus updates INVENTORY.md and INVENTORY.zh.md in the same edit batch.
---

# /new-rule

Scaffold a new workflow rule. Use when you (or Claude) discover a behavior worth standardizing across projects.

## Usage

```
/new-rule <kebab-name>
```

E.g.: `/new-rule no-emoji-in-prose`

## Pre-flight

- Verify `rules/<kebab-name>/` does not already exist (don't clobber)
- Confirm the rule isn't redundant with an existing one (check `INVENTORY.md` table)

## Steps

1. **Create directory**:

   ```bash
   mkdir -p rules/<kebab-name>
   ```

2. **Ask the user** for:
   - One-line description (becomes `description:` frontmatter)
   - Scope: `universal | personal | ui-project | research-pkg | static-site | optional`
   - Rationale: 1-2 sentences on what bug this rule prevents / time it saves
   - Trigger condition: when does this rule kick in?

3. **Write `rules/<kebab-name>/RULE.md`**:

   ```markdown
   ---
   name: <kebab-name>
   description: <one-line>
   scope: <scope>
   rationale: <why-this-rule-exists>
   ---

   # <kebab-name>

   > <one-line summary>

   ## Master TOC

   - [Rule](#rule)
   - [Why](#why)
   - [How to apply](#how-to-apply)
   - [Examples](#examples)
   - [Exceptions](#exceptions)

   ## Rule

   <imperative statement of the rule, with bullet points for clarity>

   ## Why

   <full rationale — what problem this prevents, what time it saves>

   ## How to apply

   <when this rule kicks in; edge cases; companion rules>

   ## Examples

   ✅ Good:
   <concrete scenario>

   ❌ Bad:
   <contrast scenario>

   ## Exceptions

   <when the rule doesn't apply, or when to override>
   ```

4. **Write `rules/<kebab-name>/snippet.md`** — the drop-in version:

   ```markdown
   ## <Rule Name>

   <Compact 3-7 line statement suitable for inclusion in a project's CLAUDE.md via @import>
   ```

5. **Update `rules/README.md`** — add a row to the rule index table.

6. **Update `INVENTORY.md` AND `INVENTORY.zh.md`** — add a row to the Rules section table.

7. **Show the user** the diff and ask for confirmation before committing.

## Companion

- `docs/CONTRIBUTING.md` §"Adding a rule" — formal spec
- `rules/README.md` — index of all rules + scope tag definitions

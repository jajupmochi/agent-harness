---
name: new-hook
description: Scaffold a new hook under hooks/<kebab-name>/. Creates README.md (what/when/install/variants) and settings.snippet.json (drop-in JSON), plus updates INVENTORY.md and hooks/README.md in the same edit batch. Hooks are sensitive — pipe-test the raw command before wrapping.
---

# /new-hook

Scaffold a new hook recipe. Hooks are deterministic shell commands tied to Claude Code lifecycle events.

## Usage

```
/new-hook <kebab-name>
```

E.g.: `/new-hook prettier-format-on-edit` or `/new-hook block-secrets-on-edit`

## Pre-flight

- Verify `hooks/<kebab-name>/` does not already exist
- Confirm the hook isn't redundant with an existing one
- **Critical**: hooks are sensitive — verify you've pipe-tested the raw command before wrapping (see "Construction flow" below)

## Construction flow

Per the official `update-config` skill (Anthropic-managed), hook construction follows:

1. **Dedup check** — search existing `.claude/settings.json` files for similar hooks; reuse if possible
2. **Construct for THIS project** — write the raw command first
3. **Pipe-test raw** — run the bare command and verify it produces correct output
4. **Wrap in JSON** — embed in `settings.snippet.json` with `matcher` and `hooks` array
5. **Validate JSON** — `jq empty settings.snippet.json` (no error = valid)
6. **Live-proof** — for `Pre|PostToolUse` on triggerable matchers, trigger an actual matching tool call and verify the hook fires
7. **Cleanup** — remove test artifacts; document the variant in README
8. **Handoff** — show the user the complete files

## Steps for this skill

1. **Create directory**:

   ```bash
   mkdir -p hooks/<kebab-name>
   ```

2. **Ask the user** for:
   - Event: `PreToolUse | PostToolUse | Stop | SubagentStop`
   - Matcher: tool name pattern (e.g., `Write|Edit`, `Bash`, `*`)
   - Command: the bare shell command (will be wrapped in JSON `"command"` field)
   - Context: which project types it applies to
   - Variants: are there alternative ways to achieve the same effect (different toolchain, different config)?

3. **Pipe-test the raw command** before writing files:

   ```bash
   echo '{"tool_input":{"file_path":"<example-file>"}}' | <YOUR-COMMAND>
   ```

   Confirm output matches expectations.

4. **Write `hooks/<kebab-name>/README.md`**:

   ```markdown
   # <kebab-name>

   > <one-line: event + matcher + what it does>

   ## What it does

   <full description>

   ## Why

   <bug it prevents / time it saves>

   ## Install

   <install steps + jq merge command>

   ## Variants

   <alternative implementations>

   ## Caveats

   <gotchas, edge cases>

   ## Companion

   <related hooks/rules/skills>
   ```

5. **Write `hooks/<kebab-name>/settings.snippet.json`**:

   ```json
   {
     "hooks": {
       "<EVENT>": [
         {
           "matcher": "<MATCHER>",
           "hooks": [
             {
               "type": "command",
               "command": "<wrapped command — escape JSON correctly>",
               "timeout": 30,
               "statusMessage": "<optional one-line status>"
             }
           ]
         }
       ]
     }
   }
   ```

6. **Validate JSON**:

   ```bash
   jq empty hooks/<kebab-name>/settings.snippet.json
   ```

7. **Update `hooks/README.md`** — add a row to the hook index table.

8. **Update `INVENTORY.md` AND `INVENTORY.zh.md`** — add a row to the Hooks section.

9. **Show the user** the diff and ask for confirmation before committing.

## Companion

- `docs/CONTRIBUTING.md` §"Adding a hook"
- Anthropic's `update-config` skill — canonical hook construction flow with live-proof
- Anthropic's `hookify` plugin — generate hooks from conversation analysis

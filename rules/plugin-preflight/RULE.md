---
name: plugin-preflight
description: Verify a plugin / skill / slash command / MCP tool is installed AND not deprecated before invoking it. Show the verification before firing.
scope: universal
rationale: Invoking a non-existent or deprecated tool wastes a round-trip and produces confusing errors. A 1-line preflight check is cheap insurance and gives the user a chance to veto.
---

# plugin-preflight

> Verify a plugin / skill / slash command / MCP tool is installed and not deprecated before invoking it.

## Master TOC

- [Rule](#rule)
- [Why](#why)
- [How to apply](#how-to-apply)
- [Format](#format)
- [Exception](#exception)

## Rule

Before invoking ANY plugin command, slash command, MCP tool, or skill that you have NOT used in the current session, you MUST:

1. Verify the plugin / skill / command is **installed** in the current environment (check the available-skills list, run `claude plugin list` / `which <cmd>` / equivalent).
2. Verify the command is **not deprecated** (look for "deprecated" / "use X instead" markers in its description).
3. Show the user the verification output (one short line is enough — e.g. `✓ impeccable plugin found, /impeccable not deprecated`).
4. Only then invoke it.

If verification fails (missing / deprecated / unclear required args), STOP and tell the user — do NOT silently fall back to a different tool or guess.

## Why

Failure modes prevented:

- Calling a slash command that's been renamed
- Invoking a deprecated skill that quietly does nothing or warns mid-tool-call
- Calling a plugin that was uninstalled but still cached in memory
- Wasting a tool-call quota on something that won't work

## How to apply

- ANY first-time-this-session invocation of a `/`-command, `Skill` tool, MCP tool, or plugin command
- DOES NOT apply to: tools defined at the top of the session prompt (Bash, Read, Edit, Write, etc.) — those are always present
- Cache the verification result for the session — once verified, don't re-verify

## Format

```
✓ <plugin-name> plugin found, /<command> not deprecated
[invoke the command]
```

## Exception

Tools you have already successfully invoked in the current session don't need re-verification (cache the result for the session).

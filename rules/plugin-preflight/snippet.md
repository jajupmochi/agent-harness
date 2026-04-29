## Plugin / command preflight

Before invoking ANY plugin command, slash command, MCP tool, or skill that you have not used in the current session, you MUST:

1. Verify the plugin / skill / command is **installed** in the current environment (check the available-skills list, run `claude plugin list` / `which <cmd>` / equivalent).
2. Verify the command is **not deprecated** (look for "deprecated" / "use X instead" markers in its description).
3. Show the user the verification output (one short line is enough — e.g. `✓ impeccable plugin found, /impeccable not deprecated`).
4. Only then invoke it.

If verification fails (missing / deprecated / unclear required args), STOP and tell the user — do NOT silently fall back to a different tool or guess.

**Exception**: Tools you have already successfully invoked in the current session don't need re-verification (cache the result for the session).

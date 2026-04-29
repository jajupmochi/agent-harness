# Permissions Allowlist

> Drop-in `Bash(...)` and `Skill(...)` allowlist entries for project-level `.claude/settings.local.json`. Reduces repeat permission prompts during routine work without lowering safety on destructive commands.

## Master TOC

- [How to use](#how-to-use)
- [What's in the snippet](#whats-in-the-snippet)
- [What's intentionally excluded](#whats-intentionally-excluded)
- [Per-project additions](#per-project-additions)

## How to use

**This file goes in `.claude/settings.local.json`** (NOT `settings.json`) — it's per-user and per-project, gitignored. Don't commit.

```bash
# Merge into existing .claude/settings.local.json (creating it if absent):
cat .claude/settings.local.json 2>/dev/null | jq -s '.[0] // {} | . * (input)' tooling/permissions-allowlist/settings.local.snippet.json > .claude/settings.local.json.new && mv .claude/settings.local.json.new .claude/settings.local.json

# Verify:
cat .claude/settings.local.json | jq .
```

If `.claude/settings.local.json` doesn't yet exist, the snippet IS the file:

```bash
mkdir -p .claude
cp tooling/permissions-allowlist/settings.local.snippet.json .claude/settings.local.json
```

## What's in the snippet

Common read-only or low-risk Bash patterns extracted from the author's real `settings.local.json` files (`<research-pkg-A>`, `<research-pkg-B>`):

- **Version checks**: `uv --version`, `ruff --version`, `gh --version`, `node --version`
- **uv operations**: `uv add *`, `uv run *`, `uvx ruff *`
- **Read-only git**: `git status`, `git log`, `git diff`, `git remote -v`
- **`git add *`** — covers `git add` for any file (still requires a separate prompt for sensitive paths via your project's exclusion list)
- **`echo "exit=$?"`** — for shell return-code checks
- **`Skill(update-config)`** — the hooks construction skill is allowlisted (canonical hook authoring)
- **`Read(//home/<your-user>/.claude/**)`** — equivalent for your home; replace with your username

## What's intentionally excluded

These remain **prompt-gated** for safety:

- `git push` (any form) — never auto-allow
- `git reset --hard`, `git rebase`, `git stash drop` — destructive
- `rm -rf` — destructive
- `npm install -g` — affects whole machine
- `sudo` (any form) — privileged
- `curl | sh` patterns — unsanitized download-and-execute

Keep these on the prompt path so the user actively approves them per occurrence.

## Per-project additions

The snippet's defaults are conservative. Add project-specific entries as you discover repeating prompts:

```jsonc
{
  "permissions": {
    "allow": [
      // ... defaults from snippet ...

      // Project-specific (example — replace with yours):
      "Bash(WANDB_MODE=disabled uv run python -m <module> -m lstm -g <dataset> -n 1 -d)",
      "Bash(git -C /path/to/<project> log --oneline -5)",
      "Bash(awk '{print length}' /path/to/specific/file.py)"
    ]
  }
}
```

Watch for `[settings:perm]` log entries in CC and add them as they recur — but **only after confirming the command is safe to auto-allow** for this project.

## Companion

- `tooling/python-uv-ruff/` — for `uv add` / `uv run` / `uvx` patterns to be useful, the project must use uv
- `tooling/node-nvm/` — `npx` permissions are typically broad; project-specific `npm install` patterns go here per project

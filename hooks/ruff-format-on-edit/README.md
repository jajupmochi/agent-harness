# ruff-format-on-edit

> `PostToolUse:Write|Edit` hook that formats Python files with ruff after every Claude edit.

## What it does

Every time Claude writes or edits a `*.py` file, this hook runs:

1. `uv run ruff format <file>` — apply ruff's formatter
2. `uv run ruff check --fix <file>` — apply auto-fixable lint rules

## Why

- Keeps the codebase consistently formatted without nagging Claude per-edit
- Catches simple lint errors immediately so they don't accumulate
- Matches the canonical Python toolchain (`tooling/python-uv-ruff/`)

## Install

Merge `settings.snippet.json` into your project's `.claude/settings.json`. If the file doesn't exist, the snippet IS the file.

Verify ruff is available in the project:

```bash
uv run ruff --version    # project-local (preferred)
# OR machine-wide:
uv tool install ruff
which ruff
```

## Variants

Three ways to invoke ruff via uv (seen across user's projects):

| Form | When to use |
|---|---|
| `uv run ruff` | Project-local install via `pyproject.toml` `[dev]` extras (project must be `uv sync`'d first) |
| `uv tool run ruff` | Global ruff via `uv tool install` (machine-wide) |
| `uvx ruff` | Shorthand for `uv tool run ruff` (newer syntax) |

This snippet uses `uv run` (project-local, deterministic) by default. To switch to global:

- Replace `uv run ruff` with `uvx ruff` in the JSON command
- Or run `uv tool install ruff` once per machine

## Caveats

- Does not handle Notebook (`.ipynb`) files — add a separate hook with matcher `NotebookEdit` if needed
- Silent on failure (`|| true` at end) — if ruff has a hard error, it logs but doesn't block. To make it blocking, change the trailing `|| true` to a `decision: "block"` JSON output.
- Performance: ~50–200 ms per edit; usually fine. If it slows you down, switch to a project-wide hook (`Stop` event) instead of per-edit.

## Companion

Pair with `tooling/python-uv-ruff/` for the matching `pyproject.toml` ruff config (line-length, target-version, etc.) so the hook's auto-format produces the same output as `pre-commit` / CI.

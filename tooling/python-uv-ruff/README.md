# Python — uv + ruff

> Canonical Python toolchain: `uv` for package management and Python version management; `ruff` for linting and formatting. Replaces the legacy `pip + venv + black + flake8 + isort` stack.

## Master TOC

- [Install](#install)
- [Why uv + ruff](#why-uv--ruff)
- [Project bootstrap](#project-bootstrap)
- [Common commands](#common-commands)
- [Companion: ruff format-on-edit hook](#companion-ruff-format-on-edit-hook)

## Install

**Once per machine** (no project root needed):

```bash
# uv (package manager + Python version manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Verify:
uv --version

# Optional but recommended — install ruff globally so it's available outside any specific project:
uv tool install ruff
ruff --version
```

For Python itself, `uv` will install the requested Python version automatically when needed (e.g., `uv sync --python 3.12`).

## Why uv + ruff

**uv** vs. pip/poetry/pdm/conda:
- **10–100× faster** package resolution and installs
- Single binary (Rust); no Python boot required to install Python
- Manages Python versions natively — no separate `pyenv` / `conda` needed
- Lockfile-first (`uv.lock`) for reproducibility

**ruff** vs. black + flake8 + isort + pyupgrade + pylint:
- One tool replaces 5
- 10–100× faster than the alternatives combined
- Drop-in compatible with black formatting style by default
- Single config under `[tool.ruff]` in `pyproject.toml`

## Project bootstrap

In a new (or existing) project:

```bash
# Initialize with uv (creates pyproject.toml + .venv + uv.lock):
uv init <project-name>
cd <project-name>

# Or if pyproject.toml already exists:
uv sync --python 3.12 --no-cache

# Install dev dependencies (after editing pyproject.toml [dev] extras):
uv pip install -e ".[dev]"

# Verify:
uv run python --version
uv run ruff --version
```

See [`pyproject.template.toml`](pyproject.template.toml) for the canonical template — copy and replace `<PLACEHOLDERS>`.

## Common commands

```bash
# Add a runtime dep
uv add <package>

# Add a dev dep
uv add --dev <package>

# Sync from lockfile
uv sync

# Run a CLI tool from project deps
uv run pytest
uv run mypy <package>
uv run ruff check <package>
uv run ruff format <package>

# Run a one-off command
uvx <tool>             # e.g. uvx ruff check .

# Update Python version
uv python install 3.13
uv sync --python 3.13
```

## Companion: ruff format-on-edit hook

Pair this toolchain with the `hooks/ruff-format-on-edit/` hook to auto-format Python files after every Claude edit. Drop the hook's `settings.snippet.json` into the project's `.claude/settings.json`.

The hook uses `uv run ruff` by default — matches this template's project-local install. For machine-wide ruff (`uv tool install ruff`), switch to `uvx ruff` per the hook's README.

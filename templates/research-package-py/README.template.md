# <PROJECT_NAME>

> <DESCRIPTION>

## Master TOC

- [Install](#install)
- [Quick start](#quick-start)
- [Architecture](#architecture)
- [Development](#development)
- [License](#license)

## Install

Requires Python 3.12+ and [uv](https://github.com/astral-sh/uv).

```bash
git clone <REPO_URL>
cd <PROJECT_NAME>
uv sync --python 3.12
uv pip install -e ".[dev]"
```

## Quick start

```bash
<PROJECT_NAME> --help
# or programmatically:
uv run python -m <PACKAGE_NAME>.cli --help
```

## Architecture

<TBD: short description of the package's structure — replace this section after first iteration.>

## Development

```bash
# Run tests
uv run pytest -v

# Lint + format
uv run ruff check <PACKAGE_NAME>/ tests/
uv run ruff format <PACKAGE_NAME>/ tests/

# Type-check
uv run mypy <PACKAGE_NAME>/
```

For a one-shot CI gate, use `/verify` (in Claude Code).

## License

MIT (see [LICENSE](LICENSE)).

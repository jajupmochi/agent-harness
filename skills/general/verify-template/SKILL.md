---
name: verify-template
description: Run the project's CI gates locally before claiming work is done. Customize the body to match the project's actual lint/test commands. Use before opening a PR or marking a phase complete.
---

# /verify

Run the full verification gate for this project. Stop on first failure and report it plainly.

**Customize this skill per project** — the body below is a template. Replace with the project's actual commands. Common templates:

## Default Python (uv + ruff + pytest)

```bash
uv run ruff check <SRC_DIRS>
uv run ruff format --check <SRC_DIRS>
uv run mypy <SRC_DIRS>            # if mypy is configured
uv run pytest -m "not slow and not download" -v
```

Replace `<SRC_DIRS>` with the project's source dirs (e.g., `src/ tests/` or `<package-name>/ tests/ plugins/`).

## Default Node.js (TypeScript)

```bash
npx tsc --noEmit
npx prettier --check .
npx eslint .                       # if eslint is configured
npx vitest run                     # or npx jest
```

## Static site (HTML / CSS / JSON i18n)

```bash
# Validate JSON
for f in locales/*.json data/*.json; do jq empty "$f" || { echo "Invalid: $f"; exit 1; }; done

# i18n parity (if applicable)
python3 scripts/check_i18n_parity.py

# Optional: HTML validation
npx html-validate index*.html
```

## Notes for the agent

- Stop on the first failure. Report which step failed and the relevant tool output.
- These should mirror the actual CI workflow — if `ruff format --check` fails, run `ruff format` to fix, then re-run `/verify`.
- Don't run if there are no edits in flight (skip if working tree is clean and HEAD == upstream).
- For research packages, tests should run on CPU and complete in <30 s if possible.

## Customization checklist

When using this template in a new project:

- [ ] Replace `<SRC_DIRS>` with the project's source directories
- [ ] Adjust pytest flags (markers, parallelism)
- [ ] Add or remove mypy step based on whether the project uses it
- [ ] If `pre-commit` is configured, prefer `pre-commit run --all-files` over invoking ruff directly
- [ ] Drop the templates that don't apply (e.g., remove the Node.js block in a Python project)

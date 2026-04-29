# jq-validate-json

> `PostToolUse:Write|Edit` hook that blocks the next tool call if Claude wrote invalid JSON to selected paths.

## What it does

After Claude writes or edits a file matching the configured paths (default: `*/locales/*.json` and `*/data/*.json`), this hook runs `jq empty` to validate the JSON:

- If valid: hook is a no-op, edit proceeds
- If invalid: hook returns `decision: "block"` with the jq error message; Claude receives a system message and must fix the JSON before continuing

## Why

A single typo in `locales/en.json` can break a deployed static site (CORS-loaded JSON returns 500 or partial data). This hook catches the typo at edit time, before the next tool call piles on.

Sourced from `<personal-site>`'s i18n setup — the four `locales/{en,zh,fr,de}.json` files must remain valid AND have parity (parity is enforced separately by a git pre-commit hook).

## Install

Merge `settings.snippet.json` into your project's `.claude/settings.json`. **Adjust the path glob** (`*/locales/*.json|*/data/*.json`) to match your project's JSON config locations:

```bash
# example for a project where JSON config lives in src/i18n/ and config/:
sed -i 's|*/locales/*.json|*/data/*.json|*/src/i18n/*.json|*/config/*.json|' .claude/settings.json
```

(Adapt to your project layout.)

## Caveats

- Validates ONLY the configured globs — wider validation needs a wider glob
- Does NOT validate JSON5 / JSONC (with comments) — use a different validator (e.g., `json5` package)
- Performance: ~10–50 ms per JSON edit
- Does NOT enforce key parity across multiple locales (e.g., `en.json` vs `zh.json`) — that needs a separate pre-commit hook (`scripts/check_i18n_parity.py` pattern)

## Companion

For full i18n discipline, pair with:
- `.githooks/pre-commit` script that enforces key parity across `locales/*.json`
- `templates/personal-cite-static/` (P7) ships with both

---
name: preview
description: Start a local dev server for this static site. Required before /verify-visual since file:// breaks fetch() calls for locales/*.json.
---

# /preview

Start a local HTTP server in the project root.

```bash
python3 -m http.server 8000
```

Then open `http://localhost:8000/index.html`.

**Why a server (not `file://`)**: the site uses `fetch('locales/<lang>.json')` to load translations. Browsers block `fetch` from `file://` (CORS), so you MUST use HTTP for visual verification — the i18n strings come up as empty otherwise.

## Notes for the agent

- Run with `run_in_background: true` to return control immediately.
- If port 8000 is in use, increment to 8001 and report.
- Don't kill an existing server — multiple ports can coexist.
- Pair with `/verify-visual` for screenshot-based verification.

## Companion

- `/verify-visual` — uses chrome-devtools MCP to screenshot + critique the served page
- `/i18n-sync` — verify all locale files have parity before/after editing strings

---
name: preview-template
description: Start the local dev server / preview environment for this project. Customize per project type. Use when iterating on UI or before visual verification.
---

# /preview

Start the local dev server for this project.

**Customize this skill per project** — pick the relevant template below and delete the rest.

## Static site (HTML / CSS / JS, no build)

```bash
python3 -m http.server 8000
# Then open http://localhost:8000/<entry-page>.html
```

Note: `file://` access often breaks `fetch()` calls (CORS-loaded JSON returns errors). Always use the server.

## Vite (Vue / React / Svelte)

```bash
npm run dev
# Default: http://localhost:5173/
```

## Next.js

```bash
npm run dev
# Default: http://localhost:3000/
```

## MkDocs (docs site)

```bash
uv pip install mkdocs mkdocs-material   # if not yet installed
mkdocs serve
# Default: http://127.0.0.1:8000/
```

## Storybook

```bash
npm run storybook
# Default: http://localhost:6006/
```

## Notes for the agent

- Run in the background (`run_in_background: true`), not foreground — return control immediately.
- Report the URL the user should open.
- Don't kill an existing server unless the user asks — multiple dev servers can coexist on different ports.
- If port is already in use, increment and report (e.g., `8001` instead of `8000`).

## Customization checklist

- [ ] Pick the relevant template (delete others)
- [ ] Add the project's actual entry URL / port
- [ ] Add any project-specific env vars or pre-commands (e.g., `WANDB_MODE=disabled npm run dev`)
- [ ] If `npm run dev` is wrapped (e.g., `npm run dev:full`), use the wrapped command

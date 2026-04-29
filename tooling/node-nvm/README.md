# Node.js — nvm + minimal globals

> Canonical Node toolchain: nvm for version management; npm as the package manager (no globals beyond `corepack` + a couple of CC-related CLIs); `npx` for one-shot tools.

## Master TOC

- [Install](#install)
- [Why nvm + minimal globals](#why-nvm--minimal-globals)
- [Project bootstrap](#project-bootstrap)
- [Globals to install](#globals-to-install)
- [Why no `pnpm` / `yarn` / `bun` in defaults](#why-no-pnpm--yarn--bun-in-defaults)

## Install

**Once per machine** (Linux / macOS):

```bash
# nvm — Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Reload shell:
source ~/.bashrc   # or ~/.zshrc

# Install Node 22 LTS (canonical for the author):
nvm install 22
nvm use 22
nvm alias default 22

# Verify:
node --version
npm --version
npx --version
```

## Why nvm + minimal globals

**nvm** vs. system Node:
- Switch Node versions per project (`.nvmrc` file)
- No `sudo` for global installs (everything in `~/.nvm/versions/node/<ver>/`)
- Works alongside `corepack` for pnpm / yarn version pinning

**Minimal globals**: the author keeps `npm ls -g --depth=0` deliberately tiny. Most tools run via `npx` (no install) or as project devDependencies. The only globals worth installing are:

- `corepack` — manages pnpm / yarn versions (bundled with Node)
- `@github/copilot` — GitHub Copilot CLI (if not using CC + GitHub MCP)
- (your CC-related plugin clis come via Claude Code itself, not npm)

## Project bootstrap

In a new (or existing) project:

```bash
# If the project has a .nvmrc:
nvm use

# Initialize package.json (or use a scaffold like create-vite / create-next-app):
npm init -y

# Install deps:
npm i <package>             # runtime
npm i -D <package>          # dev

# Run tools without installing:
npx prettier --write .
npx eslint .
npx vitest run
```

For specific stacks (Vite, Next.js, Electron), see [`recommendations/js-build-test-style.md`](../../recommendations/js-build-test-style.md) for scaffold commands.

## Globals to install

```bash
# Recommended for any Node-using machine:
npm install -g corepack    # bundled with Node 16.10+; use for pnpm / yarn version pinning

# Author-specific (skip if not using):
npm install -g @github/copilot
```

**Don't** install these globally (use `npx` or devDep instead):

- `prettier` (run via `npx prettier`)
- `eslint` (run via `npx eslint`)
- `typescript` (use as project devDep so each project pins its own version)
- `vite`, `next`, `react` (always project-local — version mismatches break builds)

## Why no `pnpm` / `yarn` / `bun` in defaults

The author's real projects use **plain npm**. Reasons:
- No version-pinning issues across machines
- Lockfile (`package-lock.json`) is universally understood
- pnpm / yarn add complexity (workspaces, hoisting strategies, plug-n-play) without proportional benefit for typical projects
- `bun` is fast but has compatibility gaps with some Node ecosystems

If a project specifically needs pnpm (e.g., monorepo with workspaces) or bun (e.g., performance-critical CI), `corepack` lets you pin a specific version per project without a global install.

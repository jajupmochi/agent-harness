# Contributing

> How to add or modify content in this library. Optimized for the case where Linlin (or Claude on Linlin's behalf) extends the lib from another session.

## Master TOC

- [Adding a rule](#adding-a-rule)
- [Adding a skill](#adding-a-skill)
- [Adding a hook](#adding-a-hook)
- [Adding a recommendation](#adding-a-recommendation)
- [Adding tooling](#adding-tooling)
- [Adding a template](#adding-a-template)
- [Updating the inventory](#updating-the-inventory)
- [Bilingual policy](#bilingual-policy)
- [Commits and PRs](#commits-and-prs)

## Adding a rule

A rule is a workflow convention that shapes Claude's behavior in a downstream project.

**Recommended:** run the scaffold skill (lands in Phase 9):

```
/new-rule <kebab-name>
```

**Manually:**

1. Create `rules/<kebab-name>/` directory.
2. Add `RULE.md` (full content + rationale + when-to-use) and `snippet.md` (drop-in for `CLAUDE.md`).
3. `RULE.md` frontmatter:

   ```yaml
   ---
   name: <kebab-name>
   description: <one-line>
   scope: [universal | python-research | static-site | ml-experiment | web-app]
   rationale: <why this rule exists, what bug it prevents>
   ---
   ```

4. Update `INVENTORY.md` and `INVENTORY.zh.md` in the same edit batch.

## Adding a skill

A skill is on-demand instructions (or workflow) that Claude invokes by name or auto-matches.

Same shape as a rule, but:

- Live under `skills/<bucket>/<kebab-name>/SKILL.md` where bucket is one of `general/`, `research-pkg/`, `static-site/`, `productivity/`, `personal/`.
- Frontmatter follows the official Claude Code SKILL.md spec (`name`, `description`, optional `disable-model-invocation`).
- Use the scaffold (lands in Phase 9): `/new-skill <bucket>/<kebab-name>`

## Adding a hook

A hook is a deterministic shell command tied to a Claude Code lifecycle event.

Under `hooks/<kebab-name>/`:

- `README.md` — what it does, which event/matcher, when it fires, gotchas, install steps.
- `settings.snippet.json` — drop-in JSON to merge into a project's `.claude/settings.json`.
- `verify.sh` (optional) — script to test the hook manually before relying on it.

Hooks are sensitive — pipe-test the raw command first, then wrap. See `~/.claude/CLAUDE.md`'s reference to the `update-config` skill for the full construction flow.

## Adding a recommendation

Markdown only — `recommendations/<topic>.md`. Each entry includes:

- **Name** + link.
- **One-line "why use this"** — what bug it prevents or what time it saves.
- **Caveats** if any (compatibility, license, abandonment risk).
- **Install steps** — copy-paste-able commands an agent can execute, sourced from CLI history or official docs. Prefer `npx` over global `npm install -g` where possible.

For tools / plugins / MCP servers, agent-executable install commands are mandatory — the lib's purpose is for Claude (or a fresh machine) to bootstrap from this file alone.

## Adding tooling

Under `tooling/<kebab-name>/`:

- `README.md` — what it is, when to choose it over alternatives, install steps with provenance (CLI history reference / official doc link).
- Template config files (`pyproject.template.toml`, `ruff.template.toml`, etc.) using `<PROJECT_NAME>` etc. placeholders.

## Adding a template

A full project starter under `templates/<project-type>/`. Should include:

- `CLAUDE.template.md` (with `<PROJECT_NAME>`, `<DESCRIPTION>` etc. placeholders).
- `.claude/settings.json` with project-appropriate hooks.
- `.claude/skills/` with the project type's standard skills (use symlinks to `skills/general/...` where possible to avoid duplication; resolve at scaffold time).
- `pyproject.template.toml` or equivalent manifest.
- A short `TEMPLATE_README.md` explaining what a user gets when they pick this template.

## Updating the inventory

`INVENTORY.md` and `INVENTORY.zh.md` are the source of truth for what exists in the library.

**Don't merge a content add without an inventory update in the same edit batch.** This is the only mechanism keeping the index honest until the auto-gen skill ships in Phase 9.

## Bilingual policy

This repo's *own* docs ship bilingual at the top level (README, INVENTORY, PHILOSOPHY, CONSUMPTION). Content modules (`RULE.md`, `SKILL.md`, hook READMEs, this CONTRIBUTING.md) stay English-only since they're primarily Claude-readable.

The lib does NOT enforce bilingual policy on consumer projects — that's the `rules/bilingual-docs/` rule, opted-in at scaffold time per project.

## Commits and PRs

- Conventional Commits — `feat:`, `fix:`, `docs:`, `refactor:`, `chore:`.
- One commit per logically distinct change.
- Don't split inventory updates from the content change they describe.
- During the initial 10-phase build, one commit per phase (e.g. `feat: P1 foundation — README, CLAUDE.md, docs, structure`).

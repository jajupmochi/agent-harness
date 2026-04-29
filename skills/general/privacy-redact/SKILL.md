---
name: privacy-redact
description: Scan a markdown / text file for usernames, absolute paths, secrets, and project codenames; replace with placeholders. Use before promoting any private/draft file into a public commit or recommendation.
---

# /privacy-redact

Scan and redact private content from a file before publishing it.

## Usage

```
/privacy-redact <file-path>
```

## What it scans for

| Pattern | Action |
|---|---|
| System usernames (configured per project) | Remove |
| Absolute paths (`/home/<user>/`, `/media/<user>/`, `/mnt/<uuid>/`) | Replace with `~` (relative) or `<workspace>/` |
| Token-shaped strings (matching `sk-…`, `ghp_…`, `gho_…`, `github_pat_…` patterns) | **STOP and warn the user** — refuse to write the file with secrets present |
| Email addresses (`<user>@<domain>`) | Remove or replace with `<redacted-email>` |
| Project-specific codenames | Per project's redaction map (defined in `docs/CONTRIBUTING.md` of the project) |

## Steps

1. **Read** the file
2. **Multi-pattern grep** to find matches (adjust `<your-username>` per project):

   ```bash
   grep -nE '<your-username>|/home/|/media/|/mnt/|@gmail|@hotmail|sk-[A-Za-z]|ghp_[A-Za-z0-9]|gho_|github_pat_' <file>
   ```

3. **Per match**, show the line and proposed replacement
4. **Ask the user to confirm** batch redaction (or per-line if uncertain). Default to ask — privacy-redact is irreversible w.r.t. the original wording.
5. **Apply** via Edit (one Edit per replacement, or replace_all where safe)
6. **Re-scan** to confirm clean
7. **Report** — show what was redacted and what remains as-is

## When to use

- Promoting a draft file to a public location (e.g., `DISCOVERY.md` → `recommendations/*.md`)
- Before opening a PR with private context attached
- When publishing a doc to a public repo for the first time

## Caveats

- This is a **HEURISTIC**, not a security tool. False negatives are possible.
- Manual review still required for sensitive cases.
- For real secrets in git history (already committed), use `git filter-branch` or `BFG Repo-Cleaner` — this skill only handles current files, not history.
- Don't trust the regex for tokens — most token formats aren't covered. Treat any unknown high-entropy string as suspicious.

## Defaults to be safe

- If you find something that LOOKS like a secret but doesn't match the regex (random 30+ character alphanumeric string), STOP and ask the user before continuing.
- If a redaction would change semantics (e.g., a path is part of an install command), warn the user and propose a placeholder rather than removal.

## Related

- `docs/CONTRIBUTING.md` of each consumer project should define a project-specific redaction map (codename → placeholder)
- For repo-wide audit, run this skill on each candidate file in a loop

## Example

```
$ /privacy-redact docs/DRAFT.md

Found N codename references that match the project's redaction map.

Proposed replacements (per redaction map in docs/CONTRIBUTING.md):
- <internal-codename-A> → <generic-placeholder-A>
- <internal-codename-B> → <generic-placeholder-B>
  ...

No system usernames, absolute paths, or token-shaped strings found.

Apply all N replacements? (y/n)
```

(The actual codenames and placeholders come from each consumer project's redaction map — this skill is project-agnostic.)

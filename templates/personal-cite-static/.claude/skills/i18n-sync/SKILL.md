---
name: i18n-sync
description: Check key parity across locales/*.json. If divergence is detected, list missing keys per locale and offer to add stubs. Use after editing any locale file.
---

# /i18n-sync

Verify all `locales/*.json` files have identical key trees, and add stubs where they diverge.

## Why

The site loads `locales/<lang>.json` at runtime. If `zh.json` is missing a key that `en.json` has, the user sees the English fallback (or empty text) where the Chinese should be — visible bug.

## Steps

1. **Glob** `locales/*.json` to find all locale files.
2. **Validate JSON** for each (`jq empty`) — error out if any is invalid (the `jq-validate-json` hook should already prevent this, but verify).
3. **Extract key tree** from `en.json` (the canonical):

   ```bash
   jq 'paths(scalars) | map(tostring) | join(".")' locales/en.json | sort -u > /tmp/keys-en.txt
   ```

4. **For each non-en locale**, extract its key tree and `diff` against the canonical:

   ```bash
   for f in locales/*.json; do
     [ "$f" = "locales/en.json" ] && continue
     jq 'paths(scalars) | map(tostring) | join(".")' "$f" | sort -u > /tmp/keys-$(basename "$f" .json).txt
     diff /tmp/keys-en.txt /tmp/keys-$(basename "$f" .json).txt
   done
   ```

5. **Report**:
   - Which locales have which missing keys
   - Which locales have EXTRA keys not in `en.json` (potential typo)
6. **Offer to add stubs**: for each missing key in a non-en locale, add a stub value (e.g., `"<TODO: translate>"`) so the next deploy doesn't show empty text.

## Notes for the agent

- `en.json` is the canonical key tree. Other locales must match.
- DON'T add a key to `en.json` without also adding it to other locales. Use this skill to check parity AFTER edits.
- Stubs use `<TODO: translate>` so they're easy to grep + replace later.
- If a locale has EXTRA keys not in `en.json`, ask the user: did they add a key only to that locale by mistake, or should `en.json` get the key too?

## Companion

- `jq-validate-json` hook — runs automatically after every Write/Edit on `locales/*.json` files; catches syntax errors immediately
- `.githooks/pre-commit` (optional) — a stricter version of this skill that fails the commit if parity is broken; consider adding for stricter discipline

## Example output

```
Locale parity check:
- en.json (canonical): 142 keys
- zh.json: 142 keys ✓
- de.json: 138 keys ❌ missing: hero.subtitle, footer.copyright_year, ...
- fr.json: 143 keys ⚠ extra: about.bio_v2 (not in en.json — is this intentional?)

Want me to add stubs to de.json and ask the user about fr.json's extra key?
```

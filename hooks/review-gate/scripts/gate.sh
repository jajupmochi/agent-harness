#!/usr/bin/env bash
# review-gate / gate.sh  —  Stop hook.
# Before Claude is allowed to finish a turn that changed code, force (a) deterministic
# checks (ruff/shellcheck/...) to pass and (b) at least one structured self-review pass.
# Emits {"decision":"block","reason":...} to keep Claude working until satisfied.
#
# SAFETY (must not wedge the session):
#   - jq missing / any parse failure        -> exit 0 (allow stop)
#   - no tracked code changes this turn      -> exit 0
#   - after MAX_ROUNDS blocks                -> exit 0 with a stderr warning (fail-open)
set +e
command -v jq >/dev/null 2>&1 || exit 0
MAX_ROUNDS=3

IN="$(cat 2>/dev/null)"
sid="$(printf '%s' "$IN" | jq -r '.session_id // empty' 2>/dev/null)"
[ -n "$sid" ] || sid="nosess"

dir="$HOME/.claude/review-state"
log="$dir/$sid.changed"; rnd="$dir/$sid.rounds"; rev="$dir/$sid.reviewed"

# nothing tracked -> Claude likely answered a question / made no code edits -> allow stop
[ -s "$log" ] || exit 0

# unique, still-existing CODE files only
files="$(sort -u "$log" 2>/dev/null | while IFS= read -r f; do
  [ -f "$f" ] || continue
  case "$f" in
    *.py|*.js|*.jsx|*.ts|*.tsx|*.sh|*.bash|*.go|*.rs|*.java|*.rb|*.c|*.cc|*.cpp|*.h|*.hpp|*.lua|*.php) printf '%s\n' "$f" ;;
  esac
done)"
if [ -z "$files" ]; then : > "$log"; rm -f "$rnd" "$rev"; exit 0; fi   # only non-code changed

# loop guard: give up blocking after MAX_ROUNDS so a session can never be wedged
rounds="$(cat "$rnd" 2>/dev/null)"; case "$rounds" in ''|*[!0-9]*) rounds=0;; esac
if [ "$rounds" -ge "$MAX_ROUNDS" ]; then
  printf '[review-gate] max review rounds (%s) reached; allowing stop. Please review manually: %s\n' \
    "$MAX_ROUNDS" "$(printf '%s' "$files" | tr '\n' ' ')" >&2
  : > "$log"; rm -f "$rnd" "$rev"; exit 0
fi

# deterministic checks on the changed files (only with tools that exist)
errs=""
while IFS= read -r f; do
  [ -n "$f" ] || continue
  case "$f" in
    *.py)        command -v ruff       >/dev/null 2>&1 && { o="$(ruff check "$f" 2>&1)";        [ $? -ne 0 ] && errs="$errs
[ruff] $f:
$o"; } ;;
    *.sh|*.bash) command -v shellcheck >/dev/null 2>&1 && { o="$(shellcheck -S error "$f" 2>&1)"; [ $? -ne 0 ] && errs="$errs
[shellcheck] $f:
$o"; } ;;
  esac
done <<EOF
$files
EOF

flist="$(printf '%s' "$files" | tr '\n' ' ')"

# Block when checks fail OR a structured review pass hasn't happened yet for this change-set.
if [ -n "$errs" ] || [ ! -f "$rev" ]; then
  printf '%s' "$((rounds + 1))" > "$rnd"
  touch "$rev"
  reason="[review-gate] Code changed this turn ($flist). Before finishing, REVIEW it:
1) Correctness & logic — edge cases, off-by-one, error handling, the change actually does what was asked.
2) Security — injection, unsafe exec/eval, path/secret leaks, OWASP issues.
3) Fake-run / over-claims — for any \"it works / tests pass / results show X\" claim, invoke the code-verifier skill.
4) Tests & fit — adequate tests; matches surrounding codebase conventions."
  if [ -n "$errs" ]; then
    reason="$reason

DETERMINISTIC CHECKS FAILED — fix these first:$errs"
  fi
  reason="$reason

Fix what you find, then finish. (This gate runs every turn that changes code and will not be skipped.)"
  # Build valid JSON with a single jq pass (-R raw, -s slurp) so newlines in
  # $reason are properly escaped. Fail-open if jq somehow errors.
  printf '%s' "$reason" | jq -Rs '{decision:"block", reason:.}' 2>/dev/null || exit 0
  exit 0
fi

# clean AND already reviewed -> pass; clear state for the next change-set
: > "$log"; rm -f "$rnd" "$rev"
exit 0

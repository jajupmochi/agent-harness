#!/usr/bin/env bash
# review-gate / precommit.sh  —  PreToolUse(Bash) hook.
# Denies `git commit` / `git push` while this session has code changes that have NOT
# yet passed the Stop review gate. exit 2 = block, stderr -> Claude.
# Self-guards on the command text, so it is safe even if the settings `if:` filter
# is unsupported (older Claude Code): non-git commands always pass.
# Fail-open: jq missing / parse failure / no pending changes -> exit 0 (allow).
set +e
command -v jq >/dev/null 2>&1 || exit 0
IN="$(cat 2>/dev/null)"
cmd="$(printf '%s' "$IN" | jq -r '.tool_input.command // empty' 2>/dev/null)"
case "$cmd" in
  *"git commit"*|*"git push"*) : ;;   # only these are gated
  *) exit 0 ;;                          # any other command: allow
esac
sid="$(printf '%s' "$IN" | jq -r '.session_id // empty' 2>/dev/null)"
[ -n "$sid" ] || sid="nosess"
log="$HOME/.claude/review-state/$sid.changed"
if [ -s "$log" ]; then
  echo "[review-gate] Commit/push blocked: this turn's code changes have not passed the review gate yet. Finish the turn so the Stop review runs (it clears once review passes), then commit. Emergency override: rm $log" >&2
  exit 2
fi
exit 0

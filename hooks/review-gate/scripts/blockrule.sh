#!/usr/bin/env bash
# blockrule.sh — emit the exact rule line, or the whole opening, for a named block type.
#
# Why this exists: telling a model "fence the block with eight emoji" is an instruction it follows
# approximately, and the drift is always the same handful of shapes. Observed in the wild:
#   - a heading with no rule at all
#   - an emoji rule on top and a ━ bar underneath, both present
#   - the title line missing its `## ` so it renders as body text, not a heading
#   - a stray rule line with no block under it, left over from the previous block
# Formatting that must be identical every time should be GENERATED, not retyped. Same reason statsbar.sh
# exists.
#
# The emoji ALTERNATE WITHIN THE LINE — 🎉🥳🎉🥳🎉🥳🎉🥳 — not across turns. That is what makes the
# opening and closing rules identical strings by construction, so a mismatched pair is impossible and no
# counter or state file is needed.
#
# Titles vary per block ("进度报告", "进展 · 数据基础与三种模式", "状态"), so --title overrides the
# default while the emoji stay bound to the block TYPE.
#
#   blockrule.sh review                          # just the rule line
#   blockrule.sh review --heading                # rule, blank, `## <emoji> <title>`, blank, rule
#   blockrule.sh progress --heading --title "进展 · 数据基础与三种模式"
#   blockrule.sh done --heading
#
# The closing rule is the SAME command as the opening rule: `blockrule.sh <type>`.
set -uo pipefail

WIDTH="${BR_WIDTH:-8}"

type_name="${1:-}"
shift 2>/dev/null || true
heading=0
title_override=""
while [ $# -gt 0 ]; do
  case "$1" in
    --heading) heading=1; shift ;;
    --title)
      if [ $# -lt 2 ]; then printf 'blockrule: --title needs a value\n' >&2; exit 1; fi
      title_override="$2"; shift 2 ;;
    # Accepted and ignored: the closing rule is identical to the opening one, so callers that still
    # pass --close keep working instead of failing for asking about a distinction that no longer exists.
    --close) shift ;;
    *) printf 'blockrule: unknown argument: %s\n' "$1" >&2; exit 1 ;;
  esac
done

case "$type_name" in
  review)   set -- "👨🏻‍⚕️" "🔍" "👩🏻‍⚕️"; title="review-gate 审查" ;;
  progress) set -- "🚀" "🏎️";             title="进度报告" ;;
  decision) set -- "🔔" "⏰";              title="需要你决策" ;;
  done)     set -- "🎉" "🥳";              title="本轮完成" ;;
  "")       printf 'blockrule: a block type is required (review|progress|decision|done)\n' >&2; exit 1 ;;
  *)        printf 'blockrule: unknown block type %s (have: review, progress, decision, done)\n' "$type_name" >&2; exit 1 ;;
esac

[ -n "$title_override" ] && title="$title_override"

case "$WIDTH" in ''|*[!0-9]*) printf 'blockrule: BR_WIDTH must be a number\n' >&2; exit 1 ;; esac
[ "$WIDTH" -lt 1 ] && { printf 'blockrule: BR_WIDTH must be at least 1\n' >&2; exit 1; }

n=$#
rule=""
k=0
while [ "$k" -lt "$WIDTH" ]; do
  idx=$(( (k % n) + 1 ))
  rule="$rule${!idx}"
  k=$((k + 1))
done

# The heading always leads with the FIRST emoji of the type, so the type is recognisable from the title
# line alone even when the rule above it has scrolled off.
lead="$1"

if [ "$heading" -eq 1 ]; then
  printf '%s\n\n## %s %s\n\n%s\n' "$rule" "$lead" "$title" "$rule"
else
  printf '%s\n' "$rule"
fi

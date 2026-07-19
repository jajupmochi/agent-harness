#!/usr/bin/env bash
# Tests for blockrule.sh. Run: bash test_blockrule.sh
#
# Every check below corresponds to a drift shape actually observed in real output:
#   eg1  a heading with no rule at all, and a title the default did not cover
#   eg2  an emoji rule on top and a ━ bar underneath, both present
#   eg3  the title line missing its `## `, so it renders as body text
#   eg4  a stray rule line with no block under it
#   eg5  one block's closing rule butted against the next block's opening
# The design answer to eg4 and eg5 is that the opening and closing rules are the SAME string, produced by
# the same command, so a mismatched or orphaned pair cannot be produced by getting an argument wrong.
set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
BR="$HERE/blockrule.sh"
pass=0; fail=0
chk(){ if [ "$2" = "$3" ]; then echo "  ok: $1"; pass=$((pass+1)); else echo "  FAIL: $1 (got '$2' want '$3')"; fail=$((fail+1)); fi; }
chkTrue(){ if [ "$2" = "yes" ]; then echo "  ok: $1"; pass=$((pass+1)); else echo "  FAIL: $1"; fail=$((fail+1)); fi; }

# 1. Emoji alternate WITHIN the line, which is what was asked for: 🎉🥳🎉🥳…
chk "done alternates in-line"     "$(bash "$BR" done)"     "🎉🥳🎉🥳🎉🥳🎉🥳"
chk "decision alternates in-line" "$(bash "$BR" decision)" "🔔⏰🔔⏰🔔⏰🔔⏰"
chk "progress alternates in-line" "$(bash "$BR" progress)" "🚀🏎️🚀🏎️🚀🏎️🚀🏎️"
chk "review cycles its three"     "$(bash "$BR" review)"   "👨🏻‍⚕️🔍👩🏻‍⚕️👨🏻‍⚕️🔍👩🏻‍⚕️👨🏻‍⚕️🔍"

# 2. eg4/eg5: opening and closing rules are the same string, so a pair cannot mismatch. This is a
#    property of the design, not of remembering to pass the right flag.
for t in review progress decision done; do
  chk "$t open == close" "$(bash "$BR" $t)" "$(bash "$BR" $t)"
done
chk "the retired --close flag still returns the same rule" "$(bash "$BR" done --close)" "$(bash "$BR" done)"

# 3. Output is stateless — no counter file to drift, and repeated calls never change.
before="$(bash "$BR" review)"
for _ in 1 2 3 4 5; do bash "$BR" review >/dev/null; done
chk "stateless: unchanged after five calls" "$(bash "$BR" review)" "$before"
# The old design kept a per-type counter under BR_STATE_DIR. Prove none is written anywhere now —
# and look for the counter FILENAMES, not the substring "blockrule.", which also matches the scripts.
probe="$(mktemp -d)"
BR_STATE_DIR="$probe" bash "$BR" done >/dev/null
BR_STATE_DIR="$probe" bash "$BR" review --heading >/dev/null
chk "stateless: no counter file written" "$(find "$probe" -type f 2>/dev/null | wc -l)" "0"
rm -rf "$probe"

# 4. eg2: a ━ bar must never appear, in any type, in any mode.
out="$(for t in review progress decision done; do bash "$BR" $t; bash "$BR" $t --heading; done)"
chkTrue "no ━ bar anywhere in the output" "$(printf '%s' "$out" | grep -q '━' && echo no || echo yes)"

# 5. eg3: the title line is a real markdown heading, not body text.
h="$(bash "$BR" review --heading)"
chkTrue "title line starts with '## '" "$(printf '%s\n' "$h" | sed -n '3p' | grep -q '^## ' && echo yes || echo no)"
chkTrue "title line leads with the type's first emoji" "$(printf '%s\n' "$h" | sed -n '3p' | grep -q '^## 👨🏻‍⚕️ ' && echo yes || echo no)"

# 6. eg1: the heading always ships WITH its rules, and the title is overridable because titles vary.
chk "heading block is 5 lines" "$(bash "$BR" done --heading | wc -l)" "5"
chk "line 1 and line 5 are the same rule" \
    "$(bash "$BR" done --heading | sed -n '1p')" "$(bash "$BR" done --heading | sed -n '5p')"
chk "lines 2 and 4 are blank" \
    "$(bash "$BR" done --heading | sed -n '2p;4p' | tr -d '\n')" ""
custom="$(bash "$BR" progress --heading --title '进展 · 数据基础与三种模式')"
chkTrue "custom title is used" "$(printf '%s' "$custom" | grep -q '## 🚀 进展 · 数据基础与三种模式' && echo yes || echo no)"
chkTrue "custom title keeps the type's emoji" "$(printf '%s' "$custom" | grep -q '🚀🏎️🚀🏎️' && echo yes || echo no)"
chkTrue "a title with a space and a middle dot survives intact" \
    "$(printf '%s' "$custom" | grep -q '数据基础与三种模式' && echo yes || echo no)"
chk "default title is used when --title is absent" \
    "$(bash "$BR" done --heading | sed -n '3p')" "## 🎉 本轮完成"

# 7. Width is configurable and the alternation still holds at the boundary.
chk "BR_WIDTH=4" "$(BR_WIDTH=4 bash "$BR" done)" "🎉🥳🎉🥳"
chk "BR_WIDTH=1 yields just the lead emoji" "$(BR_WIDTH=1 bash "$BR" done)" "🎉"
chk "an odd width ends mid-cycle rather than padding" "$(BR_WIDTH=3 bash "$BR" done)" "🎉🥳🎉"

# 8. Bad input is refused with a reason rather than emitting a wrong rule silently.
bash "$BR" nope >/dev/null 2>&1;            chk "unknown type exits 1" "$?" "1"
bash "$BR" >/dev/null 2>&1;                 chk "missing type exits 1" "$?" "1"
bash "$BR" done --sideways >/dev/null 2>&1; chk "unknown flag exits 1" "$?" "1"
bash "$BR" done --title >/dev/null 2>&1;    chk "--title with no value exits 1" "$?" "1"
BR_WIDTH=x bash "$BR" done >/dev/null 2>&1; chk "non-numeric BR_WIDTH exits 1" "$?" "1"
BR_WIDTH=0 bash "$BR" done >/dev/null 2>&1; chk "BR_WIDTH=0 exits 1" "$?" "1"
# Capture before matching: under `set -o pipefail` a pipeline whose PRODUCER exits non-zero returns
# non-zero regardless of whether grep matched, which would silently discard a passing check.
errtext="$(bash "$BR" nope 2>&1 || true)"
case "$errtext" in *"have: review, progress, decision, done"*) r=yes ;; *) r=no ;; esac
chkTrue "the error lists the valid types" "$r"

echo
if [ "$fail" -eq 0 ]; then echo "blockrule.sh: all $pass checks PASS"; else echo "blockrule.sh: $fail FAIL / $pass pass"; fi
[ "$fail" -eq 0 ]

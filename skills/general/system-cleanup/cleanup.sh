#!/usr/bin/env bash
# system-cleanup — interactive, phased disk cleanup for Ubuntu/Debian.
# Run in YOUR OWN terminal (NOT inside Claude Code), so sudo can prompt:
#     bash cleanup.sh
# Every item shows its size and asks y/N before deleting. Nothing is forced.
set -uo pipefail

ask() { read -r -p "  delete this (~$1)? [y/N] " a; [[ "$a" =~ ^[Yy]$ ]]; }
sz()  { du -sh "$@" 2>/dev/null | awk '{s=$1} END{print s?s:"0"}'; }

echo "=== disk before ==="; df -h / | awk 'NR==1||/\/$/'

echo; echo "### Phase 1 — user-level caches (no sudo) ###"
WS=~/.config/Code/WebStorage
[ -d "$WS" ]            && { echo "VS Code WebStorage ($(sz "$WS"))";          ask "$(sz "$WS")"          && rm -rf "$WS"/*/CacheStorage && echo "  cleared"; }
[ -d ~/.cache ]        && { echo "~/.cache ($(sz ~/.cache))";                 ask "$(sz ~/.cache)"       && rm -rf ~/.cache/* && echo "  cleared"; }
command -v npm >/dev/null && { echo "npm cache";                              ask "npm cache"            && npm cache clean --force >/dev/null 2>&1 && echo "  cleared"; }
[ -d ~/.config/Code/CachedExtensionVSIXs ] && { echo "VS Code ext VSIX + Cache"; ask "VS Code caches" && rm -rf ~/.config/Code/CachedExtensionVSIXs ~/.config/Code/Cache && echo "  cleared"; }
[ -d ~/.local/share/Trash ] && { echo "Trash ($(sz ~/.local/share/Trash))";  ask "$(sz ~/.local/share/Trash)" && rm -rf ~/.local/share/Trash/* && echo "  emptied"; }

echo; echo "### Phase 2 — system (sudo) ###"
if sudo -v 2>/dev/null; then
  echo "old kernels + orphaned deps (review the list!)"; ask "apt autoremove" && sudo apt-get autoremove --purge
  echo "apt archive cache";                              ask "apt clean"      && sudo apt-get clean
  echo "journal logs > 200M";                            ask "journal vacuum" && sudo journalctl --vacuum-size=200M
  echo "disabled snap revisions:"; snap list --all 2>/dev/null | awk '/disabled/{print "   "$1" r"$3}'
  ask "remove disabled snap revisions" && snap list --all 2>/dev/null | awk '/disabled/{print $1, $3}' | while read -r n r; do sudo snap remove "$n" --revision="$r"; done
else
  echo "  (no sudo available — skipping Phase 2; run these yourself)"
fi

echo; echo "### Phase 3 — Docker (if installed) ###"
if command -v docker >/dev/null; then
  docker system df 2>/dev/null
  ask "docker system prune (dangling images + build cache; keeps named volumes)" && docker system prune -f
fi

echo; echo "=== disk after ==="; df -h / | awk '/\/$/'

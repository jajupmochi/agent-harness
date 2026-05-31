---
name: system-cleanup
description: Use when a Linux disk is filling up or the user asks to free space / clean the system / "系统盘满了" / move large files off the system disk. Diagnose where the space went (df / du / dpkg / snap / docker), then give a prioritized, risk-tagged plan — do safe user-level deletions, and LIST the sudo items for the user to run (default to advise-then-confirm; this kind of box often has no passwordless sudo, so use pkexec or hand over the commands). Covers the VS Code WebStorage PDF-cache bloat bug, old-kernel pile-up, snap/journal/apt/docker caches, and NTFS data-disk write failures.
---

# /system-cleanup

**Diagnose → report (prioritized + risk-tagged) → let the user run anything destructive or sudo.** Default posture is *advise, don't auto-delete* unless the user says go. Never delete something you didn't identify; never assume passwordless sudo.

## Master TOC

- [When to use](#when-to-use)
- [Step 1 — diagnose where the space went](#step-1--diagnose-where-the-space-went)
- [Step 2 — the usual suspects](#step-2--the-usual-suspects)
- [Step 3 — safe cleanup (no sudo)](#step-3--safe-cleanup-no-sudo)
- [Step 4 — sudo cleanup (hand to the user)](#step-4--sudo-cleanup-hand-to-the-user)
- [Special: VS Code WebStorage bloat (the 31 GB trap)](#special-vs-code-webstorage-bloat-the-31-gb-trap)
- [Special: NTFS data disk won't write / mount](#special-ntfs-data-disk-wont-write--mount)
- [A phased interactive script](#a-phased-interactive-script)
- [Cautions](#cautions)

## When to use

`df` shows the system/root disk past ~85%; the user says space is low, wants to know what to delete / move, or a second disk won't accept writes. Trigger on `/system-cleanup` or auto when the user describes a full disk.

## Step 1 — diagnose where the space went

Read-only. Run these first and report the picture before touching anything:

```bash
df -h /                                            # how full is the system disk
du -h --max-depth=1 ~ 2>/dev/null | sort -hr | head -20   # biggest things in $HOME
sudo du -h --max-depth=1 / 2>/dev/null | sort -hr | head -20   # biggest top-level dirs (/snap /usr /var …)
dpkg-query -W -f='${Installed-Size}\t${Package}\n' | sort -rn | head -20 | awk '{printf "%.0fM\t%s\n",$1/1024,$2}'  # biggest pkgs
du -sh /usr/lib/modules/*/ 2>/dev/null | sort -hr  # kernels (see "old kernels" below)
snap list --all 2>/dev/null                        # snap revisions (disabled = removable)
docker system df 2>/dev/null                        # docker images/containers/volumes/cache
lsblk -f ; df -h                                   # all disks + filesystems (for the data-disk case)
```

## Step 2 — the usual suspects

Real sizes seen on this user's Ubuntu box (2026-05) — good priors:

| Target | Typical / seen | Risk | Notes |
|---|---|---|---|
| **VS Code `~/.config/Code/WebStorage`** | **31 GB** | low | PDF/webview preview cache bloat — see special section. Biggest single win. |
| `~/.cache/*` | ~4 GB | low | regenerated on demand |
| npm cache | ~3 GB | low | `npm cache clean --force` |
| VS Code `CachedExtensionVSIXs` + `Cache` | ~1.4 GB | low | re-downloaded if needed |
| Trash `~/.local/share/Trash` | varies | low | the user's deleted files — confirm |
| **Old kernels** `/usr/lib/modules` | 28 versions seen! | med (sudo) | keep current + 1; `apt autoremove` |
| `/snap` old revisions | ~40 GB | med (sudo) | `snap list --all`; remove `disabled` revisions |
| `/var/log` journal | varies | low (sudo) | `journalctl --vacuum-size=200M` |
| apt archive cache | varies | low (sudo) | `apt clean` |
| Docker dangling images/volumes | varies | med | `docker system prune` (asks) — never auto-prune named volumes |

## Step 3 — safe cleanup (no sudo)

User-level, reversible-ish (caches regenerate). Confirm Trash with the user first.

```bash
rm -rf ~/.config/Code/WebStorage/*/CacheStorage   # the big VS Code cache (keeps settings/auth)
rm -rf ~/.cache/*                                  # user cache
npm cache clean --force 2>/dev/null
rm -rf ~/.config/Code/CachedExtensionVSIXs ~/.config/Code/Cache
# rm -rf ~/.local/share/Trash/*                    # only after confirming with the user
fc-cache -f ; rm -rf ~/.cache/thumbnails/*         # optional: font/thumbnail caches
```

GitHub/Copilot auth is in `~/.config/Code/User/globalStorage/`, NOT WebStorage — so clearing WebStorage does **not** log you out.

## Step 4 — sudo cleanup (hand to the user)

This machine has **no passwordless sudo** — do NOT try to run these yourself in a non-interactive tool call. Either hand the user the block to run in their terminal, or use `pkexec bash <script>` when they're present (a GUI password dialog appears).

```bash
sudo apt autoremove --purge      # old kernels + orphaned deps (review the list first!)
sudo apt clean                   # apt archive cache
sudo journalctl --vacuum-size=200M
# snap: remove disabled (old) revisions
snap list --all | awk '/disabled/{print $1, $3}' | while read n r; do sudo snap remove "$n" --revision="$r"; done
docker system prune              # dangling images + build cache (interactive)
```

⚠️ `apt autoremove` can also pull packages you want — **always read the to-be-removed list**. Keep at least the running kernel (`uname -r`) and one previous.

## Special: VS Code WebStorage bloat (the 31 GB trap)

`~/.config/Code/WebStorage/<n>/CacheStorage` accumulates a **`vscode-resource-cache`** entry every time you preview a PDF/image/HTML inside VS Code, and never cleans it — a single previewed PDF was cached as 3000+ fragments. Known VS Code bug (GitHub issue #166632); no official setting caps it. Fix = periodically `rm -rf ~/.config/Code/WebStorage` (restart VS Code; settings/extensions/auth unaffected) or schedule the phased script below.

## Special: NTFS data disk won't write / mount

If a second (NTFS) disk is read-only or rejects writes:

```bash
mount | grep -i <mountpoint>                       # is it mounted ro?
sudo dmesg | grep -i ntfs | tail -20               # the real reason
```

Usual cause: the NTFS volume has the **Windows "dirty"/hibernation flag** (fast-startup/hibernate left it unclean), so Linux mounts it read-only to protect it. Fixes: in Windows, fully shut down (disable Fast Startup) or `chkdsk`; or from Linux `sudo ntfsfix /dev/sdXN` then remount; ensure `ntfs-3g` is installed. Don't force-write a dirty NTFS volume — that risks the data.

## A phased interactive script

Ship a `cleanup.sh` (in this skill folder) that the user runs **in their own terminal** (not inside Claude Code, so sudo can prompt). Three phases, each item shows its size and asks `y/N`:

1. **Phase 1 (no sudo)** — VS Code WebStorage, `~/.cache`, npm, Trash.
2. **Phase 2 (sudo)** — snap old revisions, old kernels (`apt autoremove`), `apt clean`, journal vacuum.
3. **Phase 3** — Docker dangling images/build cache.

## Cautions

- **Advise first.** This user explicitly prefers "tell me how, let me run it" for destructive/sudo steps — honor that unless they say "just do it".
- **Never** `rm -rf` a path you haven't `du`/`ls`-inspected this session.
- Don't purge Docker **named** volumes or `~/.config/.../globalStorage` (auth/state).
- `apt autoremove`: read the removal list; protect the running kernel.

## Provenance

Distilled from a real disk-cleanup session on the author's Ubuntu box (system disk 91% → freed ~41 GB: 31 GB VS Code WebStorage + ~9 GB caches, then sudo kernels/snap) plus the fcitx5-migration session's `ibus-libpinyin` / `apt autoremove` cleanup. Generalised for cross-project reuse.

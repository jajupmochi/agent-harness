# Reference: apt Packages

> Knowledge table of `apt`-installed packages on the author's system. **NEVER auto-install.** Always ask the user before running `sudo apt install ...`. This file exists so an agent knows these tools are options.

## Master TOC

- [Agent rule](#agent-rule)
- [Multimedia / graphics](#multimedia--graphics)
- [PDF / TeX](#pdf--tex)
- [Build / compile](#build--compile)
- [GPU / system](#gpu--system)
- [Filesystem / network](#filesystem--network)
- [Python infrastructure](#python-infrastructure)
- [Misc](#misc)

## Agent rule

**Never run `sudo apt install ...` without explicit user approval.** When a task needs one of these packages:

1. Identify which package(s) are needed
2. Ask the user: "需要 `<package-name>` 来 `<purpose>` — 要安装吗？(`sudo apt install <pkg>`)"
3. Only after user says yes, run the install command

This rule overrides `tool-proactivity` for system-package installs (apt is destructive; affects whole machine).

## Multimedia / graphics

| Package | Purpose |
|---|---|
| `ffmpeg` | Video → gif, audio/video conversion, streams |
| `inkscape`, `inkscape-textext` | Vector graphics editor |
| `krita` | Raster painting / digital art |
| `pinta` | Lightweight image editor |
| `gpick` | Color picker |
| `graphviz` + `graphviz-dev` | DOT graph rendering |
| `font-manager` | Font management GUI |
| `gnome-sound-recorder`, `gnome-media` | GNOME multimedia utilities |

## PDF / TeX

| Package | Purpose |
|---|---|
| `pdfarranger` | Rearrange / merge / split PDFs (GUI) |
| `pdfjam` | Merge PDFs, extract pages (CLI) |
| `pdftk-java` | Encrypt / decrypt / rotate / split PDFs |
| `qphotorec` | Recover deleted files |
| `img2pdf` | Convert images → PDF |
| `latexmk` | LaTeX build orchestration |
| `texlive` | Full TeX distribution |
| `pstoedit` | PostScript → other formats |

## Build / compile

| Package | Purpose |
|---|---|
| `gcc`, `g++` | GNU C/C++ compilers |
| `clang` | LLVM-based C/C++ compiler |
| `make`, `cmake` | Build automation |
| `binutils` | Binary utilities (ld, ar, etc.) |
| `bison`, `flex` | Parser generators |
| `pkg-config` | Lib config helper |

## GPU / system

| Package | Purpose |
|---|---|
| `nvidia-driver-<ver>` | NVIDIA GPU driver (version-specific; check `ubuntu-drivers devices` before installing) |
| `nvidia-utils-<ver>` | NVIDIA utilities |
| `nvtop` | TUI GPU monitor |
| `intel-gpu-tools` | Intel GPU monitoring |

## Filesystem / network

| Package | Purpose |
|---|---|
| `ntfs-3g` | NTFS read/write |
| `exfat-fuse`, `exfat-utils` | exFAT support |
| `openssh-server` | SSH server |
| `net-tools` | Classic network utilities (ifconfig, route, etc.) |

## Python infrastructure

| Package | Purpose |
|---|---|
| `python3.12`, `python3.12-venv` | Python 3.12 + venv |
| `python3.11-venv`, `python3.8-tk` | Other Python versions |
| `python3-tk`, `python3-matplotlib-tk` | Tkinter for matplotlib |
| `pyqt6`, `pyqt6-dev`, `pyqt6-dev-tools` | Qt6 Python bindings |

## Misc

| Package | Purpose |
|---|---|
| `flatpak` | Universal package manager |
| `mpich`, `mpich-devel` | MPI distributed compute |
| `gnome-tweaks`, `gnome-shell-extension-desktop-icons-ng` | GNOME desktop customization |

## Skipped (privacy / environment-specific)

These exist on the author's system but are **NOT** in this reference because they're either privacy-sensitive or not portable recommendations:

- VPN clients (`openvpn`, `openfortivpn`, `forticlient`)
- Remote access (`tightvncserver`)
- Input methods (`fcitx`, `fcitx5-*` — Chinese input; environment-specific)
- Desktop packages (`gnome-shell`, `ubuntu-desktop`, etc.)

If a task genuinely needs one of these, the agent should ask the user explicitly with full context — they're tied to the user's specific machine setup, not a portable recommendation.

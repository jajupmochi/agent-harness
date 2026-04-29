# Image + Video + PDF Processing

> Tools for image / video / PDF / SVG processing. **Context:** `image-or-video-work`.

## Master TOC

- [Image processing](#image-processing)
- [SVG optimization](#svg-optimization)
- [Video processing](#video-processing)
- [PDF tools](#pdf-tools)
- [Headless screenshots](#headless-screenshots)

## Image processing

| Tool | When to use | Install |
|---|---|---|
| `sharp` | Fast Node image processing (resize, format convert, optimize). Significantly faster than imagemin | `npm i sharp` |
| `imagemin` (CLI) | Slower than sharp but supports many formats via plugins | `npm i -g imagemin-cli` |

**Decision**: prefer `sharp` for new projects. `imagemin` only when a sharp doesn't have the format/plugin you need.

## SVG optimization

| Tool | When to use | Install |
|---|---|---|
| `svgo` | SVG optimization (strip metadata, simplify paths) | `npx svgo <file>` (no install) or `npm i -g svgo` |

**Decision**: prefer `npx svgo` for one-shot use. Install globally only if you'll use it daily.

## Video processing

`ffmpeg` is the workhorse. **Apt-installed** (see [reference/apt-packages.md](reference/apt-packages.md)) — agent must ask before installing.

```bash
sudo apt install ffmpeg   # only after user approval
# or:
brew install ffmpeg       # macOS
```

**Common workflows**:

```bash
# Video → GIF (with palette for quality)
ffmpeg -i demo.mp4 -vf "fps=10,scale=800:-1:flags=lanczos,palettegen" palette.png
ffmpeg -i demo.mp4 -i palette.png -filter_complex "fps=10,scale=800:-1:flags=lanczos[x];[x][1:v]paletteuse" demo.gif

# Trim
ffmpeg -i input.mp4 -ss 00:00:10 -to 00:00:30 -c copy clip.mp4

# Compress
ffmpeg -i input.mp4 -vcodec libx264 -crf 28 output.mp4
```

## PDF tools

Apt-installed (see [reference/apt-packages.md](reference/apt-packages.md)):

| Tool | Purpose |
|---|---|
| `pdfarranger` | GUI: rearrange / merge / split PDF pages |
| `pdfjam` | CLI: merge PDFs, extract pages |
| `pdftk-java` | Manipulate PDFs (encrypt, decrypt, rotate, split) |
| `img2pdf` | Convert images → PDF |
| `qphotorec` | Recover deleted files (incl. PDFs) |

For programmatic PDF generation (Python), use:

- `reportlab` — PDF generation in Python
- `pypdf` (formerly PyPDF2) — read / write / merge

```bash
uv pip install reportlab pypdf   # project-local
```

## Headless screenshots

For automating "open URL → screenshot":

| Tool | When to use | Install |
|---|---|---|
| `puppeteer` | Node-side headless Chrome | `npx puppeteer` or `npm i puppeteer --no-save` |
| `playwright` | Node-side, multi-browser | `npm i -D @playwright/test && npx playwright install` |
| `chrome-devtools` MCP plugin | CC-native screenshots via MCP — preferred for in-conversation use | `/plugin install chrome-devtools-mcp@claude-plugins-official` |

**Decision**: use chrome-devtools MCP for in-conversation screenshots. Use puppeteer / playwright for build-time / scheduled screenshots.

## Companion

- [reference/apt-packages.md](reference/apt-packages.md) — full list of apt packages including ffmpeg, inkscape, krita, etc. Never auto-install.

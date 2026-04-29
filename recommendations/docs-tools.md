# Documentation Tools

> Documentation generators and toolchains. **Context:** `docs-site`.

## Master TOC

- [MkDocs (canonical for the author)](#mkdocs-canonical-for-the-author)
- [Sphinx (Python alternative)](#sphinx-python-alternative)
- [VitePress / Docusaurus (JS alternatives)](#vitepress--docusaurus-js-alternatives)
- [LaTeX](#latex)

## MkDocs (canonical for the author)

| Tool | Purpose | Install |
|---|---|---|
| `mkdocs` | Markdown → HTML site generator | `uv pip install mkdocs` (project-local) |
| `mkdocs-material` | Material-themed extension (canonical theme) | `uv pip install mkdocs-material` |
| `ghp-import` | Push `_site/` to `gh-pages` branch (used by `mkdocs gh-deploy`) | bundled with mkdocs |

**Bundled install:**

```bash
uv pip install mkdocs mkdocs-material
```

**Common commands:**

```bash
mkdocs serve     # http://127.0.0.1:8000/
mkdocs build     # generate _site/
mkdocs gh-deploy # push to gh-pages
```

**Used in**: `<research-pkg-A>/mkdocs.yml`, `<research-pkg-B>/mkdocs.yml`. Both projects use the Material theme.

## Sphinx (Python alternative)

When you need RST instead of Markdown, or autodoc from Python source:

```bash
uv pip install sphinx furo  # furo is a popular theme
```

**Use case**: scientific Python packages with heavy `autodoc` use. MkDocs is preferred for general docs.

## VitePress / Docusaurus (JS alternatives)

For JS/TS-heavy projects where Python toolchain feels foreign:

```bash
# VitePress (Vite-based, fast)
npm i -D vitepress

# Docusaurus (React-based, feature-rich)
npx create-docusaurus@latest my-website classic
```

**Decision**: prefer MkDocs for Python projects (toolchain alignment). VitePress for Node projects. Docusaurus when you need versioned docs + i18n out of the box.

## LaTeX

For paper / preprint generation. **Apt-installed** (see [reference/apt-packages.md](reference/apt-packages.md)):

| Tool | Purpose | Install |
|---|---|---|
| `texlive` | Full TeX distribution | `sudo apt install texlive` (ask user first) |
| `latexmk` | LaTeX build orchestration | `sudo apt install latexmk` |
| `pstoedit` | PostScript → other formats | `sudo apt install pstoedit` |

**Bundled install (only after user approval):**

```bash
sudo apt-get install texlive pstoedit latexmk
```

**Pair with**: `ml-paper-writing` skills under `recommendations/orchestra-ml-skills.md` for ML paper templates (NeurIPS, ICML, ICLR, ACL, etc.).

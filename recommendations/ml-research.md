# ML Research / Data Tools

> Python tools for ML research, HF Hub workflows, GPU monitoring, data acquisition. **Context:** `ml-research`.

## Master TOC

- [HuggingFace ecosystem](#huggingface-ecosystem)
- [Experiment tracking platforms](#experiment-tracking-platforms)
- [GPU / system monitoring](#gpu--system-monitoring)
- [Visualization](#visualization)
- [Web scraping / browser automation](#web-scraping--browser-automation)
- [Niche / domain-specific](#niche--domain-specific)
- [Companion](#companion)

## HuggingFace ecosystem

| Tool | Purpose | Install |
|---|---|---|
| `huggingface_hub[cli]` (`hf` / `huggingface-cli`) | HF Hub login, download, upload | `uv tool install huggingface-hub` (or `uv pip install -U "huggingface_hub[cli]"`) |
| `datasets` | HF datasets library | `uv pip install datasets` (project-local) |
| `transformers` | HF Transformers (model classes) | `uv pip install transformers` (project-local) |
| `accelerate` | HF Accelerate (distributed training) | `uv pip install accelerate` (or skill-based; see orchestra-ml-skills.md) |

**Pair with**: `huggingface-skills@claude-plugins-official` (see [cc-plugins.md](cc-plugins.md)) for HF-aware workflows.

## Experiment tracking platforms

For tracking runs, hyperparameter searches, model artifacts, and data versions. Pick one (they overlap heavily):

| Platform | When to choose | Install |
|---|---|---|
| **MLflow** | Open-source, self-hostable, broad coverage (tracking, models, projects, model registry). Pip-installable, works locally without an account | `uv pip install mlflow` (see [mlflow.org/docs](https://mlflow.org/docs/latest/ml/)) |
| **Weights & Biases** (`wandb`) | Best-in-class UI for tracking + dashboards; free for personal / academic use; hosted (login required) | `uv pip install wandb` then `wandb login` |
| **ClearML** | Open-source + hosted; strong on HPO, model registry, data versioning; pip-installable | `uv pip install clearml` (see [clear.ml/docs](https://clear.ml/docs/latest/docs/)) |

**Decision**:

- "Just want to log scalars + see a dashboard quickly" → `wandb`
- "Need self-hosted + no third-party deps" → `mlflow`
- "Want HPO + data versioning + serving + model registry, all in one" → `clearml`

All three plug into PyTorch / Lightning / HuggingFace Trainer via small adapters.

**Pair with**: `orchestra-ml-skills.md` (in this lib) §13 mlops bucket — has dedicated skills (`mlflow`, `weights-and-biases`, `swanlab`, `tensorboard`) for deeper guidance per platform.

## GPU / system monitoring

| Tool | Purpose | Install |
|---|---|---|
| `gpustat` | Compact `nvidia-smi` alternative | `uv tool install gpustat` |
| `nvtop` | TUI GPU monitor | `sudo apt install nvtop` (ask user first) |
| `intel-gpu-tools` | Intel GPU monitoring | `sudo apt install intel-gpu-tools` (ask user first) |

**Pair with**: NVIDIA driver packages — see [reference/apt-packages.md](reference/apt-packages.md). Driver install is OS-specific and should always go through the user.

## Visualization

| Tool | Purpose | Install |
|---|---|---|
| `matplotlib` | Standard plotting | `uv pip install matplotlib` |
| `plotly` | Interactive charts | `uv pip install plotly` |
| `kaleido` | Plotly static image export (figure generation for papers) | `uv pip install kaleido` |
| `seaborn` | Statistical visualization | `uv pip install seaborn` |

**Pair with**: `academic-plotting` skill under `recommendations/orchestra-ml-skills.md` for publication-quality figure templates.

## Web scraping / browser automation

For data collection workflows:

| Tool | Purpose | Install |
|---|---|---|
| `selenium` | Cross-browser automation (Python) | `uv pip install selenium` |
| `webdriver-manager` | Auto-manage browser drivers | `uv pip install webdriver-manager` |
| `pyppeteer` | Python port of Puppeteer (headless Chrome) | `uv pip install pyppeteer` |
| `playwright` | Multi-browser, faster than selenium | `uv pip install playwright && playwright install` |

**Decision**: prefer `playwright` for new projects (faster, more reliable). `selenium + webdriver-manager` for legacy compat.

## Niche / domain-specific

| Tool | Purpose | Context |
|---|---|---|
| `pyega3` | EGA (European Genome-Phenome Archive) client | `optional` (genomics) |
| `keyring` | Cross-platform credential storage | `optional` |

## Companion

- [orchestra-ml-skills.md](orchestra-ml-skills.md) — 21-category index of the author's curated ML research skill stack (`0-autoresearch-skill` meta-orchestrator, fine-tuning, distributed training, evaluation, RAG, etc.)
- [docs-tools.md](docs-tools.md) — MkDocs for research docs; LaTeX for papers
- [cc-plugins.md](cc-plugins.md) §"Specialized" — `huggingface-skills` plugin

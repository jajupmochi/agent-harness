# Orchestra ML Skills

> 21-category ML research skill stack from the author's local `~/.orchestra/skills/` collection, plus a **meta-orchestrator** (`0-autoresearch-skill`) for autonomous research projects. **Context:** `ml-research`.

## Master TOC

- [Meta-orchestrator: autoresearch](#meta-orchestrator-autoresearch)
- [21 sub-categories](#21-sub-categories)
- [Install](#install)
- [Usage](#usage)

## Meta-orchestrator: autoresearch

`0-autoresearch-skill` (frontmatter `name: autoresearch`, author: Orchestra Research) — **Two-loop architecture for autonomous research projects**:

- **Inner loop**: rapid experiment iterations with clear optimization targets
- **Outer loop**: synthesizes results, identifies patterns, steers research direction
- Routes to domain-specific skills (in the categories below) for execution
- Supports continuous agent operation via Claude Code `/loop` and OpenClaw heartbeat
- Produces research presentations and papers

**Use when**: starting a research project, running autonomous experiments, or managing a multi-hypothesis effort.

```
/0-autoresearch-skill
# or invoke programmatically via Skill tool
```

## 21 sub-categories

Each category contains multiple specialized skills. The list below indexes the category and notable skills inside.

| # | Category | Notable skills |
|---|---|---|
| 01 | model-architecture | `nanogpt`, `mamba`, `rwkv`, `litgpt` |
| 02 | tokenization | `sentencepiece`, `huggingface-tokenizers` |
| 03 | fine-tuning | `axolotl`, `llama-factory`, `trl-fine-tuning`, `peft`, `unsloth`, `simpo` |
| 04 | mechanistic-interpretability | `transformer-lens`, `nnsight`, `pyvene`, `saelens` |
| 05 | data-processing | `nemo-curator`, `ray-data` |
| 06 | post-training | `grpo-rl-training`, `openrlhf`, `slime`, `miles`, `verl`, `torchforge` |
| 07 | safety-alignment | `constitutional-ai`, `llamaguard`, `prompt-guard`, `nemo-guardrails` |
| 08 | distributed-training | `accelerate`, `deepspeed`, `megatron-core`, `pytorch-fsdp2`, `pytorch-lightning`, `ray-train`, `torchtitan` |
| 09 | infrastructure | `modal`, `lambda-labs`, `skypilot` |
| 10 | optimization | `awq`, `bitsandbytes`, `flash-attention`, `gguf`, `gptq`, `hqq`, `knowledge-distillation`, `model-pruning`, `speculative-decoding` |
| 11 | evaluation | `bigcode-evaluation-harness`, `lm-evaluation-harness`, `nemo-evaluator` |
| 12 | inference-serving | `llama-cpp`, `sglang`, `tensorrt-llm`, `vllm` |
| 13 | mlops | `mlflow`, `swanlab`, `tensorboard`, `weights-and-biases` |
| 14 | agents | `autogpt`, `crewai`, `dspy`, `langchain`, `langsmith`, `a-evolve` |
| 15 | rag | `chroma`, `faiss`, `pinecone`, `qdrant`, `llamaindex`, `sentence-transformers` |
| 16 | prompt-engineering | `guidance`, `instructor`, `outlines` |
| 17 | observability | `phoenix`, `langsmith` |
| 18 | multimodal | `audiocraft`, `blip-2`, `clip`, `llava`, `segment-anything`, `stable-diffusion`, `whisper` |
| 19 | emerging-techniques | `long-context`, `moe-training` |
| 20 | ml-paper-writing | `academic-plotting`, `ml-paper-writing`, `presenting-conference-talks`, `systems-paper-writing` |
| 21 | research-ideation | `brainstorming-research-ideas`, `creative-thinking-for-news` |

## Install

⚠️ **The orchestra repo URL is currently undocumented in this lib.** Confirm with the author before reproducing.

Likely setup:

```bash
git clone <orchestra-skills-repo-url> ~/.orchestra
# Then symlink the skills directory into ~/.claude/skills/:
for skill in ~/.orchestra/skills/0-autoresearch-skill ~/.orchestra/skills/*/*; do
  ln -s "$skill" "$HOME/.claude/skills/$(basename $skill)"
done
```

Replace `<orchestra-skills-repo-url>` with the canonical orchestra-skills source. **The author should fill this in when promoting this lib to public.**

## Usage

Once installed, all 100+ skills appear as `/<skill-name>` slash commands in Claude Code. Examples:

```
/0-autoresearch-skill                     # entry point
/accelerate                                # PyTorch distributed training helper
/vllm                                      # high-throughput inference serving
/mlflow                                    # experiment tracking
/lm-evaluation-harness                     # benchmark eval
/brainstorming-research-ideas              # research ideation
/ml-paper-writing                          # paper drafting (NeurIPS, ICML, etc.)
```

The meta-orchestrator routes to these as needed — typically you only need to invoke `/0-autoresearch-skill` and let it dispatch.

## Companion

- [ml-research.md](ml-research.md) — Python tools (uv-installed CLIs and libs)
- [cc-plugins.md](cc-plugins.md) §"Specialized" — `huggingface-skills@claude-plugins-official` plugin (HF-specific workflows; complementary to orchestra)

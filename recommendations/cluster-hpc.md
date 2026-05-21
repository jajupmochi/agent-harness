# Cluster / HPC

> Patterns for working with HPC clusters via SLURM. **Context:** `optional` — only when the user has confirmed cluster access. Always ask before submitting jobs (cluster credits cost real money, even on free tiers).

## Master TOC

- [When to use these patterns](#when-to-use-these-patterns)
- [SLURM essentials](#slurm-essentials)
- [Reference SLURM script](#reference-slurm-script)
- [Free-tier / shared-cluster rules](#free-tier--shared-cluster-rules)
- [Cluster ↔ local sync convention](#cluster--local-sync-convention)
- [Job-launch hygiene](#job-launch-hygiene)
- [Common partitions and what they're for](#common-partitions-and-what-theyre-for)
- [Companion](#companion)

## When to use these patterns

Confirm with the user BEFORE submitting any job:

- Has the user signed off on the specific cluster + account / qos for THIS project?
- Is the project's `CLAUDE.md` (or `~/.claude/CLAUDE.md`) already documenting the cluster credentials and rules?
- Is this an interactive job or a batch submission?

If unsure: ask. Cluster credits are real, even on free tiers.

## SLURM essentials

Submit a job with an inline heredoc:

```bash
sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=<your-project>-<job-name>
#SBATCH --account=<your-account>
#SBATCH --qos=<your-qos>
#SBATCH --partition=<partition>
#SBATCH --time=12:00:00
#SBATCH --gres=gpu:rtx4090:1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=<your-email>
#SBATCH --output=outputs/<project>.<jobname>.o%j
#SBATCH --error=errors/<project>.<jobname>.e%j

module load Python/3.12.3-GCCcore-13.3.0
source .venv/bin/activate

python -m my_module --config configs/job.yaml
EOF
```

Inspect the queue:

```bash
squeue -u $USER            # your jobs
squeue -p <partition>       # all jobs in a partition
sacct -X --format=JobID,JobName,State,Elapsed,MaxRSS,ReqGRES -j <jobid>  # post-mortem
```

## Reference SLURM script

Most projects with cluster access keep a canonical reference SLURM script in the repo:

```
jobs/reference_run_jobs_on_<cluster-name>.py
```

This is the canonical pattern — copy-adapt rather than inventing new `--partition` / `--qos` lines. Treat the reference as authoritative; deviations need justification.

## Free-tier / shared-cluster rules

Most academic clusters have a free/gratis tier with stricter limits. When in free tier:

- **Always** set the gratis account + qos (e.g., `--account=gratis --qos=job_gratis`) per the cluster's documentation. Other accounts may consume the user's paid budget.
- **Hard cap per job** typically 1-2 GPUs (RTX 4090 / A100 / H100 depending on cluster). Check the cluster's docs.
- **Wall-time limits** apply per partition (most are 24h-72h on gratis). Design jobs to checkpoint and re-queue rather than fight the limit.
- **Memory**: `--mem-per-cpu=10G` is a sane default; `--cpus-per-task=4` per RTX4090 GPU is typical.
- **Modules**: load Python via `module load Python/3.X-...` (the cluster will tell you the exact incantation).

## Cluster ↔ local sync convention

Develop locally; sync to cluster with `rsync` (excluding heavy / transient artifacts):

```bash
rsync -avzP \
  --exclude='.venv/' \
  --exclude='outputs/' \
  --exclude='data/' \
  --exclude='checkpoints/' \
  --exclude='wandb/' \
  --exclude='ray_results/' \
  --exclude='__pycache__/' \
  <local>/ <user>@<cluster-host>:~/codes/<project>/
```

Pull results back via the reverse rsync (just swap source/target).

Datasets that already exist locally and are too big to sync: write a cluster-side download script using the cluster's bandwidth, not your laptop's.

## Job-launch hygiene

- **Always check `squeue -u $USER`** before resubmitting (avoid duplicate jobs).
- **Stream stdout/stderr to project-local paths**:
  - `outputs/<project>.<jobname>.o<jobid>`
  - `errors/<project>.<jobname>.e<jobid>`
- **Email is wired via `--mail-type=ALL`** — keep on for long jobs.
- **Cancel hung jobs**: `scancel <jobid>` (or `scancel -u $USER --name=<jobname>` for all jobs of a name).

## Common partitions and what they're for

| Partition | Typical use |
|---|---|
| `gpu` | GPU jobs (RTX4090, A100, H100 — varies by cluster) |
| `epyc2` / `bdw` / `cpu` | CPU-only jobs |
| `teaching` | GPU on-demand with shorter wait |
| `debug` / `short` | Quick interactive jobs (typically <1h wall time) |

Cluster-specific — consult the cluster's documentation for the exact partition map.

## Companion

- Pairs with `long-running-tasks` skill (in this lib) — when a task realistically takes hours/days, cluster is often the right answer.
- The `superpowers` plugin's autorun mode (`autorun-mode` rule) integrates with cluster jobs via `[END:WAIT]` markers + `Monitor` for completion notifications.
- For experiment tracking on cluster runs, see `recommendations/ml-research.md` (Weights & Biases, MLflow, ClearML).

## End-of-turn STOP identifier

Every turn's final user-facing line MUST end with one of three markers on its own line:

- **`[END:FINAL]`** — Task / session fully complete. No further autonomous work pending. Waiting for a new user instruction.
- **`[END:WAIT]`** — Turn ends but background work continues (cluster jobs, monitors, `run_in_background` tasks, subagents). User is auto-notified when the background event fires. Specify what's being awaited in one short clause before the marker.
- **`[END:NEEDS_USER]`** — Turn ends because input / decision / authorisation is required from the user before you can proceed. Specify the question before the marker.

Examples:

```
4-fold ensemble committed. Paper draft updated.

[END:FINAL]
```

```
Cluster SFT job 3690151 running, ETA ~12h. Monitor armed.

[END:WAIT]
```

```
Migration to v3 schema would drop column `x`. Confirm OK to proceed?

[END:NEEDS_USER]
```

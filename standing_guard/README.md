# Standing Guard

A drop-in drift governor for systems that optimise a proxy.

Attach it to a running system, call `step` where the system would step, and it
discovers the signals, detects Goodhart drift, corrects it by admitting only
standing-preserving steps, and hands back a report of what drifted and what it
did about it. Standard library only, no configuration required.

```python
from standing_guard import StandingGuard

guard = StandingGuard.wrap(system)      # system: any object with a step method
for action in actions:
    guard.step(action)                  # instead of system.step(action)

print(guard.report().to_markdown())
```

`guard.step(...)` returns whatever the system's own step returned, so it is a
substitute call, not a wrapper type. `guard.last_step` describes what the guard
did with it, and `guard.episodes` holds the drift episodes it found.

## Guarding an evaluation or agent run

`StandingGuard` corrects a system that can rescale its steps. A benchmark or
agent harness gives you no such handle: by the time a trial's numbers exist, the
trial has already happened. What can still be withheld is the interpretation — a
trial whose score rises while the independent signal falls is not evidence of
progress, however good the headline number looks.

```python
from standing_guard import AuditLog, MetricStream

stream = MetricStream("tests_passing", "user_value", audit=AuditLog("run.jsonl"))
for trial in trials:
    verdict = stream.record({"tests_passing": p, "user_value": q})
    if not verdict.accepted:
        print(verdict.reason)       # verdict.evidence holds the window
```

The verdict is decided by the same windowed statistic as the governor, and the
stream holds afterwards until consecutive trials stop separating the two
signals. `stream.summary()` and `stream.to_markdown()` report what was flagged.
`guard_trials(rows, "score", "quality")` does the same for an iterable and
returns only the trials it accepted. Either signal can be declared
`standing_direction="minimize"` for costs and debts.

## Tamper-evident audit trail

A guard's word is only worth the record behind it. Every verdict, and every
trial's raw signals, can be appended to a hash-chained JSONL log:
`AuditLog.append` links each entry to the one before it, and `verify_log(path)`
recomputes the chain, naming the first entry that was edited, reordered,
inserted or removed.

```bash
pip install .                       # installs the standing-guard command
standing-guard audit run.jsonl      # 0 clean, 2 drift flagged, 1 chain altered
standing-guard demo                 # the worked agent-evaluation example
```

The exit codes make the guard usable as a CI gate: a run whose wins were bought
by degrading the independent signal fails the build instead of shipping.

## What it reads

Nothing is configured. The guard looks for numeric signals in three places:

1. a `signals()` or `metrics()` method returning a mapping;
2. public numeric attributes, rescanned every step, so signals created by the
   first step are picked up;
3. numbers the step returns (`step_return[0]`, ...), used only when they are not
   already visible as attributes.

It then assigns two roles:

- **proxy** — the signal the action pushes hardest;
- **standing** — the signal the action barely reaches, used as the independent
  measurement that drift is judged against.

If the names are unambiguous (`reward`/`score`/`engagement` versus
`true_value`/`goal`/`audit`/`quality`/`safety`), names decide. Otherwise the
roles are inferred from how each signal responds to the action during warm-up,
which requires the action to vary. The report records which rule was used, so
"how did it decide this?" is always answerable.

## What it does

Drift is the windowed pattern the repository already defines: the proxy
improving while the standing signal declines, each measured as a normalized
endpoint change over the window (`standing_guard.drift.normalized_change` is
pinned to `goodhart_monitor._normalized_change` by a test).

Once drift is latched, every requested step is tested before it is adopted. The
guard snapshots the system, replays the step at each scaling in the correction
schedule (default `1, 0.5, 0.25, 0, -0.25, -0.5, -1`), keeps the ones that do
not decrease standing, and adopts the most standing-preserving of them. The full
action is adopted whenever it is admissible, so a healthy system never sees a
correction. If nothing is admissible the step is blocked and the guard halts in
`review` until `acknowledge(review_reference, reason)` records a human decision.

The hold lifts only when the system's own full action becomes admissible again.

## Why this is the theorem

`Collapse_Demonstrations/Goodhart_Drift/Goodhart_WithStanding.lean` proves
`noGoodhartDrift_under_StandingAlgebra`:

> If every proxy-improving transition is the application of an admissible
> operation, and every admissible operation is standing non-decreasing, then
> there is no transition where the proxy rises while standing falls.

The guard enforces that premise empirically. It refuses a proxy-improving
transition unless it can be replayed as an operation that does not decrease
standing, which is the same counterexample shape the companion SMT file
(`Goodhart_System.smt2`) asserts exists without that constraint.

This is an application of the theorem's hypothesis, not an instance of the
theorem: the guard measures standing through the signal the integration
exposes, and cannot prove that signal is the true objective. See the report's
`limits` section, which is emitted on every run.

## Report

`guard.report()` returns a `GuardReport` with `to_dict()`, `to_json()` and
`to_markdown()`. It contains the discovered roles and their provenance, each
drift episode with its evidence window and worst transition, every correction
with the scaling applied and the standing before and after, a measured total of
standing preserved, the counters, and the limits.

"Standing preserved" is measured rather than assumed: the full action is
replayed from the same snapshot, so the comparison is between two observed
outcomes from an identical state.

## Configuration

`GuardConfig` is optional and every field has a working default:

| field | default | meaning |
| --- | --- | --- |
| `window_size` | 8 | observations in the drift window |
| `min_observations` | 6 | minimum window before drift is judged |
| `warmup_steps` | 6 | observations before roles are assigned |
| `min_proxy_improvement` | 0.5 | normalized proxy gain that counts as improving |
| `max_standing_decline` | 0.5 | normalized standing loss that counts as declining |
| `correction_schedule` | `1, .5, .25, 0, -.25, -.5, -1` | scalings tested, must contain `1.0` |
| `allow_reversal` | `True` | permit negative scalings that retreat |
| `clear_steps` | 2 | consecutive admissible full steps before the hold lifts |
| `standing_tolerance` | `0.0` | allowed standing decrease; raise it for smooth optima |

## Limits

- The action must be scalable (a number, or a sequence of numbers) for
  correction; otherwise the guard can only block.
- Candidate testing re-executes the step once per scaling, so a held step is
  more expensive than an unguarded one.
- Replay restores the system's attribute state from a deep copy; side effects
  outside that state are not undone.
- Detection needs warm-up, and it cannot see drift that never appears in the
  signals the system exposes.
- The standing signal must be supplied by the integration. The guard cannot
  verify that it measures the true objective, and a clean run is not evidence
  that a system is safe.

## Demo and tests

```text
python Standing_Guard_Demo.py
python -m unittest discover -s Tests -v
```

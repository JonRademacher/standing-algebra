# Goodhart Drift Monitor Prototype

This repository includes a dependency-free Python monitor for detecting a
configured pattern where a proxy improves while an independently supplied goal
signal declines. It emits `allow`, `hold`, or `review` decisions with the
observation window that supports each decision.

## Run the monitor

Input is chronological newline-delimited JSON with a timestamp, proxy value,
and independently measured goal value:

```json
{"timestamp":"1","proxy":0.2,"goal":10}
{"timestamp":"2","proxy":0.4,"goal":9}
```

Run it on a file and write an audit log:

```text
python goodhart_monitor.py --input observations.jsonl --audit decisions.jsonl
```

Or pipe records through standard input:

```text
python goodhart_monitor.py < observations.jsonl
```

The monitor defaults to a six-observation warm-up, an eight-observation window,
and a latched `hold` when proxy improvement coincides with goal decline. It
returns `review` while warming up or when either signal is constant in the
window. Configure signal direction and thresholds with the command-line options;
the normalized changes are directional fractions of each signal's observed
window range, not calibrated effect sizes.

## Workflow control

The `workflow_control.py` layer provides a fail-closed `WorkflowController`.
It blocks each proposed action during warm-up while allowing signal collection
to continue. A detected drift or other unresolved `review` condition blocks the
step, pauses the workflow, and records an evidence-bearing human-review request.
`resume` requires both a non-empty review reference and reason; it clears the
signal window, so proposed actions are blocked while a fresh warm-up completes.

Run the end-to-end simulation with:

```text
python Goodhart_Workflow_Guard_Demo.py
```

The demo's `DryRunWorkflowAdapter` only records in-memory events; it does not
control an external workflow. To integrate a production system, implement the
`ControlAdapter` interface with its native action gate, pause, review, and
resume controls. The adapter must fail loudly if a control is rejected or
unavailable. The controller will not execute the gated action if enforcement
fails. Serialize workflow steps at the integration boundary to avoid races
between a decision and its action.

A drift alarm can only stop subsequent steps; it cannot undo an action that
already completed or guarantee cancellation of in-flight work. Recovery or
rollback must be a separately designed, reviewed, and tested workflow—not an
automatic response in this prototype.

For simpler use without workflow state or escalation, applications can import
`GoodhartMonitor` and call `run_guarded`. The richer controller keeps the
workflow paused until an explicit, referenced human review resumes it.

## Limits

The goal signal must be measured independently and supplied by the integrating
application. The monitor cannot discover the true objective, validate that a
chosen goal signal is adequate, or guarantee that configured thresholds catch
every form of Goodhart drift. A `review` or `hold` is a gate decision, not a
claim that a system is unsafe; an `allow` is not a safety certification.

The Lean Σᴿ and ICG developments motivate structural constraints and evidence
accountability, but they do not prove this Python implementation correct or
certify its runtime behavior. The existing bandit scripts remain simulations,
not empirical evidence of production effectiveness.

Run the unit tests with:

```text
python -m unittest discover -s Tests -v
```

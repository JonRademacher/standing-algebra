"""A worked example: an agent whose score climbs while its output gets worse.

The trial numbers are synthetic but shaped after the failure mode reported
against agent benchmarks: the harness measures what the agent can reach
(``tests_passing``), the independent evaluator measures what a user gets
(``user_value``), and the two are only loosely coupled. Optimising the first is
cheap once it is decoupled from the second, so the score keeps rising after the
work has stopped improving.

Run it with ``python -m standing_guard demo`` or ``python Standing_Guard_Audit_Demo.py``.
"""

from __future__ import annotations

from pathlib import Path
from typing import Callable

from .audit import AuditLog, verify_log
from .trials import MetricStream

# (tests_passing, user_value) per trial. Trials 0-5 improve together; from trial
# 6 the agent starts satisfying the harness rather than the user.
TRIALS: tuple[tuple[float, float], ...] = (
    (0.55, 0.52),
    (0.58, 0.55),
    (0.61, 0.58),
    (0.63, 0.60),
    (0.66, 0.63),
    (0.69, 0.66),
    (0.74, 0.63),
    (0.79, 0.59),
    (0.84, 0.54),
    (0.88, 0.48),
    (0.91, 0.42),
    (0.94, 0.35),
    (0.96, 0.30),
    (0.97, 0.26),
    (0.98, 0.22),
    (0.99, 0.19),
    (0.99, 0.17),
    (0.99, 0.16),
    (0.99, 0.15),
    (0.99, 0.15),
)


def run(write: Callable[[str], None] = print, audit_path: str | Path | None = None) -> dict:
    """Replay the trials through a stream and report what it would and would not accept."""
    path = Path(audit_path) if audit_path else None
    if path is not None and path.exists():
        path.unlink()
    audit = AuditLog(path) if path is not None else None
    stream = MetricStream(
        proxy="tests_passing",
        standing="user_value",
        audit=audit,
        label="agent evaluation, 20 trials",
    )

    write("Agent evaluation: proxy = tests_passing, standing = user_value")
    write("")
    write("trial  tests_passing  user_value  verdict")
    for index, (proxy, standing) in enumerate(TRIALS):
        if audit is not None:
            audit.observe({"tests_passing": proxy, "user_value": standing})
        verdict = stream.record({"tests_passing": proxy, "user_value": standing})
        label = "accept" if verdict.accepted else f"REJECT ({verdict.status.value})"
        write(f"{index:5d}  {proxy:13.2f}  {standing:10.2f}  {label}")
        if not verdict.accepted:
            write(f"       -> {verdict.reason}")

    summary = stream.summary()
    counters = summary["counters"]
    write("")
    write(f"Trials: {counters['trials']}  accepted: {counters['accepted']}  "
          f"drift flagged: {counters['flagged']}  held: {counters['held']}")
    write(f"Headline score of the run: {TRIALS[-1][0]:.2f}; "
          f"independent standing: {TRIALS[-1][1]:.2f}")

    if path is not None:
        result = verify_log(path)
        write("")
        write(f"Audit log {path}: {result['reason']} (ok={result['ok']})")
        summary["audit"] = result
    return summary


def main() -> int:
    run()
    return 0

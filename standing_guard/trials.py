"""Guarding streams of independent trials.

``StandingGuard`` corrects a system that exposes a rescalable step. Evaluation
harnesses, agent runs and A/B checks offer no such handle: by the time a trial's
numbers exist, the trial has already happened. What can still be withheld is the
*interpretation*. A trial whose proxy rose while its standing fell is not
evidence of progress, however good the headline number looks, and accepting it
is exactly the accounting error that lets a benchmark be gamed.

``MetricStream`` applies the same windowed statistic as the governor
(``standing_guard.drift.normalized_change``) to two named signals and returns a
verdict per trial. It is the drop-in form for a loop that already computes a
proxy and an independent quality signal:

    stream = MetricStream(proxy="tests_passing", standing="user_value")
    for trial in trials:
        verdict = stream.record(run_trial(trial))
        if not verdict.accepted:
            print(verdict.reason)

Verdicts are advisory until written down. ``AuditLog`` records them in a
hash-chained JSONL file, so a third party can verify afterwards that the record
of a run was not edited after the fact.
"""

from __future__ import annotations

from collections import deque
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Mapping

from . import drift
from .audit import AuditLog
from .governor import GuardConfig, GuardStatus


class SignalError(KeyError):
    """Raised when a trial does not report one of the watched signals."""


@dataclass(frozen=True)
class Verdict:
    """What the stream concluded about one trial."""

    trial: int
    accepted: bool
    status: GuardStatus
    proxy_change: float | None
    standing_change: float | None
    reason: str
    evidence: dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> dict[str, Any]:
        return {
            "trial": self.trial,
            "accepted": self.accepted,
            "status": self.status.value,
            "proxy_change": self.proxy_change,
            "standing_change": self.standing_change,
            "reason": self.reason,
            "evidence": dict(self.evidence),
        }


class MetricStream:
    """Judge each trial of a metric stream against a standing signal.

    ``proxy`` is the signal the work is optimising, ``standing`` the independent
    signal that is supposed to track the real objective. Both must be numbers
    reported per trial.
    """

    def __init__(
        self,
        proxy: str,
        standing: str,
        config: GuardConfig | None = None,
        proxy_direction: str = drift.MAXIMIZE,
        standing_direction: str = drift.MAXIMIZE,
        audit: AuditLog | None = None,
        label: str | None = None,
    ) -> None:
        if not proxy or not standing or proxy == standing:
            raise ValueError("proxy and standing must be two distinct signal names")
        drift.orientation(proxy_direction)
        drift.orientation(standing_direction)
        self.proxy = proxy
        self.standing = standing
        self.config = config or GuardConfig()
        self.proxy_direction = proxy_direction
        self.standing_direction = standing_direction
        self.audit = audit
        self.label = label or "metric-stream"
        self.verdicts: list[Verdict] = []
        self.counters = {
            "trials": 0,
            "flagged": 0,
            "held": 0,
            "accepted": 0,
        }
        self._window: deque[dict[str, float]] = deque(maxlen=self.config.window_size)
        self._hold = False
        self._clear_run = 0

    # -- recording ------------------------------------------------------

    def record(self, observations: Mapping[str, float]) -> Verdict:
        """Judge one trial and return its verdict."""
        frame = self._frame(observations)
        index = self.counters["trials"]
        self.counters["trials"] += 1
        self._window.append(frame)

        proxy_change, standing_change = self._changes()
        evidence = {
            "proxy": self.proxy,
            "standing": self.standing,
            "sample_count": len(self._window),
            "window": {
                self.proxy: [row[self.proxy] for row in self._window],
                self.standing: [row[self.standing] for row in self._window],
            },
        }

        if proxy_change is None or standing_change is None:
            if self._hold:
                self.counters["held"] += 1
                verdict = Verdict(
                    index, False, GuardStatus.HOLD, proxy_change, standing_change,
                    "hold active: the window has no variation, so nothing shows the drift has cleared",
                    evidence,
                )
                return self._finish(verdict, healthy=False)
            verdict = Verdict(
                index, True, GuardStatus.ALLOW, proxy_change, standing_change,
                "window has no variation yet; no drift judgement",
                evidence,
            )
            return self._finish(verdict, healthy=True)

        drift_shaped = (
            proxy_change >= self.config.min_proxy_improvement
            and standing_change <= -self.config.max_standing_decline
        )
        if drift_shaped:
            self.counters["flagged"] += 1
            self._hold = True
            self._clear_run = 0
            verdict = Verdict(
                index, False, GuardStatus.HOLD, proxy_change, standing_change,
                (
                    f"{self.proxy} rose {proxy_change:+.2f} while {self.standing} fell "
                    f"{standing_change:+.2f} over {len(self._window)} trials: the "
                    "improvement is not admissible evidence of progress"
                ),
                evidence,
            )
            return self._finish(verdict, healthy=False)

        if self._hold:
            self._clear_run += 1
            if self._clear_run < self.config.clear_steps:
                self.counters["held"] += 1
                verdict = Verdict(
                    index, False, GuardStatus.HOLD, proxy_change, standing_change,
                    (
                        f"hold active: {self._clear_run} of {self.config.clear_steps} "
                        "consecutive trials needed before the stream is trusted again"
                    ),
                    evidence,
                )
                return self._finish(verdict, healthy=False)
            self._hold = False
            self._clear_run = 0
            verdict = Verdict(
                index, True, GuardStatus.ALLOW, proxy_change, standing_change,
                "hold lifted: consecutive trials no longer separate proxy from standing",
                evidence,
            )
            return self._finish(verdict, healthy=True)

        verdict = Verdict(
            index, True, GuardStatus.ALLOW, proxy_change, standing_change,
            "proxy and standing moved together",
            evidence,
        )
        return self._finish(verdict, healthy=True)

    def summary(self) -> dict[str, Any]:
        """Machine-readable account of the stream."""
        flagged = [v.to_dict() for v in self.verdicts if not v.accepted and v.status is GuardStatus.HOLD]
        return {
            "label": self.label,
            "proxy": self.proxy,
            "standing": self.standing,
            "counters": dict(self.counters),
            "hold_active": self._hold,
            "flagged": flagged,
            "limits": [
                "Detection is a windowed statistic: it needs warm-up and cannot see drift "
                "that never appears in the two recorded signals.",
                "A verdict rejects an interpretation, not a trial: the run already happened.",
                "The standing signal is whatever the harness reports. The stream cannot "
                "verify that it measures the true objective.",
            ],
        }

    def to_markdown(self) -> str:
        data = self.summary()
        counters = data["counters"]
        lines = [
            f"# {self.label}",
            "",
            f"Watching `{self.proxy}` against `{self.standing}`.",
            "",
            f"- Trials: {counters['trials']}",
            f"- Accepted: {counters['accepted']}",
            f"- Drift trials flagged: {counters['flagged']}",
            f"- Held: {counters['held']}",
            f"- Hold active: {'yes' if data['hold_active'] else 'no'}",
        ]
        if data["flagged"]:
            lines += ["", "## Flagged trials", ""]
            for item in data["flagged"]:
                lines.append(
                    f"- trial {item['trial']}: proxy {item['proxy_change']:+.2f}, "
                    f"standing {item['standing_change']:+.2f}"
                )
        lines += ["", "## Limits", ""]
        lines += [f"- {limit}" for limit in data["limits"]]
        return "\n".join(lines) + "\n"

    # -- internals ------------------------------------------------------

    def _frame(self, observations: Mapping[str, float]) -> dict[str, float]:
        frame: dict[str, float] = {}
        for name in (self.proxy, self.standing):
            if name not in observations:
                raise SignalError(
                    f"trial is missing signal {name!r}; got {sorted(observations)}"
                )
            value = observations[name]
            if isinstance(value, bool) or not isinstance(value, (int, float)):
                raise SignalError(f"signal {name!r} must be numeric, got {value!r}")
            frame[name] = float(value)
        return frame

    def _changes(self) -> tuple[float | None, float | None]:
        if len(self._window) < self.config.min_observations:
            return None, None
        proxy_change = drift.normalized_change(
            [row[self.proxy] for row in self._window], self.proxy_direction
        )
        standing_change = drift.normalized_change(
            [row[self.standing] for row in self._window], self.standing_direction
        )
        return proxy_change, standing_change

    def _finish(self, verdict: Verdict, healthy: bool) -> Verdict:
        if healthy:
            self.counters["accepted"] += 1
        self.verdicts.append(verdict)
        if self.audit is not None:
            self.audit.append({"kind": "verdict", **verdict.to_dict()})
        return verdict


def guard_trials(
    trials: Any,
    proxy: str,
    standing: str,
    config: GuardConfig | None = None,
    **kwargs: Any,
) -> tuple[list[Any], MetricStream]:
    """Run ``trials`` (an iterable of signal mappings) through a stream.

    Returns the observations that were accepted as evidence of progress, and the
    stream that judged them.
    """
    stream = MetricStream(proxy=proxy, standing=standing, config=config, **kwargs)
    accepted = []
    for observation in trials:
        if stream.record(observation).accepted:
            accepted.append(observation)
    return accepted, stream


def stream_from_log(path: str | Path, proxy: str, standing: str, **kwargs: Any) -> MetricStream:
    """Replay a JSONL audit log's observations through a fresh stream."""
    from .audit import read_log

    stream = MetricStream(proxy=proxy, standing=standing, **kwargs)
    for entry in read_log(path):
        record = entry.get("record", {})
        if record.get("kind") == "observation":
            stream.record(record["signals"])
    return stream

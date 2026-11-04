#!/usr/bin/env python3
"""A small, fail-closed monitor for divergence between a proxy and an audited goal signal."""

from __future__ import annotations

import argparse
import json
import math
import sys
from collections import deque
from dataclasses import asdict, dataclass
from enum import Enum
from pathlib import Path
from typing import Callable, Deque, Generic, TextIO, TypeVar


INSUFFICIENT_OBSERVATIONS_REASON = "insufficient observations; action is not authorized"


class Direction(str, Enum):
    MAXIMIZE = "maximize"
    MINIMIZE = "minimize"

    @property
    def sign(self) -> float:
        return 1.0 if self is Direction.MAXIMIZE else -1.0


class Decision(str, Enum):
    ALLOW = "allow"
    HOLD = "hold"
    REVIEW = "review"


@dataclass(frozen=True)
class Observation:
    timestamp: str
    proxy: float
    goal: float

    def __post_init__(self) -> None:
        if not isinstance(self.timestamp, str) or not self.timestamp.strip():
            raise ValueError("timestamp must not be empty")
        values = (self.proxy, self.goal)
        if any(isinstance(value, bool) or not isinstance(value, (int, float)) for value in values):
            raise ValueError("proxy and goal values must be numeric")
        try:
            finite_values = all(math.isfinite(value) for value in values)
        except OverflowError as error:
            raise ValueError("proxy and goal values must be finite numbers") from error
        if not finite_values:
            raise ValueError("proxy and goal values must be finite numbers")


@dataclass(frozen=True)
class DriftPolicy:
    window_size: int = 8
    min_observations: int = 6
    min_proxy_improvement: float = 0.5
    max_goal_decline: float = 0.5
    proxy_direction: Direction = Direction.MAXIMIZE
    goal_direction: Direction = Direction.MAXIMIZE
    on_drift: Decision = Decision.HOLD

    def __post_init__(self) -> None:
        if self.window_size < 2:
            raise ValueError("window_size must be at least 2")
        if not 2 <= self.min_observations <= self.window_size:
            raise ValueError("min_observations must be between 2 and window_size")
        if not 0.0 <= self.min_proxy_improvement <= 1.0:
            raise ValueError("min_proxy_improvement must be between 0 and 1")
        if not 0.0 <= self.max_goal_decline <= 1.0:
            raise ValueError("max_goal_decline must be between 0 and 1")
        if not isinstance(self.proxy_direction, Direction) or not isinstance(
            self.goal_direction, Direction
        ):
            raise ValueError("signal directions must be Direction values")
        if not isinstance(self.on_drift, Decision):
            raise ValueError("on_drift must be a Decision value")
        if self.on_drift not in (Decision.HOLD, Decision.REVIEW):
            raise ValueError("on_drift must be HOLD or REVIEW")


@dataclass(frozen=True)
class DriftEvidence:
    sample_count: int
    first_timestamp: str
    last_timestamp: str
    normalized_proxy_change: float | None
    normalized_goal_change: float | None
    observations: tuple[Observation, ...]


@dataclass(frozen=True)
class Evaluation:
    decision: Decision
    reason: str
    evidence: DriftEvidence

    @property
    def permits_action(self) -> bool:
        return self.decision is Decision.ALLOW


ResultT = TypeVar("ResultT")


@dataclass(frozen=True)
class GateResult(Generic[ResultT]):
    evaluation: Evaluation
    action_executed: bool
    action_result: ResultT | None


class GoodhartMonitor:
    """Compares directional proxy and independently measured goal trends.

    Normalized changes are endpoint differences divided by the signal's range
    in the current window. They are directional evidence, not calibrated effect
    sizes or proof that the supplied goal signal captures the true objective.
    """

    def __init__(self, policy: DriftPolicy = DriftPolicy()) -> None:
        self.policy = policy
        self._observations: Deque[Observation] = deque(maxlen=policy.window_size)
        self._latched_decision: Decision | None = None
        self._latched_reason: str | None = None

    def observe(self, observation: Observation) -> Evaluation:
        self._observations.append(observation)
        window = tuple(self._observations)
        evidence = self._evidence(window)

        if self._latched_decision is not None:
            return Evaluation(
                self._latched_decision,
                self._latched_reason or "drift hold remains active until explicitly reset",
                evidence,
            )

        if evidence.sample_count < self.policy.min_observations:
            return Evaluation(
                Decision.REVIEW,
                INSUFFICIENT_OBSERVATIONS_REASON,
                evidence,
            )

        if evidence.normalized_proxy_change is None or evidence.normalized_goal_change is None:
            return Evaluation(
                Decision.REVIEW,
                "a signal is constant in the observation window; trend alignment is unknown",
                evidence,
            )

        proxy_improving = (
            evidence.normalized_proxy_change >= self.policy.min_proxy_improvement
        )
        goal_declining = (
            evidence.normalized_goal_change <= -self.policy.max_goal_decline
        )
        if proxy_improving and goal_declining:
            self._latched_decision = self.policy.on_drift
            self._latched_reason = (
                "proxy improves while the independently supplied goal signal declines"
            )
            return Evaluation(self._latched_decision, self._latched_reason, evidence)

        return Evaluation(
            Decision.ALLOW,
            "no configured proxy/goal divergence detected in the current window",
            evidence,
        )

    def run_guarded(
        self, observation: Observation, action: Callable[[], ResultT]
    ) -> GateResult[ResultT]:
        """Observe first and execute the action only when the gate returns ALLOW."""
        evaluation = self.observe(observation)
        if not evaluation.permits_action:
            return GateResult(evaluation, False, None)
        return GateResult(evaluation, True, action())

    def reset(self, reason: str) -> int:
        """Clear history and a latched decision after an explicit operator review."""
        if not isinstance(reason, str) or not reason.strip():
            raise ValueError("reset reason must not be empty")
        cleared_samples = len(self._observations)
        self._observations.clear()
        self._latched_decision = None
        self._latched_reason = None
        return cleared_samples

    def _evidence(self, window: tuple[Observation, ...]) -> DriftEvidence:
        return DriftEvidence(
            sample_count=len(window),
            first_timestamp=window[0].timestamp,
            last_timestamp=window[-1].timestamp,
            normalized_proxy_change=_normalized_change(
                [item.proxy for item in window], self.policy.proxy_direction
            ),
            normalized_goal_change=_normalized_change(
                [item.goal for item in window], self.policy.goal_direction
            ),
            observations=window,
        )


def _normalized_change(values: list[float], direction: Direction) -> float | None:
    if len(values) < 2:
        return None
    scale = max(abs(value) for value in values)
    if scale == 0:
        return None
    scaled = [value / scale for value in values]
    span = max(scaled) - min(scaled)
    if span == 0:
        return None
    return direction.sign * (scaled[-1] - scaled[0]) / span


def evaluation_record(evaluation: Evaluation) -> dict[str, object]:
    evidence = evaluation.evidence
    return {
        "event": "evaluation",
        "decision": evaluation.decision.value,
        "permits_action": evaluation.permits_action,
        "reason": evaluation.reason,
        "evidence": {
            "sample_count": evidence.sample_count,
            "first_timestamp": evidence.first_timestamp,
            "last_timestamp": evidence.last_timestamp,
            "normalized_proxy_change": evidence.normalized_proxy_change,
            "normalized_goal_change": evidence.normalized_goal_change,
            "observations": [asdict(item) for item in evidence.observations],
        },
    }


def _parse_observation(line: str, line_number: int) -> Observation:
    record = json.loads(line)
    if not isinstance(record, dict):
        raise ValueError(f"line {line_number}: expected a JSON object")
    try:
        timestamp = record["timestamp"]
        proxy = record["proxy"]
        goal = record["goal"]
    except KeyError as error:
        raise ValueError(f"line {line_number}: missing field {error.args[0]!r}") from error
    if (
        not isinstance(timestamp, str)
        or isinstance(proxy, bool)
        or isinstance(goal, bool)
        or not isinstance(proxy, (int, float))
        or not isinstance(goal, (int, float))
    ):
        raise ValueError(f"line {line_number}: expected string timestamp and numeric proxy/goal")
    try:
        return Observation(timestamp, proxy, goal)
    except (TypeError, ValueError, OverflowError) as error:
        raise ValueError(f"line {line_number}: {error}") from error


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Monitor JSONL proxy/goal observations and emit auditable gate decisions."
    )
    parser.add_argument("--input", default="-", help="JSONL input path, or - for stdin")
    parser.add_argument("--audit", help="also write decision JSONL to this path")
    parser.add_argument("--window-size", type=int, default=8)
    parser.add_argument("--min-observations", type=int, default=6)
    parser.add_argument("--min-proxy-improvement", type=float, default=0.5)
    parser.add_argument("--max-goal-decline", type=float, default=0.5)
    parser.add_argument(
        "--proxy-direction", choices=[item.value for item in Direction], default="maximize"
    )
    parser.add_argument(
        "--goal-direction", choices=[item.value for item in Direction], default="maximize"
    )
    parser.add_argument("--on-drift", choices=["hold", "review"], default="hold")
    args = parser.parse_args(argv)

    try:
        policy = DriftPolicy(
            window_size=args.window_size,
            min_observations=args.min_observations,
            min_proxy_improvement=args.min_proxy_improvement,
            max_goal_decline=args.max_goal_decline,
            proxy_direction=Direction(args.proxy_direction),
            goal_direction=Direction(args.goal_direction),
            on_drift=Decision(args.on_drift),
        )
    except ValueError as error:
        parser.error(str(error))

    source: TextIO
    if args.input == "-":
        source = sys.stdin
    else:
        if args.audit and Path(args.audit).resolve() == Path(args.input).resolve():
            parser.error("audit output must differ from input")
        try:
            source = Path(args.input).open(encoding="utf-8")
        except OSError as error:
            parser.error(f"cannot open input: {error}")

    audit: TextIO | None = None
    if args.audit:
        try:
            audit = Path(args.audit).open("w", encoding="utf-8")
        except OSError as error:
            if source is not sys.stdin:
                source.close()
            parser.error(f"cannot open audit output: {error}")

    monitor = GoodhartMonitor(policy)
    try:
        for line_number, line in enumerate(source, start=1):
            if not line.strip():
                continue
            try:
                observation = _parse_observation(line, line_number)
            except (json.JSONDecodeError, ValueError) as error:
                parser.error(str(error))
            record = evaluation_record(monitor.observe(observation))
            encoded = json.dumps(record, sort_keys=True, allow_nan=False)
            print(encoded)
            if audit is not None:
                audit.write(encoded + "\n")
    finally:
        if source is not sys.stdin:
            source.close()
        if audit is not None:
            audit.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

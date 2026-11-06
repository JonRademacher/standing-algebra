"""Standing Guard: a drop-in drift governor.

The guard attaches to a system that exposes numeric observable signals and a
step entry point. It discovers which signal the system's actions push (the
proxy) and which one they do not reach (the standing signal), and then refuses
to admit a step that improves the proxy while decreasing standing.

That refusal is the hypothesis of
``Collapse_Demonstrations.Goodhart_Drift.Goodhart_WithStanding.noGoodhartDrift_under_StandingAlgebra``:
if every proxy-improving transition is an admissible operation, and admissible
operations never decrease standing, then a proxy-up/standing-down transition
cannot occur. The guard enforces the premise empirically, by testing each
candidate step before adopting it, and records what it refused and why.

Correction is a line search over the requested action. Candidate scalings are
replayed from a snapshot of the system's state; the first admissible one is
adopted, with the most standing-preserving admissible scaling winning when the
full action is refused. If nothing is admissible the guard blocks the step and
fails closed, exactly as ``workflow_control.WorkflowController`` does.
"""

from __future__ import annotations

import copy
from collections import deque
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Mapping

from . import discovery
from .drift import MAXIMIZE, normalized_change, orientation


class GuardStatus(str, Enum):
    """Mirrors ``goodhart_monitor.Decision``: allow, hold, review."""

    ALLOW = "allow"
    HOLD = "hold"
    REVIEW = "review"


class NotScalable(Exception):
    """Raised when an action cannot be scaled along the correction schedule."""


@dataclass(frozen=True)
class GuardConfig:
    window_size: int = 8
    min_observations: int = 6
    warmup_steps: int = 6
    min_proxy_improvement: float = 0.5
    max_standing_decline: float = 0.5
    correction_schedule: tuple[float, ...] = (1.0, 0.5, 0.25, 0.0, -0.25, -0.5, -1.0)
    allow_reversal: bool = True
    clear_steps: int = 2
    standing_tolerance: float = 0.0

    def __post_init__(self) -> None:
        if self.window_size < 3:
            raise ValueError("window_size must be at least 3")
        if not 2 <= self.min_observations <= self.window_size:
            raise ValueError("min_observations must be between 2 and window_size")
        if self.warmup_steps < 2:
            raise ValueError("warmup_steps must be at least 2")
        if not 0.0 <= self.min_proxy_improvement <= 1.0:
            raise ValueError("min_proxy_improvement must be between 0 and 1")
        if not 0.0 <= self.max_standing_decline <= 1.0:
            raise ValueError("max_standing_decline must be between 0 and 1")
        if not self.correction_schedule:
            raise ValueError("correction_schedule must not be empty")
        if any(
            isinstance(alpha, bool) or not isinstance(alpha, (int, float))
            for alpha in self.correction_schedule
        ):
            raise ValueError("correction_schedule entries must be numbers")
        if 1.0 not in self.correction_schedule:
            raise ValueError("correction_schedule must contain 1.0 (the requested action)")
        if self.clear_steps < 1:
            raise ValueError("clear_steps must be at least 1")
        if self.standing_tolerance < 0.0:
            raise ValueError("standing_tolerance must not be negative")


@dataclass(frozen=True)
class DriftEvidence:
    normalized_proxy_change: float | None
    normalized_standing_change: float | None
    sample_count: int


@dataclass
class StepRecord:
    """What the guard did with one requested step."""

    index: int
    action: Any
    scaled_action: Any = None
    alpha: float = 1.0
    outcome: str = "pass"
    reason: str = ""
    standing_before: float | None = None
    standing_after: float | None = None
    proxy_after: float | None = None
    trials: tuple[tuple[float, float | None], ...] = ()


@dataclass
class Intervention:
    """One refused step and the correction that replaced it."""

    step: int
    applied_alpha: float
    trials: tuple[tuple[float, float | None], ...]
    standing_before: float | None
    standing_after: float | None

    @property
    def unguarded_delta(self) -> float | None:
        for alpha, delta in self.trials:
            if alpha == 1.0:
                return delta
        return None

    @property
    def standing_preserved(self) -> float | None:
        """Measured difference against replaying the full action from the same state."""
        unguarded = self.unguarded_delta
        if unguarded is None or self.standing_before is None or self.standing_after is None:
            return None
        return (self.standing_after - self.standing_before) - unguarded


@dataclass
class Episode:
    """One drift episode: when it opened, what was done, when it closed."""

    number: int
    opened_at: int
    proxy: str
    standing: str
    proxy_change: float | None
    standing_change: float | None
    worst_transition: dict[str, Any] | None
    interventions: list[Intervention] = field(default_factory=list)
    closed_at: int | None = None
    notes: list[str] = field(default_factory=list)


@dataclass
class _Admission:
    alpha: float
    raw: Any
    frame: dict[str, float]
    trials: tuple[tuple[float, float | None], ...]
    blocked: bool = False
    reason: str = ""


class StandingGuard:
    """Guard a system's steps against proxy improvement that costs standing."""

    def __init__(
        self,
        system: Any,
        config: GuardConfig | None = None,
        label: str | None = None,
    ) -> None:
        self.system = system
        self.config = config or GuardConfig()
        self.label = label or type(system).__name__
        self._step_fn = discovery.step_entry(system)
        self.roles: discovery.RoleAssignment | None = None
        self.status = GuardStatus.ALLOW
        self.episodes: list[Episode] = []
        self.last_step: StepRecord | None = None
        self.notes: list[str] = []
        self.counters = {
            "steps": 0,
            "corrected": 0,
            "blocked": 0,
            "admitted_drift_transitions": 0,
            "observed_drift_transitions": 0,
        }
        self._history: deque[dict[str, float]] = deque(maxlen=self.config.window_size)
        self._actions: deque[Any] = deque(maxlen=self.config.window_size)
        self._episode: Episode | None = None
        self._clear_run = 0
        self._review_reason = ""

    @classmethod
    def wrap(
        cls,
        system: Any,
        config: GuardConfig | None = None,
        label: str | None = None,
    ) -> "StandingGuard":
        """Attach a guard to ``system`` with no further configuration."""
        return cls(system, config=config, label=label)

    # -- public surface -------------------------------------------------

    def step(self, action: Any) -> Any:
        """Advance the system by one guarded step.

        Returns whatever the system's own step returned, or ``None`` when the
        guard blocked the step. ``self.last_step`` records which happened.
        """
        index = self.counters["steps"]
        record = StepRecord(index=index, action=action)

        if self.status is GuardStatus.REVIEW:
            record.outcome = "blocked"
            record.reason = (
                self._review_reason or "awaiting an acknowledged review reference"
            )
            self.counters["steps"] += 1
            self.counters["blocked"] += 1
            self.last_step = record
            return None

        standing_before = self._current_standing()
        snapshot = self._snapshot() if self._episode is not None else None

        if self._episode is not None:
            admission = self._correct(action, snapshot, standing_before)
            if admission.blocked:
                record.outcome = "blocked"
                record.reason = admission.reason
                record.trials = admission.trials
                record.standing_before = standing_before
                self.counters["steps"] += 1
                self.counters["blocked"] += 1
                self.status = GuardStatus.REVIEW
                self._review_reason = admission.reason
                self._episode.notes.append(admission.reason)
                self.last_step = record
                return None
            raw, frame, alpha = admission.raw, admission.frame, admission.alpha
            record.alpha = alpha
            record.trials = admission.trials
            record.scaled_action = _scaled_or_original(action, alpha)
            record.outcome = "corrected" if alpha != 1.0 else "pass"
            if alpha != 1.0:
                self.counters["corrected"] += 1
            self._episode.interventions.append(
                Intervention(
                    step=index,
                    applied_alpha=alpha,
                    trials=admission.trials,
                    standing_before=standing_before,
                    standing_after=frame.get(self.roles.standing) if self.roles else None,
                )
            )
        else:
            raw = self._step_fn(action)
            frame = discovery.read_frame(
                self.system, discovery.step_output_signals(raw)
            )
            record.outcome = "pass"

        record.standing_before = standing_before
        if self.roles is not None:
            record.standing_after = frame.get(self.roles.standing)
            record.proxy_after = frame.get(self.roles.proxy)
        self.counters["steps"] += 1
        self._admit(frame, action, record.outcome != "corrected")
        self.last_step = record
        return raw

    def acknowledge(self, review_reference: str, reason: str) -> bool:
        """Clear a blocked guard after an explicit, referenced human review."""
        if not isinstance(review_reference, str) or not review_reference.strip():
            raise ValueError("review_reference must not be empty")
        if not isinstance(reason, str) or not reason.strip():
            raise ValueError("acknowledge reason must not be empty")
        if self.status is not GuardStatus.REVIEW:
            raise RuntimeError("guard is not awaiting review")
        if self._episode is not None:
            self._episode.closed_at = self.counters["steps"]
            self._episode.notes.append(
                f"acknowledged under review {review_reference.strip()}: {reason.strip()}"
            )
            self._episode = None
        self._reset_window()
        self.status = GuardStatus.ALLOW
        self._review_reason = ""
        self.notes.append(
            f"review {review_reference.strip()}: {reason.strip()}"
        )
        return True

    def report(self) -> Any:
        """Build a report of what drifted and what the guard did about it."""
        from .report import build_report

        return build_report(self)

    # -- assessment -----------------------------------------------------

    def _admit(self, frame: dict[str, float], action: Any, admitted_full: bool) -> None:
        self._history.append(frame)
        self._actions.append(action)

        if self.roles is None:
            if len(self._history) < self.config.warmup_steps:
                return
            self.roles = discovery.classify(list(self._history), list(self._actions))

        previous = list(self._history)[-2] if len(self._history) >= 2 else None
        if previous is not None:
            self._count_transitions(previous, frame)

        evidence = self._evidence()
        if evidence is None:
            return
        drifting = (
            evidence.normalized_proxy_change is not None
            and evidence.normalized_standing_change is not None
            and evidence.normalized_proxy_change >= self.config.min_proxy_improvement
            and evidence.normalized_standing_change <= -self.config.max_standing_decline
        )

        if self._episode is None:
            if drifting:
                self._open_episode(evidence)
            return

        # The hold lifts only once the system's own request is admissible again,
        # so a frozen system cannot slip back into drift during a re-warm-up.
        self._clear_run = self._clear_run + 1 if admitted_full else 0
        if self._clear_run >= self.config.clear_steps:
            self._close_episode()

    def _count_transitions(
        self, previous: Mapping[str, float], current: Mapping[str, float]
    ) -> None:
        if self.roles is None:
            return
        proxy_step = current[self.roles.proxy] - previous[self.roles.proxy]
        standing_step = current[self.roles.standing] - previous[self.roles.standing]
        improved = orientation(self.roles.proxy_direction) * proxy_step > 0.0
        declined = standing_step < 0.0
        if improved and declined:
            self.counters["observed_drift_transitions"] += 1
            if self._episode is None:
                self.counters["admitted_drift_transitions"] += 1

    def _evidence(self) -> DriftEvidence | None:
        if self.roles is None or len(self._history) < self.config.min_observations:
            return None
        frames = list(self._history)
        proxy_values = [frame[self.roles.proxy] for frame in frames]
        standing_values = [frame[self.roles.standing] for frame in frames]
        return DriftEvidence(
            normalized_proxy_change=normalized_change(
                proxy_values, self.roles.proxy_direction
            ),
            normalized_standing_change=normalized_change(standing_values, MAXIMIZE),
            sample_count=len(frames),
        )

    def _worst_transition(self) -> dict[str, Any] | None:
        if self.roles is None or len(self._history) < 2:
            return None
        frames = list(self._history)
        base = self.counters["steps"] - len(frames)
        best: tuple[float, dict[str, Any]] | None = None
        for index in range(1, len(frames)):
            proxy_before = frames[index - 1][self.roles.proxy]
            proxy_after = frames[index][self.roles.proxy]
            standing_before = frames[index - 1][self.roles.standing]
            standing_after = frames[index][self.roles.standing]
            improvement = orientation(self.roles.proxy_direction) * (
                proxy_after - proxy_before
            )
            decline = -(standing_after - standing_before)
            score = improvement + decline
            candidate = {
                "step": base + index,
                "proxy_before": proxy_before,
                "proxy_after": proxy_after,
                "standing_before": standing_before,
                "standing_after": standing_after,
            }
            if best is None or score > best[0]:
                best = (score, candidate)
        return best[1] if best else None

    def _open_episode(self, evidence: DriftEvidence) -> None:
        assert self.roles is not None
        episode = Episode(
            number=len(self.episodes) + 1,
            opened_at=self.counters["steps"],
            proxy=self.roles.proxy,
            standing=self.roles.standing,
            proxy_change=evidence.normalized_proxy_change,
            standing_change=evidence.normalized_standing_change,
            worst_transition=self._worst_transition(),
        )
        self.episodes.append(episode)
        self._episode = episode
        self._clear_run = 0
        self.status = GuardStatus.HOLD

    def _close_episode(self) -> None:
        if self._episode is not None:
            self._episode.closed_at = self.counters["steps"]
        self._episode = None
        self._clear_run = 0
        self.status = GuardStatus.ALLOW
        self._reset_window()

    def _reset_window(self) -> None:
        self._history.clear()
        self._actions.clear()

    # -- correction -----------------------------------------------------

    def _correct(
        self,
        action: Any,
        snapshot: dict[str, Any] | None,
        standing_before: float | None,
    ) -> _Admission:
        assert self.roles is not None
        assert self._episode is not None

        if snapshot is None:
            return _Admission(
                alpha=1.0,
                raw=None,
                frame={},
                trials=(),
                blocked=True,
                reason=(
                    "drift is latched and the system's state cannot be snapshotted, "
                    "so no correction can be tested; the step is blocked"
                ),
            )

        schedule = self.config.correction_schedule
        if not self.config.allow_reversal:
            schedule = tuple(alpha for alpha in schedule if alpha >= 0.0)
        schedule = tuple(sorted(dict.fromkeys((1.0, *schedule)), reverse=True))

        trials: list[tuple[float, float | None]] = []
        for alpha in schedule:
            self._restore(snapshot)
            try:
                scaled = _scale_action(action, alpha)
            except NotScalable as error:
                return _Admission(
                    alpha=1.0,
                    raw=None,
                    frame={},
                    trials=tuple(trials),
                    blocked=True,
                    reason=(
                        "drift is latched and the requested action cannot be scaled "
                        f"({error}); the step is blocked"
                    ),
                )
            raw = self._step_fn(scaled)
            frame = discovery.read_frame(
                self.system, discovery.step_output_signals(raw)
            )
            if self.roles.standing not in frame:
                return _Admission(
                    alpha=1.0,
                    raw=None,
                    frame={},
                    trials=tuple(trials),
                    blocked=True,
                    reason=(
                        f"frozen: the standing signal {self.roles.standing!r} "
                        "disappeared while testing a correction"
                    ),
                )
            delta = (
                None
                if standing_before is None
                else frame[self.roles.standing] - standing_before
            )
            trials.append((alpha, delta))
            if alpha == 1.0 and delta is not None and delta >= -self.config.standing_tolerance:
                return _Admission(alpha, raw, frame, tuple(trials))

        admissible = [
            (alpha, delta)
            for alpha, delta in trials
            if delta is not None and delta >= -self.config.standing_tolerance
        ]
        if not admissible:
            self._restore(snapshot)
            return _Admission(
                alpha=1.0,
                raw=None,
                frame={},
                trials=tuple(trials),
                blocked=True,
                reason=(
                    "no scaling of the requested action is admissible at this state; "
                    "the step is blocked pending review"
                ),
            )

        alpha, _ = max(admissible, key=lambda trial: (trial[1], trial[0]))
        self._restore(snapshot)
        raw = self._step_fn(_scale_action(action, alpha))
        frame = discovery.read_frame(self.system, discovery.step_output_signals(raw))
        return _Admission(alpha, raw, frame, tuple(trials))

    # -- state ----------------------------------------------------------

    def _current_standing(self) -> float | None:
        if self.roles is None:
            return None
        return discovery.read_frame(self.system).get(self.roles.standing)

    def _snapshot(self) -> dict[str, Any] | None:
        try:
            return copy.deepcopy(dict(vars(self.system)))
        except Exception:
            return None

    def _restore(self, snapshot: Mapping[str, Any]) -> None:
        state = vars(self.system)
        state.clear()
        state.update(copy.deepcopy(dict(snapshot)))


def _scale_action(action: Any, alpha: float) -> Any:
    if alpha == 1.0:
        return action
    if action is None or isinstance(action, bool):
        raise NotScalable(f"{type(action).__name__} actions are not scalable")
    if isinstance(action, (int, float)):
        return action * alpha
    if isinstance(action, (list, tuple)):
        if not all(discovery.is_number(value) for value in action):
            raise NotScalable("only sequences of real numbers can be scaled")
        return type(action)(value * alpha for value in action)
    try:
        return action * alpha
    except TypeError as error:
        raise NotScalable(f"{type(action).__name__} actions are not scalable") from error


def _scaled_or_original(action: Any, alpha: float) -> Any:
    try:
        return _scale_action(action, alpha)
    except NotScalable:
        return None

"""Mechanism discovery: read a system instead of asking for a configuration.

The guard is attached to objects it has never seen, so it discovers what to
watch rather than requiring a schema. Three sources are used:

1. an explicit ``signals()`` or ``metrics()`` method returning a mapping;
2. public numeric attributes, rescanned on every step so that signals created
   by the first step are picked up;
3. numeric values returned by the step itself (``step_return[0]``, ...), or
   the numeric entries of a returned mapping.

Role assignment then uses signal names when they are unambiguous, and
otherwise infers the roles from how each signal responds to the action. Every
assignment carries its provenance so the report can say how it decided.
"""

from __future__ import annotations

import math
import re
from dataclasses import dataclass
from typing import Any, Mapping, Sequence

from .drift import MAXIMIZE, MINIMIZE

PROXY = "proxy"
STANDING = "standing"
CONTEXT = "context"

PROXY_HINTS = (
    "proxy",
    "reward",
    "score",
    "objective",
    "fitness",
    "return",
    "engagement",
    "throughput",
    "utilization",
    "progress",
    "metric",
    "loss",
)

STANDING_HINTS = (
    "true",
    "goal",
    "audit",
    "standing",
    "quality",
    "safety",
    "health",
    "welfare",
    "wellbeing",
    "harm",
    "ground",
    "correctness",
    "trust",
)

STEP_NAMES = ("step", "advance", "tick", "update", "run")
SIGNAL_METHODS = ("signals", "metrics")

_WORD = re.compile(r"[a-z0-9]+")


class DiscoveryError(RuntimeError):
    """Raised when the guard cannot tell which signals it should watch."""


@dataclass(frozen=True)
class RoleAssignment:
    """Which discovered signal plays which role, and why."""

    proxy: str
    standing: str
    proxy_direction: str
    context: tuple[str, ...]
    provenance: tuple[str, ...]


def is_number(value: Any) -> bool:
    """True for finite real numbers, excluding booleans."""
    return (
        isinstance(value, (int, float))
        and not isinstance(value, bool)
        and math.isfinite(value)
    )


def read_frame(system: Any, extra: Mapping[str, Any] | None = None) -> dict[str, float]:
    """Read every observable numeric signal currently exposed by ``system``."""
    frame: dict[str, float] = {}

    try:
        attributes = list(vars(system).items())
    except TypeError:  # objects with __slots__
        attributes = []

    for name, value in attributes:
        if name.startswith("_"):
            continue
        if is_number(value):
            frame[name] = float(value)

    for method_name in SIGNAL_METHODS:
        method = getattr(system, method_name, None)
        if not callable(method):
            continue
        try:
            mapping = method()
        except Exception:  # a broken accessor must not stop the guard
            continue
        if isinstance(mapping, Mapping):
            for key, value in mapping.items():
                if isinstance(key, str) and is_number(value):
                    frame[key] = float(value)

    # Values returned by the step are a fallback source for systems that do not
    # keep their signals on the instance. Skip any that merely repeat a signal
    # already read, so one quantity is not counted twice.
    for key, value in (extra or {}).items():
        if not isinstance(key, str) or not is_number(value) or key in frame:
            continue
        if any(existing == float(value) for existing in frame.values()):
            continue
        frame[key] = float(value)

    return frame


def step_output_signals(raw: Any) -> dict[str, float]:
    """Name the numeric values a step returned, if any."""
    if is_number(raw):
        return {"step_return[0]": float(raw)}
    if isinstance(raw, Mapping):
        return {
            f"step_return[{key}]": float(value)
            for key, value in raw.items()
            if is_number(value)
        }
    if isinstance(raw, (tuple, list)):
        return {
            f"step_return[{index}]": float(value)
            for index, value in enumerate(raw)
            if is_number(value)
        }
    return {}


def step_entry(system: Any) -> Any:
    """Return the callable that advances the system by one step."""
    for name in STEP_NAMES:
        candidate = getattr(system, name, None)
        if callable(candidate):
            return candidate
    if callable(system):
        return system
    raise DiscoveryError(
        f"{type(system).__name__} has no step entry point; expected one of "
        f"{STEP_NAMES} or a callable object"
    )


def classify(
    frames: Sequence[Mapping[str, float]],
    actions: Sequence[Any],
) -> RoleAssignment:
    """Assign the proxy and standing roles from observed frames and actions."""
    if len(frames) < 3:
        raise DiscoveryError(
            "need at least three observed frames before roles can be assigned"
        )

    common = [name for name in frames[-1] if all(name in frame for frame in frames)]
    if len(common) < 2:
        raise DiscoveryError(
            f"found {len(common)} usable numeric signal(s); the guard needs at least "
            "two (a proxy and an independent standing signal). Expose them as public "
            "attributes or from a signals() mapping."
        )

    proxy_hits = [name for name in common if _matches(name, PROXY_HINTS)]
    standing_hits = [name for name in common if _matches(name, STANDING_HINTS)]
    proxy_fixed = proxy_hits[0] if len(proxy_hits) == 1 else None
    standing_fixed = standing_hits[0] if len(standing_hits) == 1 else None

    provenance: list[str] = []
    if proxy_fixed and standing_fixed and proxy_fixed != standing_fixed:
        provenance.append(
            f"name hint: {proxy_fixed!r} reads as a proxy, {standing_fixed!r} reads as "
            "an independently supplied standing signal"
        )
        proxy, standing = proxy_fixed, standing_fixed
    else:
        proxy, standing = _coupling_assignment(
            frames, actions, common, proxy_fixed, standing_fixed, provenance
        )

    direction = _direction_from_coupling(frames, actions, proxy)
    provenance.append(
        f"proxy direction: {direction} (inferred from how the action moves {proxy!r})"
    )

    context = tuple(sorted(name for name in common if name not in {proxy, standing}))
    return RoleAssignment(proxy, standing, direction, context, tuple(provenance))


def _matches(name: str, hints: Sequence[str]) -> bool:
    """Match whole words only, and never on synthetic 'step_return[...]' names."""
    if not name.isidentifier():
        return False
    words = _WORD.findall(name.lower())
    return any(hint in words for hint in hints)


def _coupling_assignment(
    frames: Sequence[Mapping[str, float]],
    actions: Sequence[Any],
    names: Sequence[str],
    proxy_fixed: str | None,
    standing_fixed: str | None,
    provenance: list[str],
) -> tuple[str, str]:
    scores = {name: _coupling(frames, actions, name) for name in names}
    if any(score is None for score in scores.values()):
        raise DiscoveryError(
            "the action did not vary enough to tell the proxy from the standing "
            "signal. Either name the signals unambiguously (for example 'reward' "
            "and 'true_value') or let the action vary during warm-up."
        )

    if proxy_fixed is not None:
        proxy = proxy_fixed
        provenance.append(f"name hint: {proxy!r} reads as a proxy")
    else:
        proxy = max(names, key=lambda name: (scores[name], _variance(frames, name)))
        if standing_fixed == proxy:
            raise DiscoveryError(
                f"{proxy!r} was named as both a proxy and a standing signal"
            )
        provenance.append(
            f"action coupling: {proxy!r} is the signal the action pushes hardest "
            f"(r={scores[proxy]:+.2f})"
        )

    if standing_fixed is not None:
        standing = standing_fixed
        provenance.append(f"name hint: {standing!r} reads as a standing signal")
    else:
        candidates = [
            name
            for name in names
            if name != proxy and _variance(frames, name) > 0.0
        ]
        if not candidates:
            candidates = [name for name in names if name != proxy]
        standing = min(candidates, key=lambda name: abs(scores[name]))
        provenance.append(
            f"action coupling: {standing!r} is the signal the action barely reaches "
            f"(r={scores[standing]:+.2f}), so it can serve as the independent standing "
            "signal"
        )

    if standing == proxy:
        raise DiscoveryError("could not separate a proxy signal from a standing signal")
    return proxy, standing


def _deltas(frames: Sequence[Mapping[str, float]], name: str) -> list[float]:
    return [frames[index][name] - frames[index - 1][name] for index in range(1, len(frames))]


def _variance(frames: Sequence[Mapping[str, float]], name: str) -> float:
    values = [frame[name] for frame in frames]
    mean = sum(values) / len(values)
    return sum((value - mean) ** 2 for value in values) / len(values)


def _coupling(
    frames: Sequence[Mapping[str, float]], actions: Sequence[Any], name: str
) -> float | None:
    if len(actions) != len(frames):
        return None
    if not all(is_number(action) for action in actions):
        return None
    return _pearson([float(action) for action in actions[1:]], _deltas(frames, name))


def _direction_from_coupling(
    frames: Sequence[Mapping[str, float]], actions: Sequence[Any], name: str
) -> str:
    score = _coupling(frames, actions, name)
    if score is None or score == 0.0:
        return MAXIMIZE
    return MAXIMIZE if score > 0 else MINIMIZE


def _pearson(xs: Sequence[float], ys: Sequence[float]) -> float | None:
    count = len(xs)
    if count < 3 or count != len(ys):
        return None
    mean_x = sum(xs) / count
    mean_y = sum(ys) / count
    var_x = sum((value - mean_x) ** 2 for value in xs)
    var_y = sum((value - mean_y) ** 2 for value in ys)
    if var_x <= 0.0 or var_y <= 0.0:
        return None
    covariance = sum(
        (x - mean_x) * (y - mean_y) for x, y in zip(xs, ys)
    )
    return covariance / math.sqrt(var_x * var_y)

"""Directional drift statistics.

The windowed statistic is the same normalized endpoint change that
``goodhart_monitor._normalized_change`` already uses in this repository: each
signal is rescaled by its peak magnitude inside the window, and the endpoint
difference is divided by the window span.

The guard keeps its own copy so the package can be vendored on its own, and
``Tests/test_standing_guard.py`` pins the two implementations to each other so
they cannot drift apart.
"""

from __future__ import annotations

from typing import Sequence

MAXIMIZE = "maximize"
MINIMIZE = "minimize"


def orientation(direction: str) -> float:
    """Return the sign that turns a raw trend into an improvement."""
    if direction == MAXIMIZE:
        return 1.0
    if direction == MINIMIZE:
        return -1.0
    raise ValueError(f"unknown direction: {direction!r}")


def normalized_change(values: Sequence[float], direction: str = MAXIMIZE) -> float | None:
    """Directional endpoint change as a fraction of the window span.

    Returns ``None`` when the trend is undefined: fewer than two values, an
    all-zero window, or a constant window. A positive result always means
    "improved in the configured direction", whatever the raw sign.
    """
    if len(values) < 2:
        return None
    scale = max(abs(value) for value in values)
    if scale == 0:
        return None
    scaled = [value / scale for value in values]
    span = max(scaled) - min(scaled)
    if span == 0:
        return None
    return orientation(direction) * (scaled[-1] - scaled[0]) / span

#!/usr/bin/env python3
"""A system that drifts, and the same system under the Standing Guard.

The system is an ordinary Python class. It exposes two observable signals and a
``step`` method, and that is all the guard is given: no schema, no thresholds,
no signal mapping. Run this file to see the unguarded run collapse and the
guarded run held on the admissible boundary, with a report of both.
"""

from __future__ import annotations

from standing_guard import StandingGuard


class PushingSystem:
    """A recommender-style loop whose action only ever pushes one way.

    ``engagement`` is the proxy the action drives: every step of push raises it
    without bound. ``true_value`` is an independently measured standing signal
    that is flat until the state passes the admissible boundary at 3.0, then
    falls away quadratically. Nothing tells the guard any of this.
    """

    BOUNDARY = 3.0

    def __init__(self) -> None:
        self.state = 0.0
        self.engagement = 10.0
        self.true_value = 50.0

    def step(self, action: float) -> tuple[float, float]:
        self.state += action
        self.engagement = 10.0 + 3.0 * self.state
        overshoot = max(0.0, self.state - self.BOUNDARY)
        self.true_value = 50.0 - 0.4 * overshoot**2
        return self.engagement, self.true_value


def run_unguarded(steps: int) -> list[tuple[float, float, float]]:
    system = PushingSystem()
    trace = []
    for _ in range(steps):
        system.step(1.0)
        trace.append((system.state, system.engagement, system.true_value))
    return trace


def run_guarded(steps: int, guard_out):
    system = PushingSystem()
    guard = StandingGuard.wrap(system, label="pushing-system")
    trace = []
    for _ in range(steps):
        guard.step(1.0)
        trace.append((system.state, system.engagement, system.true_value))
    guard_out.append(guard)
    return trace


def summarise(name: str, trace: list[tuple[float, float, float]]) -> None:
    state, engagement, true_value = trace[-1]
    peak = max(item[2] for item in trace)
    print(
        f"{name:<12} final state {state:6.2f}   engagement {engagement:7.2f}   "
        f"true_value {true_value:7.2f}   worst true_value {min(i[2] for i in trace):7.2f}   "
        f"peak {peak:6.2f}"
    )


def main() -> None:
    steps = 24
    print("=== Standing Guard demo ===")
    print(f"{steps} steps, the same action requested every step, no configuration.\n")

    unguarded = run_unguarded(steps)
    holders: list[StandingGuard] = []
    guarded = run_guarded(steps, holders)
    guard = holders[0]

    summarise("unguarded", unguarded)
    summarise("guarded", guarded)
    print()

    print("--- guarded trace (state, engagement, true_value) ---")
    for index, (state, engagement, true_value) in enumerate(guarded):
        print(f"step {index:2d}   {state:6.2f}   {engagement:7.2f}   {true_value:7.2f}")
    print()

    print(guard.report().to_markdown())


if __name__ == "__main__":
    main()

"""Report rendering: what drifted, what the guard did, and what it cannot know."""

from __future__ import annotations

import copy
import json
from typing import Any

LIMITS = (
    "Detection is a windowed statistic over the signals the system exposes; it "
    "needs warm-up and cannot see drift that never shows up in those signals.",
    "The standing signal is whatever the integration exposes. The guard cannot "
    "verify that it measures the true objective.",
    "Correction is limited to scaling the requested action (damping, freezing, "
    "or reversing where the schedule allows). A system whose action cannot be "
    "scaled can only be blocked.",
    "Candidate steps are replayed from a deep copy of the system's attributes. "
    "Side effects outside that attribute state are not undone.",
    "Testing candidates re-executes the system's step once per scaling in the "
    "correction schedule, so a guarded step can cost several times an unguarded "
    "one while a hold is active.",
    "Enforcing non-decreasing standing applies the Lean theorem's hypothesis "
    "empirically; it is not a proof that the system is safe, aligned, or "
    "non-manipulative.",
)


class GuardReport:
    """A JSON- and Markdown-renderable record of one guard run."""

    def __init__(self, data: dict[str, Any]) -> None:
        self._data = data

    def to_dict(self) -> dict[str, Any]:
        return copy.deepcopy(self._data)

    def to_json(self, indent: int = 2) -> str:
        return json.dumps(self._data, indent=indent, sort_keys=True, allow_nan=False)

    def to_markdown(self) -> str:
        return _to_markdown(self._data)


def build_report(guard: Any) -> GuardReport:
    roles = guard.roles
    episodes = [_episode_record(episode) for episode in guard.episodes]
    return GuardReport(
        {
            "label": guard.label,
            "status": guard.status.value,
            "principle": (
                "a proxy-improving transition must be an admissible operation, and "
                "admissible operations do not decrease standing"
            ),
            "roles": (
                {
                    "proxy": roles.proxy,
                    "standing": roles.standing,
                    "proxy_direction": roles.proxy_direction,
                    "context": list(roles.context),
                    "provenance": list(roles.provenance),
                }
                if roles is not None
                else None
            ),
            "config": {
                "window_size": guard.config.window_size,
                "min_observations": guard.config.min_observations,
                "warmup_steps": guard.config.warmup_steps,
                "min_proxy_improvement": guard.config.min_proxy_improvement,
                "max_standing_decline": guard.config.max_standing_decline,
                "correction_schedule": list(guard.config.correction_schedule),
                "allow_reversal": guard.config.allow_reversal,
                "standing_tolerance": guard.config.standing_tolerance,
            },
            "totals": dict(guard.counters),
            "episodes": episodes,
            "notes": list(guard.notes),
            "limits": list(LIMITS),
        }
    )


def _episode_record(episode: Any) -> dict[str, Any]:
    interventions = []
    for item in episode.interventions:
        interventions.append(
            {
                "step": item.step,
                "applied_alpha": item.applied_alpha,
                "trials": [
                    {"alpha": alpha, "standing_delta": delta}
                    for alpha, delta in item.trials
                ],
                "standing_before": item.standing_before,
                "standing_after": item.standing_after,
                "unguarded_delta": item.unguarded_delta,
                "standing_preserved": item.standing_preserved,
            }
        )
    preserved = [
        item["standing_preserved"]
        for item in interventions
        if item["standing_preserved"] is not None
    ]
    notes = list(episode.notes)
    if episode.closed_at is None:
        notes.insert(
            0,
            "the hold is still active: the system keeps requesting a step that "
            "costs standing",
        )
    return {
        "episode": episode.number,
        "opened_at_step": episode.opened_at,
        "closed_at_step": episode.closed_at,
        "proxy": episode.proxy,
        "standing": episode.standing,
        "normalized_proxy_change": episode.proxy_change,
        "normalized_standing_change": episode.standing_change,
        "worst_transition": episode.worst_transition,
        "interventions": interventions,
        "measured_standing_preserved": sum(preserved) if preserved else None,
        "notes": notes,
    }


def _format(value: Any, digits: int = 3) -> str:
    if value is None:
        return "n/a"
    if isinstance(value, float):
        return f"{value:.{digits}f}"
    return str(value)


def _signed(value: Any, digits: int = 3) -> str:
    if value is None:
        return "n/a"
    if isinstance(value, float):
        return f"{value:+.{digits}f}"
    return str(value)


def _outcome(alpha: float) -> str:
    if alpha == 1.0:
        return "allowed unchanged"
    if alpha == 0.0:
        return "held in place, no admissible movement"
    if alpha < 0.0:
        return "reversed to restore standing"
    return "damped to the admissible fraction"


def _to_markdown(data: dict[str, Any]) -> str:
    lines: list[str] = []
    totals = data["totals"]
    lines.append(f"# Standing Guard report — {data['label']}")
    lines.append("")
    lines.append(
        f"**Status:** {data['status']}  |  **Steps guarded:** {totals['steps']}  |  "
        f"**Corrected:** {totals['corrected']}  |  **Blocked:** {totals['blocked']}"
    )
    lines.append("")
    lines.append(f"**Principle enforced:** {data['principle']}.")
    lines.append("")

    roles = data.get("roles")
    lines.append("## Signals and roles")
    lines.append("")
    if roles is None:
        lines.append(
            "_No roles were assigned: the run ended before warm-up completed._"
        )
    else:
        lines.append(f"- **Proxy:** `{roles['proxy']}` ({roles['proxy_direction']})")
        lines.append(f"- **Standing:** `{roles['standing']}`")
        if roles["context"]:
            lines.append(
                "- **Context only:** "
                + ", ".join(f"`{name}`" for name in roles["context"])
            )
        lines.append("")
        for line in roles["provenance"]:
            lines.append(f"- {line}")
    lines.append("")

    lines.append("## Drift episodes")
    lines.append("")
    if not data["episodes"]:
        lines.append(
            "_No proxy-up/standing-down window was observed in this run._"
        )
        lines.append("")
    for episode in data["episodes"]:
        closed = episode["closed_at_step"]
        lines.append(
            f"### Episode {episode['episode']} — opened at step "
            f"{episode['opened_at_step']}, "
            + (f"closed at step {closed}" if closed is not None else "still open")
        )
        lines.append("")
        lines.append(
            f"- Proxy `{episode['proxy']}` moved {_format(episode['normalized_proxy_change'])} "
            f"(normalized over the window)"
        )
        lines.append(
            f"- Standing `{episode['standing']}` moved "
            f"{_format(episode['normalized_standing_change'])}"
        )
        worst = episode["worst_transition"]
        if worst:
            lines.append(
                f"- Worst transition at step {worst['step']}: "
                f"{episode['proxy']} {worst['proxy_before']:.3f} → "
                f"{worst['proxy_after']:.3f}, {episode['standing']} "
                f"{worst['standing_before']:.3f} → {worst['standing_after']:.3f}"
            )
        lines.append("")
        if episode["interventions"]:
            lines.append("| step | scaling applied | standing before → after | outcome |")
            lines.append("| --- | --- | --- | --- |")
            for item in episode["interventions"]:
                lines.append(
                    f"| {item['step']} | {item['applied_alpha']:+.2f} | "
                    f"{_format(item['standing_before'])} → "
                    f"{_format(item['standing_after'])} | "
                    f"{_outcome(item['applied_alpha'])} |"
                )
            lines.append("")
        else:
            lines.append("_No step required correction inside this episode._")
            lines.append("")
        if episode["measured_standing_preserved"] is not None:
            lines.append(
                "Measured standing preserved: "
                f"{_format(episode['measured_standing_preserved'])} "
                "(the full action was replayed from the same state, so this is a "
                "measured difference, not a counterfactual estimate)."
            )
            lines.append("")
        if episode["notes"]:
            for note in episode["notes"]:
                lines.append(f"- {note}")
            lines.append("")

    lines.append("## Totals")
    lines.append("")
    lines.append(
        f"- Drift transitions observed: {totals['observed_drift_transitions']}"
    )
    lines.append(
        f"- Drift transitions admitted while unguarded: "
        f"{totals['admitted_drift_transitions']}"
    )
    lines.append(f"- Steps corrected: {totals['corrected']}")
    lines.append(f"- Steps blocked: {totals['blocked']}")
    lines.append("")

    if data["notes"]:
        lines.append("## Review record")
        lines.append("")
        for note in data["notes"]:
            lines.append(f"- {note}")
        lines.append("")

    lines.append("## Limits")
    lines.append("")
    for limit in data["limits"]:
        lines.append(f"- {limit}")
    lines.append("")
    return "\n".join(lines)

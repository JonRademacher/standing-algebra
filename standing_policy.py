#!/usr/bin/env python3
"""standing_policy.py - a drop-in Standing Algebra (Sigma-R) policy layer for AI.

One file, standard library only. Copy it next to your agent, declare the policy
explicitly, and route every proposed action through it before it runs.

The layer is *declared*, never inferred. You name the proxy signal the AI is
rewarded for, the standing signals it must not spend, and the floors those
signals may not fall below. The AI then has to submit each action as a proposal
that states what it expects the action to do to every standing signal, plus the
evidence it is relying on. The policy admits, dampens, holds or blocks:

    allow   the proposal is admissible at the requested scale
    dampen  admissible only at a reduced scale (drift is latched, cap applies)
    hold    cannot be evaluated or evidence is missing - fail closed, do not act
    block   the proposal declares or would cause a breach - never admitted

Rules, evaluated in this order, each with its own reason code:

    R1 malformed_proposal          the proposal is not a readable action record
    R2 insufficient_signals        the declared signals are not observable yet
    R3 declared_tradeoff           the proposal claims a standing decrease
    R4 floor_breached              standing is below its floor and no repair claimed
    R5 undeclared_standing_effect  no expected effect stated for a standing signal
    R6 evidence_required           drift is latched and no evidence is cited
    R7 drift_capped                drift is latched; scale capped at drift_scale_cap
    R8 admissible                  no rule fired

Usage, in an agent loop:

    from standing_policy import Policy, StandingPolicy

    policy = StandingPolicy(Policy.from_dict({
        "name": "assistant-tools",
        "proxy": {"name": "engagement", "direction": "maximize"},
        "standing": [{"name": "user_value", "floor": 0.35}],
    }))

    policy.observe({"engagement": 0.41, "user_value": 0.72})
    decision = policy.judge({
        "action": "push_notifications",
        "scale": 1.0,
        "expected": {"engagement": 0.20, "user_value": 0.00},
        "evidence": "abtest-117",
    })
    if decision.admitted:
        run(decision.action, scale=decision.scale)
    else:
        ask_for_more_evidence(decision.explain())

Or as a fail-closed guard on a tool function:

    @policy.tool()
    def send_campaign(audience, scale=1.0):
        ...

    send_campaign("weekly", expected={"engagement": 0.2, "user_value": 0.0},
                  evidence="abtest-117")

``policy.system_prompt()`` renders the same policy as text for an agent's system
prompt, so the model is told the rules it is being judged by.

The refusal is the hypothesis of
``Collapse_Demonstrations/Goodhart_Drift/Goodhart_WithStanding.lean``
(``noGoodhartDrift_under_StandingAlgebra``): no proxy-improving transition that
is standing non-decreasing. This layer enforces that hypothesis for AI actions
empirically, against signals you declare. It is not a proof that those signals
are the true objective, and it does not decide what the objective is.

Command line::

    python standing_policy.py prompt --policy policy.json
    python standing_policy.py screen --policy policy.json --observation obs.json \\
        --proposal proposal.json
    python standing_policy.py verify decisions.jsonl

``screen`` exits 0 when the proposal is admitted, 2 when it is held or blocked,
1 when a receipt log failed verification.
"""

from __future__ import annotations

import argparse
import functools
import hashlib
import inspect
import json
import sys
from collections import deque
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Callable, Iterable, Mapping, Sequence

MAXIMIZE = "maximize"
MINIMIZE = "minimize"

ALLOW = "allow"
DAMPEN = "dampen"
HOLD = "hold"
BLOCK = "block"

_ADMITTING = (ALLOW, DAMPEN)
_GENESIS = "0" * 64


class ProposalError(ValueError):
    """Raised when a proposal cannot be read as an action record."""


class PolicyViolation(RuntimeError):
    """Raised by ``StandingPolicy.tool`` when a call is not admitted."""

    def __init__(self, decision: "Decision") -> None:
        super().__init__(decision.explain())
        self.decision = decision


# --------------------------------------------------------------------------
# declaration
# --------------------------------------------------------------------------


def _finite(value: Any, field_name: str) -> float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ValueError(f"{field_name} must be a number")
    number = float(value)
    if number != number or number in (float("inf"), float("-inf")):
        raise ValueError(f"{field_name} must be finite")
    return number


def _proposal_number(value: Any, field_name: str) -> float:
    """``_finite`` for model-supplied values: any bad number is a ``ProposalError``."""
    try:
        return _finite(value, field_name)
    except ValueError as error:
        raise ProposalError(str(error)) from None


@dataclass(frozen=True)
class Signal:
    """One declared measurement. ``direction`` says which way is better."""

    name: str
    direction: str = MAXIMIZE
    floor: float | None = None
    description: str = ""

    def __post_init__(self) -> None:
        if not isinstance(self.name, str) or not self.name.strip():
            raise ValueError("signal name must be a non-empty string")
        if self.direction not in (MAXIMIZE, MINIMIZE):
            raise ValueError(
                f"signal {self.name!r}: direction must be {MAXIMIZE!r} or {MINIMIZE!r}"
            )
        if self.floor is not None:
            _finite(self.floor, f"signal {self.name!r} floor")
        if not isinstance(self.description, str):
            raise ValueError(f"signal {self.name!r}: description must be a string")

    @property
    def orientation(self) -> float:
        """Sign that turns a raw trend into an improvement."""
        return 1.0 if self.direction == MAXIMIZE else -1.0

    def to_dict(self) -> dict[str, Any]:
        data: dict[str, Any] = {"name": self.name, "direction": self.direction}
        if self.floor is not None:
            data["floor"] = self.floor
        if self.description:
            data["description"] = self.description
        return data


def _as_signal(raw: Any, role: str) -> Signal:
    if isinstance(raw, Signal):
        return raw
    if isinstance(raw, str):
        return Signal(name=raw)
    if isinstance(raw, Mapping):
        name = raw.get("name")
        if not isinstance(name, str) or not name.strip():
            raise ValueError(f"{role} signal needs a name")
        return Signal(
            name=name.strip(),
            direction=str(raw.get("direction", MAXIMIZE)),
            floor=raw.get("floor"),
            description=str(raw.get("description", "")),
        )
    raise ValueError(f"{role} must be a signal name, a signal mapping, or a Signal")


@dataclass(frozen=True)
class Policy:
    """An explicit standing policy: one proxy, its standing signals, its rules."""

    name: str
    proxy: Signal
    standing: tuple[Signal, ...]
    window: int = 8
    min_observations: int = 4
    drift_threshold: float = 0.05
    harm_threshold: float = 0.02
    drift_scale_cap: float = 0.25
    require_evidence_on_drift: bool = True
    require_declared_effects: bool = True
    notes: str = ""

    def __post_init__(self) -> None:
        if not isinstance(self.name, str) or not self.name.strip():
            raise ValueError("policy name must be a non-empty string")
        if not isinstance(self.standing, tuple) or not self.standing:
            raise ValueError("policy must declare at least one standing signal")
        names = [self.proxy.name] + [signal.name for signal in self.standing]
        if len(set(names)) != len(names):
            raise ValueError("signal names must be distinct across the policy")
        if self.window < 3:
            raise ValueError("window must be at least 3")
        if not 2 <= self.min_observations <= self.window:
            raise ValueError("min_observations must be between 2 and window")
        for field_name, value in (
            ("drift_threshold", self.drift_threshold),
            ("harm_threshold", self.harm_threshold),
            ("drift_scale_cap", self.drift_scale_cap),
        ):
            if not 0.0 < _finite(value, field_name) <= 1.0:
                raise ValueError(f"{field_name} must be in (0, 1]")

    # -- construction ---------------------------------------------------

    @classmethod
    def from_dict(cls, data: Mapping[str, Any]) -> "Policy":
        """Read a policy declared as plain data (also the JSON file format)."""
        if not isinstance(data, Mapping):
            raise ValueError("policy must be a mapping")
        missing = {"name", "proxy", "standing"} - set(data)
        if missing:
            raise ValueError(f"policy is missing: {', '.join(sorted(missing))}")
        raw_standing = data["standing"]
        if isinstance(raw_standing, (str, Mapping)):
            raw_standing = [raw_standing]
        if not isinstance(raw_standing, Sequence):
            raise ValueError("standing must be a list of signals")
        standing = tuple(_as_signal(item, "standing") for item in raw_standing)
        known = {
            "window",
            "min_observations",
            "drift_threshold",
            "harm_threshold",
            "drift_scale_cap",
            "require_evidence_on_drift",
            "require_declared_effects",
            "notes",
        }
        unknown = set(data) - known - {"name", "proxy", "standing"}
        if unknown:
            raise ValueError(f"unknown policy fields: {', '.join(sorted(unknown))}")
        return cls(
            name=str(data["name"]),
            proxy=_as_signal(data["proxy"], "proxy"),
            standing=standing,
            **{key: data[key] for key in known if key in data},
        )

    @classmethod
    def load(cls, path: str | Path) -> "Policy":
        return cls.from_dict(json.loads(Path(path).read_text(encoding="utf-8")))

    def to_dict(self) -> dict[str, Any]:
        return {
            "name": self.name,
            "proxy": self.proxy.to_dict(),
            "standing": [signal.to_dict() for signal in self.standing],
            "window": self.window,
            "min_observations": self.min_observations,
            "drift_threshold": self.drift_threshold,
            "harm_threshold": self.harm_threshold,
            "drift_scale_cap": self.drift_scale_cap,
            "require_evidence_on_drift": self.require_evidence_on_drift,
            "require_declared_effects": self.require_declared_effects,
            "notes": self.notes,
        }

    @property
    def fingerprint(self) -> str:
        """SHA-256 over the canonical policy, so a run can be pinned to it."""
        return hashlib.sha256(
            json.dumps(self.to_dict(), sort_keys=True, separators=(",", ":")).encode("utf-8")
        ).hexdigest()

    @property
    def signals(self) -> tuple[Signal, ...]:
        return (self.proxy,) + self.standing


# --------------------------------------------------------------------------
# proposals
# --------------------------------------------------------------------------


@dataclass(frozen=True)
class Proposal:
    """What the AI wants to do, and what it says the action will do."""

    action: str
    scale: float = 1.0
    expected: Mapping[str, float] = field(default_factory=dict)
    evidence: str | None = None
    note: str = ""

    def __post_init__(self) -> None:
        if not isinstance(self.action, str) or not self.action.strip():
            raise ProposalError("action must be a non-empty string")
        scale = _proposal_number(self.scale, "scale")
        if not 0.0 < scale <= 1.0:
            raise ProposalError("scale must be greater than 0 and at most 1")
        if not isinstance(self.expected, Mapping):
            raise ProposalError("expected must map signal names to expected changes")
        for key, value in self.expected.items():
            if not isinstance(key, str):
                raise ProposalError("expected keys must be signal names")
            _proposal_number(value, f"expected[{key}]")
        if self.evidence is not None and not isinstance(self.evidence, str):
            raise ProposalError("evidence must be a string reference")
        if self.evidence is not None and not self.evidence.strip():
            raise ProposalError("evidence must not be blank")

    @classmethod
    def from_raw(cls, raw: Any) -> "Proposal":
        """Accept a Proposal, a mapping, or JSON text produced by a model."""
        if isinstance(raw, Proposal):
            return raw
        if isinstance(raw, str):
            try:
                raw = json.loads(raw)
            except json.JSONDecodeError as error:
                raise ProposalError(f"proposal is not valid JSON: {error}") from error
        if not isinstance(raw, Mapping):
            raise ProposalError("proposal must be a mapping or JSON object")
        unknown = set(raw) - {"action", "scale", "expected", "evidence", "note"}
        if unknown:
            raise ProposalError(f"unknown proposal fields: {', '.join(sorted(unknown))}")
        evidence = raw.get("evidence")
        if isinstance(evidence, str) and not evidence.strip():
            evidence = None
        expected = raw.get("expected", {})
        if expected is None:
            expected = {}
        return cls(
            action=raw.get("action", ""),
            scale=raw.get("scale", 1.0),
            expected=dict(expected) if isinstance(expected, Mapping) else expected,
            evidence=evidence,
            note=str(raw.get("note", "")),
        )


# --------------------------------------------------------------------------
# decisions
# --------------------------------------------------------------------------


@dataclass(frozen=True)
class Decision:
    """The policy's verdict on one proposal, with its reasons and statistics."""

    policy: str
    fingerprint: str
    action: str
    status: str
    code: str
    reasons: tuple[str, ...]
    requested_scale: float
    scale: float
    evidence: str | None
    statistics: Mapping[str, Any]
    at: str

    @property
    def admitted(self) -> bool:
        return self.status in _ADMITTING

    def explain(self) -> str:
        detail = " ".join(self.reasons)
        return f"{self.status.upper()} {self.action!r} [{self.code}] {detail}".strip()

    def to_dict(self) -> dict[str, Any]:
        return {
            "policy": self.policy,
            "fingerprint": self.fingerprint,
            "action": self.action,
            "status": self.status,
            "code": self.code,
            "admitted": self.admitted,
            "scale": self.scale,
            "requested_scale": self.requested_scale,
            "evidence": self.evidence,
            "reasons": list(self.reasons),
            "statistics": dict(self.statistics),
            "at": self.at,
        }


# --------------------------------------------------------------------------
# tamper-evident receipts
# --------------------------------------------------------------------------


def _canonical(value: Any) -> bytes:
    return json.dumps(value, sort_keys=True, separators=(",", ":")).encode("utf-8")


def _entry_hash(entry: Mapping[str, Any]) -> str:
    body = {key: entry.get(key) for key in ("seq", "at", "prev", "receipt")}
    return hashlib.sha256(_canonical(body)).hexdigest()


class ReceiptLog:
    """Append-only hash-chained JSONL record of every decision."""

    def __init__(self, path: str | Path) -> None:
        self.path = Path(path)

    def _entries(self) -> list[dict[str, Any]]:
        if not self.path.is_file():
            return []
        return [
            json.loads(line)
            for line in self.path.read_text(encoding="utf-8").splitlines()
            if line.strip()
        ]

    def append(self, receipt: Mapping[str, Any]) -> dict[str, Any]:
        entries = self._entries()
        entry: dict[str, Any] = {
            "seq": len(entries),
            "at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
            "prev": entries[-1]["hash"] if entries else _GENESIS,
            "receipt": dict(receipt),
        }
        entry["hash"] = _entry_hash(entry)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        with self.path.open("a", encoding="utf-8", newline="\n") as stream:
            stream.write(json.dumps(entry, sort_keys=True, separators=(",", ":")) + "\n")
        return entry


def verify_receipts(path: str | Path) -> tuple[bool, str]:
    """Recompute a receipt chain, naming the first line that does not hold."""
    log = Path(path)
    if not log.is_file():
        return False, f"no receipt log at {log}"
    previous = _GENESIS
    count = 0
    for number, line in enumerate(log.read_text(encoding="utf-8").splitlines(), 1):
        if not line.strip():
            return False, f"line {number}: blank entry"
        try:
            entry = json.loads(line)
        except json.JSONDecodeError:
            return False, f"line {number}: not valid JSON"
        if entry.get("seq") != count:
            return False, (
                f"line {number}: out of order (seq {entry.get('seq')}, expected {count})"
            )
        if entry.get("prev") != previous:
            return False, f"line {number}: chain broken (previous hash mismatch)"
        if entry.get("hash") != _entry_hash(entry):
            return False, f"line {number}: entry altered (hash mismatch)"
        previous = entry["hash"]
        count += 1
    return True, f"{count} receipt(s) verified"


# --------------------------------------------------------------------------
# the layer
# --------------------------------------------------------------------------


def _normalized_change(values: Sequence[float], signal: Signal) -> float | None:
    """Endpoint change as a fraction of the window span, sign-corrected.

    Pinned to ``standing_guard.drift.normalized_change`` by a test: a positive
    result always means "improved in the declared direction".
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
    return signal.orientation * (scaled[-1] - scaled[0]) / span


class StandingPolicy:
    """Observe declared signals, judge proposals, keep the receipts."""

    def __init__(
        self,
        policy: Policy,
        *,
        log: ReceiptLog | None = None,
        clock: Callable[[], datetime] | None = None,
    ) -> None:
        self.policy = policy
        self.log = log
        self.frames: deque[dict[str, float]] = deque(maxlen=policy.window)
        self.decisions: list[Decision] = []
        self.counts = {ALLOW: 0, DAMPEN: 0, HOLD: 0, BLOCK: 0}
        self._clock = clock or (lambda: datetime.now(timezone.utc))

    @classmethod
    def declare(cls, data: Mapping[str, Any], **kwargs: Any) -> "StandingPolicy":
        return cls(Policy.from_dict(data), **kwargs)

    # -- observation ----------------------------------------------------

    def observe(self, metrics: Mapping[str, Any]) -> dict[str, float]:
        """Record one frame of measured signals. Non-numeric entries are dropped."""
        if not isinstance(metrics, Mapping):
            raise TypeError("metrics must be a mapping of signal names to numbers")
        frame: dict[str, float] = {}
        for name, value in metrics.items():
            if isinstance(value, bool) or not isinstance(value, (int, float)):
                continue
            if value != value:  # NaN
                continue
            frame[str(name)] = float(value)
        self.frames.append(frame)
        return frame

    @property
    def latest(self) -> dict[str, float]:
        return dict(self.frames[-1]) if self.frames else {}

    def check(self, metrics: Mapping[str, Any], proposal: Any = None) -> Decision:
        """Observe a frame and judge a proposal against it, in one call."""
        self.observe(metrics)
        return self.judge(proposal)

    # -- judgement ------------------------------------------------------

    def judge(self, proposal: Any = None) -> Decision:
        """Apply the ordered rules to ``proposal`` and record the decision."""
        if proposal is None:
            proposal = {
                "action": "<status check>",
                "expected": {signal.name: 0.0 for signal in self.policy.standing},
            }
        try:
            proposal = Proposal.from_raw(proposal)
        except ProposalError as error:
            return self._record(
                "<malformed>", HOLD, "malformed_proposal", (str(error),),
                1.0, 0.0, None, self._statistics(),
            )

        statistics = self._statistics()
        latest = self.latest
        expected = {name: float(value) for name, value in proposal.expected.items()}

        # R2: the policy cannot judge what it cannot see.
        missing = [signal.name for signal in self.policy.signals if signal.name not in latest]
        if len(self.frames) < 2 or missing:
            reasons = []
            if len(self.frames) < 2:
                reasons.append(f"only {len(self.frames)} observation(s) recorded, need 2.")
            if missing:
                reasons.append(f"no reading for {', '.join(missing)}.")
            reasons.append("An unobserved signal is not evidence of standing.")
            return self._record(
                proposal.action, HOLD, "insufficient_signals", reasons,
                proposal.scale, 0.0, proposal.evidence, statistics,
            )

        # R3: a declared standing decrease is a declared trade, and is refused.
        standing_names = {signal.name for signal in self.policy.standing}
        declared = [
            f"{name} {value:+.3f}"
            for name, value in expected.items()
            if name in standing_names and value < 0.0
        ]
        if declared:
            return self._record(
                proposal.action, BLOCK, "declared_tradeoff",
                (f"The proposal declares a standing decrease: {', '.join(declared)}.",
                 "Standing is not currency the policy lets an action spend."),
                proposal.scale, 0.0, proposal.evidence, statistics,
            )

        # R4: a breached floor admits only a declared repair.
        breached = [
            signal for signal in self.policy.standing
            if signal.floor is not None and latest[signal.name] < signal.floor
        ]
        if breached:
            unrepaired = [
                f"{signal.name} at {latest[signal.name]:.3f} (floor {signal.floor:.3f})"
                for signal in breached
                if expected.get(signal.name, 0.0) <= 0.0
            ]
            if unrepaired:
                return self._record(
                    proposal.action, BLOCK, "floor_breached",
                    (f"Standing floor breached: {'; '.join(unrepaired)}.",
                     "Only an action that declares a standing increase for the breached "
                     "signal is admitted until it recovers."),
                    proposal.scale, 0.0, proposal.evidence, statistics,
                )
            return self._record(
                proposal.action, ALLOW, "floor_repair",
                (f"Standing floor breached: {'; '.join(s.name for s in breached)}.",
                 "The proposal declares the repair, so it is admitted."),
                proposal.scale, proposal.scale, proposal.evidence, statistics,
            )

        # R5: the AI must state its effect on every standing signal.
        if self.policy.require_declared_effects:
            undeclared = [
                signal.name for signal in self.policy.standing
                if signal.name not in expected
            ]
            if undeclared:
                return self._record(
                    proposal.action, HOLD, "undeclared_standing_effect",
                    (f"No expected effect declared for {', '.join(undeclared)}.",
                     "State the expected change for every standing signal, or the "
                     "policy has no claim to check."),
                    proposal.scale, 0.0, proposal.evidence, statistics,
                )

        # R6/R7: latched drift needs cited evidence and caps the scale.
        if statistics["drifting"]:
            separating = ", ".join(
                f"{name} {change:+.3f}"
                for name, change in statistics["standing_change"].items()
                if change is not None and change <= -self.policy.harm_threshold
            )
            if self.policy.require_evidence_on_drift and not proposal.evidence:
                return self._record(
                    proposal.action, HOLD, "evidence_required",
                    (f"Drift latched: {self.policy.proxy.name} "
                     f"{statistics['proxy_change']:+.3f} while {separating}.",
                     "Cite evidence for the expected standing effect before acting."),
                    proposal.scale, 0.0, proposal.evidence, statistics,
                )
            cap = min(proposal.scale, self.policy.drift_scale_cap)
            citation = f" Evidence: {proposal.evidence}." if proposal.evidence else ""
            return self._record(
                proposal.action,
                DAMPEN if cap < proposal.scale else ALLOW,
                "drift_capped",
                (f"Drift latched: {self.policy.proxy.name} "
                 f"{statistics['proxy_change']:+.3f} while {separating}.",
                 f"Scale held to {cap:.2f} of the request (cap "
                 f"{self.policy.drift_scale_cap:.2f}).{citation}"),
                proposal.scale, cap, proposal.evidence, statistics,
            )

        # R8: nothing fired.
        return self._record(
            proposal.action, ALLOW, "admissible",
            ("No declared trade, breach, or latched drift.",),
            proposal.scale, proposal.scale, proposal.evidence, statistics,
        )

    # -- statistics -----------------------------------------------------

    def _statistics(self) -> dict[str, Any]:
        frames = list(self.frames)
        change: dict[str, float | None] = {}
        for signal in self.policy.signals:
            values = [frame[signal.name] for frame in frames if signal.name in frame]
            change[signal.name] = _normalized_change(values, signal)
        proxy_change = change[self.policy.proxy.name]
        standing_change = {
            signal.name: change[signal.name] for signal in self.policy.standing
        }
        drifting = bool(
            len(frames) >= self.policy.min_observations
            and proxy_change is not None
            and proxy_change >= self.policy.drift_threshold
            and any(
                value is not None and value <= -self.policy.harm_threshold
                for value in standing_change.values()
            )
        )
        return {
            "samples": len(frames),
            "proxy": self.policy.proxy.name,
            "proxy_change": proxy_change,
            "standing_change": standing_change,
            "drifting": drifting,
        }

    # -- recording ------------------------------------------------------

    def _record(
        self,
        action: str,
        status: str,
        code: str,
        reasons: Iterable[str],
        requested_scale: float,
        scale: float,
        evidence: str | None,
        statistics: Mapping[str, Any],
    ) -> Decision:
        decision = Decision(
            policy=self.policy.name,
            fingerprint=self.policy.fingerprint,
            action=action,
            status=status,
            code=code,
            reasons=tuple(reasons),
            requested_scale=requested_scale,
            scale=scale,
            evidence=evidence,
            statistics=dict(statistics),
            at=self._clock().isoformat(timespec="seconds"),
        )
        self.counts[status] += 1
        self.decisions.append(decision)
        if self.log is not None:
            self.log.append(decision.to_dict())
        return decision

    # -- integration surface --------------------------------------------

    def tool(self, action: str | None = None) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        """Wrap a function so it runs only when the policy admits the call.

        The wrapper accepts ``proposal``, or ``expected``/``evidence``/``scale``,
        and optionally ``metrics`` to observe a fresh frame. A refused call
        raises ``PolicyViolation``; an admitted call receives the admitted
        ``scale`` if the function declares that parameter.
        """

        def decorate(function: Callable[..., Any]) -> Callable[..., Any]:
            name = action or function.__name__
            takes_scale = "scale" in inspect.signature(function).parameters

            @functools.wraps(function)
            def wrapper(*args: Any, **kwargs: Any) -> Any:
                metrics = kwargs.pop("metrics", None)
                if metrics is not None:
                    self.observe(metrics)
                raw = kwargs.pop("proposal", None)
                if raw is None:
                    raw = {
                        "action": name,
                        "scale": kwargs.pop("scale", 1.0),
                        "expected": kwargs.pop("expected", {}),
                        "evidence": kwargs.pop("evidence", None),
                    }
                decision = self.judge(raw)
                if not decision.admitted:
                    raise PolicyViolation(decision)
                if takes_scale:
                    kwargs["scale"] = decision.scale
                return function(*args, **kwargs)

            return wrapper

        return decorate

    def system_prompt(self) -> str:
        """The policy as text, for an agent's system prompt."""
        policy = self.policy
        lines = [
            f"STANDING POLICY: {policy.name} (sha256 {policy.fingerprint[:16]})",
            "",
            "Every action you propose is judged by this policy before it runs. Do not",
            "describe or plan an action you have not submitted for judgement.",
            "",
            "Signals:",
            f"  proxy    {policy.proxy.name} [{policy.proxy.direction}]"
            " - the number you are rewarded for; it is a proxy, not the objective.",
        ]
        for signal in policy.standing:
            floor = "" if signal.floor is None else f", floor {signal.floor:g}"
            lines.append(
                f"  standing {signal.name} [{signal.direction}{floor}]"
                " - must not be spent to raise the proxy."
            )
        declared = ", ".join(f'"{s.name}": <number>' for s in policy.signals)
        lines += [
            "",
            "Submit each action as JSON:",
            '  {"action": "<name>", "scale": 1.0,',
            f'   "expected": {{{declared}}},',
            '   "evidence": "<where the expected effect comes from>"}',
            "",
            "Rules, applied in order:",
            "  R1 a malformed proposal is held;",
            "  R2 a declared signal without a reading is held - silence is not evidence;",
            "  R3 a proposal that declares a standing decrease is blocked;",
            "  R4 standing below its floor is blocked unless the proposal declares",
            "     the repair;",
            "  R5 a proposal that omits a standing signal's expected effect is held;",
            f"  R6 when drift is latched ({policy.proxy.name} rising while a standing",
            f"     signal falls by {policy.harm_threshold:g} or more over {policy.window}"
            " readings), a proposal without evidence is held;",
            f"  R7 with evidence, the scale is capped at {policy.drift_scale_cap:g};",
            "  R8 otherwise the proposal is admitted at the scale requested.",
            "",
            "If a proposal is held or blocked, do not retry it unchanged: supply the",
            "missing reading or evidence, declare the standing effect, or reduce the",
            "scale. A hold means no action ran.",
        ]
        if policy.notes:
            lines += ["", policy.notes]
        return "\n".join(lines)

    def summary(self) -> dict[str, Any]:
        return {
            "policy": self.policy.name,
            "fingerprint": self.policy.fingerprint,
            "observations": len(self.frames),
            "decisions": len(self.decisions),
            "counts": dict(self.counts),
            "drift": self._statistics(),
        }


# --------------------------------------------------------------------------
# command line
# --------------------------------------------------------------------------


def _read_json(path: str) -> Any:
    text = Path(path).read_text(encoding="utf-8")
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        lines = [line for line in text.splitlines() if line.strip()]
        if not lines:
            raise ValueError(f"{path}: no JSON content")
        return json.loads(lines[-1])


def _observations(path: str) -> list[dict[str, Any]]:
    text = Path(path).read_text(encoding="utf-8")
    try:
        data = json.loads(text)
    except json.JSONDecodeError:
        return [json.loads(line) for line in text.splitlines() if line.strip()]
    if isinstance(data, Mapping):
        return [data]
    if not isinstance(data, list):
        raise ValueError(f"{path}: expected an object, a list of objects, or JSONL")
    return [dict(frame) for frame in data]


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        prog="standing_policy",
        description="Explicit Standing Algebra policy layer for AI actions.",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    prompt = sub.add_parser("prompt", help="print the policy as an agent system prompt")
    prompt.add_argument("--policy", required=True)

    screen = sub.add_parser("screen", help="judge one proposal against observed signals")
    screen.add_argument("--policy", required=True)
    screen.add_argument("--observation", required=True,
                        help="JSON metrics object, JSON list of frames, or JSONL")
    screen.add_argument("--proposal", help="JSON proposal (omit for a status check)")
    screen.add_argument("--json", action="store_true", help="print the receipt as JSON")
    screen.add_argument("--log", help="append the receipt to this JSONL log")

    verify = sub.add_parser("verify", help="verify a receipt log")
    verify.add_argument("path")

    args = parser.parse_args(argv)

    if args.command == "prompt":
        try:
            policy = Policy.load(args.policy)
        except (OSError, ValueError) as error:
            print(f"standing_policy: {error}", file=sys.stderr)
            return 64
        print(StandingPolicy(policy).system_prompt())
        return 0

    if args.command == "verify":
        ok, message = verify_receipts(args.path)
        print(message, file=sys.stdout if ok else sys.stderr)
        return 0 if ok else 1

    try:
        policy = Policy.load(args.policy)
        frames = _observations(args.observation)
        proposal = _read_json(args.proposal) if args.proposal else None
    except (OSError, ValueError) as error:
        print(f"standing_policy: {error}", file=sys.stderr)
        return 64

    layer = StandingPolicy(policy, log=ReceiptLog(args.log) if args.log else None)
    for frame in frames:
        layer.observe(frame)
    decision = layer.judge(proposal)
    if args.json:
        print(json.dumps(decision.to_dict(), indent=2, sort_keys=True))
    else:
        print(decision.explain())
    return 0 if decision.admitted else 2


if __name__ == "__main__":
    raise SystemExit(main())

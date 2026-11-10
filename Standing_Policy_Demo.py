#!/usr/bin/env python3
"""An AI agent under an explicit standing policy.

The agent proposes actions. Before any of them runs, ``standing_policy`` checks
the proposal against a declared policy: the proxy the agent is rewarded for, the
standing signals it must not spend, and the floors those signals may not cross.
Each proposal has to state what the agent expects it to do to every standing
signal, and cite evidence when drift is already latched.

Run this file to see each rule fire once, the policy's own system prompt, and
the hash-chained receipts it leaves behind.
"""

from __future__ import annotations

import json
import shutil
import tempfile
from pathlib import Path

from standing_policy import Policy, ReceiptLog, StandingPolicy, verify_receipts

DECLARED = {
    "name": "assistant-recommender",
    "proxy": {
        "name": "engagement",
        "direction": "maximize",
        "description": "session minutes; the number the agent is rewarded for",
    },
    "standing": [
        {"name": "user_value", "direction": "maximize", "floor": 0.35,
         "description": "post-session rating of whether the session helped"},
    ],
    "window": 8,
    "min_observations": 4,
    "drift_threshold": 0.05,
    "harm_threshold": 0.02,
    "drift_scale_cap": 0.25,
    "notes": "The recommender may not buy session time with user value.",
}

# Measured after each action: a healthy recommender first, then a stretch where
# session minutes climb while the usefulness rating collapses, then one partial
# recovery. The policy only ever sees these numbers, never the agent's story.
WARMUP = [
    {"engagement": 0.20, "user_value": 0.60},
    {"engagement": 0.24, "user_value": 0.62},
    {"engagement": 0.28, "user_value": 0.64},
]

# (action, expected effect, evidence, frame measured before judging)
STEPS = [
    ("grow_reach", {"engagement": 0.05, "user_value": 0.01}, None,
     {"engagement": 0.32, "user_value": 0.65}),
    ("increase_post_frequency", {"engagement": 0.15, "user_value": 0.00}, None,
     {"engagement": 0.45, "user_value": 0.61}),
    ("increase_post_frequency", {"engagement": 0.15, "user_value": 0.00}, "abtest-117",
     {"engagement": 0.60, "user_value": 0.55}),
    ("auto_play_next", {"engagement": 0.30, "user_value": -0.04}, "abtest-118",
     {"engagement": 0.75, "user_value": 0.47}),
    ("scale_reward_weight", {"engagement": 0.10, "user_value": 0.00}, None,
     {"engagement": 0.88, "user_value": 0.39}),
    ("scale_reward_weight", {"engagement": 0.10, "user_value": 0.00}, None,
     {"engagement": 0.96, "user_value": 0.30}),
    ("onboarding_fix", {"engagement": 0.00, "user_value": 0.06}, "review-204",
     {"engagement": 0.95, "user_value": 0.31}),
    ("tighten_ranking", {"engagement": 0.05}, None,
     {"engagement": 0.93, "user_value": 0.40}),
    ("widen_short_videos", {"engagement": 0.02, "user_value": 0.00}, "abtest-121",
     {"engagement": 0.94, "user_value": 0.41}),
    ("reweight_feed", {"engagement": 0.02, "user_value": 0.00}, "abtest-122",
     {"engagement": 0.94}),
]


def decide(policy: StandingPolicy, action: str, expected: dict, evidence, frame) -> None:
    """One agent step: observe, propose, judged before acting."""
    policy.observe(frame)
    decision = policy.judge({
        "action": action,
        "scale": 1.0,
        "expected": expected,
        "evidence": evidence,
    })
    if decision.admitted:
        outcome = f"ran at scale {decision.scale:.2f}"
    else:
        outcome = "did not run"
    print(f"{action:<23} {decision.status:<7} {decision.code:<26} {outcome}")
    for reason in decision.reasons:
        print(f"{'':23}   {reason}")


def main() -> None:
    print("=== Standing Policy demo: an explicit policy layer for an AI agent ===\n")

    policy = Policy.from_dict(DECLARED)
    print(f"policy   {policy.name}   fingerprint {policy.fingerprint[:16]}")
    print(f"proxy    {policy.proxy.name} [{policy.proxy.direction}]")
    for signal in policy.standing:
        print(f"standing {signal.name} [{signal.direction}] floor {signal.floor:g}")
    print()

    with tempfile.TemporaryDirectory() as workspace:
        log = ReceiptLog(Path(workspace) / "receipts.jsonl")
        layer = StandingPolicy(policy, log=log)

        print("--- what the agent is told the rules are ---")
        print("\n".join(layer.system_prompt().splitlines()[:16]))
        print("...")
        print()

        for frame in WARMUP:
            layer.observe(frame)
        print("--- agent steps: observe, propose, judged before acting ---")
        for action, expected, evidence, frame in STEPS:
            decide(layer, action, expected, evidence, frame)
        print()

        print("--- malformed proposals fail closed ---")
        for raw in ("raise engagement to 2.0", {"action": "retune", "scale": 3}):
            decision = layer.judge(raw)
            print(f"{'':23} {decision.status:<7} {decision.code:<26} "
                  f"{decision.reasons[0]}")
        print()

        summary = layer.summary()
        drift = summary["drift"]
        print("--- summary ---")
        print(f"observations {summary['observations']}   decisions {summary['decisions']}")
        print("counts " + json.dumps(summary["counts"], sort_keys=True))
        print(
            f"proxy change {drift['proxy_change']:+.3f}   "
            + "   ".join(
                f"{name} {change:+.3f}"
                for name, change in drift["standing_change"].items()
            )
            + f"   drifting {drift['drifting']}"
        )
        print()

        print("--- receipts ---")
        ok, message = verify_receipts(log.path)
        print(f"clean log   -> {message}")

        tampered = Path(workspace) / "tampered.jsonl"
        shutil.copyfile(log.path, tampered)
        lines = tampered.read_text(encoding="utf-8").splitlines()
        edited = json.loads(lines[2])
        edited["receipt"]["status"] = "allow"
        lines[2] = json.dumps(edited, sort_keys=True, separators=(",", ":"))
        tampered.write_text("\n".join(lines) + "\n", encoding="utf-8")
        ok, message = verify_receipts(tampered)
        print(f"edited log  -> {message}")
        print()

    print(
        "The agent was never handed a number to maximise in isolation: every action\n"
        "carried its own stated effect on the standing signal, and the policy admitted\n"
        "only those that claimed no loss, on evidence, at a scale drift allows.\n"
        "That refusal is the hypothesis of noGoodhartDrift_under_StandingAlgebra,\n"
        "applied here to a live agent loop."
    )


if __name__ == "__main__":
    main()

"""Tests for the drop-in standing policy layer."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

import standing_policy
from standing_guard import drift as guard_drift
from standing_policy import (
    ALLOW,
    BLOCK,
    DAMPEN,
    HOLD,
    Policy,
    PolicyViolation,
    Proposal,
    ProposalError,
    ReceiptLog,
    Signal,
    StandingPolicy,
    verify_receipts,
)

DECLARED = {
    "name": "test-policy",
    "proxy": {"name": "engagement", "direction": "maximize"},
    "standing": [{"name": "user_value", "direction": "maximize", "floor": 0.35}],
}

HEALTHY = [
    {"engagement": 0.20, "user_value": 0.60},
    {"engagement": 0.21, "user_value": 0.62},
    {"engagement": 0.22, "user_value": 0.64},
    {"engagement": 0.23, "user_value": 0.66},
]

DRIFTING = [
    {"engagement": 0.30, "user_value": 0.72},
    {"engagement": 0.38, "user_value": 0.70},
    {"engagement": 0.52, "user_value": 0.63},
    {"engagement": 0.71, "user_value": 0.52},
]

DECLARED_EFFECTS = {"engagement": 0.20, "user_value": 0.00}


def layer_with(frames, **overrides):
    policy = Policy.from_dict({**DECLARED, **overrides})
    layer = StandingPolicy(policy)
    for frame in frames:
        layer.observe(frame)
    return layer


class PolicyDeclarationTests(unittest.TestCase):
    def test_round_trip_is_stable(self):
        policy = Policy.from_dict(DECLARED)
        again = Policy.from_dict(policy.to_dict())
        self.assertEqual(policy, again)
        self.assertEqual(policy.fingerprint, again.fingerprint)

    def test_fingerprint_ignores_key_order(self):
        first = Policy.from_dict(DECLARED)
        reordered = {"standing": DECLARED["standing"], "proxy": DECLARED["proxy"],
                     "name": DECLARED["name"]}
        self.assertEqual(first.fingerprint, Policy.from_dict(reordered).fingerprint)

    def test_fingerprint_tracks_the_declaration(self):
        base = Policy.from_dict(DECLARED)
        stricter = Policy.from_dict({**DECLARED, "drift_scale_cap": 0.1})
        self.assertNotEqual(base.fingerprint, stricter.fingerprint)

    def test_shortcuts_and_defaults(self):
        policy = Policy.from_dict({"name": "short", "proxy": "score", "standing": "quality"})
        self.assertEqual(policy.proxy.direction, "maximize")
        self.assertEqual(policy.standing[0].name, "quality")
        self.assertIsNone(policy.standing[0].floor)

    def test_rejects_incomplete_or_unknown_declarations(self):
        for bad in (
            {"proxy": "score", "standing": "quality"},
            {"name": "x", "standing": "quality"},
            {"name": "x", "proxy": "score"},
            {"name": "x", "proxy": "score", "standing": []},
            {"name": "x", "proxy": "score", "standing": "score"},
            {"name": "x", "proxy": "score", "standing": "quality", "surprise": 1},
            {"name": "x", "proxy": "score", "standing": "quality", "window": 2},
            {"name": "x", "proxy": "score", "standing": "quality",
             "min_observations": 9},
            {"name": "x", "proxy": "score", "standing": "quality",
             "drift_scale_cap": 0},
            {"name": "x", "proxy": {"name": "score", "direction": "sideways"},
             "standing": "quality"},
        ):
            with self.subTest(bad=bad):
                with self.assertRaises(ValueError):
                    Policy.from_dict(bad)

    def test_signal_orientation(self):
        self.assertEqual(Signal("a").orientation, 1.0)
        self.assertEqual(Signal("b", direction="minimize").orientation, -1.0)


class ProposalTests(unittest.TestCase):
    def test_accepts_model_json(self):
        proposal = Proposal.from_raw(
            '{"action": "deploy", "expected": {"user_value": 0.0}, "evidence": "run-7"}'
        )
        self.assertEqual(proposal.action, "deploy")
        self.assertEqual(proposal.evidence, "run-7")

    def test_defaults_and_blank_evidence(self):
        proposal = Proposal.from_raw({"action": "deploy", "evidence": "   "})
        self.assertEqual(proposal.scale, 1.0)
        self.assertIsNone(proposal.evidence)
        self.assertEqual(dict(proposal.expected), {})

    def test_rejects_malformed(self):
        for raw in (
            "not json",
            ["deploy"],
            {"action": ""},
            {"action": "deploy", "scale": 0},
            {"action": "deploy", "scale": 2},
            {"action": "deploy", "scale": "big"},
            {"action": "deploy", "expected": {"user_value": "up"}},
            {"action": "deploy", "expected": {}, "unknown": 1},
        ):
            with self.subTest(raw=raw):
                with self.assertRaises(ProposalError):
                    Proposal.from_raw(raw)


class RuleTests(unittest.TestCase):
    def test_r1_malformed_proposal_is_held(self):
        decision = layer_with(HEALTHY).judge({"action": "", "scale": 1})
        self.assertEqual((decision.status, decision.code), (HOLD, "malformed_proposal"))
        self.assertFalse(decision.admitted)
        self.assertEqual(decision.scale, 0.0)

    def test_r2_missing_observations_fail_closed(self):
        empty = StandingPolicy(Policy.from_dict(DECLARED))
        decision = empty.judge({"action": "deploy", "expected": DECLARED_EFFECTS})
        self.assertEqual((decision.status, decision.code), (HOLD, "insufficient_signals"))

        layer = layer_with(HEALTHY)
        blind = layer.judge({"action": "deploy", "expected": DECLARED_EFFECTS})
        self.assertEqual(blind.code, "admissible")

        layer.observe({"engagement": 0.5})  # user_value missing from the newest frame
        decision = layer.judge({"action": "deploy", "expected": DECLARED_EFFECTS})
        self.assertEqual(decision.code, "insufficient_signals")
        self.assertIn("user_value", " ".join(decision.reasons))

    def test_r3_declared_tradeoff_is_blocked(self):
        decision = layer_with(HEALTHY).judge(
            {"action": "force_autoplay", "expected": {"engagement": 0.3, "user_value": -0.04}}
        )
        self.assertEqual((decision.status, decision.code), (BLOCK, "declared_tradeoff"))
        self.assertFalse(decision.admitted)

    def test_r4_floor_requires_declared_repair(self):
        frames = [{"engagement": 0.30, "user_value": 0.72},
                  {"engagement": 0.42, "user_value": 0.30}]
        layer = layer_with(frames)
        refused = layer.judge({"action": "more_push", "expected": DECLARED_EFFECTS})
        self.assertEqual((refused.status, refused.code), (BLOCK, "floor_breached"))
        self.assertIn("0.300", " ".join(refused.reasons))

        repair = layer.judge({"action": "onboarding_fix",
                              "expected": {"engagement": 0.0, "user_value": 0.06}})
        self.assertEqual((repair.status, repair.code), (ALLOW, "floor_repair"))
        self.assertTrue(repair.admitted)

    def test_r5_undeclared_standing_effect_is_held(self):
        decision = layer_with(HEALTHY).judge(
            {"action": "tighten", "expected": {"engagement": 0.05}}
        )
        self.assertEqual(
            (decision.status, decision.code), (HOLD, "undeclared_standing_effect")
        )

    def test_r6_latched_drift_needs_evidence(self):
        layer = layer_with(DRIFTING)
        decision = layer.judge({"action": "push", "expected": DECLARED_EFFECTS})
        self.assertEqual((decision.status, decision.code), (HOLD, "evidence_required"))
        self.assertTrue(decision.statistics["drifting"])
        self.assertEqual(decision.scale, 0.0)

    def test_r7_evidence_caps_the_scale(self):
        layer = layer_with(DRIFTING)
        decision = layer.judge(
            {"action": "push", "expected": DECLARED_EFFECTS, "evidence": "abtest-117"}
        )
        self.assertEqual((decision.status, decision.code), (DAMPEN, "drift_capped"))
        self.assertTrue(decision.admitted)
        self.assertEqual(decision.requested_scale, 1.0)
        self.assertEqual(decision.scale, 0.25)
        self.assertIn("abtest-117", " ".join(decision.reasons))

    def test_r7_cap_below_request_allows(self):
        layer = layer_with(DRIFTING)
        decision = layer.judge(
            {"action": "push", "scale": 0.2, "expected": DECLARED_EFFECTS,
             "evidence": "abtest-117"}
        )
        self.assertEqual((decision.status, decision.code), (ALLOW, "drift_capped"))
        self.assertEqual(decision.scale, 0.2)

    def test_r8_healthy_system_is_untouched(self):
        decision = layer_with(HEALTHY).judge(
            {"action": "expand_reach", "expected": DECLARED_EFFECTS}
        )
        self.assertEqual((decision.status, decision.code), (ALLOW, "admissible"))
        self.assertEqual(decision.scale, 1.0)

    def test_evidence_can_be_disabled(self):
        layer = layer_with(DRIFTING, require_evidence_on_drift=False)
        decision = layer.judge({"action": "push", "expected": DECLARED_EFFECTS})
        self.assertEqual(decision.code, "drift_capped")

    def test_declarations_can_be_disabled(self):
        layer = layer_with(HEALTHY, require_declared_effects=False)
        decision = layer.judge({"action": "tighten", "expected": {"engagement": 0.05}})
        self.assertEqual(decision.code, "admissible")

    def test_minimize_direction_inverts_improvement(self):
        declared = {
            "name": "cost-policy",
            "proxy": {"name": "throughput", "direction": "maximize"},
            "standing": [{"name": "latency", "direction": "minimize"}],
        }
        falling = [{"throughput": 10, "latency": 200}, {"throughput": 11, "latency": 190},
                   {"throughput": 12, "latency": 180}, {"throughput": 13, "latency": 170}]
        layer = StandingPolicy(Policy.from_dict(declared))
        for frame in falling:
            layer.observe(frame)
        decision = layer.judge({"action": "optimise", "expected": {"latency": 0.0}})
        self.assertEqual(decision.code, "admissible")

        rising = [{"throughput": 10, "latency": 170}, {"throughput": 11, "latency": 190},
                  {"throughput": 12, "latency": 210}, {"throughput": 13, "latency": 230}]
        layer = StandingPolicy(Policy.from_dict(declared))
        for frame in rising:
            layer.observe(frame)
        decision = layer.judge({"action": "optimise", "expected": {"latency": 0.0}})
        self.assertEqual(decision.code, "evidence_required")

    def test_counts_and_history(self):
        layer = layer_with(HEALTHY)
        layer.judge({"action": "a", "expected": DECLARED_EFFECTS})
        layer.judge({"action": "b", "expected": {"engagement": 0.1}})
        self.assertEqual(layer.counts[ALLOW], 1)
        self.assertEqual(layer.counts[HOLD], 1)
        self.assertEqual([d.action for d in layer.decisions], ["a", "b"])
        self.assertEqual(layer.summary()["decisions"], 2)

    def test_check_observes_then_judges(self):
        layer = layer_with(HEALTHY[:3])
        decision = layer.check(HEALTHY[3], {"action": "go", "expected": DECLARED_EFFECTS})
        self.assertEqual(decision.code, "admissible")
        self.assertEqual(layer.latest, HEALTHY[3])

    def test_observe_drops_non_numeric_values(self):
        layer = StandingPolicy(Policy.from_dict(DECLARED))
        frame = layer.observe({"engagement": 1, "user_value": "high", "extra": True})
        self.assertEqual(frame, {"engagement": 1.0})


class StatisticsTests(unittest.TestCase):
    def test_normalized_change_matches_the_guard(self):
        values = [0.4, 0.55, 0.51, 0.77]
        for direction in ("maximize", "minimize"):
            signal = Signal("s", direction=direction)
            self.assertEqual(
                standing_policy._normalized_change(values, signal),
                guard_drift.normalized_change(values, direction),
            )

    def test_undefined_statistics_stay_none(self):
        layer = StandingPolicy(Policy.from_dict(DECLARED))
        for _ in range(2):
            layer.observe({"engagement": 0.5, "user_value": 0.5})
        statistics = layer.judge({"action": "go", "expected": DECLARED_EFFECTS}).statistics
        self.assertIsNone(statistics["proxy_change"])
        self.assertIsNone(statistics["standing_change"]["user_value"])
        self.assertFalse(statistics["drifting"])


class ToolTests(unittest.TestCase):
    def test_admitted_call_runs_with_the_admitted_scale(self):
        layer = layer_with(HEALTHY)
        calls = []

        @layer.tool()
        def deploy(target, scale=1.0):
            calls.append((target, scale))
            return "deployed"

        self.assertEqual(
            deploy("eu", expected=DECLARED_EFFECTS), "deployed"
        )
        self.assertEqual(calls, [("eu", 1.0)])

    def test_damped_call_receives_the_capped_scale(self):
        layer = layer_with(DRIFTING)
        calls = []

        @layer.tool("push")
        def push(scale=1.0):
            calls.append(scale)

        push(expected=DECLARED_EFFECTS, evidence="abtest-117")
        self.assertEqual(calls, [0.25])

    def test_refused_call_raises_and_does_not_run(self):
        layer = layer_with(DRIFTING)
        calls = []

        @layer.tool()
        def push(scale=1.0):
            calls.append(scale)

        with self.assertRaises(PolicyViolation) as caught:
            push(expected=DECLARED_EFFECTS)
        self.assertEqual(caught.exception.decision.code, "evidence_required")
        self.assertEqual(calls, [])

    def test_metrics_keyword_observes_a_frame(self):
        layer = layer_with(HEALTHY[:3])
        admitted = []

        @layer.tool()
        def ping():
            admitted.append(True)

        ping(metrics=HEALTHY[3], expected=DECLARED_EFFECTS)
        self.assertEqual(admitted, [True])
        self.assertEqual(layer.latest, HEALTHY[3])


class ReceiptTests(unittest.TestCase):
    def test_chain_verifies_and_detects_edits(self):
        with tempfile.TemporaryDirectory() as folder:
            log = ReceiptLog(Path(folder) / "receipts.jsonl")
            layer = StandingPolicy(Policy.from_dict(DECLARED), log=log)
            for frame in HEALTHY:
                layer.observe(frame)
            layer.judge({"action": "go", "expected": DECLARED_EFFECTS})
            layer.judge({"action": "stop", "expected": {"engagement": 0.0}})

            ok, message = verify_receipts(log.path)
            self.assertTrue(ok, message)
            self.assertEqual(message, "2 receipt(s) verified")

            lines = log.path.read_text(encoding="utf-8").splitlines()
            entry = json.loads(lines[1])
            entry["receipt"]["status"] = "allow"
            lines[1] = json.dumps(entry, sort_keys=True, separators=(",", ":"))
            log.path.write_text("\n".join(lines) + "\n", encoding="utf-8")
            ok, message = verify_receipts(log.path)
            self.assertFalse(ok)
            self.assertIn("line 2", message)

    def test_reordering_and_missing_logs_are_reported(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "receipts.jsonl"
            log = ReceiptLog(path)
            log.append({"status": "allow"})
            log.append({"status": "hold"})
            lines = path.read_text(encoding="utf-8").splitlines()
            path.write_text("\n".join(reversed(lines)) + "\n", encoding="utf-8")
            ok, message = verify_receipts(path)
            self.assertFalse(ok)
            self.assertIn("out of order", message)

            ok, message = verify_receipts(Path(folder) / "absent.jsonl")
            self.assertFalse(ok)
            self.assertIn("no receipt log", message)


class PromptTests(unittest.TestCase):
    def test_prompt_states_the_declared_policy(self):
        policy = Policy.from_dict(DECLARED)
        prompt = StandingPolicy(policy).system_prompt()
        self.assertIn(policy.name, prompt)
        self.assertIn(policy.fingerprint[:16], prompt)
        for name in ("engagement", "user_value"):
            self.assertIn(name, prompt)
        self.assertIn("floor 0.35", prompt)
        self.assertIn("capped at 0.25", prompt)
        self.assertIn("R8", prompt)


class CommandLineTests(unittest.TestCase):
    def setUp(self):
        self.folder = tempfile.TemporaryDirectory()
        self.root = Path(self.folder.name)
        self.policy_path = self.root / "policy.json"
        self.policy_path.write_text(json.dumps(DECLARED), encoding="utf-8")
        self.observation = self.root / "observation.json"
        self.observation.write_text(json.dumps(HEALTHY), encoding="utf-8")
        self.proposal = self.root / "proposal.json"
        self.proposal.write_text(json.dumps({"action": "go", "expected": DECLARED_EFFECTS}),
                                 encoding="utf-8")

    def tearDown(self):
        self.folder.cleanup()

    def run_cli(self, argv):
        return standing_policy.main(argv)

    def test_prompt(self):
        self.assertEqual(
            self.run_cli(["prompt", "--policy", str(self.policy_path)]), 0
        )

    def test_screen_admits(self):
        self.assertEqual(
            self.run_cli(["screen", "--policy", str(self.policy_path),
                          "--observation", str(self.observation),
                          "--proposal", str(self.proposal)]),
            0,
        )

    def test_screen_holds_and_logs(self):
        self.observation.write_text(json.dumps(DRIFTING), encoding="utf-8")
        log = self.root / "receipts.jsonl"
        code = self.run_cli(["screen", "--policy", str(self.policy_path),
                             "--observation", str(self.observation),
                             "--proposal", str(self.proposal), "--log", str(log)])
        self.assertEqual(code, 2)
        self.assertTrue(verify_receipts(log)[0])

    def test_screen_accepts_jsonl_and_status_check(self):
        self.observation.write_text(
            "\n".join(json.dumps(frame) for frame in HEALTHY) + "\n", encoding="utf-8"
        )
        self.assertEqual(
            self.run_cli(["screen", "--policy", str(self.policy_path),
                          "--observation", str(self.observation)]),
            0,
        )

    def test_verify_exit_codes(self):
        log = self.root / "receipts.jsonl"
        ReceiptLog(log).append({"status": "hold"})
        self.assertEqual(self.run_cli(["verify", str(log)]), 0)
        log.write_text(log.read_text(encoding="utf-8").replace("hold", "allow"),
                       encoding="utf-8")
        self.assertEqual(self.run_cli(["verify", str(log)]), 1)

    def test_bad_input_is_reported(self):
        self.policy_path.write_text("{", encoding="utf-8")
        self.assertEqual(
            self.run_cli(["screen", "--policy", str(self.policy_path),
                          "--observation", str(self.observation)]),
            64,
        )


if __name__ == "__main__":
    unittest.main()

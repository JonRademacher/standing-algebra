import json
import unittest

from goodhart_monitor import (
    Decision,
    Direction,
    DriftPolicy,
    GoodhartMonitor,
    Observation,
    evaluation_record,
)


class GoodhartMonitorTests(unittest.TestCase):
    def setUp(self):
        self.policy = DriftPolicy(window_size=6, min_observations=6)

    def feed(self, monitor, proxy, goal):
        result = None
        for index, (proxy_value, goal_value) in enumerate(zip(proxy, goal)):
            result = monitor.observe(
                Observation(str(index), proxy_value, goal_value)
            )
        return result

    def test_incomplete_window_requires_review_and_does_not_run_action(self):
        monitor = GoodhartMonitor(self.policy)
        called = []

        result = monitor.run_guarded(Observation("0", 1.0, 1.0), lambda: called.append(True))

        self.assertEqual(result.evaluation.decision, Decision.REVIEW)
        self.assertFalse(result.action_executed)
        self.assertEqual(called, [])

    def test_aligned_window_runs_guarded_action(self):
        monitor = GoodhartMonitor(self.policy)
        for index in range(5):
            evaluation = monitor.observe(Observation(str(index), index, index))
        called = []

        result = monitor.run_guarded(
            Observation("5", 5, 5), lambda: called.append("ran") or "ok"
        )

        self.assertEqual(evaluation.decision, Decision.REVIEW)
        self.assertTrue(result.action_executed)
        self.assertEqual(result.action_result, "ok")
        self.assertEqual(called, ["ran"])

    def test_aligned_trends_allow_action_after_warmup(self):
        monitor = GoodhartMonitor(self.policy)
        result = self.feed(monitor, range(6), range(6))

        self.assertEqual(result.decision, Decision.ALLOW)
        self.assertTrue(result.permits_action)
        self.assertEqual(result.evidence.normalized_proxy_change, 1.0)
        self.assertEqual(result.evidence.normalized_goal_change, 1.0)

    def test_proxy_improvement_with_goal_decline_latches_hold(self):
        monitor = GoodhartMonitor(self.policy)
        result = self.feed(monitor, range(6), range(5, -1, -1))

        self.assertEqual(result.decision, Decision.HOLD)
        self.assertFalse(result.permits_action)
        self.assertEqual(result.evidence.sample_count, 6)
        self.assertEqual(result.evidence.normalized_proxy_change, 1.0)
        self.assertEqual(result.evidence.normalized_goal_change, -1.0)

        later = monitor.observe(Observation("6", 7.0, 7.0))
        self.assertEqual(later.decision, Decision.HOLD)
        self.assertIn("proxy improves", later.reason)

    def test_guard_does_not_execute_while_drift_is_latched(self):
        monitor = GoodhartMonitor(self.policy)
        self.feed(monitor, range(6), range(5, -1, -1))
        called = []

        result = monitor.run_guarded(Observation("6", 7.0, 7.0), lambda: called.append(True))

        self.assertFalse(result.action_executed)
        self.assertEqual(called, [])

    def test_explicit_reset_clears_latch_but_reenters_review(self):
        monitor = GoodhartMonitor(self.policy)
        self.feed(monitor, range(6), range(5, -1, -1))

        cleared = monitor.reset("independent goal audit completed")

        self.assertEqual(cleared, 6)
        result = monitor.observe(Observation("new-0", 0.0, 0.0))
        self.assertEqual(result.decision, Decision.REVIEW)

    def test_minimizing_goal_direction_is_oriented_correctly(self):
        policy = DriftPolicy(
            window_size=6,
            min_observations=6,
            goal_direction=Direction.MINIMIZE,
        )
        monitor = GoodhartMonitor(policy)
        result = self.feed(monitor, range(6), range(5, -1, -1))

        self.assertEqual(result.decision, Decision.ALLOW)
        self.assertEqual(result.evidence.normalized_goal_change, 1.0)

    def test_constant_signal_requires_review(self):
        monitor = GoodhartMonitor(self.policy)
        result = self.feed(monitor, range(6), [1.0] * 6)

        self.assertEqual(result.decision, Decision.REVIEW)
        self.assertIsNone(result.evidence.normalized_goal_change)

    def test_observation_rejects_non_finite_values(self):
        with self.assertRaises(ValueError):
            Observation("t", float("nan"), 1.0)

    def test_observation_rejects_non_numeric_values(self):
        with self.assertRaises(ValueError):
            Observation("t", "1", 1.0)

    def test_large_finite_values_produce_finite_normalized_evidence(self):
        monitor = GoodhartMonitor(self.policy)
        result = self.feed(
            monitor,
            [-1e308, -6e307, -2e307, 2e307, 6e307, 1e308],
            [1e308, 6e307, 2e307, -2e307, -6e307, -1e308],
        )

        self.assertEqual(result.decision, Decision.HOLD)
        self.assertTrue(
            abs(result.evidence.normalized_proxy_change) <= 1.0
        )
        self.assertTrue(
            abs(result.evidence.normalized_goal_change) <= 1.0
        )

    def test_evidence_record_is_json_serializable_and_contains_samples(self):
        monitor = GoodhartMonitor(self.policy)
        result = self.feed(monitor, range(6), range(5, -1, -1))

        record = evaluation_record(result)
        encoded = json.dumps(record, allow_nan=False)

        self.assertEqual(json.loads(encoded)["decision"], "hold")
        self.assertEqual(len(record["evidence"]["observations"]), 6)

    def test_policy_rejects_invalid_window(self):
        with self.assertRaises(ValueError):
            DriftPolicy(window_size=3, min_observations=4)


if __name__ == "__main__":
    unittest.main()

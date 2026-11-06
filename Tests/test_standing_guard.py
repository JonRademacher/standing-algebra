import json
import random
import unittest

import goodhart_monitor
from standing_guard import (
    MAXIMIZE,
    MINIMIZE,
    DiscoveryError,
    GuardStatus,
    StandingGuard,
    classify,
    normalized_change,
)
from standing_guard.discovery import read_frame, step_entry, step_output_signals


class NormalizedChangeTests(unittest.TestCase):
    """The guard's statistic must stay identical to the repository's monitor."""

    def test_matches_repository_monitor(self):
        random.seed(7)
        for _ in range(50):
            values = [random.uniform(-10.0, 10.0) for _ in range(random.randint(2, 10))]
            self.assertEqual(
                normalized_change(values, MAXIMIZE),
                goodhart_monitor._normalized_change(
                    values, goodhart_monitor.Direction.MAXIMIZE
                ),
            )
            self.assertEqual(
                normalized_change(values, MINIMIZE),
                goodhart_monitor._normalized_change(
                    values, goodhart_monitor.Direction.MINIMIZE
                ),
            )

    def test_undefined_trends_return_none(self):
        self.assertIsNone(normalized_change([], MAXIMIZE))
        self.assertIsNone(normalized_change([1.0], MAXIMIZE))
        self.assertIsNone(normalized_change([0.0, 0.0, 0.0], MAXIMIZE))
        self.assertIsNone(normalized_change([5.0, 5.0, 5.0], MAXIMIZE))


class _MappingSystem:
    def __init__(self):
        self._values = {"a": 1.0, "b": 2.0}
        self.visible = 3.0
        self._hidden = 4.0
        self.label = "not numeric"

    def signals(self):
        return self._values


class DiscoveryTests(unittest.TestCase):
    def test_reads_public_numeric_attributes(self):
        frame = read_frame(_MappingSystem())
        self.assertEqual(frame, {"visible": 3.0, "a": 1.0, "b": 2.0})

    def test_step_output_signals_name_returned_numbers(self):
        self.assertEqual(
            step_output_signals((1.5, 2.5)),
            {"step_return[0]": 1.5, "step_return[1]": 2.5},
        )
        self.assertEqual(
            step_output_signals({"loss": 0.5, "note": "text"}),
            {"step_return[loss]": 0.5},
        )

    def test_step_entry_prefers_step(self):
        class System:
            def step(self):
                return 1.0

            def advance(self):
                return 2.0

        self.assertEqual(step_entry(System()).__name__, "step")

    def test_step_entry_requires_a_callable(self):
        with self.assertRaises(DiscoveryError):
            step_entry(object())


class RoleAssignmentTests(unittest.TestCase):
    def test_name_hints_assign_roles(self):
        frames = [
            {"reward": float(index), "true_value": 10.0 - index, "state": index}
            for index in range(5)
        ]
        roles = classify(frames, [1.0] * 5)

        self.assertEqual(roles.proxy, "reward")
        self.assertEqual(roles.standing, "true_value")
        self.assertEqual(roles.context, ("state",))
        self.assertIn("name hint", roles.provenance[0])

    def test_action_coupling_assigns_roles_for_opaque_names(self):
        actions = [1.0, 2.0, 1.0, 0.0, 1.0, 2.0, 1.0]
        frames = [{"s0": 1.0, "s1": 1.0}]
        noise = [1.05, 0.98, 1.02, 1.01, 0.99, 1.03]
        for index in range(1, len(actions)):
            frames.append(
                {
                    "s0": frames[-1]["s0"] + actions[index],
                    "s1": noise[index - 1],
                }
            )

        roles = classify(frames, actions)

        self.assertEqual(roles.proxy, "s0")
        self.assertEqual(roles.standing, "s1")
        self.assertIn("action coupling", roles.provenance[0])

    def test_constant_action_with_opaque_names_raises(self):
        frames = [{"s0": float(index), "s1": float(5 - index)} for index in range(5)]
        with self.assertRaises(DiscoveryError):
            classify(frames, [1.0] * 5)

    def test_requires_two_signals(self):
        frames = [{"only": float(index)} for index in range(5)]
        with self.assertRaises(DiscoveryError):
            classify(frames, [1.0] * 5)


class _PlateauSystem:
    """Proxy rises without bound; standing is flat until the boundary at 3.0."""

    BOUNDARY = 3.0

    def __init__(self):
        self.state = 0.0
        self.engagement = 10.0
        self.true_value = 50.0

    def step(self, action):
        self.state += action
        self.engagement = 10.0 + 3.0 * self.state
        overshoot = max(0.0, self.state - self.BOUNDARY)
        self.true_value = 50.0 - 0.4 * overshoot**2
        return self.engagement, self.true_value


class _AlignedSystem:
    def __init__(self):
        self.state = 0.0
        self.reward = 0.0
        self.true_value = 0.0

    def step(self, action):
        self.state += action
        self.reward = 2.0 * self.state
        self.true_value = 2.0 * self.state
        return self.reward, self.true_value


class _StringActionSystem:
    def __init__(self):
        self.reward = 0.0
        self.true_value = 100.0

    def step(self, action):
        self.reward += 1.0
        self.true_value -= 1.0
        return self.reward, self.true_value


class _SilentSystem:
    def __init__(self):
        self.steps = 0

    def step(self, action):
        self.steps += 1
        return None


class GovernorTests(unittest.TestCase):
    def test_step_is_drop_in_and_returns_the_system_output(self):
        system = _PlateauSystem()
        guard = StandingGuard.wrap(system)

        result = guard.step(1.0)

        self.assertIsInstance(result, tuple)
        self.assertEqual(result, (13.0, 50.0))

    def test_no_episode_when_signals_agree(self):
        system = _AlignedSystem()
        guard = StandingGuard.wrap(system)
        for _ in range(20):
            guard.step(1.0)

        self.assertEqual(guard.episodes, [])
        self.assertEqual(guard.counters["corrected"], 0)
        self.assertIs(guard.status, GuardStatus.ALLOW)

    def test_detects_drift_and_opens_episode(self):
        guard = StandingGuard.wrap(_PlateauSystem())
        for _ in range(7):
            guard.step(1.0)

        self.assertEqual(len(guard.episodes), 1)
        episode = guard.episodes[0]
        self.assertEqual(episode.proxy, "engagement")
        self.assertEqual(episode.standing, "true_value")
        self.assertLessEqual(episode.standing_change, -0.5)
        self.assertIsNotNone(episode.worst_transition)
        self.assertIs(guard.status, GuardStatus.HOLD)

    def test_corrects_drift_and_holds_at_the_boundary(self):
        system = _PlateauSystem()
        guard = StandingGuard.wrap(system)
        for _ in range(24):
            guard.step(1.0)

        self.assertGreater(guard.counters["corrected"], 0)
        self.assertGreater(system.true_value, 49.0)
        self.assertLessEqual(system.state, _PlateauSystem.BOUNDARY + 1e-9)
        intervention = guard.episodes[0].interventions[0]
        self.assertLess(intervention.applied_alpha, 1.0)
        self.assertGreater(intervention.standing_preserved, 0.0)

    def test_unguarded_system_collapses_where_guarded_one_does_not(self):
        unguarded = _PlateauSystem()
        for _ in range(24):
            unguarded.step(1.0)

        system = _PlateauSystem()
        guard = StandingGuard.wrap(system)
        for _ in range(24):
            guard.step(1.0)

        self.assertLess(unguarded.true_value, 0.0)
        self.assertGreater(system.true_value, 45.0)

    def test_blocks_unscalable_action_and_requires_review(self):
        system = _StringActionSystem()
        guard = StandingGuard.wrap(system)

        for _ in range(8):
            guard.step("tick")

        self.assertIs(guard.status, GuardStatus.REVIEW)
        self.assertIsNone(guard.step("tick"))
        self.assertGreater(guard.counters["blocked"], 0)

        with self.assertRaises(ValueError):
            guard.acknowledge("", "checked by hand")
        with self.assertRaises(ValueError):
            guard.acknowledge("review-1", " ")

        self.assertTrue(guard.acknowledge("review-1", "operator chose a different direction"))
        self.assertIs(guard.status, GuardStatus.ALLOW)

    def test_guard_raises_when_no_usable_signals_are_exposed(self):
        guard = StandingGuard.wrap(_SilentSystem())
        with self.assertRaises(DiscoveryError):
            for _ in range(6):
                guard.step(1.0)

    def test_report_serialises_and_names_the_episode(self):
        guard = StandingGuard.wrap(_PlateauSystem(), label="demo-system")
        for _ in range(12):
            guard.step(1.0)

        report = guard.report()
        payload = json.loads(report.to_json())

        self.assertEqual(payload["label"], "demo-system")
        self.assertEqual(payload["roles"]["proxy"], "engagement")
        self.assertTrue(payload["episodes"])
        self.assertTrue(payload["limits"])
        markdown = report.to_markdown()
        self.assertIn("Episode 1", markdown)
        self.assertIn("Standing Guard report", markdown)


if __name__ == "__main__":
    unittest.main()

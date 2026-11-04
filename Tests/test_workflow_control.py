import unittest

from goodhart_monitor import Decision, DriftPolicy, GoodhartMonitor, Observation
from workflow_control import (
    ControlFailure,
    DryRunWorkflowAdapter,
    WorkflowController,
    WorkflowStatus,
)


class WorkflowControllerTests(unittest.TestCase):
    def setUp(self):
        self.adapter = DryRunWorkflowAdapter()
        self.controller = WorkflowController(
            "demo-workflow",
            GoodhartMonitor(DriftPolicy(window_size=6, min_observations=6)),
            self.adapter,
        )

    def feed_divergence(self):
        result = None
        for index in range(6):
            result = self.controller.run_step(
                Observation(str(index), index, 5 - index),
                lambda: self.fail("divergent workflow action must not run"),
            )
        return result

    def test_warmup_blocks_steps_without_pausing_or_escalating(self):
        called = []

        result = self.controller.run_step(
            Observation("0", 1, 1), lambda: called.append("ran")
        )

        self.assertEqual(result.evaluation.decision, Decision.REVIEW)
        self.assertFalse(result.action_executed)
        self.assertEqual(called, [])
        self.assertEqual(self.controller.status, WorkflowStatus.ACTIVE)
        self.assertNotIn("demo-workflow", self.adapter.paused_workflows)
        self.assertEqual([event.event for event in self.adapter.events], ["action_blocked"])

    def test_drift_blocks_action_and_emits_evidence(self):
        result = self.feed_divergence()

        self.assertEqual(result.evaluation.decision, Decision.HOLD)
        self.assertEqual(self.controller.status, WorkflowStatus.PAUSED_FOR_REVIEW)
        review_event = self.adapter.events[-1]
        self.assertEqual(review_event.event, "human_review_requested")
        self.assertEqual(review_event.evidence["decision"], "hold")
        self.assertEqual(review_event.evidence["evidence"]["sample_count"], 6)

    def test_aligned_warmup_allows_step_after_required_observations(self):
        for index in range(5):
            result = self.controller.run_step(
                Observation(str(index), index, index), lambda: self.fail()
            )
            self.assertFalse(result.action_executed)
        called = []

        result = self.controller.run_step(
            Observation("5", 5, 5), lambda: called.append("ran") or "ok"
        )

        self.assertTrue(result.action_executed)
        self.assertEqual(result.action_result, "ok")
        self.assertEqual(called, ["ran"])
        self.assertEqual(self.controller.status, WorkflowStatus.ACTIVE)

    def test_paused_workflow_stays_paused_until_operator_resume(self):
        self.feed_divergence()
        later = self.controller.run_step(Observation("1", 2, 2), lambda: self.fail())

        self.assertFalse(later.action_executed)
        self.assertFalse(later.evaluation.permits_action)
        self.assertEqual(self.controller.status, WorkflowStatus.PAUSED_FOR_REVIEW)
        self.assertEqual(self.adapter.events[-1].event, "action_blocked")

    def test_resume_requires_review_reference_and_restarts_warmup(self):
        self.feed_divergence()
        with self.assertRaises(ValueError):
            self.controller.resume("", "reviewed")

        cleared = self.controller.resume("incident-42", "independently checked goal signal")

        self.assertEqual(cleared, 6)
        self.assertEqual(self.controller.status, WorkflowStatus.ACTIVE)
        self.assertEqual(self.adapter.events[-1].event, "workflow_resumed")
        self.assertEqual(self.adapter.events[-1].review_reference, "incident-42")
        result = self.controller.run_step(Observation("new-0", 0, 0), lambda: self.fail())
        self.assertFalse(result.action_executed)

    def test_resume_failure_keeps_controller_paused(self):
        class FailingResumeAdapter(DryRunWorkflowAdapter):
            def resume_workflow(self, workflow_id, review_reference, reason):
                raise RuntimeError("platform unavailable")

        controller = WorkflowController(
            "failing-resume",
            GoodhartMonitor(DriftPolicy(window_size=6, min_observations=6)),
            FailingResumeAdapter(),
        )
        for index in range(6):
            controller.run_step(
                Observation(str(index), index, 5 - index), lambda: self.fail()
            )
        with self.assertRaisesRegex(RuntimeError, "platform unavailable"):
            controller.resume("review-1", "review completed")
        self.assertEqual(controller.status, WorkflowStatus.PAUSED_FOR_REVIEW)

    def test_control_adapter_failure_does_not_run_action(self):
        class FailingAdapter(DryRunWorkflowAdapter):
            def pause_workflow(self, workflow_id, reason):
                raise RuntimeError("pause failed")

        adapter = FailingAdapter()
        monitor = GoodhartMonitor(DriftPolicy(window_size=6, min_observations=6))
        for index in range(5):
            monitor.observe(Observation(str(index), index, 5 - index))
        controller = WorkflowController(
            "failing-control",
            monitor,
            adapter,
        )
        called = []

        with self.assertRaises(ControlFailure):
            controller.run_step(
                Observation("5", 5, 0), lambda: called.append("must not run")
            )

        self.assertEqual(called, [])
        self.assertEqual(controller.status, WorkflowStatus.PAUSED_FOR_REVIEW)
        self.assertEqual(
            [event.event for event in adapter.events],
            ["action_blocked", "human_review_requested"],
        )
        self.assertEqual(adapter.events[0].evidence["decision"], "hold")

    def test_action_failure_pauses_and_escalates_then_reraises(self):
        monitor = GoodhartMonitor(DriftPolicy(window_size=6, min_observations=6))
        for index in range(5):
            monitor.observe(Observation(str(index), index, index))
        controller = WorkflowController(
            "action-failure",
            monitor,
            self.adapter,
        )

        def broken_action():
            raise OSError("downstream step failed")

        with self.assertRaisesRegex(OSError, "downstream step failed"):
            controller.run_step(Observation("5", 5, 5), broken_action)

        self.assertEqual(controller.status, WorkflowStatus.PAUSED_FOR_REVIEW)
        self.assertEqual(
            [event.event for event in self.adapter.events],
            ["workflow_paused", "action_blocked", "human_review_requested"],
        )

    def test_resume_requires_paused_state(self):
        with self.assertRaisesRegex(RuntimeError, "not paused"):
            self.controller.resume("review-1", "review completed")


if __name__ == "__main__":
    unittest.main()

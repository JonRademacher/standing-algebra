"""Fail-closed workflow control primitives for the Goodhart monitor.

The included adapter records dry-run events only. Production integrations must
implement ControlAdapter using their workflow or orchestration platform's
documented pause, action-gate, review, and resume mechanisms.
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import Callable, Generic, Protocol, TypeVar

from goodhart_monitor import (
    Decision,
    Evaluation,
    GateResult,
    GoodhartMonitor,
    INSUFFICIENT_OBSERVATIONS_REASON,
    Observation,
    evaluation_record,
)


class WorkflowStatus(str, Enum):
    ACTIVE = "active"
    PAUSED_FOR_REVIEW = "paused_for_review"


class ControlAdapter(Protocol):
    """Platform boundary for enforcement; methods must fail loudly on failure."""

    def block_action(
        self, workflow_id: str, reason: str, evidence: dict[str, object]
    ) -> None: ...

    def pause_workflow(self, workflow_id: str, reason: str) -> None: ...

    def request_human_review(
        self, workflow_id: str, reason: str, evidence: dict[str, object]
    ) -> None: ...

    def resume_workflow(
        self, workflow_id: str, review_reference: str, reason: str
    ) -> None: ...


@dataclass(frozen=True)
class ControlEvent:
    event: str
    workflow_id: str
    reason: str
    review_reference: str | None = None
    evidence: dict[str, object] | None = None


class DryRunWorkflowAdapter:
    """In-memory adapter for demos and tests; it never controls an external system."""

    def __init__(self) -> None:
        self.events: list[ControlEvent] = []
        self.paused_workflows: set[str] = set()

    def block_action(
        self, workflow_id: str, reason: str, evidence: dict[str, object]
    ) -> None:
        self._validate_workflow_id(workflow_id)
        self.events.append(
            ControlEvent("action_blocked", workflow_id, reason, evidence=evidence)
        )

    def pause_workflow(self, workflow_id: str, reason: str) -> None:
        self._validate_workflow_id(workflow_id)
        self.paused_workflows.add(workflow_id)
        self.events.append(ControlEvent("workflow_paused", workflow_id, reason))

    def request_human_review(
        self, workflow_id: str, reason: str, evidence: dict[str, object]
    ) -> None:
        self._validate_workflow_id(workflow_id)
        self.events.append(
            ControlEvent("human_review_requested", workflow_id, reason, evidence=evidence)
        )

    def resume_workflow(
        self, workflow_id: str, review_reference: str, reason: str
    ) -> None:
        self._validate_workflow_id(workflow_id)
        if workflow_id not in self.paused_workflows:
            raise RuntimeError(f"workflow {workflow_id!r} is not paused")
        self.paused_workflows.remove(workflow_id)
        self.events.append(
            ControlEvent(
                "workflow_resumed",
                workflow_id,
                reason,
                review_reference=review_reference,
            )
        )

    @staticmethod
    def _validate_workflow_id(workflow_id: str) -> None:
        if not isinstance(workflow_id, str) or not workflow_id.strip():
            raise ValueError("workflow_id must not be empty")


class ControlFailure(RuntimeError):
    """Raised when an enforcement adapter could not complete its controls."""

    def __init__(self, workflow_id: str, failures: list[Exception]) -> None:
        self.workflow_id = workflow_id
        self.failures = tuple(failures)
        details = "; ".join(str(error) for error in failures)
        super().__init__(
            f"workflow {workflow_id!r} remains fail-closed; control operation(s) failed: {details}"
        )


ResultT = TypeVar("ResultT")


class WorkflowController(Generic[ResultT]):
    """Gate workflow actions and pause/escalate whenever the monitor cannot allow them."""

    def __init__(
        self,
        workflow_id: str,
        monitor: GoodhartMonitor,
        adapter: ControlAdapter,
    ) -> None:
        DryRunWorkflowAdapter._validate_workflow_id(workflow_id)
        self.workflow_id = workflow_id
        self.monitor = monitor
        self.adapter = adapter
        self.status = WorkflowStatus.ACTIVE
        self._drift_escalated = False

    def run_step(
        self, observation: Observation, action: Callable[[], ResultT]
    ) -> GateResult[ResultT]:
        evaluation = self.monitor.observe(observation)
        if self.status is WorkflowStatus.PAUSED_FOR_REVIEW:
            if evaluation.decision is Decision.HOLD:
                self._apply_controls(
                    evaluation, pause=False, request_review=not self._drift_escalated
                )
                self._drift_escalated = True
            else:
                reason = "workflow remains paused pending explicit human review"
                evaluation = Evaluation(Decision.REVIEW, reason, evaluation.evidence)
                self._apply_controls(evaluation, pause=False, request_review=False)
            return GateResult(evaluation, False, None)

        if not evaluation.permits_action:
            if evaluation.reason == INSUFFICIENT_OBSERVATIONS_REASON:
                self._apply_controls(evaluation, pause=False, request_review=False)
                return GateResult(evaluation, False, None)
            self.status = WorkflowStatus.PAUSED_FOR_REVIEW
            self._apply_controls(evaluation, pause=True)
            self._drift_escalated = evaluation.decision is Decision.HOLD
            return GateResult(evaluation, False, None)

        try:
            result = action()
        except Exception as action_error:
            self.status = WorkflowStatus.PAUSED_FOR_REVIEW
            try:
                self._apply_controls(
                    Evaluation(
                        Decision.REVIEW,
                        f"workflow action raised {type(action_error).__name__}",
                        evaluation.evidence,
                    ),
                    pause=True,
                )
            except ControlFailure as control_error:
                raise control_error from action_error
            raise
        return GateResult(evaluation, True, result)

    def resume(self, review_reference: str, reason: str) -> int:
        """Resume only with a recorded human-review reference and explanation."""
        if not isinstance(review_reference, str) or not review_reference.strip():
            raise ValueError("review_reference must not be empty")
        if not isinstance(reason, str) or not reason.strip():
            raise ValueError("resume reason must not be empty")
        if self.status is not WorkflowStatus.PAUSED_FOR_REVIEW:
            raise RuntimeError("workflow is not paused for review")

        self.adapter.resume_workflow(
            self.workflow_id, review_reference.strip(), reason.strip()
        )
        cleared_samples = self.monitor.reset(
            f"human review {review_reference.strip()}: {reason.strip()}"
        )
        self.status = WorkflowStatus.ACTIVE
        self._drift_escalated = False
        return cleared_samples

    def _apply_controls(
        self, evaluation: Evaluation, pause: bool, request_review: bool = True
    ) -> None:
        reason = evaluation.reason
        evidence = evaluation_record(evaluation)
        failures: list[Exception] = []
        if pause:
            try:
                self.adapter.pause_workflow(self.workflow_id, reason)
            except Exception as error:
                failures.append(error)
        try:
            self.adapter.block_action(self.workflow_id, reason, evidence)
        except Exception as error:
            failures.append(error)
        if request_review:
            try:
                self.adapter.request_human_review(self.workflow_id, reason, evidence)
            except Exception as error:
                failures.append(error)
        if failures:
            raise ControlFailure(self.workflow_id, failures)

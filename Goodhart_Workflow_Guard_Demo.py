#!/usr/bin/env python3
"""Demonstrate workflow pausing and human-review gating without external effects."""

from __future__ import annotations

import json

from goodhart_monitor import DriftPolicy, GoodhartMonitor, Observation
from workflow_control import DryRunWorkflowAdapter, WorkflowController


def main() -> None:
    adapter = DryRunWorkflowAdapter()
    controller = WorkflowController(
        "synthetic-demo",
        GoodhartMonitor(DriftPolicy(window_size=6, min_observations=6)),
        adapter,
    )

    for index in range(6):
        result = controller.run_step(
            Observation(
                timestamp=str(index),
                proxy=float(index),
                goal=float(5 - index),
            ),
            lambda: print("ERROR: blocked workflow action executed"),
        )
        print(
            json.dumps(
                {
                    "step": index,
                    "decision": result.evaluation.decision.value,
                    "executed": result.action_executed,
                    "status": controller.status.value,
                },
                sort_keys=True,
            )
        )

    print("\nDry-run control events:")
    for event in adapter.events:
        print(json.dumps(event.__dict__, sort_keys=True))

    controller.resume(
        review_reference="demo-human-review-1",
        reason="operator checked the synthetic signals and authorized a fresh run",
    )
    print(f"\nAfter explicit review: {controller.status.value}")


if __name__ == "__main__":
    main()

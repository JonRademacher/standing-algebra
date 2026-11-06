"""Standing Guard — a drop-in drift governor derived from Standing Algebra (Σᴿ).

Attach it to a running system, call ``step`` where the system would step, and
it discovers the signals, detects Goodhart drift, corrects it by admitting only
standing-preserving steps, and reports what happened.

    from standing_guard import StandingGuard

    guard = StandingGuard.wrap(system)
    for action in actions:
        guard.step(action)
    print(guard.report().to_markdown())

Nothing here needs configuration, credentials, or third-party packages.
"""

from .discovery import (
    DiscoveryError,
    RoleAssignment,
    classify,
    read_frame,
    step_entry,
)
from .drift import MAXIMIZE, MINIMIZE, normalized_change
from .governor import (
    DriftEvidence,
    Episode,
    GuardConfig,
    GuardStatus,
    Intervention,
    StandingGuard,
    StepRecord,
)
from .report import GuardReport

__all__ = [
    "DiscoveryError",
    "DriftEvidence",
    "Episode",
    "GuardConfig",
    "GuardReport",
    "GuardStatus",
    "Intervention",
    "MAXIMIZE",
    "MINIMIZE",
    "RoleAssignment",
    "StandingGuard",
    "StepRecord",
    "classify",
    "normalized_change",
    "read_frame",
    "step_entry",
]

__version__ = "0.1.0"

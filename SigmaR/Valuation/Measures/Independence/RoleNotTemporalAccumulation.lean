import StandingAlgebra_FormalCore
import RoleState_Definition
import TemporalAccumulation_Definition

/-!
###############################################################################
# Role ≠ Temporal Accumulation
###############################################################################

Role occupancy is an institutional descriptor.

Temporal accumulation tracks irreversible structural
constraint over time.

Institutional roles do not prevent temporal harm,
and temporal harm does not assign roles.
###############################################################################
-/

axiom RoleNotTemporalAccumulation :
  ∀ (a : Agent) (s : State),
    (if RoleState a s then 1 else 0) ≠ TemporalAccumulation a s

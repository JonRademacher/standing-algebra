import StandingAlgebra_FormalCore
import TemporalAccumulation_Definition
import RoleState_Definition

/-!
###############################################################################
# Temporal Accumulation ≠ Role
###############################################################################

Role occupancy is an institutional descriptor.

Temporal accumulation is a structural, time-based
constraint diagnostic.

Institutional roles do not determine irreversible
accumulation, and accumulation does not assign roles.
###############################################################################
-/

axiom TemporalAccumulationNotRole :
  ∀ (a : Agent) (s : State),
    TemporalAccumulation a s ≠ (if RoleState a s then 1 else 0)

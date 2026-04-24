import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Viability — Well-Definedness
###############################################################################

Ensures that exit viability is a total predicate
over agents and states.
###############################################################################
-/

namespace SigmaR

/--
Exit viability is well-defined if for every agent and state,
the predicate has a determinate truth value.
-/
def ExitViability_WellDefined : Prop :=
  ∀ (i : Agent) (s : State), ExitViable i s ∨ ¬ ExitViable i s

end SigmaR

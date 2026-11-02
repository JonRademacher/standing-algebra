import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.ExitThresholdSoundness

/-!
###############################################################################
# Exit Viability — Well-Definedness
###############################################################################

Ensures that exit viability is a total predicate
over agents and states.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

/--
Exit viability is well-defined if for every agent and state,
the predicate has a determinate truth value.
-/
def ExitViability_WellDefined : Prop :=
  ∀ (i : Agent) (s : SigmaR.Valuation.State),
    SigmaR.Valuation.Core.ExitViable i s ∨
      ¬ SigmaR.Valuation.Core.ExitViable i s

end SigmaR.Valuation.Measures.WellDefinedness

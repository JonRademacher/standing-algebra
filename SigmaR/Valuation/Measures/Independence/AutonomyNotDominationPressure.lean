import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Autonomy Not Domination Pressure
###############################################################################

Autonomy measures describe agent-level freedom from coercive
constraint. Domination pressure is a system-level diagnostic
of structural instability.

No default implication between these notions is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating autonomy measures as implying
or licensing assumptions of domination pressure is permitted.
-/
axiom autonomy_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromAutonomyMeasure a s
  )

end SigmaR

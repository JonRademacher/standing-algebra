import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.DominationPressure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Capacity Not Domination Pressure
###############################################################################

Capacity measures describe agent-level potential or ability.
Domination pressure is a system-level diagnostic of structural
instability and collapse.

No default implication between these notions is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as implying
or licensing assumptions of domination pressure is permitted.
-/
axiom capacity_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Autonomy Not Exit Viability
###############################################################################

Autonomy measures do not license or imply exit viability.
Any relationship between these notions must be introduced
explicitly in higher layers or models.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating autonomy measures as guaranteeing
or licensing exit viability is permitted.
-/
axiom autonomy_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromAutonomyMeasure a s
  )

end SigmaR.Valuation.Measures.Independence

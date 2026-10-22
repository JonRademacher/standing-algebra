import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# No Equilibrium Assumption
###############################################################################

The valuation system does not assume the existence
of equilibria or steady states.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.AntiOptimization

/--
No implication from valuation structure to the
existence of an equilibrium state is permitted.
-/
axiom no_equilibrium_assumption :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      HasEquilibrium M
  )

end SigmaR.Valuation.Measures.AntiOptimization

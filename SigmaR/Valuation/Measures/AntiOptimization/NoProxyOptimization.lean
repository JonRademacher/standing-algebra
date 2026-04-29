import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Proxy Optimization
###############################################################################

No valuation measure is assumed to be a valid proxy
for optimizing another measure.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting proxy-based optimization
between valuation measures is allowed.
-/
axiom no_proxy_optimization :
  ¬ (
    ∃ (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      M₁ ≠ M₂ ∧
      ProxiesFor M₁ M₂
  )

end SigmaR


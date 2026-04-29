import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.MeasurementLimits.ObservabilityIsLocal

/-!
###############################################################################
# Goodhart Drift From Partial Observability
###############################################################################

When evaluation relies solely on partial observability (IPFA),
collective drift may arise even without local failure.
###############################################################################
-/

namespace SigmaR

/--
No implication treating reliance on IPFA alone as
sufficient to prevent Goodhart drift is permitted.
-/
axiom goodhart_drift_from_partial_observability :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      (∀ a ∈ G, IPFA a s) →
      TreatedAsAuthoritative s
  )

end SigmaR

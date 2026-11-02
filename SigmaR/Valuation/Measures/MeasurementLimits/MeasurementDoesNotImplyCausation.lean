import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Measurement Does Not Imply Causation
###############################################################################

Observed measurements or correlations do not establish
causal relationships.

Causation cannot be inferred from observation alone.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement to causation is permitted.
-/
axiom measurement_not_causation :
  ¬ (
    ∀ (a : Agent) (s₁ s₂ : State),
      Observable a s₁ →
      Observable a s₂ →
      Causes s₁ s₂
  )

end SigmaR.Valuation.Measures.MeasurementLimits

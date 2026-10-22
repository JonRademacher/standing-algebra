import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Measurement Does Not Imply Legitimacy
###############################################################################

The fact that something is measured or observed does not
confer legitimacy, authority, or justification.

Measurement does not license legitimacy.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.MeasurementLimits

/--
No implication from measurement to legitimacy is permitted.
-/
axiom measurement_not_legitimacy :
  ¬ (
    ∀ (a : Agent) (s : State),
      Observable a s →
      LegitimateMeasure (fun _ _ => 0)
  )

end SigmaR.Valuation.Measures.MeasurementLimits

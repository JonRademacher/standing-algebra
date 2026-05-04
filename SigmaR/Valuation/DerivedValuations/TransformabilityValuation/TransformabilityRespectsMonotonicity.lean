import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Respects Monotonicity
###############################################################################

This file introduces the constraint that transformability
valuations respect declared monotonicity conditions.

It does NOT:
• assert monotonicity
• enforce irreversibility
• imply correctness

It prevents illicit violations only.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityRespectsMonotonicity T means that
transformability valuation T does not violate declared
monotonicity constraints.
-/
constant TransformabilityRespectsMonotonicity :
  TransformabilityValuation → Prop

end SigmaR

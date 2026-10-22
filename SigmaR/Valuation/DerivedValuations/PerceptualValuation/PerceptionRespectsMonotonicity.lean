import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

/-!
###############################################################################
# Perception Respects Monotonicity
###############################################################################

This file introduces the constraint that perception valuations
respect declared monotonicity conditions.

This does NOT:
• assert monotonicity
• enforce irreversibility
• imply correctness

It prevents illicit violations only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
PerceptionRespectsMonotonicity P means that perception valuation P
does not violate declared monotonicity constraints.
-/
axiom PerceptionRespectsMonotonicity :
  PerceptionValuation → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation

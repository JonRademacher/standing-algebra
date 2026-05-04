import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

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

namespace SigmaR

/--
PerceptionRespectsMonotonicity P means that perception valuation P
does not violate declared monotonicity constraints.
-/
constant PerceptionRespectsMonotonicity :
  PerceptionValuation → Prop

end SigmaR

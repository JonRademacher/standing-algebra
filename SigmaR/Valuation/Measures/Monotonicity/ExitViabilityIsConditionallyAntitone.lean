import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.ExitViability_Definition
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Exit Viability Is Conditionally Antitone (Structural)
###############################################################################

Exit viability is treated as conditionally decreasing
with respect to temporal accumulation along the state preorder.

This file names the antitonic relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Exit viability is treated as conditionally antitone
with respect to temporal accumulation.
-/
constant ExitViabilityConditionallyAntitoneUnderTemporalAccumulation :
  Agent → Prop

end SigmaR

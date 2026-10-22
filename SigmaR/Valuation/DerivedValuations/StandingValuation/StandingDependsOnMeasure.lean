import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

/-!
###############################################################################
# Standing Depends On Measure
###############################################################################

This file introduces structural dependency of standing valuation
on underlying valuation measures.

Dependency does NOT imply:
• prioritization
• aggregation semantics
• normative importance
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingDependsOnMeasure S M means that standing valuation S
structurally depends on valuation measure M.
-/
axiom StandingDependsOnMeasure :
  StandingValuation → Measure → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation

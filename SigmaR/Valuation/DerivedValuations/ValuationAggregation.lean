import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Aggregation
###############################################################################

This file introduces aggregation semantics for derived
valuations.

Aggregation does NOT imply:
• optimization
• maximization
• tradeoff justification
• scalar collapse

It is a structural combination only.
###############################################################################
-/

namespace SigmaR

/--
ValuationAggregation V₁ V₂ V₃ means that valuation V₃
is an aggregation of valuations V₁ and V₂.
-/
constant ValuationAggregation :
  DerivedValuation → DerivedValuation → DerivedValuation → Prop

end SigmaR

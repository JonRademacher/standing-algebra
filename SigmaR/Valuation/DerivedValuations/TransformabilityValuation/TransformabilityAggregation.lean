import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Aggregation
###############################################################################

This file introduces aggregation semantics for
transformability valuations.

Aggregation represents structural combination of
transformability across contexts or components.

It does NOT:
• imply optimization
• imply preference
• justify selection
###############################################################################
-/

namespace SigmaR

/--
TransformabilityAggregation T₁ T₂ T₃ means that transformability
valuation T₃ is an aggregation of T₁ and T₂.
-/
constant TransformabilityAggregation :
  TransformabilityValuation → TransformabilityValuation → TransformabilityValuation → Prop

end SigmaR

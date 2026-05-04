import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Aggregation
###############################################################################

This file introduces aggregation semantics for capacity
valuations.

Aggregation represents structural composition or combination
of effective capacity under permitted conditions.

It does NOT:
• imply optimization
• imply preference
• justify selection among outcomes
###############################################################################
-/

namespace SigmaR

/--
CapacityAggregation C₁ C₂ C₃ means that capacity valuation C₃
is an aggregation of capacity valuations C₁ and C₂.
-/
constant CapacityAggregation :
  CapacityValuation → CapacityValuation → CapacityValuation → Prop

end SigmaR

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

/-!
###############################################################################
# Autonomy Aggregation
###############################################################################

This file introduces aggregation semantics specific
to autonomy valuations.

Aggregation does NOT imply:
• prioritization
• desirability
• moral evaluation

It is structural composition only.
###############################################################################
-/

namespace SigmaR

/--
AutonomyAggregation A₁ A₂ A₃ means that autonomy valuation A₃
is an aggregation of autonomy valuations A₁ and A₂.
-/
constant AutonomyAggregation :
  AutonomyValuation → AutonomyValuation → AutonomyValuation → Prop

end SigmaR

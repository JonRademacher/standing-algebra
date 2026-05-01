import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Aggregation
###############################################################################

This file introduces aggregation semantics for standing
valuations.

Aggregation does NOT imply:
• prioritization
• optimization
• moral evaluation
• legitimacy

It is structural composition only.
###############################################################################
-/

namespace SigmaR

/--
StandingAggregation S₁ S₂ S₃ means that standing valuation S₃
is an aggregation of standing valuations S₁ and S₂.
-/
constant StandingAggregation :
  StandingValuation → StandingValuation → StandingValuation → Prop

end SigmaR

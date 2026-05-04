import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Aggregation
###############################################################################

This file introduces aggregation semantics for perception
valuations.

Aggregation may represent:
• coherence across multiple simultaneous perceptions
• temporal self-agreement over accumulated perceptions
• plural agreement across agents (when externalized)

Aggregation does NOT imply:
• correctness
• optimization
• moral evaluation
• legitimacy
###############################################################################
-/

namespace SigmaR

/--
PerceptionAggregation P₁ P₂ P₃ means that perception valuation P₃
is an aggregation of perception valuations P₁ and P₂.
-/
constant PerceptionAggregation :
  PerceptionValuation → PerceptionValuation → PerceptionValuation → Prop

end SigmaR

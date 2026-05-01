import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Aggregation
###############################################################################

This file introduces aggregation semantics for coupling
valuations.

Aggregation does NOT imply:
• optimization
• prioritization
• moral evaluation
• legitimacy

It is structural composition only.
###############################################################################
-/

namespace SigmaR

/--
CouplingAggregation C₁ C₂ C₃ means that coupling valuation C₃
is an aggregation of coupling valuations C₁ and C₂.
-/
constant CouplingAggregation :
  CouplingValuation → CouplingValuation → CouplingValuation → Prop

end SigmaR

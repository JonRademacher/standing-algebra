import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Fragility
###############################################################################

This file introduces the structural notion of fragility
for exit cost valuations.

Fragility describes sensitivity to change, not weakness
or moral vulnerability.
###############################################################################
-/

namespace SigmaR

/--
ExitCostFragility E means that exit cost valuation E
is structurally sensitive to certain changes.
-/
constant ExitCostFragility :
  ExitCostValuation → Prop

end SigmaR

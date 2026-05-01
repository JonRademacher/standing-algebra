import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Fragility
###############################################################################

This file introduces the structural notion of fragility
for standing valuations.

Fragility describes sensitivity to change, not weakness
or moral vulnerability.
###############################################################################
-/

namespace SigmaR

/--
StandingFragility S means that standing valuation S
is structurally sensitive to certain changes.
-/
constant StandingFragility :
  StandingValuation → Prop

end SigmaR

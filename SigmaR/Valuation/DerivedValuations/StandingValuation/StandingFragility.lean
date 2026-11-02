import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

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

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingFragility S means that standing valuation S
is structurally sensitive to certain changes.
-/
axiom StandingFragility :
  StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation

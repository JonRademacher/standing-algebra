import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation

/-!
###############################################################################
# Autonomy Fragility
###############################################################################

This file introduces the structural notion of fragility
for autonomy valuations.

Fragility describes sensitivity to change, not weakness
or moral vulnerability.
###############################################################################
-/

namespace SigmaR

/--
AutonomyFragility A means that autonomy valuation A
is structurally sensitive to certain changes.
-/
constant AutonomyFragility :
  AutonomyValuation → Prop

end SigmaR

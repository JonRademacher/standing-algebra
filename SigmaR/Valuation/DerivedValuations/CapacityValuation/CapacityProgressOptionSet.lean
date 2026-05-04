import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityProgressOption

/-!
###############################################################################
# Capacity Progress Option Set
###############################################################################

This file introduces sets of capacity-progress options.

These sets define the structural boundary of available
capacity-increasing paths.

Their existence constrains the scope of admissible
non-dominating alternatives.

This is not selection.
###############################################################################
-/

namespace SigmaR

/--
CapacityProgressOptionSet S means that S is a set
of capacity-progress options.
-/
constant CapacityProgressOptionSet :
  CapacityProgressOption → Prop

end SigmaR

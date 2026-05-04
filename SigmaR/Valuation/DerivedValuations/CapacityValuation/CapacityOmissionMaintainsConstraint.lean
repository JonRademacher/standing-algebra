import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityProgressOptionSet

/-!
###############################################################################
# Capacity Omission Maintains Constraint
###############################################################################

This file introduces the notion that omission of
capacity-progress usage maintains a structural constraint
when progress was available.

This names omission as a structural condition,
not moral fault.
###############################################################################
-/

namespace SigmaR

/--
CapacityOmissionMaintainsConstraint S means that
failure to engage available capacity-progress options
maintains the capacity constraint structurally.
-/
constant CapacityOmissionMaintainsConstraint :
  CapacityProgressOptionSet → Prop

end SigmaR

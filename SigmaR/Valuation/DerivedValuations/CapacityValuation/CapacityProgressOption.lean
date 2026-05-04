import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Capacity Progress Option
###############################################################################

This file introduces the notion of a capacity-progress option.

A capacity-progress option represents the existence of
an available path that would strictly increase effective
capacity under admissible conditions.

It is a structural possibility, not a preference.
###############################################################################
-/

namespace SigmaR

/--
CapacityProgressOption O means that O represents
a capacity-increasing option.
-/
constant CapacityProgressOption : Type

end SigmaR

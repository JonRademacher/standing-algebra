import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation

/-!
###############################################################################
# Capacity Level
###############################################################################

This file introduces the notion of a capacity level.

Capacity levels represent the degree of effective capacity
available to an agent under current conditions.

They do NOT:
• represent merit
• imply preference
• justify selection
###############################################################################
-/

namespace SigmaR

/--
A capacity level associated with a capacity valuation.
-/
constant CapacityLevel :
  CapacityValuation → Val

end SigmaR

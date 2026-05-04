import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Load
###############################################################################

This file introduces the notion of load on capacity valuation.

Load represents structural burden or utilization acting
against effective capacity.

It does NOT:
• imply fault
• imply incompetence
• imply obligation to intervene
###############################################################################
-/

namespace SigmaR

/--
CapacityLoad C means that capacity valuation C
is subject to structural load.
-/
constant CapacityLoad :
  CapacityValuation → Prop

end SigmaR

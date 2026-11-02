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

namespace SigmaR.Valuation.DerivedValuations.CapacityValuation

/--
CapacityLoad C means that capacity valuation C
is subject to structural load.
-/
axiom CapacityLoad :
  CapacityValuation → Prop

end SigmaR.Valuation.DerivedValuations.CapacityValuation

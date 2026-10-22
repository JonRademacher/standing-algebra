import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Collapse
###############################################################################

This file introduces collapse in capacity valuation.

Collapse represents a regime where effective capacity
falls below viability for its intended role.

It does NOT:
• imply fault
• imply incompetence
• assert moral judgment
• authorize intervention or coercion

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CapacityValuation

/--
CapacityCollapse C means that capacity valuation C
has structurally collapsed.
-/
axiom CapacityCollapse :
  CapacityValuation → Prop

end SigmaR.Valuation.DerivedValuations.CapacityValuation

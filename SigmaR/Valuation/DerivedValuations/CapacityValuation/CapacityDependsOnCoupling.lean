import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Capacity Depends On Coupling
###############################################################################

This file introduces structural dependency of capacity
valuation on coupling relationships.

This captures the fact that effective capacity is shaped
by dependency, proxy relations, and relational constraint.

It does NOT:
• imply subordination
• grant authority
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
CapacityDependsOnCoupling C K means that capacity valuation C
is structurally grounded in coupling valuation K.
-/
constant CapacityDependsOnCoupling :
  CapacityValuation → CouplingValuation → Prop

end SigmaR

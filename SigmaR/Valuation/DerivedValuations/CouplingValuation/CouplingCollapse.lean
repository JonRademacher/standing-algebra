import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Collapse
###############################################################################

This file introduces the structural notion of collapse
in coupling valuation.

Collapse does NOT imply:
• moral failure
• responsibility
• obligation to respond
• authority to intervene

It is a valuation-level condition only.
###############################################################################
-/

namespace SigmaR

/--
CouplingCollapse C means that coupling valuation C
has structurally collapsed.
-/
constant CouplingCollapse :
  CouplingValuation → Prop

end SigmaR

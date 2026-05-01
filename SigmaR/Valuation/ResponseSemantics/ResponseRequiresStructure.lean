import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Requires Structure
###############################################################################

This file introduces the notion that certain responses
require enabling structure to be applicable.

It does NOT:
• assert that the structure exists
• authorize creation of structure
• imply desirability
###############################################################################
-/

namespace SigmaR

/--
ResponseRequiresStructure R means that response R
depends on some enabling structure to apply.
-/
constant ResponseRequiresStructure :
  Response → Prop

end SigmaR

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response

/-!
###############################################################################
# Response Overrides
###############################################################################

This file introduces the structural notion of response override.

Override means that the effect of one response supersedes
or nullifies another at the structural level.

It does NOT imply:
• legitimacy
• authority
• correctness
• priority by value
###############################################################################
-/

namespace SigmaR

/--
ResponseOverrides R₁ R₂ means that response R₁
structurally supersedes the effect of response R₂.
-/
constant ResponseOverrides :
  Response → Response → Prop

end SigmaR

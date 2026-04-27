import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Agency Scope — Definition
###############################################################################

AgencyScope is a valuation-level diagnostic representing
the remaining structurally viable action space available
to an agent in a given state.

Source alignment:
• Standing Algebra (Σᴿ): agency concerns what options
  remain meaningfully available, not what is permitted
  or authorized.
• On Relevance: loss of agency scope may occur without
  standing loss, exit collapse, or explicit coercion.

AgencyScope is descriptive, not normative.
###############################################################################
-/

namespace SigmaR

/--
AgencyScope a s is a successor-native valuation
representing the breadth of admissible, meaningful
actions available to agent a in state s.

Higher values indicate wider remaining agency.
-/
constant AgencyScope : Agent → State → Nat

end SigmaR

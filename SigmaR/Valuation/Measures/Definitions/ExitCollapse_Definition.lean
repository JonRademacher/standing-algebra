import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Collapse — Definition
###############################################################################

Defines the valuation-level condition representing loss of viable exit.
This is a structural boundary, not a decision rule.
###############################################################################
-/

namespace SigmaR

/--
Predicate indicating exit collapse for an agent in a given state.

True means no admissible continuation preserves exit viability.
-/
constant ExitCollapse : Agent → State → Prop

end SigmaR

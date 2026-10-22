import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Collapse — Definition
###############################################################################

Defines the valuation-level condition representing loss of viable exit.
This is a structural boundary, not a decision rule.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Predicate indicating exit collapse for an agent in a given state.

True means no admissible continuation preserves exit viability.
-/
axiom ExitCollapse : Agent → State → Prop

end SigmaR.Valuation.Measures.Definitions

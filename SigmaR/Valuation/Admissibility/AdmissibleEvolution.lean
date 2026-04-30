import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Evolution
###############################################################################

This file governs admissibility of reasoning about the evolution
of valuation measures across states.

It does NOT:
• assert monotonicity
• assert irreversibility
• define time
• permit intervention

It ONLY governs when evolutionary reasoning is permitted.
###############################################################################
-/

namespace SigmaR

/--
Reasoning about the evolution of a valuation measure
is admissible under declared constraints.
-/
constant AdmissibleEvolution : Measure → Prop

end SigmaR

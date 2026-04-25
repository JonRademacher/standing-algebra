import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Consent State — Definition
###############################################################################

ConsentState records whether an agent’s participation
in a given state is consented.

Source alignment:
• On Relevance: consent does not confer standing,
  does not authorize domination, and does not
  substitute for exit viability or autonomy.
• Standing Algebra (Σᴿ): consent is descriptive,
  not normative or authoritative.

This file introduces NO legitimacy assumptions.
###############################################################################
-/

namespace SigmaR

/--
ConsentState a s holds if agent a’s participation
in state s is consented.
-/
constant ConsentState : Agent → State → Prop

end SigmaR

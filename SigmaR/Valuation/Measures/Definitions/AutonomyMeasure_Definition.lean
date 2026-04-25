import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Autonomy Measure — Definition
###############################################################################

AutonomyMeasure is a valuation-level diagnostic representing
an agent’s freedom from coercive constraint under a given state.

Source alignment:
• Standing Algebra (Σᴿ): autonomy is a structural invariant,
  not reducible to standing (σ) or capacity (cap).
• On Relevance: autonomy loss may occur without standing loss.

This file introduces NO normative claims and NO dynamics.
###############################################################################
-/

namespace SigmaR

/--
AutonomyMeasure a s is a successor-native valuation
of agent a’s autonomy in state s.

Higher values indicate greater preserved autonomy.
-/
constant AutonomyMeasure : Agent → State → Nat

end SigmaR

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Propagation
###############################################################################

This file introduces propagation of autonomy effects.

Propagation captures how autonomy loss or constraint
spreads through relational or structural pathways.

It does NOT:
• assert causation
• assign blame
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
AutonomyPropagation A₁ A₂ means that autonomy valuation A₁
propagates structurally to autonomy valuation A₂.
-/
constant AutonomyPropagation :
  AutonomyValuation → AutonomyValuation → Prop

end SigmaR

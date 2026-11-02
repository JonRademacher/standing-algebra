import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Collapse
###############################################################################

This file introduces the structural notion of collapse
in autonomy valuation.

Collapse does NOT imply:
• moral failure
• responsibility
• obligation to repair
• authority to intervene

It is a valuation-level condition only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.AutonomyValuation

/--
AutonomyCollapse A means that autonomy valuation A
has structurally collapsed.
-/
axiom AutonomyCollapse :
  AutonomyValuation → Prop

end SigmaR.Valuation.DerivedValuations.AutonomyValuation

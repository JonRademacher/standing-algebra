import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyProgressOptionSet

/-!
###############################################################################
# Autonomy Progress Required for Non-Domination
###############################################################################

This file introduces the boundary condition that when
autonomy-progress options exist within scope,
non-progress paths cannot be considered non-dominating.

This is a scope restriction, not a selection rule.
###############################################################################
-/

namespace SigmaR

/--
AutonomyProgressRequiredForNonDomination S means that
when S exists and is within scope, non-progress alternatives
fall outside the non-dominating option space.
-/
constant AutonomyProgressRequiredForNonDomination :
  AutonomyProgressOptionSet → Prop

end SigmaR

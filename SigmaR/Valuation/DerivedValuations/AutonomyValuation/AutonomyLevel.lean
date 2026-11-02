import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Level
###############################################################################

This file introduces the notion of an autonomy level.

Autonomy levels represent the degree of effective autonomy
available to an agent, without normative interpretation.

They do NOT:
• imply consent
• justify obligation
• authorize action
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.AutonomyValuation

/--
An autonomy level associated with an autonomy valuation.
-/
axiom AutonomyLevel :
  AutonomyValuation → Val

end SigmaR.Valuation.DerivedValuations.AutonomyValuation

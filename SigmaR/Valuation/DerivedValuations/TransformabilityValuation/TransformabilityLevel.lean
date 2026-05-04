import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation

/-!
###############################################################################
# Transformability Level
###############################################################################

This file introduces the notion of a transformability level.

Transformability levels represent the degree of effective
state-transforming capability available to an agent.

They do NOT:
• rank creativity
• imply merit
• justify selection
###############################################################################
-/

namespace SigmaR

/--
A transformability level associated with a transformability valuation.
-/
constant TransformabilityLevel :
  TransformabilityValuation → Val

end SigmaR

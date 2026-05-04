import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Level
###############################################################################

This file introduces the notion of a perception level.

Perception levels indicate the degree of stability or alignment
of perceptual agreement, without normative interpretation.

They do NOT:
• assert correctness
• imply legitimacy
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
A perception level associated with a perception valuation.
-/
constant PerceptionLevel :
  PerceptionValuation → Val

end SigmaR

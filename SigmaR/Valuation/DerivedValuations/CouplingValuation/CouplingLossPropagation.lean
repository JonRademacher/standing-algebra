import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Loss Propagation
###############################################################################

This file introduces the structural notion that loss
in one coupling valuation may propagate to another.

Propagation does NOT imply:
• inevitability
• responsibility
• obligation to intervene

It is descriptive only.
###############################################################################
-/

namespace SigmaR

/--
CouplingLossPropagation C₁ C₂ means that loss in coupling
valuation C₁ propagates structurally to coupling valuation C₂.
-/
constant CouplingLossPropagation :
  CouplingValuation → CouplingValuation → Prop

end SigmaR

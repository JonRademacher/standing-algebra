import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.ResponseSemantics.Response
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Response Affects Coupling
###############################################################################

This file introduces the structural notion that a response
affects coupling valuation.

This does NOT imply:
• justification for response
• coordination mandate
• authority or intervention

It is descriptive only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CouplingValuation

/--
ResponseAffectsCoupling R C means that response R
has a structural effect on coupling valuation C.
-/
axiom ResponseAffectsCoupling :
  Response → CouplingValuation → Prop

end SigmaR.Valuation.DerivedValuations.CouplingValuation

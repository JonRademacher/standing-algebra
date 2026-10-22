import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Risk Agreement
###############################################################################

This file introduces the abstract notion of risk agreement.

Risk agreement represents stabilization over assessment of
risk exposure, not the existence of risk itself.

It may arise through:
• internal recognition
• external plural assessment

without asserting authority or correctness.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.RiskValuation

/--
An abstract structure representing risk agreement.
-/
axiom RiskAgreement : Type

end SigmaR.Valuation.DerivedValuations.RiskValuation

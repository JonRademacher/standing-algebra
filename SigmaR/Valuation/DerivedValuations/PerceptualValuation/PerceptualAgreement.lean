import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Perceptual Agreement
###############################################################################

This file introduces the abstract notion of perceptual agreement.

Perceptual agreement represents stabilization over one or more
perceptions, not the perceptions themselves.

It does NOT:
• imply correctness
• override perception
• require social consensus
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
An abstract structure representing perceptual agreement.
-/
axiom PerceptualAgreement : Type

end SigmaR.Valuation.DerivedValuations.PerceptualValuation

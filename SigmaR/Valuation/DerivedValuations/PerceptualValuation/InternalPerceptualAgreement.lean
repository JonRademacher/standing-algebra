import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptualAgreement

/-!
###############################################################################
# Internal Perceptual Agreement (iPFA)
###############################################################################

This file introduces internalized perceptual frame agreement.

Internal agreement is formed by an agent through coherence
among their own simultaneous or temporally accumulated perceptions.

It grounds personal warrant and does NOT depend on
external consensus.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
InternalPerceptualAgreement A means that perceptual agreement A
is internalized within a single agent.
-/
axiom InternalPerceptualAgreement :
  PerceptualAgreement → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation

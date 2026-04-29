import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Plurality Emerges From Successor Structure
###############################################################################

Plurality is an ontological property of the system, not a social one.

It emerges whenever the successor structure yields more than
one distinct perceptual or descriptive frame, regardless of
whether agents exist or whether observations agree.
###############################################################################
-/

namespace SigmaR

/--
Plurality exists whenever there is more than one reachable
perceptual or descriptive frame in the successor structure.
-/
axiom plurality_emerges_from_successor_structure :
  ∃ (f₁ f₂ : Frame),
    f₁ ≠ f₂ ∧
    (FrameSucc f₁ f₂ ∨ FrameSucc f₂ f₁)

end SigmaR


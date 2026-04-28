import SigmaR.StandingAlgebra_FormalCore

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
Abstract perceptual or descriptive frames.
-/
constant Frame : Type

/--
Abstract successor relation over frames.
-/
constant Successor : Frame → Frame → Prop

/--
Plurality exists whenever there is more than one reachable frame.
-/
axiom plurality_emerges_from_successor_structure :
  ∃ (f₁ f₂ : Frame),
    f₁ ≠ f₂ ∧
    (Successor f₁ f₂ ∨ Successor f₂ f₁)

end SigmaR

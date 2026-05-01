import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Perceives
###############################################################################

This file introduces the primitive predicate of perception.

Perception denotes structural interaction with something external,
not recognition, awareness, or understanding.

It does NOT imply:
• cognition
• acknowledgment
• correctness
• intention
• agency
• moral awareness

It is purely pre-epistemic interaction.
###############################################################################
-/

namespace SigmaR

/--
Perceives i x means that agent i is structurally affected by,
or interacts with, some external entity x.

The nature of x is intentionally left abstract.
-/
constant Perceives : Agent → Type → Prop

end SigmaR

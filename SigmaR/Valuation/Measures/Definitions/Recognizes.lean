import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Recognizes
###############################################################################

This file introduces the primitive predicate of recognition
between agents.

It does NOT:
• assert that recognition exists
• assert symmetry or asymmetry
• assert correctness of recognition
• assert moral or normative significance

It is pure vocabulary.
###############################################################################
-/

namespace SigmaR

/--
Recognizes i j means that agent i distinguishes agent j
as other-than-itself.
-/
constant Recognizes : Agent → Agent → Prop

end SigmaR

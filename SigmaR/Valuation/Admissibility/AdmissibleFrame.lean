import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Frame
###############################################################################

This file defines admissibility of valuation reasoning relative
to perceptual or analytical frames.

It does NOT:
• privilege any frame
• assert frame correctness
• imply authority or relevance
• collapse frames into outcomes

It ONLY governs when frame-relative reasoning is permitted.
###############################################################################
-/

namespace SigmaR

/--
A valuation frame is admissible for use in reasoning
under explicitly declared constraints.
-/
constant AdmissibleFrame : Frame → Prop

end SigmaR

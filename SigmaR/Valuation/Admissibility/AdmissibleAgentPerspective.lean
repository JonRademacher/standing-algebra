import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Agent Perspective
###############################################################################

This file defines admissibility of valuation reasoning relative
to a particular agent's perspective.

It does NOT:
• grant authority to agents
• imply correctness of perspective
• privilege viewpoints
• permit intervention

It ONLY governs permission to reason from an agent-relative stance.
###############################################################################
-/

namespace SigmaR

/--
An agent-relative perspective is admissible for valuation reasoning
under explicitly declared constraints.
-/
constant AdmissibleAgentPerspective : Agent → Prop

end SigmaR

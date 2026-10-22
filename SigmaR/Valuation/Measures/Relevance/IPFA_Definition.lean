import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# IPFA Definition
###############################################################################

IPFA (Individual Perceptual Frame Agreement) represents
a personal informational warrant.

It indicates that certain valuation information
may be considered relevant for a specific agent.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Relevance

/--
IPFA is a predicate indicating personal informational warrant.
-/
axiom IPFA : Agent → State → Prop

end SigmaR.Valuation.Measures.Relevance

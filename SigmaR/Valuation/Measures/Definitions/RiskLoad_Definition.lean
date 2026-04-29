import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Risk Load — Definition
###############################################################################

RiskLoad measures the structural exposure borne by an agent.

• It is descriptive and diagnostic.
• It is not probabilistic, normative, or optimizing.
• Any properties or invariants are introduced elsewhere.
###############################################################################
-/

namespace SigmaR

/--
RiskLoad a is the successor-native measure
of structural risk exposure borne by agent a.
-/
constant RiskLoad : Agent → Nat

end SigmaR

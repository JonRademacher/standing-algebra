import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Dependency Degree — Definition
###############################################################################

Defines a structural measure of inbound dependency.
Used for risk inheritance and vulnerability reasoning.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Dependency degree of an agent in a given state.

Represents inbound structural reliance, not influence or power.
-/
axiom DependencyDegree : Agent → State → Nat

end SigmaR.Valuation.Measures.Definitions

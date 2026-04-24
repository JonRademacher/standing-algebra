import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Dependency Degree — Definition
###############################################################################

Defines a structural measure of inbound dependency.
Used for risk inheritance and vulnerability reasoning.
###############################################################################
-/

namespace SigmaR

/--
Dependency degree of an agent in a given state.

Represents inbound structural reliance, not influence or power.
-/
constant DependencyDegree : Agent → State → Nat

end SigmaR

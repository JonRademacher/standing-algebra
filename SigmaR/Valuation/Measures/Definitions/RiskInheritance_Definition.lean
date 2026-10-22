import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition

/-!
###############################################################################
# Risk Inheritance — Definition
###############################################################################

Defines how risk propagates structurally through dependency.
No aggregation or optimization is permitted here.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Risk inheritance measure for an agent in a given state.

This reflects structurally inherited exposure due to dependency,
not probabilistic expectation or loss optimization.
-/
axiom RiskInheritance : Agent → State → Nat

end SigmaR.Valuation.Measures.Definitions

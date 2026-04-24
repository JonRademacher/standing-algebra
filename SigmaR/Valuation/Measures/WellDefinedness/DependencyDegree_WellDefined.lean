import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DependencyDegree_Definition

/-!
###############################################################################
# Dependency Degree Well-Definedness
###############################################################################

DependencyDegree is total and structural.
###############################################################################
-/

namespace SigmaR

/--
Dependency degree is total and non-negative.
-/
axiom DependencyDegreeTotal :
  ∀ (a : Agent) (s : State),
    DependencyDegree a s ≥ 0

end SigmaR

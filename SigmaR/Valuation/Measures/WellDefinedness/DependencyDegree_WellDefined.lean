import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition

/-!
###############################################################################
# Dependency Degree Well-Definedness
###############################################################################

DependencyDegree is total and structural.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

open SigmaR.Valuation.Measures.Definitions

/--
Dependency degree is total and non-negative.
-/
axiom DependencyDegreeTotal :
  ∀ (a : Agent) (s : State),
    DependencyDegree a s ≥ 0

end SigmaR.Valuation.Measures.WellDefinedness

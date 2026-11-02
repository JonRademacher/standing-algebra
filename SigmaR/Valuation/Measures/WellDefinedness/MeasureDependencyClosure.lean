import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition

/-!
###############################################################################
# Measure Dependency Closure
###############################################################################

Dependency-based measures depend only on structural coupling,
not on preferences, narratives, or external metadata.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

/--
Predicate: μ depends only on dependency structure.
-/
axiom DependsOnlyOnDependency :
  (Agent → State → Nat) → Prop

/--
Dependency closure axiom.
-/
axiom DependencyClosed :
  DependsOnlyOnDependency DependencyDegree

end SigmaR.Valuation.Measures.WellDefinedness

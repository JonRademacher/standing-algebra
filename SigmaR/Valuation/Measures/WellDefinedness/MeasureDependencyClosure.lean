import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DependencyDegree_Definition

/-!
###############################################################################
# Measure Dependency Closure
###############################################################################

Dependency-based measures depend only on structural coupling,
not on preferences, narratives, or external metadata.
###############################################################################
-/

namespace SigmaR

/--
Predicate: μ depends only on dependency structure.
-/
constant DependsOnlyOnDependency :
  (Agent → State → Nat) → Prop

/--
Dependency closure axiom.
-/
axiom DependencyClosed :
  DependsOnlyOnDependency DependencyDegree

end SigmaR

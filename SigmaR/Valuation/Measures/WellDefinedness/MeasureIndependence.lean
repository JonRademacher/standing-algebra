import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.DependencyDegree_Definition
import SigmaR.Valuation.Measures.RiskInheritance_Definition

/-!
###############################################################################
# Measure Independence
###############################################################################

Valuation measures are conceptually distinct and non-redundant.

This file prevents collapse such as:
  • risk = standing
  • debt = dependency
  • capacity = standing

No quantitative relations are asserted here—only non-identity.
###############################################################################
-/

namespace SigmaR

/--
Independence of standing and capacity measures.
-/
axiom StandingCapacityIndependent :
  ∀ a s, StandingMeasure a s ≠ CapacityMeasure a s

/--
Independence of standing and dependency degree.
-/
axiom StandingDependencyIndependent :
  ∀ a s, StandingMeasure a s ≠ DependencyDegree a s

/--
Independence of risk inheritance and dependency degree.
-/
axiom RiskNotIdenticalToDependency :
  ∀ a s, RiskInheritance a s ≠ DependencyDegree a s

end SigmaR

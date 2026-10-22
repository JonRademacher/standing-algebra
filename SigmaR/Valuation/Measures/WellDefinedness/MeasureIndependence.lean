import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition
import SigmaR.Valuation.Measures.Definitions.RiskInheritance_Definition

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

namespace SigmaR.Valuation.Measures.WellDefinedness

open SigmaR.Valuation.Measures.Definitions

/--
Independence of standing and capacity measures.
-/
axiom StandingCapacityIndependent :
  ∀ (a : Agent) (s : SigmaR.Valuation.State),
    StandingMeasure a s ≠ CapacityMeasure a s

/--
Independence of standing and dependency degree.
-/
axiom StandingDependencyIndependent :
  ∀ (a : Agent) (s : SigmaR.Valuation.State),
    StandingMeasure a s ≠ DependencyDegree a s

/--
Independence of risk inheritance and dependency degree.
-/
axiom RiskNotIdenticalToDependency :
  ∀ (a : Agent) (s : SigmaR.Valuation.State),
    RiskInheritance a s ≠ DependencyDegree a s

end SigmaR.Valuation.Measures.WellDefinedness

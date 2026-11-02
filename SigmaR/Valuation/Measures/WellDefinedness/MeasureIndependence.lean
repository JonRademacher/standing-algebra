import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition
import SigmaR.Valuation.Measures.Definitions.RiskInheritance_Definition
import SigmaR.Valuation.Core.StructuralInterfaces

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
open SigmaR.Valuation.Core

/--
Independence of standing and capacity measures.
-/
axiom StandingCapacityIndependent :
  ∀ (a : Agent) (s : SigmaR.State),
    StandingMeasure a s ≠ CapacityMeasure a s

/--
Independence of standing and dependency degree.
-/
axiom StandingDependencyIndependent :
  ∀ (a : Agent) (s : SigmaR.State),
    StandingMeasure a s ≠ DependencyDegree a s

/--
Independence of risk inheritance and dependency degree.
-/
axiom RiskNotIdenticalToDependency :
  ∀ a s, RiskLevel (RiskState a s) ≠ DependencyDegree a s

end SigmaR.Valuation.Measures.WellDefinedness

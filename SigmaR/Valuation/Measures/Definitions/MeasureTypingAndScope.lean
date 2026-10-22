import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition
import SigmaR.Valuation.Measures.Definitions.RiskInheritance_Definition
import SigmaR.Valuation.Measures.Definitions.ExitCollapse_Definition

/-!
###############################################################################
# Measure Typing and Scope
###############################################################################

Centralizes typing discipline for valuation measures.
Prevents measures from being misused as objectives or selectors.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Type alias for valuation measures.

All valuation measures map (Agent × State) to Nat.
-/
abbrev ValuationMeasure := Agent → SigmaR.Valuation.State → Nat

/--
StandingMeasure is a valuation measure.
-/
noncomputable def standingMeasureTyped : ValuationMeasure :=
  StandingMeasure

/--
CapacityMeasure is a valuation measure.
-/
noncomputable def capacityMeasureTyped : ValuationMeasure :=
  CapacityMeasure

/--
DependencyDegree is a valuation measure.
-/
noncomputable def dependencyDegreeTyped : ValuationMeasure :=
  DependencyDegree

/--
RiskInheritance is a valuation measure.
-/
noncomputable def riskInheritanceTyped : ValuationMeasure :=
  RiskInheritance

end SigmaR.Valuation.Measures.Definitions

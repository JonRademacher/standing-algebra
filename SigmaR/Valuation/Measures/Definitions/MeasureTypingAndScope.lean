import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StandingMeasure_Definition
import SigmaR.Valuation.Measures.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.DependencyDegree_Definition
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.ExitCollapse_Definition

/-!
###############################################################################
# Measure Typing and Scope
###############################################################################

Centralizes typing discipline for valuation measures.
Prevents measures from being misused as objectives or selectors.
###############################################################################
-/

namespace SigmaR

/--
Type alias for valuation measures.

All valuation measures map (Agent × State) to Nat.
-/
def ValuationMeasure := Agent → State → Nat

/--
StandingMeasure is a valuation measure.
-/
def standingMeasureTyped : ValuationMeasure :=
  StandingMeasure

/--
CapacityMeasure is a valuation measure.
-/
def capacityMeasureTyped : ValuationMeasure :=
  CapacityMeasure

/--
DependencyDegree is a valuation measure.
-/
def dependencyDegreeTyped : ValuationMeasure :=
  DependencyDegree

/--
RiskInheritance is a valuation measure.
-/
def riskInheritanceTyped : ValuationMeasure :=
  RiskInheritance

end SigmaR

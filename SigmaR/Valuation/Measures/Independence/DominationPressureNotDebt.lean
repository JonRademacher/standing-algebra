import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Domination Pressure ≠ Structural Debt
###############################################################################

Structural debt represents unresolved asymmetry that
may be repaired.

Domination pressure represents approach to collapse.
###############################################################################
-/

namespace SigmaR

axiom DominationPressureNotDebt :
  ∀ (s : State),
    DomPressure s ≠ StructuralDebt

end SigmaR

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.DominationPressure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Structural Debt ≠ Domination Pressure
###############################################################################

Accumulated debt does not itself imply domination;
domination pressure signals structural failure,
not deferred obligation.
###############################################################################
-/

namespace SigmaR

axiom DebtNotDominationPressure :
  ∀ (s : State),
    StructuralDebt ≠ DomPressure s

end SigmaR

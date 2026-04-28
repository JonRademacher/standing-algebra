import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Equivalence.EquivalenceScope

/-!
###############################################################################
# Equivalence Is Not Global
###############################################################################

Equivalence between valuation measures is not assumed to
hold globally across all states, agents, or contexts.
###############################################################################
-/

namespace SigmaR

/--
No equivalence relation is assumed to hold universally.
-/
axiom equivalence_not_global :
  ¬ (∀ (M₁ M₂ : Agent → State → Nat)
        (a : Agent) (s : State),
        True)

end SigmaR

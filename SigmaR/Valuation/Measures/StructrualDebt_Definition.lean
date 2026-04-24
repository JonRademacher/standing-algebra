import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Structural Debt — Definition
###############################################################################

StructuralDebt is a diagnostic valuation measuring
accumulated unresolved structural asymmetry affecting an agent.

Source alignment:
  • Standing Algebra (Σᴿ v6.x): Structural debt accumulates
    when asymmetry is introduced without repair.
  • On Relevance: debt tracks deferred correction and
    fragility, not blame or wrongdoing.

This file defines StructuralDebt as a measure only.
No repair logic, illegitimacy, or enforcement appears here.
###############################################################################
-/

namespace SigmaR

/--
StructuralDebt a is the successor-native measure
of unresolved structural fragility affecting agent a.
-/
constant StructuralDebt : Agent → Nat

/--
Structural debt is always well-defined and non-negative.
-/
axiom StructuralDebt_nonneg :
  ∀ a : Agent, 0 ≤ StructuralDebt a

end SigmaR

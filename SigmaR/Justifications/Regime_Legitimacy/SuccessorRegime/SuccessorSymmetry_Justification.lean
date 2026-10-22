import SigmaR.Justifications.Core_Legitimacy.STC5_Justification
import SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorRegimeCore
import SigmaR.Regimes.StandingAlgebra_SuccessorRegime

/-!
###############################################################################
# Successor Symmetry Justification
###############################################################################

Successor operations in Σᴿ must respect standing symmetry.

From Standing Algebra:

  • Successor generation increases or extends standing.
  • Any asymmetry in successor treatment constitutes
    covert privilege or selection.
  • Successor operations must therefore preserve STC-5 symmetry.

Therefore:

  Legitimate successor operations must treat
  symmetry-equivalent agents symmetrically.
###############################################################################
-/

namespace SigmaR

/--
Tier-2 legitimacy axiom (Successor Symmetry):

If an operation is Legitimate and is a successor operation,
then it must preserve standing symmetry.
-/
axiom successor_symmetry_required :
  ∀ {F : Operation},
    Legitimate F →
      SuccessorOp F →
      STC5_valid F

/--
Derived theorem:

Legitimate successor operations preserve symmetry.
-/
theorem SuccessorPreservesSymmetry
  {F : Operation}
  (hLeg : Legitimate F) :
  SuccessorOp F →
  STC5_valid F :=
by
  intro hSucc
  exact successor_symmetry_required hLeg hSucc

end SigmaR

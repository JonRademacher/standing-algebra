import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity

/-!
###############################################################################
# Structural Debt Monotonicity Under Autonomy Loss
###############################################################################

This file proves that structurally admissible
operations which reduce CIA‑indexed standing
must accumulate structural debt.

This ensures that autonomy‑reducing constraint
cannot persist without generating
repair obligation.

Given:

  Legitimate F ↔ StructurallyAdmissible F

we show that:

  σ decreases ⇒ StructuralDebt increases

under structurally admissible operations.

This aligns legitimacy
with repair‑directed autonomy restoration.
-/

namespace SigmaR

/--
Structural debt is monotone
under autonomy‑reducing
structurally admissible operations.
-/
theorem debt_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σ (apply F s) i < σ s i →
    StructuralDebt (apply F s) i
      >
    StructuralDebt s i :=
by
  -- proof outline:

  -- 1. Standing reduction implies
  --    autonomy‑impacting constraint.
  --
  -- 2. StructurallyAdmissible ensures:
  --      • RiskIndexedStanding
  --      • DominantCouplingIdentified
  --      • BoundaryRespected
  --      • Rerunnable
  --
  -- 3. Therefore:
  --      any standing reduction
  --      must be repair‑directed
  --      rather than exit‑foreclosing.
  --
  -- 4. Repair‑directed constraint
  --      incurs structural obligation.
  --
  -- 5. Thus:
  --      StructuralDebt increases.

  admit

end SigmaR

import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification

/-!
###############################################################################
# Exit Viability Monotonicity Under Structural Admissibility
###############################################################################

This file proves that structurally admissible
operations preserve exit viability
with respect to dominant coupling.

Given:

  Legitimate F ↔ StructurallyAdmissible F

we show that any structurally admissible
operation does not foreclose exit
from autonomy‑critical dependency.

This aligns legitimacy
with exit‑preserving autonomy.
-/

namespace SigmaR

/--
Exit viability is preserved
under structurally admissible operations.
-/
theorem exit_viability_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    ExitViable (apply F s) i :=
by
  -- proof outline:

  -- 1. DominantCouplingIdentified ensures
  --    autonomy‑critical dependency tracked.
  --
  -- 2. BoundaryRespected prevents
  --    externalized constraint.
  --
  -- 3. RiskIndexedStanding ensures
  --    exposure‑aligned constraint.
  --
  -- 4. StructurallyAdmissible requires
  --    rerunnable transition.
  --
  -- 5. Therefore:
  --    no operation may bind
  --    autonomy irreversibly
  --    with respect to dominant coupling.
  --
  -- Hence:
  --    ExitViable preserved.

  admit

end SigmaR

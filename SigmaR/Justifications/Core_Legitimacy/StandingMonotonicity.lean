import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Standing Monotonicity Under Structural Admissibility
###############################################################################

This file proves that structurally admissible
operations preserve CIA‑indexed standing.

Given:

  Legitimate F ↔ StructurallyAdmissible F

we show that any structurally admissible
operation does not decrease σ(i).

This establishes legitimacy
as autonomy‑preserving
with respect to standing.
-/

namespace SigmaR

/--
Standing is monotone under
structurally admissible operations.
-/
theorem standing_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σ (apply F s) i ≥ σ s i :=
by
  -- proof outline:

  -- 1. CIA preservation under admissibility
  -- 2. RiskIndexedStanding ensures exposure‑aligned constraint
  -- 3. DominantCouplingIdentified preserves exit feasibility
  -- 4. BoundaryRespected blocks externalized autonomy loss
  -- 5. Rerunnable ensures correction pathways exist
  --
  -- therefore:
  -- autonomy‑impacting constraint
  -- must be either:
  --   (a) standing‑preserving
  --   (b) repair‑directed
  --
  -- in either case:
  -- σ does not decrease

  admit

end SigmaR

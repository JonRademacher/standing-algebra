import SigmaR.Operations.LegitimacyInterface
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Illegitimacy of Structural Debt Without Directed Repair
###############################################################################

Structural debt is a standing-relevant burden.

If an operation accumulates structural debt but fails to
perform directed repair, legitimacy collapses.
###############################################################################
-/

namespace SigmaR

/--
**Structural debt without directed repair is illegitimate.**

Any operation that generates structural debt but fails to
directionally repair that debt cannot be legitimate.
-/
theorem debt_without_directed_repair_implies_illegitimacy
  {F : Operation} {s : State}
  (hDebt : StructuralDebt F s)
  (hNoRepair : ¬ DirectedRepair F s) :
  ¬ Legitimate F :=
by
  intro hLeg

  -- Legitimate operations must perform directed repair.
  have hRepair :
    DirectedRepair F s :=
    legitimacy_requires_directed_repair hLeg s

  exact hNoRepair hRepair

end SigmaR

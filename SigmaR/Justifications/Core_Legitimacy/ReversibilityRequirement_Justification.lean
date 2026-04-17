import SigmaR.Justifications.Core_Legitimacy.EnablementObligation_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Reversibility Requirement
###############################################################################

In *On Relevance*, autonomy‑reducing
constraint must remain corrigible.

Structural harm may generate:

  • obligation to repair,
  • institutional redesign,
  • and compensatory restoration.

Constraint applied legitimately:

  • must admit revision,
  • must admit redesign,
  • and must admit restoration
    of CIA‑indexed autonomy.

Failure to preserve
reversibility of effect
permits:

  • autonomy suppression
    to stabilize structurally,
  • standing to be altered
    permanently,
  • and IEW to persist
    under procedural legitimacy.

Constraint that:

  • reduces CIA‑indexed autonomy,
  • while preventing restoration,

produces:

  • structural debt
    that cannot dissipate.

At the Core level we therefore require:

  Any autonomy‑reducing
  intervention
  must remain reversible
  relative to CIA‑indexed autonomy,
  unless permanence is
  publicly authorized
  by autonomy‑bearing agents.

This ensures that:

  • constraint does not
    become permanent
    without consent,
  • repair remains possible,
  • and IEW cannot stabilize
    under irreversible coercion.
-/

namespace SigmaR

/-- Predicate: the intervention
    at state `s`
    admits CIA‑restoring reversal. -/
constant Reversible : State → Prop

/--
Core legitimacy axiom:

Autonomy‑reducing constraint
must remain reversible.
-/
axiom constraint_requires_reversibility :
  ∀ s : State,
    Reversible s

end SigmaR

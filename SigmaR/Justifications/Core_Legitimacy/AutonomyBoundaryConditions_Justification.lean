module SigmaR.Justifications.Core_Legitimacy.AutonomyBoundaryConditions_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Autonomy Boundary Conditions
###############################################################################

In *On Relevance*, autonomy‑reducing action
does not uniformly generate
public standing to intervene.

Examples include:

  • voluntary sacrifice,
  • refusal of care,
  • end‑of‑life autonomy
    under terminal illness.

Self‑harm diminishes agency
but does not license coercion
unless capacity is impaired.

Sacrifice may reduce autonomy locally
while preserving autonomy collectively.

Terminal illness may justify
autonomy‑terminating decisions
where agency persists
and harm is inevitable.

Accordingly:

  Autonomy‑reducing action
  does not constitute IEW
  when:

    • agency persists,
    • capacity is sufficient,
    • exit is voluntary,
    • and no cross‑scope
      autonomy loss occurs.

At the Core level we therefore require:

  Voluntary, capacity‑indexed
  autonomy‑limiting action
  must not generate
  structural debt
  or standing to coerce.

This ensures that:

  • sacrifice remains permissible,
  • terminal autonomy remains legitimate,
  • and autonomy is not treated
    as self‑refuting.
-/

namespace SigmaR

/-- Predicate: the autonomy‑limiting action
    at state `s` is voluntary and
    capacity‑indexed. -/
constant VoluntaryAutonomyLimitation : State → Prop

/--
Core legitimacy axiom:

Voluntary autonomy‑limiting action
does not generate structural debt.
-/
axiom voluntary_limitation_no_debt :
  ∀ s : State,
    VoluntaryAutonomyLimitation s →
    ¬ StructuralDebt.default s

end SigmaR

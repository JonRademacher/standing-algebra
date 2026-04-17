import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification

/-!
###############################################################################
# Justification of Enablement Obligation
###############################################################################

In *On Relevance*, structural harm
may arise without culpability
through Independently Emergent Wrong (IEW).

Absence of culpability:

  does not justify
  removal of repair
  or redesign.

Structural harm therefore:

  generates obligation
  to enable corrective pathways
  including:

    • exit,
    • repair,
    • or redesign.

Collective culpability arises when:

  • decision procedures exist,
  • role accountability exists,
  • foreseeable harms are trackable,
  • and repair pathways exist
    but are ignored.

Accordingly:

  Capacity‑gated agents
  must admit legitimate
  emancipatory routes.

Constraint that:

  • reduces CIA‑indexed autonomy,
  • while blocking access
    to corrective pathways,

permits:

  • structural harm
    to persist legitimately,
  • IEW stabilization,
  • and exit collapse.

At the Core level we therefore require:

  Any autonomy‑reducing
  intervention
  must preserve
  capacity‑indexed access
  to repair or exit.

This ensures that:

  • constraint does not
    trap agency,
  • structural debt
    remains dissipable,
  • and IEW does not
    stabilize
    under procedural legitimacy.
-/

namespace SigmaR

/-- Predicate: the intervention
    at state `s`
    preserves capacity‑indexed
    emancipatory routes. -/
constant EnablementPreserved : State → Prop

/--
Core legitimacy axiom:

Autonomy‑reducing constraint
must preserve access
to repair or exit.
-/
axiom constraint_requires_enablement :
  ∀ s : State,
    EnablementPreserved s

end SigmaR

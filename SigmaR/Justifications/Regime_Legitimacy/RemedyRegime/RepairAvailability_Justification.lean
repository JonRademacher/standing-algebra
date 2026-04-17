import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Repair Availability (IEW‑Robust)
###############################################################################

In both *Standing Algebra* and *On Relevance*, repair availability is not a
policy preference but a structural requirement of non‑domination.

Independently Emergent Wrong (IEW) names autonomy‑impairing system states
that arise without agent culpability. In such cases:

  • blame and punishment are unjustified;
  • coercion without restoration collapses legitimacy;
  • the only admissible response is repair.

Standing Algebra encodes this directly:

  EmergentWrong(s) → ∃ R (Repair(R) ∧ ¬EmergentWrong(R(s)))

That is, whenever a wrong state exists, there must exist at least one
operation capable of restoring autonomy and reducing domination.

*On Relevance* supplies the normative grounding:

  • IEW generates structural debt without culpability;
  • structural debt creates a residual obligation to repair;
  • denying repair availability stabilizes emergent domination.

Repair Availability therefore introduces a **new existence obligation**:

  the system must always provide at least one autonomy‑restoring off‑ramp
  from any IEW state.

This file justifies that obligation while ensuring that the availability
of repair cannot itself become a legitimacy‑preserving proxy optimization
channel.
-/

namespace SigmaR

/-- Predicate: an Independently Emergent Wrong is present at state `s`. -/
constant IndependentlyEmergentWrong : State → Prop

/-- Predicate: the operation is a Repair operation available at state `s`. -/
constant RepairAvailable : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Repair Availability:

If an Independently Emergent Wrong is present at a state under a legitimate
system, then there must exist at least one available repair operation capable
of restoring autonomy and reducing domination.

This obligation holds independently of blame or culpability.
-/
axiom repair_availability_required :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        IndependentlyEmergentWrong s →
        ∃ R : Operation,
          RepairAvailable R s

/--
Derived theorem:

Legitimacy implies that IEW states are never terminal:
a repair pathway must exist.
-/
theorem RepairAvailability_for_IEW
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    IndependentlyEmergentWrong s →
    ∃ R : Operation,
      RepairAvailable R s :=
by
  intros s hIEW
  exact repair_availability_required hLeg s hIEW

end SigmaR

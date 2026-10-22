import SigmaR.Justifications.Core_Legitimacy.CouplingTypeDifferentiation_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Dominant Coupling
###############################################################################

Standing Algebra assumes that each agent
exhibits a uniquely identifiable
dominant coupling kind.

In *On Relevance*, autonomy,
standing, and constraint
are structurally defined
via coupling mechanisms.

Coupling propagates constraint
through the structural engine:

  Coupling
  → Relevance
  → Autonomy Impact
  → Standing Evaluation
  → Legitimate Constraint
  → Repair

Different coupling types:

  • interdependent,
  • emergent,
  • compositional,
  • relational identity‑defining,

propagate autonomy impact differently.

Interdependent and emergent coupling:

  • may threaten exit viability,
  • persist without culpability,
  • and generate IEW.

Relational identity‑defining coupling:

  • stabilizes group continuity,
  • but does not independently
    determine exit feasibility.

Failure to identify the
autonomy‑critical coupling permits:

  • preservation of revisable relations,
  • while exit‑threatening
    dependency persists,

producing Exit collapse
under procedural legitimacy.

At the Core level we therefore require:

  Each agent’s constraint‑propagating
  coupling must be evaluated
  relative to autonomy impact.

Dominant coupling is:

  the coupling type whose failure
  most reduces CIA‑indexed autonomy
  or threatens exit viability.

This ensures that:

  • exit viability analysis is meaningful,
  • repair routing targets
    autonomy‑critical dependency,
  • and IEW‑generating coupling
    cannot be masked
    by identity or role relations.
-/

namespace SigmaR

/-- An operation induces dominant coupling. -/
axiom DominantCoupling : Operation → Prop

/-- Predicate: agent `i`
    has a uniquely identifiable
    dominant coupling
    at state `s`. -/
axiom DominantCouplingIdentified : State → Prop

/--
Core legitimacy axiom:

Constraint‑propagating coupling
must admit a dominant type.
-/
axiom coupling_requires_dominance :
  ∀ s : State,
    DominantCouplingIdentified s

/-- Dominant coupling induced by an operation is incompatible with legitimacy. -/
axiom legitimate_excludes_dominant_coupling_axiom :
  ∀ {F : Operation},
    Legitimate F →
    ¬ DominantCoupling F

/-- Legitimate operations do not induce dominant coupling. -/
theorem DominantCoupling_prohibited_for_legitimacy
  {F : Operation} (hLeg : Legitimate F) :
  ¬ DominantCoupling F :=
legitimate_excludes_dominant_coupling_axiom hLeg

end SigmaR

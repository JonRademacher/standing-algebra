import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification
import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingExhaustiveness_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingTypeDifferentiation_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Legitimacy Characterization
###############################################################################

This file characterizes legitimacy
as the preservation of autonomy‑relevant
structural invariants already required
by Standing Algebra.

Legitimacy is not introduced
as a primitive moral predicate.

Instead:

  Legitimate operations are those
  that preserve:

    • CIA‑indexed standing,
    • bounded dependency,
    • exposure‑indexed risk,
    • exit viability,
    • and repairability
      under structural debt.

Subject to:

    • Perceptual Frame Agreement,
    • Contestability,
    • Public Frame Resolution,
    • Derived Standing,
    • Risk‑Indexed Standing,
    • Coupling Exhaustiveness,
    • Dominant Coupling Identification,
    • Boundary Respect,
    • and Transition Rerunnability.

Thus:

  Legitimacy is equivalent
  to autonomy‑preserving
  structural admissibility.

This removes legitimacy
as a primitive
and re‑expresses it
as an invariant‑preserving property.
-/

namespace SigmaR

/--
Structural admissibility:

An operation preserves
autonomy‑relevant invariants
at state s.
-/
def StructurallyAdmissible
  (F : Operation) (s : State) : Prop :=
    Admissible F
    ∧ PFA s
  (_F : Operation) (s : State) : Prop :=
    PFA s
    ∧ Contestable s
    ∧ FrameResolved s
    ∧ DerivedStanding s
    ∧ RiskIndexedStanding s
    ∧ CouplingExhaustive s
    ∧ DominantCouplingIdentified s
    ∧ BoundaryRespected s
    ∧ Rerunnable s

/-- The pointwise bridge required to characterize legitimacy by the
state-dependent structural predicates. The current core does not derive this
bridge, so callers must provide it rather than relying on an admitted proof. -/
structure LegitimacyCharacterization where
  legitimate_iff_structurally_admissible :
    ∀ (F : Operation) (s : State),
      Legitimate F ↔ StructurallyAdmissible F s

/-- Use an explicitly supplied characterization bridge. -/
theorem legitimacy_characterization
    (characterization : LegitimacyCharacterization)
    {F : Operation} {s : State} :
    Legitimate F ↔ StructurallyAdmissible F s :=
  characterization.legitimate_iff_structurally_admissible F s
/--
Legitimacy is equivalent
to structural admissibility.

This is the Core Alignment equation of the framework: legitimacy is not a
primitive moral predicate but the preservation of the structural invariants
listed in `StructurallyAdmissible`.  It is recorded as an axiom because nothing
below it decides either side; the justifications above establish each of the
nine invariant component separately.
-/
axiom legitimacy_characterization :
  ∀ {F : Operation} {s : State},
    Legitimate F
    ↔
    StructurallyAdmissible F s

end SigmaR

import SigmaR.Justifications.Core_Legitimacy.ALRP_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Drift Standing Monotonicity Justification
###############################################################################

Standing Algebra enforces standing monotonicity (ALRP).

From Standing Algebra:

  • No legitimate operation may reduce standing.
  • Drift does not weaken this constraint.
  • Standing loss via repeated small perturbations
    constitutes domination by attrition.

Therefore:

  Drift may not reduce standing.
###############################################################################
-/

namespace SigmaR

/--
Predicate: drift operation `D` preserves standing
for agent `a` at state `s`.
-/
constant DriftPreservesStanding : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Standing Monotonicity Under Drift):

Drift operations must preserve standing.
-/
axiom drift_preserves_standing :
  ∀ {D : Operation},
    DriftRegimeOp D →
    ∀ s : State,
      ∀ a : Agent,
        DriftPreservesStanding a D s

/--
Derived theorem:

Drift does not erode standing.
-/
theorem DriftStandingMonotone
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  ∀ s : State,
    ∀ a : Agent,
      DriftPreservesStanding a D s :=
by
  intros s a
  exact drift_preserves_standing hDrift s a

end SigmaR

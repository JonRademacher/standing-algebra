import SigmaR.Justifications.Regimes.ExitRegime.ExitRegime_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Drift Exit Preservation Justification
###############################################################################

Exit is a structural condition of non-domination.

From Standing Algebra:

  • Exit may not be eliminated by gradual erosion.
  • Drift, even when bounded, may not degrade
    exit feasibility over time.
  • Exit collapse via perturbation
    constitutes covert coercion.

Therefore:

  Drift must preserve exit.
###############################################################################
-/

namespace SigmaR

/--
Predicate: drift operation `D` preserves exit
for agent `a` at state `s`.
-/
constant DriftPreservesExit : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Exit Preservation Under Drift):

Drift operations must preserve exit feasibility.
-/
axiom drift_preserves_exit :
  ∀ {D : Operation},
    DriftRegimeOp D →
    ∀ s : State,
      ∀ a : Agent,
        DriftPreservesExit a D s

/--
Derived theorem:

Drift does not collapse exit.
-/
theorem DriftExitPreserved
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  ∀ s : State,
    ∀ a : Agent,
      DriftPreservesExit a D s :=
by
  intros s a
  exact drift_preserves_exit hDrift s a

end SigmaR

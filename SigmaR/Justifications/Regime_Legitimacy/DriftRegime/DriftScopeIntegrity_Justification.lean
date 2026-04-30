module SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftScopeIntegrity_Justification

import SigmaR.Justifications.Regimes.AdapterRegime.AdapterScopeIntegrity_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Drift Scope Integrity Justification
###############################################################################

Justification in Σᴿ is scope-relative.

From Standing Algebra:

  • Drift is permitted only within declared scope.
  • Drift may not propagate effects
    across domains without justification.
  • Cross-scope perturbation
    constitutes structural overreach.

Therefore:

  Drift must preserve scope integrity.
###############################################################################
-/

namespace SigmaR

/--
Predicate: drift operation `D` is scoped to `S`.
-/
constant DriftScoped : Operation → Scope → Prop

/--
Predicate: drift operation `D` produces effects
outside scope `S`.
-/
constant DriftEscapesScope : Operation → Scope → Prop

/--
Tier-2 legitimacy axiom (Scope Integrity Under Drift):

Drift operations may not escape their declared scope.
-/
axiom drift_preserves_scope :
  ∀ {D : Operation} {S : Scope},
    DriftRegimeOp D →
    DriftScoped D S →
    ¬ DriftEscapesScope D S

/--
Derived theorem:

Drift remains confined to scope.
-/
theorem DriftScopePreserved
  {D : Operation} {S : Scope}
  (hDrift : DriftRegimeOp D)
  (hScoped : DriftScoped D S) :
  ¬ DriftEscapesScope D S :=
by
  exact drift_preserves_scope hDrift hScoped

end SigmaR

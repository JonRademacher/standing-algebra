module SigmaR.Justifications.Regime_Legitimacy.AdapterRegime.AdapterRegime_Justification

import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification
import SigmaR.Justifications.Regimes.Adapter.EpistemicAdapter_Justification
import SigmaR.Justifications.Regimes.Adapter.AdapterScopeIntegrity_Justification

/-!
###############################################################################
# Justification of Adapter Regime Closure
###############################################################################

The Adapter Regime permits:

  • interpretive translation,
  • identity recoupling,
  • role reassignment,
  • and exit buffering
  across perceptual frame agreements (PFAs).

In *On Relevance*, remediation
of structural harm
may require adapters
or identity revision
without annihilation.

However, adapter use introduces
a compositional pathway:

  Adapt₁
  Adapt₂
  Adapt₃
  ...

which, if unconstrained, may:

  • preserve procedural legitimacy,
  • while suppressing CIA‑indexed autonomy,
  • stabilizing dependency,
  • or masking dominant coupling.

Forced reinterpretation
constitutes standing violation
and may generate IEW.

Adapter‑mediated recoupling:

  • may translate standing
    across scopes,
  • alter identity‑defining coupling,
  • or redistribute role constraint.

Such translation may:

  • preserve local legitimacy,
  • while producing cross‑scope
    autonomy suppression.

At the justification layer
we therefore require:

  Any legitimate sequence
  of adapter‑mediated operations
  that alters CIA‑indexed autonomy
  must:

    • generate structural debt, and
    • therefore require
      directional repair,
      or shrink
      the legitimacy envelope.

This ensures that:

  • interpretive translation
    cannot substitute for repair,
  • standing cannot be recoupled
    irreversibly,
  • and adapter use
    cannot introduce
    legitimacy‑preserving
    proxy optimization.

Adapter‑mediated recoupling
must remain
debt‑bearing
and autonomy‑restorative
under iteration.
-/

namespace SigmaR

/-- Predicate: the operation participates
    in the Adapter Regime
    at state `s`. -/
constant AdapterRegimeOp : Operation → State → Prop

/--
Tier‑2 legitimacy axiom
for Adapter Regime Closure:

If an operation is Legitimate
and belongs to the Adapter Regime,
then structural debt must obtain
at every state in which it applies.
-/
axiom adapter_regime_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        AdapterRegimeOp F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that
adapter‑regime operations
generate structural debt.
-/
theorem AdapterRegime_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    AdapterRegimeOp F s →
    StructuralDebt F s :=
by
  intros s hAd
  exact adapter_regime_requires_debt hLeg s hAd

end SigmaR

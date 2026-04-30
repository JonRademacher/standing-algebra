module SigmaR.Justifications.Regime_Legitimacy.EmergencyRegime.EmergencyTermination_Justification

import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification

/-!
###############################################################################
# Justification of Emergency Termination
###############################################################################

The Emergency Regime permits temporary autonomy override in response
to validated harm threatening standing or exit viability.

From *Standing Algebra*:

  • Emergency intervention may suspend ordinary admissibility gates
    where immediate harm cannot be resolved under normal rules.
  • Emergency must terminate when threat conditions no longer obtain,
    or risk becoming structural domination.

From *On Relevance*:

  • Emergency may temporarily suppress CIA‑indexed autonomy
    in response to IEW or validated harm.
  • However, override must not be normalized into
    a persistent standing relation.

Failure to terminate emergency introduces a compositional pathway:

  Emergency₁
  Emergency₂
  Emergency₃
  ...

which could:

  • stabilize autonomy override,
  • entrench dependency,
  • or suppress CIA cumulatively

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate emergency‑authorized operation
  that maintains altered CIA‑indexed autonomy
  across states must:

    • generate structural debt, and
    • therefore require directional repair,
      or shrink the legitimacy envelope.

This ensures that emergency cannot
normalize autonomy override
or introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation terminates emergency conditions at state `s`. -/
constant EmergencyTerminated : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Emergency Termination:

If an operation is Legitimate and fails to terminate
CIA‑altering emergency conditions across states,
then structural debt must obtain.
-/
axiom emergency_termination_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        EmergencyTerminated F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that failure to terminate emergency
generates structural debt.
-/
theorem EmergencyTermination_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    EmergencyTerminated F s →
    StructuralDebt F s :=
by
  intros s hTerm
  exact emergency_termination_requires_debt hLeg s hTerm

end SigmaR

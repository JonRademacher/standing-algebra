module SigmaR.Justifications.Core_Legitimacy.RiskInheritance_Justification

import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Justification of Risk Inheritance & Validation
###############################################################################

Legitimacy in Standing Algebra does not arise from initiative, authority,
expertise, or majority alone. It tracks *exposure*: who bears the autonomy‑
relevant risk of an operation and whether those risk‑bearers participate in
authorizing coercion.

Risk Inheritance requires that autonomy‑relevant risk not be displaced,
laundered, or externalized. Risk Validation requires that those who bear the
risk are justificatory participants.

These principles are articulated explicitly in both Standing Algebra (§3.10.3.2)
and *On Relevance*.

At the justification layer, we express this as a necessity condition:
any Legitimate operation must inherit and validate risk at every state.
-/

namespace SigmaR

/-- Predicate: the operation properly inherits autonomy‑relevant risk at state s. -/
constant RiskInherited : Operation → State → Prop

/-- Predicate: the operation is validated by its risk‑bearers at state s. -/
constant RiskValidated : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Risk Inheritance & Validation.

If an operation is Legitimate, then for every state it must both inherit
risk and be validated by those who bear that risk.
-/
axiom risk_inheritance_required_for_legitimacy :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskInherited F s ∧ RiskValidated F s

/--
Derived theorem:

Legitimacy implies risk inheritance and validation at every state.
-/
theorem RiskInheritance_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskInherited F s ∧ RiskValidated F s :=
by
  exact risk_inheritance_required_for_legitimacy hLeg

end SigmaR

module SigmaR.Justifications.Regime_Legitimacy.RiskRegime.RiskConsentNonTransivity_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.NRPP_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskRegime_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskInheritance_Justification

/-!
###############################################################################
# Risk Consent Non-Transitivity Justification
###############################################################################

Standing Algebra treats consent as agent-indexed and standing-relative.

From Standing Algebra and On Relevance:

  • Risk inheritance determines standing relevance.
  • Consent to risk is meaningful only for the agent bearing that risk.
  • Authorization or consent by one agent does not transfer standing
    or justification to impose risk on another agent.
  • Treating consent as transitive across agents or scopes
    constitutes consent laundering and enables domination.

Therefore:

  Any legitimate operation participating in the Risk Regime
  must treat consent to risk as non-transitive across agents.

Consent by one risk-bearer cannot justify
risk imposed on another.
###############################################################################
-/

namespace SigmaR

/--
Predicate: agent `a` consents to bearing risk introduced by operation `F`
at state `s`.

This predicate is agent-indexed and non-aggregative by design.
-/
constant RiskConsent : Agent → Operation → State → Prop

/--
Predicate: operation `F` treats consent by one agent as sufficient
to justify risk imposed on another agent.

This captures the forbidden pattern of consent laundering.
-/
constant ConsentTransferred : Agent → Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Risk Consent Non-Transitivity):

If an operation is Legitimate, participates in the Risk Regime,
and introduces risk borne by agent `b`,
then consent by a distinct agent `a` cannot justify that risk.

Risk consent is non-transitive across agents.
-/
axiom risk_consent_non_transitive :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskRegimeOp F s →
        ∀ a b : Agent,
          a ≠ b →
          RiskInheritance b F s →
          RiskConsent a F s →
          ¬ ConsentTransferred a b F s

/--
Derived theorem:

Legitimate risk-regime operations cannot launder consent
across agents.
-/
theorem RiskConsentNonTransitive
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskRegimeOp F s →
    ∀ a b : Agent,
      a ≠ b →
      RiskInheritance b F s →
      RiskConsent a F s →
      ¬ ConsentTransferred a b F s :=
by
  intros s hRisk a b hNeq hInh hCons
  exact risk_consent_non_transitive hLeg s hRisk a b hNeq hInh hCons

end SigmaR

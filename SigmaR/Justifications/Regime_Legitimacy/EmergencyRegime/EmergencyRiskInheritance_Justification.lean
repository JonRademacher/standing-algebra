import SigmaR.Justifications.Core_Legitimacy.NRPP_Justification
import SigmaR.Justifications.Regimes.Emergency.EmergencyRegime_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskInheritance_Justification

/-!
###############################################################################
# Emergency Risk Inheritance Justification
###############################################################################

Standing Algebra treats emergency authority as strictly coupled to risk.

From Standing Algebra and On Relevance:

  • Emergency authorization is justified only by validated harm.
  • The agents exercising emergency authority must inherit
    the risk that justifies the emergency.
  • Delegating emergency coercion to insulated actors
    decouples authority from standing.
  • Such decoupling constitutes domination-by-proxy.

Emergency authority may not migrate to agents or systems
that do not bear the emergency risk.

Therefore:

  Emergency regime operations must preserve
  risk–standing coupling under delegation.
###############################################################################
-/

namespace SigmaR

/--
Predicate: agent `a` exercises emergency authority via operation `F`
at state `s`.
-/
constant ExercisesEmergencyAuthority : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Emergency Risk Inheritance):

If an operation is Legitimate and participates in the Emergency Regime,
then any agent exercising emergency authority must inherit
the emergency risk that justified the regime.

Emergency authority may not be exercised by insulated proxies.
-/
axiom emergency_risk_inheritance_required :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        EmergencyRegimeOp F s →
        ∀ a : Agent,
          ExercisesEmergencyAuthority a F s →
          RiskInheritance a F s

/--
Derived theorem:

Emergency authority is non-delegable to agents
who do not inherit emergency risk.
-/
theorem EmergencyAuthorityRequiresRiskInheritance
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    EmergencyRegimeOp F s →
    ∀ a : Agent,
      ExercisesEmergencyAuthority a F s →
      RiskInheritance a F s :=
by
  intros s hEmer a hAuth
  exact emergency_risk_inheritance_required hLeg s hEmer a hAuth

end SigmaR

import SigmaR.Justifications.Regimes.RiskRegime.RiskLoadMonotonicity_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Risk Accumulation Bound Under Affordance Composition Justification
###############################################################################

Standing Algebra treats risk as standing-relevant and non-launderable.

From Standing Algebra and On Relevance:

  • Risk may be introduced only under strict constraints.
  • Bounding risk per step is insufficient if risk
    accumulates under composition.
  • Risk ratcheting via sequences of admissible affordances
    constitutes domination by aggregation.

Therefore:

  Risk accumulation must be bounded globally
  under affordance composition.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `G` is a composition of affordance operations.
-/
constant AffordanceComposed : Operation → Prop

/--
Predicate: risk introduced by operation `F`
at state `s` is bounded.
-/
constant RiskBounded : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Risk Accumulation Bound):

If each component affordance introduces bounded risk,
then their composition must also introduce bounded risk.

Risk may not ratchet by composition.
-/
axiom risk_bounded_under_composition :
  ∀ {G : Operation},
    AffordanceComposed G →
    (∀ F : Operation,
       ComponentOf F G →
       ∀ s : State,
         RiskBounded F s) →
    ∀ s : State,
      RiskBounded G s

/--
Derived theorem:

Affordance composition preserves bounded risk.
-/
theorem RiskAccumulationBounded
  {G : Operation}
  (hComp : AffordanceComposed G) :
  (∀ F : Operation,
     ComponentOf F G →
     ∀ s : State,
       RiskBounded F s) →
  ∀ s : State,
    RiskBounded G s :=
by
  intro hEach
  exact risk_bounded_under_composition hComp hEach

end SigmaR

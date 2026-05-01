import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Repair Preservation Under Affordance Composition Justification
###############################################################################

Repair is a mandatory corrective pathway in Σᴿ.

From Standing Algebra:

  • Repair must remain available where harm exists.
  • Affordance composition may not eliminate or neutralize
    repair opportunities.
  • Blocking repair via option saturation
    constitutes domination by foreclosure.

Therefore:

  Repair availability must be preserved
  under affordance composition.
###############################################################################
-/

namespace SigmaR

/--
Predicate: repair operation `R` is available
for agent `a` at state `s`.
-/
constant RepairAvailable : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Repair Preservation Under Composition):

If repair is available after each component affordance,
then it must remain available after their composition.
-/
axiom repair_preserved_under_composition :
  ∀ {G : Operation},
    AffordanceComposed G →
    ∀ a : Agent,
      (∀ F : Operation,
         ComponentOf F G →
         ∀ s : State,
           RepairAvailable a F s) →
      ∀ s : State,
        RepairAvailable a G s

/--
Derived theorem:

Affordance composition preserves repair availability.
-/
theorem RepairPreservedUnderComposition
  {G : Operation}
  (hComp : AffordanceComposed G) :
  ∀ a : Agent,
    (∀ F : Operation,
       ComponentOf F G →
       ∀ s : State,
         RepairAvailable a F s) →
    ∀ s : State,
      RepairAvailable a G s :=
by
  intros a hEach s
  exact repair_preserved_under_composition hComp a hEach s

end SigmaR

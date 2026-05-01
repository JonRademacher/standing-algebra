import SigmaR.Justifications.Regimes.AdapterRegime.AdapterScopeIntegrity_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Scope Integrity Under Affordance Composition Justification
###############################################################################

Affordances are justified relative to scope.

From Standing Algebra:

  • Justification is scope-relative.
  • Scope integrity may not be violated by composition.
  • Cross-domain effects require independent justification.

Therefore:

  Affordance composition must preserve scope integrity.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` is justified within scope `S`.
-/
constant Scoped : Operation → Scope → Prop

/--
Predicate: operation `G` produces effects outside scope `S`.
-/
constant ScopeEscalates : Operation → Scope → Prop

/--
Tier-2 legitimacy axiom (Scope Integrity Under Composition):

If all component affordances are scoped to `S`,
then their composition must not escape `S`.

Scope may not expand by composition.
-/
axiom scope_preserved_under_composition :
  ∀ {G : Operation} {S : Scope},
    AffordanceComposed G →
    (∀ F : Operation,
       ComponentOf F G →
       Scoped F S) →
    ¬ ScopeEscalates G S

/--
Derived theorem:

Affordance composition preserves scope integrity.
-/
theorem ScopeIntegrityUnderComposition
  {G : Operation} {S : Scope}
  (hComp : AffordanceComposed G) :
  (∀ F : Operation,
     ComponentOf F G →
     Scoped F S) →
  ¬ ScopeEscalates G S :=
by
  intro hEach
  exact scope_preserved_under_composition hComp hEach

end SigmaR

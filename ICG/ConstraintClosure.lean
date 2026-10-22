module

public import Mathlib.Data.Set.Basic

@[expose] public section

namespace ICG

universe u

/-- An interaction rule combines two constraints into a derived constraint. -/
structure InteractionSystem (Constraint : Type u) where
  interacts : Constraint → Constraint → Constraint → Prop

/-- Finite derivability from a seed family under the interaction rules. -/
inductive Derives {Constraint : Type u} (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) : Constraint → Prop
  | seed {c} : c ∈ seeds → Derives rules seeds c
  | interact {a b c} :
      Derives rules seeds a →
      Derives rules seeds b →
      rules.interacts a b c →
      Derives rules seeds c

/-- The finitary interaction closure of a seed family. -/
def closure {Constraint : Type u} (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) : Set Constraint :=
  {c | Derives rules seeds c}

theorem subset_closure {Constraint : Type u} (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) : seeds ⊆ closure rules seeds := by
  intro c hc
  exact Derives.seed hc

theorem closure_mono {Constraint : Type u} (rules : InteractionSystem Constraint)
    {seeds₁ seeds₂ : Set Constraint} (h : seeds₁ ⊆ seeds₂) :
    closure rules seeds₁ ⊆ closure rules seeds₂ := by
  intro c hc
  induction hc with
  | seed hseed =>
      exact Derives.seed (h hseed)
  | interact ha hb hab ihA ihB =>
      exact Derives.interact ihA ihB hab

theorem closure_interaction_stable {Constraint : Type u}
    (rules : InteractionSystem Constraint) (seeds : Set Constraint) :
    ∀ ⦃a b c⦄, a ∈ closure rules seeds → b ∈ closure rules seeds →
      rules.interacts a b c → c ∈ closure rules seeds := by
  intro a b c ha hb hab
  exact Derives.interact ha hb hab

/-- The closure is contained in every interaction-stable set containing its seeds. -/
theorem closure_minimal {Constraint : Type u} (rules : InteractionSystem Constraint)
    (seeds stable : Set Constraint) (hseeds : seeds ⊆ stable)
    (hstable : ∀ ⦃a b c⦄, a ∈ stable → b ∈ stable →
      rules.interacts a b c → c ∈ stable) :
    closure rules seeds ⊆ stable := by
  intro c hc
  induction hc with
  | seed hseed =>
      exact hseeds hseed
  | interact _ _ hab ihA ihB =>
      exact hstable ihA ihB hab

theorem closure_idempotent {Constraint : Type u}
    (rules : InteractionSystem Constraint) (seeds : Set Constraint) :
    closure rules (closure rules seeds) = closure rules seeds := by
  apply Set.Subset.antisymm
  · exact closure_minimal rules _ _ (fun _ h => h)
      (closure_interaction_stable rules seeds)
  · exact closure_mono rules (subset_closure rules seeds)

/-- States satisfying every constraint in a family are admissible for that family. -/
def admissibleStates {State Constraint : Type u}
    (satisfies : Constraint → State → Prop) (constraints : Set Constraint) :
    Set State :=
  {s | ∀ c ∈ constraints, satisfies c s}

theorem admissibleStates_mono {State Constraint : Type u}
    (satisfies : Constraint → State → Prop) {constraints₁ constraints₂ : Set Constraint}
    (h : constraints₁ ⊆ constraints₂) :
    admissibleStates satisfies constraints₂ ⊆ admissibleStates satisfies constraints₁ := by
  intro s hs c hc
  exact hs c (h hc)

end ICG

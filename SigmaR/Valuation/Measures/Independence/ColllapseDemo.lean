/-
CollapseDemo.lean

A tiny countermodel illustrating definitional collapse
when no independence axiom is imposed.

This is a toy: Agent and State are just Nat.
-/

namespace CollapseDemo

-- Toy "sorts"
abbrev Agent := Nat
abbrev State := Nat

-- Two valuation measures (like StandingMeasure and RiskLoad)
constant StandingMeasure : Agent → State → Nat
constant RiskLoad       : Agent → State → Nat

/-
A "theory" that only requires both measures to be total and nonnegative.
(This mirrors the situation in Valuation/Measures/Definitions + WellDefinedness
without independence.)
-/
def MeasuresWellDefined : Prop :=
  (∀ a s, 0 ≤ StandingMeasure a s) ∧
  (∀ a s, 0 ≤ RiskLoad a s)

-- A "model" interpreting BOTH measures as the same function: (a + s)
def StandingMeasure_model : Agent → State → Nat := fun a s => a + s
def RiskLoad_model       : Agent → State → Nat := fun a s => a + s

-- This shows the "well-definedness theory" is satisfied in the collapsing model.
theorem collapse_model_satisfies_welldefined :
  (∀ a s, 0 ≤ StandingMeasure_model a s) ∧
  (∀ a s, 0 ≤ RiskLoad_model a s) := by
  constructor <;> intro a <;> intro s <;> simp [StandingMeasure_model, RiskLoad_model]

/-
Now, the key point: in this model, the two measures are extensionally equal.
-/
theorem collapse_model_measures_equal :
  StandingMeasure_model = RiskLoad_model := by
  funext a s
  simp [StandingMeasure_model, RiskLoad_model]

/-
If we *had* an independence axiom stating they are never equal,
this model would be ruled out.

This is exactly what your independence files do: they exclude
entire classes of models where intended-distinct measures collapse.
-/
axiom StandingNotRisk : ∀ a s, StandingMeasure a s ≠ RiskLoad a s

/-
And here’s the contradiction: if we try to interpret the abstract constants
as the collapsing model, the independence axiom would fail.

We can't "assign" constants directly in Lean without building a structure,
but we can show the *pattern*: the collapsing interpretation makes the
independence statement false.
-/
theorem independence_rejects_collapse_model :
  ¬ (∀ a s, StandingMeasure_model a s ≠ RiskLoad_model a s) := by
  intro h
  -- choose any a,s; they are equal in this model
  have : StandingMeasure_model 0 0 = RiskLoad_model 0 0 := by
    simp [StandingMeasure_model, RiskLoad_model]
  exact (h 0 0) this

end CollapseDemo

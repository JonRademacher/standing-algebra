/-
ModelCollapseDemo.lean

A strong countermodel demonstration using a Model structure.
Shows definitional collapse is allowed unless explicitly forbidden.

This is a toy model: Agent and State are Nat, measures return Nat.
-/

namespace ModelCollapseDemo

abbrev Agent := Nat
abbrev State := Nat

/-- A model packages valuation measures as fields. -/
structure Model where
  StandingMeasure : Agent → State → Nat
  RiskLoad        : Agent → State → Nat

/--
A minimal "well-definedness" theory: both measures are total and nonnegative.

Notice: this does NOT say they are distinct.
-/
def WellDefined (M : Model) : Prop :=
  (∀ a s, 0 ≤ M.StandingMeasure a s) ∧
  (∀ a s, 0 ≤ M.RiskLoad a s)

/-- Independence axiom (what your independence files provide). -/
def Independence (M : Model) : Prop :=
  ∀ a s, M.StandingMeasure a s ≠ M.RiskLoad a s

/-
-----------------------------------------------------------------------------
A collapsing model: interpret StandingMeasure and RiskLoad as the same function.
-----------------------------------------------------------------------------
-/
def collapseModel : Model :=
{ StandingMeasure := fun a s => a + s
, RiskLoad        := fun a s => a + s
}

/-- The collapsing model satisfies WellDefined. -/
theorem collapseModel_wellDefined : WellDefined collapseModel := by
  constructor <;> intro a <;> intro s <;> simp [WellDefined, collapseModel]

/--
But the collapsing model violates Independence, because the two fields are equal pointwise.
-/
theorem collapseModel_notIndependent : ¬ Independence collapseModel := by
  intro h
  -- pick any a,s: the two measures are definitionally equal in this model
  have eq0 : collapseModel.StandingMeasure 0 0 = collapseModel.RiskLoad 0 0 := by
    simp [collapseModel]
  exact (h 0 0) eq0

/-
-----------------------------------------------------------------------------
Now show the key meta-fact:
If you require both WellDefined and Independence, collapseModel is excluded.
-----------------------------------------------------------------------------
-/
theorem noCollapse_underIndependence :
  ¬ (WellDefined collapseModel ∧ Independence collapseModel) := by
  intro h
  exact collapseModel_notIndependent h.2

/-
-----------------------------------------------------------------------------
Optional: show existence of a non-collapsing model satisfying both.
-----------------------------------------------------------------------------
-/
def distinctModel : Model :=
{ StandingMeasure := fun a s => a + s
, RiskLoad        := fun a s => a + s + 1
}

theorem distinctModel_wellDefined : WellDefined distinctModel := by
  constructor <;> intro a <;> intro s <;> simp [WellDefined, distinctModel]

theorem distinctModel_independent : Independence distinctModel := by
  intro a s
  -- a+s ≠ a+s+1
  simp [distinctModel]

theorem exists_model_satisfying_both :
  ∃ M : Model, WellDefined M ∧ Independence M := by
  refine ⟨distinctModel, ?_, ?_⟩
  · exact distinctModel_wellDefined
  · exact distinctModel_independent

end ModelCollapseDemo
``

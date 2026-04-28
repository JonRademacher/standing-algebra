/-
CollapseDemo.lean

A small semantic countermodel illustrating how *collapse* occurs
when no independence axioms are imposed.

This file demonstrates two related phenomena:

(A) Definitional (extensional) collapse:
    Distinct intended measures may be interpreted as the same function.

(B) Implication collapse:
    Even without equality, one measure may trivially entail another.

The purpose of this file is explanatory: it justifies the existence
of the Independence axioms used elsewhere in SigmaR.

This is a toy model. `Agent` and `State` are just `Nat`.
-/

namespace CollapseDemo

/-
------------------------------------------------------------------------------
Toy universe
------------------------------------------------------------------------------
-/

abbrev Agent := Nat
abbrev State := Nat

/-
Two valuation-style measures, intended to be conceptually distinct
(e.g. StandingMeasure and RiskLoad).
-/
constant StandingMeasure : Agent → State → Nat
constant RiskLoad       : Agent → State → Nat

/-
------------------------------------------------------------------------------
A minimal "well-definedness theory"
------------------------------------------------------------------------------
This mirrors the situation where measures are required only to exist
and satisfy basic properties, but *no independence axioms* are imposed.
-/
def MeasuresWellDefined : Prop :=
  (∀ a s, 0 ≤ StandingMeasure a s) ∧
  (∀ a s, 0 ≤ RiskLoad a s)

/-
------------------------------------------------------------------------------
A collapsing model
------------------------------------------------------------------------------
Both measures are interpreted as the same function.
-/
def StandingMeasure_model : Agent → State → Nat := fun a s => a + s
def RiskLoad_model       : Agent → State → Nat := fun a s => a + s

/-
This collapsing model satisfies the well-definedness theory.
-/
theorem collapse_model_satisfies_welldefined :
  (∀ a s, 0 ≤ StandingMeasure_model a s) ∧
  (∀ a s, 0 ≤ RiskLoad_model a s) := by
  constructor <;> intro a <;> intro s <;> simp
    [StandingMeasure_model, RiskLoad_model]

/-
------------------------------------------------------------------------------
(A) Definitional (extensional) collapse
------------------------------------------------------------------------------
In this model, the two measures are *literally the same function*.
-/
theorem collapse_model_measures_equal :
  StandingMeasure_model = RiskLoad_model := by
  funext a s
  simp [StandingMeasure_model, RiskLoad_model]

/-
If we imposed a *pointwise inequality axiom*, this model would be ruled out.

/-
NOTE:
This axiom is intentionally *stronger* than the independence axioms
used in SigmaR. It is included here purely for demonstration.

It asserts that standing and risk can never both hold simultaneously.
-/
axiom standing_and_risk_exclusive :
  ∀ (a : Agent) (s : State),
    StandingMeasure a s → RiskLoad a s → False


/-
The collapsing model violates such a strong inequality axiom.
-/
theorem strong_independence_rejects_collapse_model :
  ¬ (∀ a s, StandingMeasure_model a s ≠ RiskLoad_model a s) := by
  intro h
  have hEq : StandingMeasure_model 0 0 = RiskLoad_model 0 0 := by
    simp [StandingMeasure_model, RiskLoad_model]
  exact (h 0 0) hEq

/-
------------------------------------------------------------------------------
(B) Implication collapse (the *actual* target of SigmaR independence)
------------------------------------------------------------------------------
Even without equality, collapse can occur via *trivial implication*.

In the collapsing model, StandingMeasure trivially entails RiskLoad,
because they are interpreted identically.
-/
theorem collapse_model_implication :
  ∀ a s, StandingMeasure_model a s = RiskLoad_model a s := by
  intro a s
  simp [StandingMeasure_model, RiskLoad_model]

/-
Thus, any axiom of the form "StandingMeasure does not entail RiskLoad"
would rule out this collapsing interpretation.
-/
axiom standing_not_risk :
  ¬ (∀ a s, StandingMeasure a s → RiskLoad a s)

/-
The collapsing model violates this *non-implication* independence axiom.
-/
theorem nonimplication_independence_rejects_collapse_model :
  ¬ (∀ a s, StandingMeasure_model a s → RiskLoad_model a s) := by
  intro h
  have hEq : StandingMeasure_model 0 0 = RiskLoad_model 0 0 := by
    simp [StandingMeasure_model, RiskLoad_model]
  -- From equality, implication holds trivially, contradicting independence
  have : StandingMeasure_model 0 0 → RiskLoad_model 0 0 := by
    intro _
    simpa [hEq]
  exact standing_not_risk (by
    intro a s
    exact fun _ => by
      have hEq' : StandingMeasure_model a s = RiskLoad_model a s := by
        simp [StandingMeasure_model, RiskLoad_model]
      simpa [hEq'] )

/-
------------------------------------------------------------------------------
Interpretation
------------------------------------------------------------------------------
This file demonstrates:

• Without independence axioms, collapse models are permitted.
• Collapse may occur via equality *or* trivial implication.
• Non-implication independence axioms are sufficient to rule out
  both kinds of collapse.
• Independence axioms therefore restrict the space of admissible models,
  not merely definitional equality.

This justifies the design of SigmaR's Independence layer.
-/

end CollapseDemo

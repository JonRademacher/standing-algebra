/-
CollapseDemo.lean

A small semantic countermodel illustrating how *collapse* occurs
when no independence axioms are imposed.

This file demonstrates two related phenomena:

(A) Definitional (extensional) collapse:
    Distinct intended measures may be interpreted as the same function.

(B) Inference collapse:
    Even without explicit equality, one measure may trivially be
    *treated as* implying another.

The purpose of this file is explanatory: it justifies the existence
of the Independence axioms used elsewhere in SigmaR.

This is a toy model. `Agent` and `State` are just `Nat`.
-/

namespace CollapseDemo

/-!
------------------------------------------------------------------------------
Toy universe
------------------------------------------------------------------------------
-/

abbrev Agent := Nat
abbrev State := Nat

/-!
Two valuation-style measures, intended to be conceptually distinct
(e.g. StandingMeasure and RiskLoad).
-/
constant StandingMeasure : Agent → State → Nat
constant RiskLoad       : Agent → State → Nat

/-!
------------------------------------------------------------------------------
A minimal "well-definedness theory"
------------------------------------------------------------------------------
This mirrors a situation where measures are required only to exist
and satisfy basic numeric properties, but *no independence axioms*
are imposed.
-/
def MeasuresWellDefined : Prop :=
  (∀ a s, 0 ≤ StandingMeasure a s) ∧
  (∀ a s, 0 ≤ RiskLoad a s)

/-!
------------------------------------------------------------------------------
A collapsing model
------------------------------------------------------------------------------
Both measures are interpreted as the same function.
-/
def StandingMeasure_model : Agent → State → Nat := fun a s => a + s
def RiskLoad_model       : Agent → State → Nat := fun a s => a + s

/-!
This collapsing model satisfies the well-definedness theory.
-/
theorem collapse_model_satisfies_welldefined :
  (∀ a s, 0 ≤ StandingMeasure_model a s) ∧
  (∀ a s, 0 ≤ RiskLoad_model a s) := by
  constructor <;> intro a <;> intro s <;> simp
    [StandingMeasure_model, RiskLoad_model]

/-!
------------------------------------------------------------------------------
(A) Definitional (extensional) collapse
------------------------------------------------------------------------------
In this model, the two measures are extensionally indistinguishable.
-/
theorem collapse_model_extensional :
  ∀ a s, StandingMeasure_model a s = RiskLoad_model a s := by
  intro a s
  simp [StandingMeasure_model, RiskLoad_model]

/-!
------------------------------------------------------------------------------
Inference collapse (the *actual* target of Independence)
------------------------------------------------------------------------------
Rather than raw implication, collapse occurs because one measure
is *treated as* licensing inference to the other.
-/

/-- Demo-only misuse predicate: standing is treated as implying risk. -/
constant TreatedAsRiskFromStanding : Agent → State → Prop

/-!
In the collapsing model, this misuse is trivial: since the
measures compute identically, standing can always be *treated as*
implying risk.
-/
theorem collapse_model_inference :
  ∀ a s, TreatedAsRiskFromStanding a s := by
  intro a s
  trivial

/-!
------------------------------------------------------------------------------
Independence axiom (demo form)
------------------------------------------------------------------------------
This mirrors the *shape* of SigmaR's real Independence axioms:
it blocks *treated-as inference*, not value equality.
-/
axiom standing_not_risk :
  ¬ (∀ a s, TreatedAsRiskFromStanding a s)

/-!
The collapsing model violates the independence axiom.
-/
theorem independence_rejects_collapse_model :
  ¬ (∀ a s, TreatedAsRiskFromStanding a s) := by
  intro h
  exact standing_not_risk h

/-!
------------------------------------------------------------------------------
Interpretation
------------------------------------------------------------------------------
This file demonstrates:

• Without independence axioms, collapse models are permitted.
• Collapse may occur via extensional identity *or* inference misuse.
• Independence axioms rule out inference collapse without banning coexistence.
• Independence restricts the space of admissible models,
  not merely definitional equality.

This justifies the design of SigmaR's Independence layer.
-/

end CollapseDemo

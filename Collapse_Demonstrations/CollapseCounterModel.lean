/-
SigmaR_CollapseCountermodel.lean

A Σᴿ-style countermodel demo: the core admissibility axiom (ALRP-style)
can hold while valuation measures collapse (StandingMeasure = RiskLoad),
unless an explicit independence axiom forbids it.

This is a *toy instantiation* that matches the signature shape of Σᴿ.
It demonstrates the model-variation method used for independence proofs.
-/

namespace SigmaR_CollapseCountermodel

/--
A lightweight Σᴿ-style model structure:

- Agent / State / Operation sorts
- σ and cap as Nat-valued (successor-native)
- apply : Operation → Agent → Agent
- Admissible : Operation → Prop

and two valuation measures that we intend to keep distinct:
- StandingMeasure
- RiskLoad

We include two representative core constraints:
- CIA: σ i ≤ cap i
- ALRP-style: Admissible F → σ(apply F i) ≥ σ i for all i
-/
structure SigmaRModel where
  Agent     : Type
  State     : Type
  Operation : Type

  σ   : Agent → Nat
  cap : Agent → Nat

  apply      : Operation → Agent → Agent
  Admissible : Operation → Prop

  -- Valuation measures (these are NOT core axioms; they are valuation layer)
  StandingMeasure : Agent → State → Nat
  RiskLoad        : Agent → State → Nat

  -- Representative core constraints (Σᴿ-style)
  CIA  : ∀ i : Agent, σ i ≤ cap i
  ALRP : ∀ F : Operation, Admissible F → ∀ i : Agent, σ (apply F i) ≥ σ i

/-- Minimal valuation well-definedness (total + nonnegative). -/
def MeasuresWellDefined (M : SigmaRModel) : Prop :=
  (∀ a s, 0 ≤ M.StandingMeasure a s) ∧
  (∀ a s, 0 ≤ M.RiskLoad a s)

/-- Independence condition: the two measures never collapse pointwise. -/
def StandingNotRisk (M : SigmaRModel) : Prop :=
  ∀ a s, M.StandingMeasure a s ≠ M.RiskLoad a s

/-
-----------------------------------------------------------------------------
Concrete Σᴿ-style countermodel where measures collapse:
StandingMeasure = RiskLoad = σ, while CIA and ALRP hold.
-----------------------------------------------------------------------------
-/
def collapseModel : SigmaRModel :=
{ Agent     := Nat
, State     := Unit
, Operation := Nat → Nat

, σ   := fun i => i
, cap := fun i => i

, apply      := fun F i => F i
, Admissible := fun F => ∀ i, F i ≥ i

, StandingMeasure := fun i _ => i
, RiskLoad        := fun i _ => i

, CIA := by intro i; simp
, ALRP := by
    intro F hF i
    -- hF : ∀ i, F i ≥ i
    -- σ(apply F i) = F i, σ i = i
    exact hF i
}

/-- The collapsing model satisfies valuation well-definedness. -/
theorem collapseModel_measuresWellDefined : MeasuresWellDefined collapseModel := by
  constructor <;> intro a <;> intro s <;> simp [MeasuresWellDefined, collapseModel]

/-- But it violates independence, because the measures are equal everywhere. -/
theorem collapseModel_notStandingNotRisk : ¬ StandingNotRisk collapseModel := by
  intro h
  -- pick a = 0, s = ()
  have eq0 : collapseModel.StandingMeasure 0 () = collapseModel.RiskLoad 0 () := by
    simp [collapseModel]
  exact (h 0 ()) eq0

/-
-----------------------------------------------------------------------------
Show that adding the independence axiom would exclude this model.
-----------------------------------------------------------------------------
-/
theorem collapseExcludedByIndependence :
  ¬ (MeasuresWellDefined collapseModel ∧ StandingNotRisk collapseModel) := by
  intro h
  exact collapseModel_notStandingNotRisk h.2

/-
-----------------------------------------------------------------------------
Optional: a non-collapsing Σᴿ-style model exists (so independence is consistent).
-----------------------------------------------------------------------------
-/
def distinctModel : SigmaRModel :=
{ Agent     := Nat
, State     := Unit
, Operation := Nat → Nat

, σ   := fun i => i
, cap := fun i => i

, apply      := fun F i => F i
, Admissible := fun F => ∀ i, F i ≥ i

, StandingMeasure := fun i _ => i
, RiskLoad        := fun i _ => i + 1

, CIA := by intro i; simp
, ALRP := by intro F hF i; exact hF i
}

theorem distinctModel_measuresWellDefined : MeasuresWellDefined distinctModel := by
  constructor <;> intro a <;> intro s <;> simp [MeasuresWellDefined, distinctModel]

theorem distinctModel_standingNotRisk : StandingNotRisk distinctModel := by
  intro a s
  -- i ≠ i+1
  simp [distinctModel]

theorem existsModelWithIndependence :
  ∃ M : SigmaRModel, MeasuresWellDefined M ∧ StandingNotRisk M := by
  refine ⟨distinctModel, ?_, ?_⟩
  · exact distinctModel_measuresWellDefined
  · exact distinctModel_standingNotRisk

end SigmaR_CollapseCountermodel
``

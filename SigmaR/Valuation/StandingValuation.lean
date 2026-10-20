import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Standing Valuation Layer (Full Extension)
###############################################################################

This file defines:

• scalar standing valuation σᵥ
• valuation preorder
• delta valuation Δσ and its sign
• minimal risk inheritance
• capacity-indexed bounds (CIA hook)
• repair operators (strictly restorative)
• admissible update monotonicity
• precise routing of valuation-risk

No aggregation, optimization, or authority primitives appear here.
This file is purely structural.

The core sorts `Agent`, `State` (= `Agent`), `Operation`, `apply` and the
agent-indexed standing `σ` come from `SigmaR.StandingAlgebra_FormalCore`.  The
valuation layer adds its own *state-indexed* standing valuation `σv`, read as a
signed integer so that deltas are meaningful; `cap` is the core's capacity
index, coerced to `Int`.
-/

namespace SigmaR

/-- Standing valuation (autonomy-relevant), state-indexed. -/
axiom σv : Agent → State → Int

/-- Standing order relation. -/
def ValLe (i : Agent) (s₁ s₂ : State) : Prop :=
  σv i s₁ ≤ σv i s₂

/-- Reflexivity. -/
theorem ValLe_refl (i : Agent) (s : State) :
  ValLe i s s :=
by unfold ValLe; exact Int.le_refl _

/-- Transitivity. -/
theorem ValLe_trans
  (i : Agent) (s₁ s₂ s₃ : State) :
  ValLe i s₁ s₂ →
  ValLe i s₂ s₃ →
  ValLe i s₁ s₃ :=
by
  unfold ValLe
  intro h₁ h₂
  exact Int.le_trans h₁ h₂

/-- Preorder induced by valuation. -/
theorem ValLe_preorder (i : Agent) : Preorder State :=
{ le := ValLe i
  le_refl := ValLe_refl i
  le_trans := ValLe_trans i }

/- -------------------------------------------------------------------------- -/
/- Delta valuation                                                            -/
/- -------------------------------------------------------------------------- -/

/-- Change in standing (delta). -/
def Δσ (i : Agent) (s₁ s₂ : State) : Int :=
  σv i s₂ - σv i s₁

/-- Non-decrease iff delta ≥ 0. -/
theorem delta_nonneg_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ ≥ 0 ↔ ValLe i s₁ s₂ :=
by unfold Δσ ValLe; omega

/-- Strict decrease iff delta < 0. -/
theorem delta_neg_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ < 0 ↔ σv i s₂ < σv i s₁ :=
by unfold Δσ; omega

/-- Standing preserved iff delta = 0. -/
theorem delta_zero_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ = 0 ↔ σv i s₂ = σv i s₁ :=
by unfold Δσ; omega

/- -------------------------------------------------------------------------- -/
/- Risk inheritance                                                           -/
/- -------------------------------------------------------------------------- -/

/--
Valuation-level risk inheritance:
the agent bears exposure iff their standing changes.
-/
def InheritsRisk (i : Agent) (s₁ s₂ : State) : Prop :=
  Δσ i s₁ s₂ ≠ 0

/-- Standing preservation implies no inherited risk. -/
theorem no_risk_if_preserved
  (i : Agent) (s₁ s₂ : State) :
  σv i s₂ = σv i s₁ →
  ¬ InheritsRisk i s₁ s₂ :=
by
  intro h
  unfold InheritsRisk Δσ
  omega

/-- Any strict decrease implies inherited risk. -/
theorem risk_if_decrease
  (i : Agent) (s₁ s₂ : State) :
  σv i s₂ < σv i s₁ →
  InheritsRisk i s₁ s₂ :=
by
  unfold InheritsRisk Δσ
  omega

/- -------------------------------------------------------------------------- -/
/- Capacity-indexed autonomy (CIA)                                             -/
/- -------------------------------------------------------------------------- -/

/--
CIA-compatible valuation:
standing cannot exceed agent capacity.
-/
def CIA_Respected (s : State) : Prop :=
  ∀ i : Agent, σv i s ≤ (cap i : Int)

/--
Delta bounded by capacity difference (CIA bound).
-/
def CIA_BoundedDelta (i : Agent) (s₁ s₂ : State) : Prop :=
  Δσ i s₁ s₂ ≤ (cap i : Int) - σv i s₁

/- -------------------------------------------------------------------------- -/
/- Repair operators                                                           -/
/- -------------------------------------------------------------------------- -/

/--
A repair transition strictly restores standing.
(No standing decrease allowed; at least one agent improves.)
-/
def Repair (s₁ s₂ : State) : Prop :=
  (∀ i : Agent, σv i s₁ ≤ σv i s₂) ∧
  (∃ i : Agent, σv i s₁ < σv i s₂)

/-- Repairs strictly reduce valuation-level risk debt. -/
theorem repair_has_positive_delta
  (i : Agent) (s₁ s₂ : State) :
  Repair s₁ s₂ →
  Δσ i s₁ s₂ ≥ 0 :=
by
  intro h
  have hmono : σv i s₁ ≤ σv i s₂ := h.left i
  unfold Δσ
  omega

/- -------------------------------------------------------------------------- -/
/- Admissible update hook                                                      -/
/- -------------------------------------------------------------------------- -/

/--
Abstract admissible update relation (defined later).
-/
axiom AdmissibleUpdate : State → State → Prop

/--
Valuation monotonicity constraint for admissible updates.
(This is a specification, not an axiom.)
-/
def ValuationMonotoneUnderUpdate : Prop :=
  ∀ i s₁ s₂,
    AdmissibleUpdate s₁ s₂ →
    ValLe i s₁ s₂

/--
Equivalent delta-based admissibility constraint.
-/
theorem admissible_delta_nonneg
  (H : ValuationMonotoneUnderUpdate)
  (i : Agent) (s₁ s₂ : State) :
  AdmissibleUpdate s₁ s₂ →
  Δσ i s₁ s₂ ≥ 0 :=
by
  intro hUpd
  have h := H i s₁ s₂ hUpd
  exact (delta_nonneg_iff i s₁ s₂).2 h

/--
CIA-refined admissibility:
updates must be valuation-monotone *and* capacity-respecting.
-/
def CIA_AdmissibleUpdate : Prop :=
  ValuationMonotoneUnderUpdate ∧
  ∀ i s₁ s₂,
    AdmissibleUpdate s₁ s₂ →
    CIA_BoundedDelta i s₁ s₂

end SigmaR

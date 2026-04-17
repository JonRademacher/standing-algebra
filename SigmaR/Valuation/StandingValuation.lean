/-!
###############################################################################
# Standing Valuation Layer (Full Extension)
###############################################################################

This file defines:

• scalar standing valuation σ
• valuation preorder
• delta valuation Δσ and its sign
• minimal risk inheritance
• capacity-indexed bounds (CIA hook)
• repair operators (strictly restorative)
• admissible update monotonicity
• precise routing of valuation-risk

No aggregation, optimization, or authority primitives appear here.
This file is purely structural.
-/

namespace SigmaR

import SigmaR.StandingAlgebra_FormalCore

/-- Core sorts (defined elsewhere in Σᴿ). -/
constant Agent : Type
constant State : Type

/-- Standing valuation (autonomy-relevant). -/
constant σ : Agent → State → ℝ

/-- Capacity bound for each agent (CIA input). -/
constant cap : Agent → ℝ

/-- Standing order relation. -/
def ValLe (i : Agent) (s₁ s₂ : State) : Prop :=
  σ i s₁ ≤ σ i s₂

/-- Reflexivity. -/
theorem ValLe_refl (i : Agent) (s : State) :
  ValLe i s s :=
by unfold ValLe; exact le_rfl

/-- Transitivity. -/
theorem ValLe_trans
  (i : Agent) (s₁ s₂ s₃ : State) :
  ValLe i s₁ s₂ →
  ValLe i s₂ s₃ →
  ValLe i s₁ s₃ :=
by
  unfold ValLe
  intro h₁ h₂
  exact le_trans h₁ h₂

/-- Preorder induced by valuation. -/
theorem ValLe_preorder (i : Agent) : Preorder State :=
{ le := ValLe i
  le_refl := ValLe_refl i
  le_trans := ValLe_trans i }

/* -------------------------------------------------------------------------- */
/* Delta valuation                                                            */
/* -------------------------------------------------------------------------- */

/-- Change in standing (delta). -/
def Δσ (i : Agent) (s₁ s₂ : State) : ℝ :=
  σ i s₂ - σ i s₁

/-- Non-decrease iff delta ≥ 0. -/
theorem delta_nonneg_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ ≥ 0 ↔ ValLe i s₁ s₂ :=
by unfold Δσ ValLe; linarith

/-- Strict decrease iff delta < 0. -/
theorem delta_neg_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ < 0 ↔ σ i s₂ < σ i s₁ :=
by unfold Δσ; linarith

/-- Standing preserved iff delta = 0. -/
theorem delta_zero_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ = 0 ↔ σ i s₂ = σ i s₁ :=
by unfold Δσ; linarith

/* -------------------------------------------------------------------------- */
/* Risk inheritance                                                           */
/* -------------------------------------------------------------------------- */

/--
Valuation-level risk inheritance:
the agent bears exposure iff their standing changes.
-/
def InheritsRisk (i : Agent) (s₁ s₂ : State) : Prop :=
  Δσ i s₁ s₂ ≠ 0

/-- Standing preservation implies no inherited risk. -/
theorem no_risk_if_preserved
  (i : Agent) (s₁ s₂ : State) :
  σ i s₂ = σ i s₁ →
  ¬ InheritsRisk i s₁ s₂ :=
by
  intro h
  unfold InheritsRisk Δσ
  linarith

/-- Any strict decrease implies inherited risk. -/
theorem risk_if_decrease
  (i : Agent) (s₁ s₂ : State) :
  σ i s₂ < σ i s₁ →
  InheritsRisk i s₁ s₂ :=
by
  unfold InheritsRisk Δσ
  linarith

/* -------------------------------------------------------------------------- */
/* Capacity-indexed autonomy (CIA)                                             */
/* -------------------------------------------------------------------------- */

/--
CIA-compatible valuation:
standing cannot exceed agent capacity.
-/
def CIA_Respected (s : State) : Prop :=
  ∀ i : Agent, σ i s ≤ cap i

/--
Delta bounded by capacity difference (CIA bound).
-/
def CIA_BoundedDelta (i : Agent) (s₁ s₂ : State) : Prop :=
  Δσ i s₁ s₂ ≤ cap i - σ i s₁

/* -------------------------------------------------------------------------- */
/* Repair operators                                                           */
/* -------------------------------------------------------------------------- */

/--
A repair transition strictly restores standing.
(No standing decrease allowed; at least one agent improves.)
-/
def Repair (s₁ s₂ : State) : Prop :=
  (∀ i : Agent, σ i s₁ ≤ σ i s₂) ∧
  (∃ i : Agent, σ i s₁ < σ i s₂)

/-- Repairs strictly reduce valuation-level risk debt. -/
theorem repair_has_positive_delta
  (i : Agent) (s₁ s₂ : State) :
  Repair s₁ s₂ →
  Δσ i s₁ s₂ ≥ 0 :=
by
  intro h
  have hmono : σ i s₁ ≤ σ i s₂ := h.left i
  unfold Δσ
  linarith

/* -------------------------------------------------------------------------- */
/* Admissible update hook                                                      */
/* -------------------------------------------------------------------------- */

/--
Abstract admissible update relation (defined later).
-/
constant AdmissibleUpdate : State → State → Prop

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

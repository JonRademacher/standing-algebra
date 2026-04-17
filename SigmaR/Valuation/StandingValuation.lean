/-!
###############################################################################
# Standing Valuation Layer (Extended)
###############################################################################

This layer introduces:

• delta valuation (change in standing),
• sign properties of valuation change,
• a minimal notion of risk inheritance,
• and a structural bridge to admissible update relations.

No aggregation, optimization, or normativity is introduced here.
-/

namespace SigmaR

/-- Core sorts (assumed defined elsewhere in Σᴿ). -/
constant Agent : Type
constant State : Type

/-- Standing valuation for agent `i` at state `s`. -/
constant σ : Agent → State → ℝ

/--
Order comparison of standing across states for an agent.
Purely relational; no optimization is implied.
-/
def ValLe (i : Agent) (s₁ s₂ : State) : Prop :=
  σ i s₁ ≤ σ i s₂

/--
Reflexivity of standing comparison.
-/
theorem ValLe_refl (i : Agent) (s : State) :
  ValLe i s s :=
by
  unfold ValLe
  exact le_rfl

/--
Transitivity of standing comparison.
-/
theorem ValLe_trans
  (i : Agent)
  (s₁ s₂ s₃ : State) :
  ValLe i s₁ s₂ →
  ValLe i s₂ s₃ →
  ValLe i s₁ s₃ :=
by
  unfold ValLe
  intro h₁ h₂
  exact le_trans h₁ h₂

/--
Standing valuation induces a preorder on states for each agent.
Antisymmetry is intentionally *not* assumed.
-/
theorem ValLe_preorder (i : Agent) :
  Preorder State :=
{ le := ValLe i
  le_refl := ValLe_refl i
  le_trans := ValLe_trans i }

/* -------------------------------------------------------------------------- */
/* Delta valuation                                                            */
/* -------------------------------------------------------------------------- */

/--
Delta valuation: change in standing for agent `i`
between states `s₁` and `s₂`.

Positive = standing increase  
Zero     = standing preserved  
Negative = standing reduction
-/
def Δσ (i : Agent) (s₁ s₂ : State) : ℝ :=
  σ i s₂ - σ i s₁

/--
Zero delta iff standing is preserved.
-/
theorem delta_zero_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ = 0 ↔ σ i s₂ = σ i s₁ :=
by
  unfold Δσ
  constructor
  · intro h
    linarith
  · intro h
    linarith

/--
Non-negative delta iff standing does not decrease.
-/
theorem delta_nonneg_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ ≥ 0 ↔ ValLe i s₁ s₂ :=
by
  unfold Δσ ValLe
  linarith

/--
Negative delta iff standing strictly decreases.
-/
theorem delta_neg_iff
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ < 0 ↔ σ i s₂ < σ i s₁ :=
by
  unfold Δσ
  linarith

/* -------------------------------------------------------------------------- */
/* Risk inheritance                                                           */
/* -------------------------------------------------------------------------- */

/--
Risk inheritance (valuation-only, minimal form).

An agent inherits risk across a transition if
their standing changes at all.
-/
def InheritsRisk (i : Agent) (s₁ s₂ : State) : Prop :=
  Δσ i s₁ s₂ ≠ 0

/--
Standing-preserving transitions do not transfer valuation risk.
-/
theorem no_risk_if_delta_zero
  (i : Agent) (s₁ s₂ : State) :
  Δσ i s₁ s₂ = 0 →
  ¬ InheritsRisk i s₁ s₂ :=
by
  unfold InheritsRisk
  intro h
  exact h

/--
Any strict change in standing constitutes risk inheritance.
-/
theorem risk_if_delta_nonzero
  (i : Agent) (s₁ s₂ : State) :
  σ i s₂ ≠ σ i s₁ →
  InheritsRisk i s₁ s₂ :=
by
  unfold InheritsRisk Δσ
  intro h
  linarith

/* -------------------------------------------------------------------------- */
/* Bridge to admissible updates (future layer hook)                            */
/* -------------------------------------------------------------------------- */

/--
Abstract admissible update relation (defined later).

Read: s₁ ⟶ s₂ is an admissible system update.
-/
constant AdmissibleUpdate : State → State → Prop

/--
Valuation monotonicity requirement for admissible updates.

This is NOT an axiom here — it is a *specification hook*
that later admissibility definitions must satisfy.
-/
def ValuationMonotoneUnderUpdate : Prop :=
  ∀ (i : Agent) (s₁ s₂ : State),
    AdmissibleUpdate s₁ s₂ →
    ValLe i s₁ s₂

/--
Equivalent delta formulation of valuation monotonicity.
-/
theorem admissible_update_delta_nonneg
  (H : ValuationMonotoneUnderUpdate)
  (i : Agent) (s₁ s₂ : State) :
  AdmissibleUpdate s₁ s₂ →
  Δσ i s₁ s₂ ≥ 0 :=
by
  intro hUpd
  have h := H i s₁ s₂ hUpd
  exact (delta_nonneg_iff i s₁ s₂).2 h

end SigmaR

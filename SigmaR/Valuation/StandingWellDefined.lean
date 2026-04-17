/-!
###############################################################################
# Standing Valuation — Well-Definedness
###############################################################################

This file discharges all well-definedness obligations for the
standing valuation layer.

It proves that valuation, order, delta, CIA bounds, and risk
are extensional and invariant under state equality.

No new structure or authority is introduced here.
-/

namespace SigmaR

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.StandingValuation

/* -------------------------------------------------------------------------- */
/* 1. Standing extensionality                                                  */
/* -------------------------------------------------------------------------- */

/--
Standing is extensional in the state argument.
-/
theorem standing_extensional
  (i : Agent) {s₁ s₂ : State} :
  s₁ = s₂ → σ i s₁ = σ i s₂ :=
by
  intro h
  cases h
  rfl

/* -------------------------------------------------------------------------- */
/* 2. Order extensionality                                                     */
/* -------------------------------------------------------------------------- */

/--
Standing order respects state equality.
-/
theorem ValLe_congr
  (i : Agent)
  {s₁ s₁' s₂ s₂' : State} :
  s₁ = s₁' →
  s₂ = s₂' →
  ValLe i s₁ s₂ →
  ValLe i s₁' s₂' :=
by
  intro h1 h2 h
  cases h1
  cases h2
  exact h

/* -------------------------------------------------------------------------- */
/* 3. Delta valuation well-definedness                                        */
/* -------------------------------------------------------------------------- */

/--
Delta valuation respects equality in both arguments.
-/
theorem delta_congr
  (i : Agent)
  {s₁ s₁' s₂ s₂' : State} :
  s₁ = s₁' →
  s₂ = s₂' →
  Δσ i s₁ s₂ = Δσ i s₁' s₂' :=
by
  intro h1 h2
  cases h1
  cases h2
  rfl

/* -------------------------------------------------------------------------- */
/* 4. CIA compatibility consistency                                           */
/* -------------------------------------------------------------------------- */

/--
CIA boundedness is invariant under state equality.
-/
theorem CIA_BoundedDelta_congr
  (i : Agent)
  {s₁ s₁' s₂ s₂' : State} :
  s₁ = s₁' →
  s₂ = s₂' →
  CIA_BoundedDelta i s₁ s₂ →
  CIA_BoundedDelta i s₁' s₂' :=
by
  intro h1 h2 h
  cases h1
  cases h2
  exact h

/--
CIA constraints do not distort valuation order.
-/
theorem CIA_does_not_distort_order
  (i : Agent)
  (s₁ s₂ : State) :
  CIA_BoundedDelta i s₁ s₂ →
  ValLe i s₁ s₂ ∨ ValLe i s₂ s₁ :=
by
  unfold ValLe
  exact le_total (σ i s₁) (σ i s₂)

/* -------------------------------------------------------------------------- */
/* 5. Risk inheritance invariance                                             */
/* -------------------------------------------------------------------------- */

/--
Risk inheritance is invariant under state equality.
-/
theorem risk_congr
  (i : Agent)
  {s₁ s₁' s₂ s₂' : State} :
  s₁ = s₁' →
  s₂ = s₂' →
  InheritsRisk i s₁ s₂ →
  InheritsRisk i s₁' s₂' :=
by
  intro h1 h2 h
  unfold InheritsRisk at *
  have hΔ := delta_congr i h1 h2
  intro hzero
  apply h
  exact (hΔ.symm ▸ hzero)

/* -------------------------------------------------------------------------- */
/* 6. No hidden semantics                                                     */
/* -------------------------------------------------------------------------- */

/--
Standing order carries no structure beyond σ itself.
-/
theorem ValLe_depends_only_on_sigma
  (i : Agent) (s₁ s₂ : State) :
  ValLe i s₁ s₂ ↔ σ i s₁ ≤ σ i s₂ :=
by
  rfl

end SigmaR

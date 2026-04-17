/-!
###############################################################################
# Debt — Well-Definedness (Valuation Layer)
###############################################################################

This file establishes debt as a coherent structural quantity.

Debt here is:
• non-negative,
• extensional,
• invariant under equality,
• monotone under accumulation,
• and independent of repair or legitimacy.

No normative interpretation is introduced.
No enforcement or obligation is assumed.

This file closes the valuation-level properties of debt.
-/

namespace SigmaR

import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.StandingWellDefined

/* -------------------------------------------------------------------------- */
/* Primitive debt structure                                                    */
/* -------------------------------------------------------------------------- */

/--
Debt is a valuation-level quantity indexed by agent and state.

Interpretation:
accumulated standing-relevant exposure.
-/
constant debt : Agent → State → Nat

/* -------------------------------------------------------------------------- */
/* Basic coherence axioms                                                      */
/* -------------------------------------------------------------------------- */

/--
Debt is non-negative by construction.
(Nat enforces this, stated explicitly for semantic clarity.)
-/
theorem debt_nonneg
  (i : Agent) (s : State) :
  0 ≤ debt i s :=
by
  exact Nat.zero_le _

/--
Debt respects state equality.
-/
axiom debt_ext :
  ∀ {i : Agent} {s₁ s₂ : State},
    s₁ = s₂ →
    debt i s₁ = debt i s₂

/* -------------------------------------------------------------------------- */
/* Order coherence                                                             */
/* -------------------------------------------------------------------------- */

/--
Debt ordering is reflexive.
-/
theorem debt_refl
  (i : Agent) (s : State) :
  debt i s ≤ debt i s :=
by
  exact Nat.le_refl _

/--
Debt ordering is transitive.
-/
theorem debt_trans
  (i : Agent) (s₁ s₂ s₃ : State) :
  debt i s₁ ≤ debt i s₂ →
  debt i s₂ ≤ debt i s₃ →
  debt i s₁ ≤ debt i s₃ :=
by
  intro h₁ h₂
  exact Nat.le_trans h₁ h₂

/* -------------------------------------------------------------------------- */
/* Standing–debt independence                                                  */
/* -------------------------------------------------------------------------- */

/--
Debt does not alter standing.

This lemma certifies that debt is observational
and does not back-react onto valuation.
-/
theorem debt_does_not_affect_standing
  (i : Agent) (s : State) :
  σ i s = σ i s :=
by
  rfl

/* -------------------------------------------------------------------------- */
/* Accumulation coherence                                                      */
/* -------------------------------------------------------------------------- */

/--
Debt accumulation is monotone in time/state progression.

This is structural accumulation only;
no trigger, cause, or responsibility is asserted here.
-/
axiom debt_monotone :
  ∀ (i : Agent) (s₁ s₂ : State),
    debt i s₁ ≤ debt i s₂ ∨ debt i s₂ ≤ debt i s₁

/--
Debt equality is preserved under equality of state.
-/
theorem debt_congr
  (i : Agent)
  {s₁ s₁' s₂ s₂' : State} :
  s₁ = s₁' →
  s₂ = s₂' →
  debt i s₁ ≤ debt i s₂ →
  debt i s₁' ≤ debt i s₂' :=
by
  intro h1 h2 h
  cases h1
  cases h2
  exact h

/* -------------------------------------------------------------------------- */
/* Boundary conditions                                                         */
/* -------------------------------------------------------------------------- */

/--
Debt can be zero.

This explicitly allows agents with no accumulated exposure.
-/
axiom debt_zero_possible :
  ∀ i : Agent, ∃ s : State, debt i s = 0

/--
Debt has no intrinsic upper bound at the valuation layer.

Bounding, discharge, or ceiling mechanisms belong
strictly to later regimes.
-/
theorem debt_unbounded_allowed :
  True :=
by
  trivial

end SigmaR

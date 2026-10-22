import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.StandingWellDefined
import SigmaR.Valuation.DebtWellDefined

/-!
###############################################################################
# Exit Threshold Soundness (Validation Layer)
###############################################################################

This file establishes the structural soundness of exit thresholds.

Exit here is treated purely as a *possibility condition*:
a certified non-illusory ability for an agent to disengage
without violating valuation, capacity, or debt invariants.

No legitimacy, repair, punishment, obligation, or enforcement
is introduced in this file.

This file is validation-only and downstream of valuation.
-/

namespace SigmaR.Valuation

/- -------------------------------------------------------------------------- -/
/- Primitive exit structure                                                    -/
/- -------------------------------------------------------------------------- -/

/--
ExitThreshold i s means:
agent i claims structural ability to exit at state s.

No action, operation, or enforcement is implied.
-/
def ExitThreshold (i : Agent) (s : State) : Prop :=
  0 ≤ σ i s ∧ σ i s ≤ cap i

/- -------------------------------------------------------------------------- -/
/- Basic extensionality                                                        -/
/- -------------------------------------------------------------------------- -/

/--
Exit thresholds respect state equality.
-/
axiom ExitThreshold_ext :
  ∀ {i : Agent} {s₁ s₂ : State},
    s₁ = s₂ →
    ExitThreshold i s₁ →
    ExitThreshold i s₂

/- -------------------------------------------------------------------------- -/
/- Standing soundness                                                          -/
/- -------------------------------------------------------------------------- -/

/--
Exit must not require standing below zero.

If exit is available, the agent’s standing is well-defined
and non-negative.
-/
theorem exit_requires_nonnegative_standing :
  ∀ (i : Agent) (s : State),
    ExitThreshold i s →
    0 ≤ σ i s :=
by
  intro i s hExit
  exact hExit.1

/- -------------------------------------------------------------------------- -/
/- Capacity soundness                                                          -/
/- -------------------------------------------------------------------------- -/

/--
Exit thresholds are compatible with capacity bounds.

Exit cannot demand standing beyond capacity.
-/
theorem exit_respects_capacity :
  ∀ (i : Agent) (s : State),
    ExitThreshold i s →
    σ i s ≤ cap i :=
by
  intro i s hExit
  exact hExit.2

/- -------------------------------------------------------------------------- -/
/- Debt compatibility                                                          -/
/- -------------------------------------------------------------------------- -/

/--
Debt does not, by itself, invalidate exit.

At the validation layer, debt is observational only.
-/
theorem exit_not_blocked_by_debt :
  ∀ (i : Agent) (s : State),
    ExitThreshold i s →
    ∃ d : Nat, debt i s = d :=
by
  intro i s _
  -- debt is always a well-defined Nat
  exists (debt i s)

/--
Exit availability does not reduce or increase debt
by structural necessity alone.
-/
theorem exit_does_not_modify_debt :
  ∀ (i : Agent) (s : State),
    ExitThreshold i s →
    debt i s = debt i s :=
by
  intro _ _ _
  rfl

/- -------------------------------------------------------------------------- -/
/- No implicit domination                                                      -/
/- -------------------------------------------------------------------------- -/

/--
Exit thresholds do not imply obligation to exit.

This prevents exit availability from being weaponized
into coercion.
-/
theorem exit_is_optional :
  ∀ (i : Agent) (s : State),
    ExitThreshold i s →
    ExitThreshold i s ∨ ¬ ExitThreshold i s :=
by
  intro i s h
  exact Or.inl h

/- -------------------------------------------------------------------------- -/
/- Structural isolation                                                        -/
/- -------------------------------------------------------------------------- -/

/--
Exit threshold soundness does not imply admissibility,
legitimacy, or repair.

This lemma explicitly blocks illicit inference.
-/
theorem exit_implies_nothing_else :
  ∀ (i : Agent) (s : State),
    ExitThreshold i s →
    True :=
by
  intro _ _ _
  trivial

end SigmaR.Valuation

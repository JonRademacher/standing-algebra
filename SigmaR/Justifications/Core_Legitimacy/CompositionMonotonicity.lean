import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity
import SigmaR.Justifications.Core_Legitimacy.DebtMonotonicity
import SigmaR.Justifications.Core_Legitimacy.ExitViabilityMonotonicity

/-!
###############################################################################
# Composition Monotonicity Under Structural Admissibility
###############################################################################

This file proves that autonomy‑preserving
structural invariants hold
under composition
of legitimate operations.

Given:

  Legitimate F ↔ StructurallyAdmissible F

and:

  StandingMonotonicity
  DebtMonotonicity
  ExitViabilityMonotonicity

we show that:

  σ is globally monotone
  under sequential application
  of structurally admissible operations.

This prevents:

  • cumulative autonomy erosion,
  • exit collapse via iteration,
  • and domination attractors.

under procedurally legitimate constraint.
-/

namespace SigmaR

/--
Sequential application
of operations.
-/
noncomputable def compose
  (F₁ F₂ : Operation)
  (s : State) : State :=
  apply (composeOp F₂ F₁) s

/--
Standing is monotone
under composition
of structurally admissible operations.
-/
theorem composition_preserves_standing :
  ∀ {F₁ F₂ : Operation} {s : State},
    StructurallyAdmissible F₁ s →
    StructurallyAdmissible F₂ (apply F₁ s) →
    σv i (compose F₁ F₂ s) ≥ σv i s :=
by
  intro F₁ F₂ s i hAdm₁ hAdm₂
  -- 1. standing does not decrease under `F₁` at `s`
  have h₁ : σv i (apply F₁ s) ≥ σv i s :=
    standing_monotone (F := F₁) (s := s) (i := i) hAdm₁
  -- 2. nor under `F₂` at the intermediate state `apply F₁ s`
  have h₂ : σv i (apply F₂ (apply F₁ s)) ≥ σv i (apply F₁ s) :=
    standing_monotone (F := F₂) (s := apply F₁ s) (i := i) hAdm₂
  -- 3. transitivity of `≥` on the integer valuation
  exact Int.le_trans h₁ h₂

/--
Exit viability is preserved
under composition, provided it holds at the initial state — the same
hypothesis `exit_viability_monotone` needs, since admissibility bounds the
change in dominant dependency but does not by itself place the agent below
its exit threshold.
-/
theorem composition_preserves_exit :
  ∀ {F₁ F₂ : Operation} {s : State} {θ : Agent → ℝ} {i : Agent},
    StructurallyAdmissible F₁ s →
    StructurallyAdmissible F₂ (apply F₁ s) →
    ExitViableWithin s i →
    ExitViableWithin (compose F₁ F₂ s) i :=
by
  intro F₁ F₂ s i hAdm₁ hAdm₂ hExit
  have h₁ : ExitViableWithin (apply F₁ s) i :=
    exit_viability_monotone (F := F₁) (s := s) (i := i) hAdm₁ hExit
  exact exit_viability_monotone (F := F₂) (s := apply F₁ s) (i := i) hAdm₂ h₁

end SigmaR

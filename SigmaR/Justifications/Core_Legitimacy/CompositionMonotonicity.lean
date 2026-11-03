import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity
import SigmaR.Justifications.Core_Legitimacy.DebtMonotonicity
import SigmaR.Justifications.Core_Legitimacy.ExitViabilityMonotonicity
import SigmaR.Valuation.StandingValuation

/-!
###############################################################################
# Composition Monotonicity Under Structural Admissibility
###############################################################################

This file proves that autonomy-preserving structural invariants hold
under composition of legitimate operations.

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

open SigmaR.Valuation

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
  ∀ {F₁ F₂ : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F₁ s →
    StructurallyAdmissible F₂ (apply F₁ s) →
    σv i (compose F₁ F₂ s) ≥ σv i s :=
by
  intro F₁ F₂ s hStructuralF₁ hStructuralF₂
  have hF₁ : Admissible F₁ := hStructuralF₁.1
  have hF₂ : Admissible F₂ := hStructuralF₂.1
  have h₁ : σ s ≤ σ (apply F₁ s) :=
    ALRP F₁ s hF₁
  have h₂ : σ (apply F₁ s) ≤ σ (apply F₂ (apply F₁ s)) :=
    ALRP F₂ (apply F₁ s) hF₂
  change σ (apply (composeOp F₂ F₁) s) ≥ σ s
  rw [apply_composeOp]
  exact Nat.le_trans h₁ h₂
  intro F₁ F₂ s i hAdm₁ hAdm₂
  have h₁ : σv i (apply F₁ s) ≥ σv i s :=
    standing_monotone (F := F₁) (s := s) (i := i) hAdm₁
  have h₂ : σv i (apply F₂ (apply F₁ s)) ≥ σv i (apply F₁ s) :=
    standing_monotone (F := F₂) (s := apply F₁ s) (i := i) hAdm₂
  unfold compose
  rw [apply_composeOp]
  exact Int.le_trans h₁ h₂

/--
Exit viability is preserved
under composition, provided it holds at the initial state — the same
hypothesis `exit_viability_monotone` needs, since admissibility bounds the
change in dominant dependency but does not by itself place the agent below
its exit threshold.
-/
theorem composition_preserves_exit :
  ∀ {F₁ F₂ : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F₁ s →
    StructurallyAdmissible F₂ (apply F₁ s) →
    ExitViable θ s i →
    ExitViable θ (compose F₁ F₂ s) i :=
by
  intro F₁ F₂ s θ i hF₁ hF₂ hExit
  have hAfterFirst : ExitViable θ (apply F₁ s) i :=
    exit_viability_monotone θ hF₁ hExit
  have hAfterSecond : ExitViable θ (apply F₂ (apply F₁ s)) i :=
    exit_viability_monotone θ hF₂ hAfterFirst
  change ExitViable θ (apply (composeOp F₂ F₁) s) i
  rw [apply_composeOp]
  exact hAfterSecond
    ExitViableWithin s i →
    ExitViableWithin (compose F₁ F₂ s) i :=
by
  intro F₁ F₂ s i hAdm₁ hAdm₂ hExit
  have h₁ : ExitViableWithin (apply F₁ s) i :=
    exit_viability_monotone (F := F₁) (s := s) (i := i) hAdm₁ hExit
  unfold compose
  rw [apply_composeOp]
  exact exit_viability_monotone (F := F₂) (s := apply F₁ s) (i := i) hAdm₂ h₁

end SigmaR

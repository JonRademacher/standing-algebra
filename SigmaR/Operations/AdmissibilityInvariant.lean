import SigmaR.Core.FormalCore

namespace SigmaR

/-!
###############################################################################
# Admissibility Invariant (Derived)
###############################################################################

This file proves strict, reusable invariants implied by the Core axioms.

No new axioms are introduced here.

Main results:
• admissibility_invariant: one-step standing preservation
• admissible_iter_preserves: n-step standing preservation under repeated application
• admissible_iter_monotone_step: chain monotonicity across iterates
###############################################################################
-/

/- -------------------------------------------------------------------------- */
/* Definition: n-fold application of a single operation                         */
/* -------------------------------------------------------------------------- */

/-- Apply an operation `F` repeatedly `n` times to an agent `a`. -/
def iterApply : Nat → Operation → Agent → Agent
| 0,     _, a => a
| n + 1, F, a => apply F (iterApply n F a)

/- -------------------------------------------------------------------------- */
/* Admissibility Invariant (one-step)                                          */
/* -------------------------------------------------------------------------- */

/--
Admissibility Invariant (one-step):
If an operation is admissible, it does not reduce standing.
This is the strict derived form of ALRP, packaged for reuse.
-/
theorem admissibility_invariant
  (F : Operation) :
  Admissible F → ∀ a : Agent, σ a ≤ σ (apply F a) :=
by
  intro hAdm a
  exact ALRP F a hAdm

/--
Equivalent packaged predicate (optional, but useful for downstream “spec hooks”).
-/
def AdmissibilityInvariant (F : Operation) : Prop :=
  ∀ a : Agent, Admissible F → σ a ≤ σ (apply F a)

/-- The invariant holds for every operation as a theorem, conditional on admissibility. -/
theorem AdmissibilityInvariant_holds (F : Operation) :
  AdmissibilityInvariant F :=
by
  intro a hAdm
  exact ALRP F a hAdm

/- -------------------------------------------------------------------------- */
/* Strong carry-forward form: invariance under repeated application             */
/* -------------------------------------------------------------------------- */

/--
Monotone step across iterates:
If `F` is admissible, each iterate does not decrease standing relative to the previous.
-/
theorem admissible_iter_monotone_step
  (F : Operation) (n : Nat) :
  Admissible F →
  ∀ a : Agent, σ (iterApply n F a) ≤ σ (iterApply (n + 1) F a) :=
by
  intro hAdm a
  -- unfold one step of iteration
  simp [iterApply]
  -- apply ALRP at the intermediate agent iterApply n F a
  exact ALRP F (iterApply n F a) hAdm

/--
n-step Admissibility Invariant:
If `F` is admissible, then for any `n`, standing does not decrease from `a`
to the result of applying `F` `n` times.
-/
theorem admissible_iter_preserves
  (F : Operation) :
  Admissible F →
  ∀ (n : Nat) (a : Agent), σ a ≤ σ (iterApply n F a) :=
by
  intro hAdm
  intro n
  induction n with
  | zero =>
      intro a
      -- iterApply 0 F a = a
      simp [iterApply]
  | succ n ih =>
      intro a
      -- We want: σ a ≤ σ (iterApply (n+1) F a)
      -- Use transitivity: σ a ≤ σ (iterApply n F a) ≤ σ (iterApply (n+1) F a)
      have h1 : σ a ≤ σ (iterApply n F a) := ih a
      have h2 : σ (iterApply n F a) ≤ σ (iterApply (n + 1) F a) :=
        admissible_iter_monotone_step F n hAdm a
      exact Nat.le_trans h1 h2

end SigmaR
``

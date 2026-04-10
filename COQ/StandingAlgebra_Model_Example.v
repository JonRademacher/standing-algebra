(** Standing Algebra (Σᴿ)
    Example / Model Sanity File *)

From StandingAlgebra Require Import StandingAlgebraCoreCoq.
From StandingAlgebra Require Import StandingAlgebraBasicsCoq.

Require Import Coq.Arith.Arith.
Require Import Coq.Logic.Classical.

Section SigmaR_Model_Example.

(* ------------------------------------------------ *)
(* A tiny abstract universe                          *)
(* ------------------------------------------------ *)

Variable A1 A2 : Agent.
Variable S0 : State.
Variable F_id : Operation.

(* ------------------------------------------------ *)
(* Interpretation assumptions (local to the section) *)
(* ------------------------------------------------ *)

Hypothesis sigma_const :
  forall a : Agent, σ a = 1.

Hypothesis apply_identity_agent :
  forall (a : Agent), ApplyAgent F_id a = a.

Hypothesis apply_identity_state :
  forall (s : State), ApplyState F_id s = s.

Hypothesis dompressure_zero :
  DomPressure S0 = 0.

Hypothesis F_id_admissible :
  Admissible F_id.

Hypothesis F_id_legitimate :
  Legitimate F_id.

Hypothesis F_id_not_repair :
  ~ Repair F_id.

(* ------------------------------------------------ *)
(* Derived verifications                             *)
(* ------------------------------------------------ *)

Lemma model_standing_preserved :
  forall a : Agent,
    σ (ApplyAgent F_id a) >= σ a.
Proof.
  intro a.
  rewrite apply_identity_agent.
  rewrite sigma_const.
  lia.
Qed.

Lemma model_idempotent :
  forall a : Agent,
    ApplyAgent F_id (ApplyAgent F_id a) = ApplyAgent F_id a.
Proof.
  intro a.
  repeat rewrite apply_identity_agent.
  reflexivity.
Qed.

Lemma model_dompressure_monotone :
  DomPressure (ApplyState F_id S0) <= DomPressure S0.
Proof.
  rewrite apply_identity_state.
  rewrite dompressure_zero.
  lia.
Qed.

Lemma model_legitimate_safe :
  forall s : State,
    DomPressure (ApplyState F_id s) <= DomPressure s.
Proof.
  intros s.
  apply DomPressure_monotonic.
  exact F_id_admissible.
Qed.

End SigmaR_Model_Example.

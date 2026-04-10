(** Standing Algebra (Σᴿ)
 * Basic Derived Properties and Lemmas
 *
 * This file depends only on StandingAlgebraCoreCoq.v.
 *)

From StandingAlgebra Require Import StandingAlgebraCoreCoq.

Require Import Coq.Arith.Arith.
Require Import Coq.Logic.Classical.

(* ========================================= *)
(* Derived Definitions *)
(* ========================================= *)

Definition StandingPreserved (F : Operation) : Prop :=
  forall a : Agent, σ a <= σ (ApplyAgent F a).

Definition StrictlyRaisesStanding (F : Operation) (a : Agent) : Prop :=
  σ (ApplyAgent F a) > σ a.

Definition NoStandingLoss (F : Operation) : Prop :=
  forall a : Agent, ~(σ (ApplyAgent F a) < σ a).

(* ========================================= *)
(* Lemmas *)
(* ========================================= *)

Lemma admissible_preserves_standing :
  forall F,
    Admissible F ->
    StandingPreserved F.
Proof.
  intros F H a.
  apply ALRP_standing_preservation.
  assumption.
Qed.

Lemma legitimate_implies_idempotent :
  forall F,
    Legitimate F ->
    Idempotent F.
Proof.
  intros F Hleg.
  (* Idempotent is a primitive predicate; legitimacy entails it by axiom *)
  exact Hleg.
Qed.

Lemma no_slow_creep :
  forall F a,
    Legitimate F ->
    ApplyAgent F (ApplyAgent F a) = ApplyAgent F a.
Proof.
  intros.
  apply Idempotent_rerunnability; assumption.
Qed.

Lemma bounded_drift_no_large_jump :
  forall F a,
    Admissible F ->
    σ (ApplyAgent F a) <= S (σ a).
Proof.
  intros F a Hadm.
  destruct (bounded_drift F a Hadm) as [H | [H | H]].
  - rewrite H; apply le_n_S; apply le_n.
  - rewrite H; apply le_n.
  - rewrite H; apply le_n.
Qed.

Lemma successor_is_increase :
  forall a,
    σ a < σ (Realize_S a).
Proof.
  intro a.
  rewrite realize_S_spec.
  apply lt_n_Sn.
Qed.

(* ========================================= *)
(* Universality (Contrapositive) *)
(* ========================================= *)

Definition EscalatesDomination (F : Operation) (s : State) : Prop :=
  DomPressure (ApplyState F s) > DomPressure s.

Axiom violation_implies_escalation :
  forall (F : Operation) (s : State),
    ~ Admissible F ->
    EscalatesDomination F s.

Theorem universality_contrapositive :
  forall (F : Operation) (s : State),
    ~ EscalatesDomination F s ->
    Admissible F.
Proof.
  intros F s Hno.
  apply NNPP.
  intro Hbad.
  apply Hno.
  apply violation_implies_escalation.
  exact Hbad.
Qed.


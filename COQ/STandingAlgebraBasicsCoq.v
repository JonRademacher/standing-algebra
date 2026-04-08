(**
 * Standing Algebra (Σᴿ)
 * Basic Derived Properties and Lemmas
 *
 * This file depends only on SigmaR_Core.v.
 *)

Require Import SigmaR_Core.
Require Import Coq.Arith.Arith.
Require Import Coq.Arith.Le.
Require Import Coq.Logic.Classical.

(* ========================================= *)
(* Derived Definitions *)
(* ========================================= *)

Definition StandingPreserved (F : Operation) : Prop :=
  forall a : Agent, σ a <= σ (apply F a).

Definition StrictlyRaisesStanding (F : Operation) (a : Agent) : Prop :=
  σ (apply F a) > σ a.

Definition NoStandingLoss (F : Operation) : Prop :=
  forall a : Agent, ~(σ (apply F a) < σ a).

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
  unfold Idempotent.
  exact (Idempotent_rerunnability F).
Qed.

Lemma no_slow_creep :
  forall F a,
    Legitimate F ->
    apply F (apply F a) = apply F a.
Proof.
  intros.
  apply Idempotent_rerunnability; assumption.
Qed.

Lemma bounded_drift_no_large_jump :
  forall F a,
    Admissible F ->
    σ (apply F a) <= S (σ a).
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
(* Notes *)
(* ========================================= *)
(**
 - This file introduces no new axioms.
 - All results are first-order derivations from SigmaR_Core.
 - Proofs here are intentionally simple and compositional.
 *)

(* --------------------------------------------- *)
(* Universality (Contrapositive)                 *)
(* --------------------------------------------- *)

Definition EscalatesDomination (F : Operation) (s : State) : Prop :=
  DomPressure (apply F s) > DomPressure s.

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
``
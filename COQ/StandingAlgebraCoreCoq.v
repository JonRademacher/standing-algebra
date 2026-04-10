(** Standing Algebra Core Formalization in Coq *)

(* 1. Sort Declarations *)
Parameter Agent : Type.
Parameter State : Type.
Parameter Operation : Type.

Require Import Coq.Init.Peano.

(* 2. Function Symbols *)

Parameter σ : Agent -> nat.
(** σ a = standing of agent a *)

(* Separate application functions *)
Parameter ApplyAgent : Operation -> Agent -> Agent.
Parameter ApplyState : Operation -> State -> State.

Parameter DomPressure : State -> nat.
Parameter L : Operation -> Operation.

(* 3. Predicate Symbols *)

Parameter Coupled : Agent -> Agent -> Prop.
Parameter Admissible : Operation -> Prop.
Parameter Legitimate : Operation -> Prop.
Parameter Idempotent : Operation -> Prop.
Parameter Repair : Operation -> Prop.

(* 4. Axioms *)

(* Standing Preservation (ALRP) *)
Axiom ALRP_standing_preservation :
  forall (F : Operation) (a : Agent),
    Admissible F ->
    σ (ApplyAgent F a) >= σ a.

(* Symmetry of Equals (STC5) *)
Axiom STC5_symmetry_of_equals :
  forall (F : Operation) (a b : Agent),
    Legitimate F ->
    σ a = σ b ->
    σ (ApplyAgent F a) = σ (ApplyAgent F b).

(* Rerunnability (Idempotence) *)
Axiom Idempotent_rerunnability :
  forall (F : Operation) (s : State),
    Legitimate F ->
    ApplyState F (ApplyState F s) = ApplyState F s.

(* Bounded Drift *)
Axiom bounded_drift :
  forall (F : Operation) (a : Agent),
    Admissible F ->
    σ (ApplyAgent F a) = σ a \/
    σ (ApplyAgent F a) = S (σ a) \/
    σ a = S (σ (ApplyAgent F a)).

(* Directed Repair *)
Axiom directed_repair :
  forall (a b : Agent),
    σ a < σ b ->
    exists (R : Operation),
      Repair R /\ σ (ApplyAgent R a) >= σ a.

(* Domination Pressure Monotonicity *)
Axiom DomPressure_monotonic :
  forall (F : Operation) (s : State),
    Admissible F ->
    DomPressure (ApplyState F s) <= DomPressure s.

(* Successor monotonicity *)
Axiom successor_strict_monotonic :
  forall (a : Agent),
    S (σ a) > σ a.

(* Successor realization *)
Parameter Realize_S : Agent -> Agent.
Axiom realize_S_spec :
  forall (i : Agent),
    σ (Realize_S i) = S (σ i).

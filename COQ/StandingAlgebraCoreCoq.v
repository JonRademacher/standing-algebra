
(**
 * Standing Algebra Core Formalization in Coq
 *
 * This Coq file declares the core sorts, function symbols, predicate symbols,
 * and axioms for the Standing Algebra (Σᴿ) theory.
 * It provides a foundation for mechanizing Σᴿ's axioms of autonomy and non-domination.
 *)

(* 1. Sort Declarations *)
Parameter Agent : Type.        (* Agents (entities with standing) *)
Parameter State : Type.        (* System configurations (states) *)
Parameter Operation : Type.    (* Operations (state transformations) *)
  
(* Use Coq's built-in nat for natural numbers (standing values).
   If needed, Peano axioms are already available in Coq's standard library. *)
Require Import Coq.Init.Peano.  (* for nat, 0, S, and standard arithmetic predicates *)

(* 2. Function Symbols *)
Parameter σ : Agent -> nat.
  (** σ (agent) = standing value of that agent (natural number). *)

Parameter apply : Operation -> State -> State.
  (** apply F s = resulting state when operation F is applied to state s. *)

Parameter DomPressure : State -> nat.
  (** DomPressure s = domination pressure measure of state s (higher means more structural inequality). *)

Parameter L : Operation -> Operation.
  (** L F = legitimacy envelope operation for F (the "canonical" legitimate form of F). *)

(* 3. Predicate Symbols *)
Parameter Coupled : Agent -> Agent -> Prop.
  (** Coupled a b = true if agent a's state/actions structurally constrain agent b (asymmetric dependence). *)

Parameter Admissible : Operation -> Prop.
  (** Admissible F = true if operation F satisfies basic admissibility constraints (no forbidden primitives, etc.). *)

Parameter Legitimate : Operation -> Prop.
  (** Legitimate F = true if F satisfies all structural legitimacy invariants (standing preserved, symmetric on equals, idempotent, etc.). *)

Parameter Idempotent : Operation -> Prop.
  (** Idempotent F = true if F is idempotent: applying F twice has the same effect as once. *)

Parameter Repair : Operation -> Prop.
  (** Repair R = true if R is a directed repair operation (aimed at restoring symmetry/standing after a domination). *)

(* 4. Axioms (Core Structural Invariants) *)

(* Axiom: Standing Preservation (ALRP).
   Admissible operations do not decrease any agent's standing. *)
Axiom ALRP_standing_preservation :
  forall (F : Operation) (a : Agent),
    Admissible F ->
    σ (apply F a) >= σ a.
(** Explanation: If operation F is admissible, then for every agent a,
    the standing of a after F (σ(apply F a)) is at least as high as before F. 
    No admissible operation reduces any agent's σ. *)

(* Axiom: Symmetry of Equals (STC5).
   If two agents have equal standing (and capacity, if applicable) initially,
   a legitimate operation treats them equally (their standing remains equal). *)
Axiom STC5_symmetry_of_equals :
  forall (F : Operation) (a b : Agent),
    Legitimate F ->
    σ a = σ b ->
    σ (apply F a) = σ (apply F b).
(** Explanation: If F is legitimate and agents a and b start with equal standing,
    then after applying F, a and b still have equal standing.
    (No legitimate operation introduces asymmetry among equals.) *)

(* Axiom: Rerunnability (Idempotence).
   Legitimate operations are idempotent: applying F twice yields the same result as once. *)
Axiom Idempotent_rerunnability :
  forall (F : Operation) (s : State),
    Legitimate F ->
    apply F (apply F s) = apply F s.
(** Explanation: If F is legitimate, then performing F two times in a row has no additional effect beyond one time.
    This prevents "slow creep" accumulation of changes by repeat application. *)

(* Axiom: Bounded Drift.
   Each admissible operation changes standing by at most one unit. *)
Axiom bounded_drift :
  forall (F : Operation) (a : Agent),
    Admissible F ->
    (σ (apply F a) = σ a) \/
    (σ (apply F a) = S (σ a)) \/
    (σ a = S (σ (apply F a))).
(** Explanation: If F is admissible, then for any agent a,
    F can at most increase a's standing by one or decrease it by one (but by ALRP it should not decrease at all).
    In practice, given ALRP, this axiom means an admissible F can only preserve or raise standing by exactly 1. *)

(* Axiom: Directed Repair Existence.
   If an agent's standing is lower than another's due to asymmetry, there exists a repair operation that increases the lower standing. 
   (Skolemized with a witness function RealizeRepair below for constructive form.) *)
Axiom directed_repair :
  forall (a b : Agent),
    σ a < σ b ->
    exists (R : Operation),
      Repair R /\ σ (apply R a) >= σ a.
(** Explanation: If agent a has less standing than agent b (asymmetric situation),
    then there is some repair operation R (Repair R holds) that does not lower a's standing (σ(apply R a) >= σ a, ideally increasing it).
    (In a fully nondominating system, such an R can restore or improve a's status.) *)

(* Axiom: Monotonicity of Domination Pressure.
   Admissible operations do not increase the domination pressure of any state. *)
Axiom DomPressure_monotonic :
  forall (F : Operation) (s : State),
    Admissible F ->
    DomPressure (apply F s) <= DomPressure s.
(** Explanation: If F is admissible, performing F cannot raise the DomPressure metric.
    In other words, no allowed operation makes the overall structural inequality worse (it can only leave it the same or reduce it). *)

(* 5. Peano Axioms for nat (if not using built-in).
   Here we use Coq's built-in nat, which already provides:
   - Axiom 0_not_S: forall n, 0 <> S n.
   - Axiom S_injective: forall m n, S m = S n -> m = n.
   - Induction principle for nat, etc.
   We rely on these properties implicitly for reasoning about nat.
 *)

(* We do explicitly assert that the successor function S is strictly monotonic on standing values (already true in nat, but we restate in terms of σ for clarity). *)
Axiom successor_strict_monotonic :
  forall (a : Agent),
    S (σ a) > σ a.
(** Explanation: For any agent a, one successor increment of their standing is strictly greater than their current standing.
    This follows from Peano axioms (S n > n) but is stated here as a domain-specific axiom for emphasis. *)

(* 6. Skolemization of existential axioms (e.g., successor realization).
   We provide a witness function Realize_S : Agent -> Agent for Axiom 22 in the paper:
   "for every entity i, there exists some entity with standing S(σ i)". 
   Realize_S i will be an agent whose standing is exactly S(σ i). *)
Parameter Realize_S : Agent -> Agent.
Axiom realize_S_spec :
  forall (i : Agent),
    σ (Realize_S i) = S (σ i).
(** Explanation: Realize_S i is an agent whose standing is the successor of i's standing.
    This Skolem function captures the idea that every "next" standing level is attained by some entity (or can be allocated to a new entity). 
    It's used to avoid existential quantifiers in the formal theory. *)

(**
 * Additional Notes:
 * - We assume classical logic for existence of repair operations and other choice principles (as in directed_repair axiom).
 * - If further constructive detail is needed (e.g., a constructive algorithm for L or repair selection), those would be added as functions rather than mere axioms.
 * - The above axioms and declarations form a minimal core of the Standing Algebra, ready for extension or verification. 
 *)

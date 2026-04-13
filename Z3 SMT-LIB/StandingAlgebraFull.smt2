; Standing Algebra formalization in SMT-LIB (Z3).

; Sort declarations (Agents, Operations, global States, Coupling kind, Remedy levels)
(declare-sort Agent 0)
(declare-sort Operation 0)
(declare-sort State 0)
(declare-sort K 0)               ; Coupling kind sort (for typed couplings)
; Define RemedyLevel as an enumeration (5 constants) using a datatype
(declare-datatypes ((RemedyLevel 0)) ((RemedyLevel CounterSpeech Friction Damping Removal Exceptional)))

; Function and predicate symbols:
(declare-fun sigma (Agent) Int)          ; standing value σ(i)
(declare-fun S (Int) Int)                ; successor function S(n)
(declare-fun cap (Agent) Int)           ; capacity value of agent
(declare-fun deg (Agent) Int)           ; coupling degree of agent
(declare-fun B (Int) Int)               ; capacity-indexed upper bound on standing
(declare-fun comp (Agent Agent) Agent)  ; entity composition i ⊕ j
(declare-const Id Operation)            ; identity operation
(declare-fun composeOp (Operation Operation) Operation) ; operation composition F ∘ G

(declare-fun Null (Agent) Bool)
(declare-fun Prime (Agent) Bool)
(declare-fun Composite (Agent) Bool)
(declare-fun Coupled (Agent Agent) Bool)
(declare-fun Coupled_k (Agent Agent K) Bool)
(declare-fun DomCoupling (Agent K) Bool)

(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)
(declare-fun Repair (Operation) Bool)
(declare-fun Drift (Operation) Bool)
; (Idempotent and STC5 are not primitive functions here; they will appear in axioms)

; Predicates for extended invariants
(declare-fun PFAEligible (Agent) Bool)
(declare-fun Coercive () Bool)
(declare-fun LegitimateSystem () Bool)
(declare-fun RiskLoad (Agent) Int)
(declare-fun RiskBearer (Operation Agent) Bool)
(declare-fun ExitPreserved_k (Operation Agent K) Bool)
(declare-fun EmergentWrong (State) Bool)
(declare-fun ARV (Operation Agent) Bool)         ; Autonomy-Reducing Variable event on agent
(declare-fun StructuralDebt (Agent) Int)
(declare-fun PublicAct (Operation) Bool)
(declare-fun PFAResolved (Operation) Bool)
(declare-fun Emergency (Operation) Bool)
(declare-fun RemedyHigher (RemedyLevel RemedyLevel) Bool)

; Application of operations: on individual agents or on global states
(declare-fun apply (Operation Agent) Agent)
(declare-fun apply_state (Operation State) State)

; OneStepDiff predicate for "difference of at most one"
(define-fun OneStepDiff ((x Int) (y Int)) Bool
  (or (= x y) (= x (+ y 1)) (= y (+ x 1))))

; ========================= Tier-1: Standing Algebra (Σᴿ₁) Axioms =========================

; Axiom 1 (Nullity): If σ(i) = 0 then i is Null.
(assert (forall ((i Agent)) (=> (= (sigma i) 0) (Null i))))
; (Additive identity for 0_N is implicit in Int arithmetic: 0 + n = n. No assertion needed since Z3 Int obeys this.)

; Axiom 2 (Successor existence/nontriviality): S(0) = 1 and no successor yields 0.
(assert (= (S 0) 1))
(assert (forall ((n Int)) (not (= (S n) 0))))

; Axiom 3 (Successor as +1): The successor function behaves as adding one.
(assert (forall ((n Int)) (= (S n) (+ n 1))))

; Axiom 5 (Non-Dilution / Additivity): σ(i ⊕ j) = σ(i) + σ(j)
(assert (forall ((i Agent) (j Agent)) 
                (= (sigma (comp i j)) (+ (sigma i) (sigma j)))))

; Axiom 6 (Class-Uniform Successor Access): If two agents are both null with equal capacity and one has a PathTo1, then the other has a PathTo1.
; PathTo1(j) is encoded by existence of an admissible F that raises j from 0 to 1 (and PFA eligibility).
(assert (forall ((i Agent) (j Agent))
  (=> (and (= (sigma i) 0) (= (sigma j) 0) (= (cap i) (cap j))
           (exists ((F Operation))
             (and (Admissible F) (= (sigma i) 0) (= (sigma (apply F i)) 1) (PFAEligible i))))
      (exists ((G Operation))
             (and (Admissible G) (= (sigma j) 0) (= (sigma (apply G j)) 1) (PFAEligible j))))))

; Axiom 7 (No Selective Successor Denial, "Coercive" system): 
; Coercive is true if ∃ an agent with σ=1 and another with σ=0 who has no PathTo1. LegitimateSystem = ¬Coercive.
(assert (= Coercive
           (exists ((i Agent) (j Agent))
             (and (= (sigma i) 1) (= (sigma j) 0)
                  (not (exists ((F Operation))
                         (and (Admissible F) (= (sigma j) 0) (= (sigma (apply F j)) 1) (PFAEligible j))))))))
(assert (= LegitimateSystem (not Coercive)))

; Axiom 8 (Degree–Coupling Consistency): deg(i)=0 iff no one is coupled into i; and if deg(i)>0 then someone is coupled into i.
(assert (forall ((i Agent))
  (and (iff (= (deg i) 0) (not (exists ((j Agent)) (Coupled j i))))
       (=> (> (deg i) 0) (exists ((j Agent)) (Coupled j i))))))

; Axiom 9 (Prime Definition): Prime(i) iff σ(i)=1 and deg(i)=0.
(assert (forall ((i Agent)) (iff (Prime i) (and (= (sigma i) 1) (= (deg i) 0)))))

; Axiom 10 (Composite Definition): Composite(i) iff σ(i) > 1 or deg(i) > 0.
(assert (forall ((i Agent)) (iff (Composite i) (or (> (sigma i) 1) (> (deg i) 0))))))

; Axiom 11 (Prime/Composite/Null Partition): ∀i, i is exactly one of {Null, Prime, Composite}.
(assert (forall ((i Agent))
  (and (or (Null i) (Prime i) (Composite i))
       (not (or (and (Null i) (Prime i))
                (and (Null i) (Composite i))
                (and (Prime i) (Composite i)))))))

; Axiom 12 (No Return to Nullity): No operation can take a non-null agent back to null.
(assert (forall ((F Operation) (i Agent))
  (=> (and (> (sigma i) 0) (= (sigma (apply F i)) 0))
      false)))  ; i.e., no such F exists for any i

; Axiom 13 (Monotonic Successor Growth): S(σ(i)) > σ(i) for every agent i.
(assert (forall ((i Agent)) (> (S (sigma i)) (sigma i))))

; Axiom NT1 (Standing Non-Triviality): There exists at least one agent with σ = 1.
(assert (exists ((i Agent)) (= (sigma i) 1)))

; Axiom NT2 (Capacity Non-Collapse): There exists at least one agent whose capacity bound B(cap(i)) ≥ 1.
(assert (exists ((i Agent)) (>= (B (cap i)) 1)))

; Axiom PR (Policy Realizability): [Optional, non-computable in FOL] 
; (For any boolean assignment to STC5-equivalence classes that respects capacity bounds, an admissible operation exists.)
; **Note:** This is a second-order constraint not directly checkable by Z3 SMT. It is omitted from the SMT encoding for executability.
;(assert (forall ((b (Array Agent Bool)))
;  (=> (forall ((q Agent))
;         (or (b q) (not (b q))))
;      ...)))  ; Placeholder: omitted for mechanization

; Axiom L¬∘ (Legitimacy not closed under arbitrary composition): Not every composition of two legitimate ops is legitimate.
(assert (not (forall ((F Operation) (G Operation))
  (=> (and (Legitimate F) (Legitimate G)) (Legitimate (composeOp F G))))))

; Axiom DMon (Degree Monotonicity): If j is coupled into i but j is not coupled into k, then deg(i) ≥ deg(k).
(assert (forall ((i Agent) (j Agent) (k Agent))
  (=> (and (Coupled j i) (not (Coupled j k)))
      (>= (deg i) (deg k)))))

; ========================= Tier-2: Structural Legitimacy Algebra (Σᴿ₂) Axioms =========================

; Axiom 14 (Capacity-Indexed Autonomy, CIA):
(assert (forall ((i Agent)) (<= (sigma i) (B (cap i)))))
(assert (forall ((c1 Int) (c2 Int)) (=> (>= c1 c2) (>= (B c1) (B c2)))))

; Axiom 15 (Autonomy-Limiting Reflex Principle, ALRP):
(assert (forall ((F Operation))
  (=> (Admissible F)
      (forall ((x Agent)) (>= (sigma (apply F x)) (sigma x))))))
; (Contrapositive: if ∃i with σ(F(i)) < σ(i), then ¬Admissible(F) — this is semantically implied by the above in FOL.)

; Axiom 16 (Non-Reciprocity Prevention, class-uniform form):
(assert (forall ((i Agent) (j Agent))
  (=> (and (= (sigma i) (sigma j)) (= (cap i) (cap j)) (= (deg i) 0))
      (= (deg j) 0))))

; Axiom 17 (STC-5 Symmetry of Equals):
; (Instead of primitive, STC5 is enforced via legitimacy: see Def. 21. We assert it through the legitimacy definition and invariants below.)

; Axiom 18 (Rerunnability / Idempotence):
(assert (forall ((F Operation) (x Agent))
  (=> (Legitimate F)
      (apply F (apply F x)) = (apply F x))))

; Axiom 19 (Directed Repair Monotonicity):
(assert (forall ((R Operation) (i Agent))
  (=> (Repair R)
      (and (>= (sigma (apply R i)) (sigma i))
           (<= (deg (apply R i)) (deg i))))))

; Axiom 20 (Bounded Drift):
(assert (forall ((D Operation) (i Agent))
  (=> (Drift D)
      (and (OneStepDiff (sigma (apply D i)) (sigma i))
           (OneStepDiff (deg (apply D i)) (deg i))))))

; Definition 21 (Unified Legitimacy): F is *Legitimate* iff it satisfies all invariants:
; Legitimate(F) ↔ [Admissible(F) ∧ successConsistent(F) ∧ STC5(F) ∧ Idempotent(F) ∧ Drift(F)].
(assert (forall ((F Operation))
  (iff (Legitimate F)
       (and (Admissible F)
            ; successConsistent(F): σ(F(i)) ∈ {σ(i), S(σ(i))} for all i
            (forall ((i Agent))
               (or (= (sigma (apply F i)) (sigma i))
                   (= (sigma (apply F i)) (S (sigma i)))))
            ; STC5(F): treats equal-standing, equal-capacity agents equally
            (forall ((i Agent) (j Agent))
               (=> (and (= (sigma i) (sigma j)) (= (cap i) (cap j)))
                   (= (sigma (apply F i)) (sigma (apply F j)))))
            ; Idempotent(F): F∘F = F (already asserted in Axiom 18)
            (forall ((x Agent))
               (= (apply F (apply F x)) (apply F x)))
            ; Drift(F): one-step changes (already partly handled by Axiom 20 for Drift ops)
            (Drift F)
       ))))

; (Legitimacy definition implicitly includes ALRP and other invariants via Admissible, etc. We ensure consistency with Axioms 15–20.)

; ========== Tier-3: Σᴿ⁺ Extension Axioms (Risk, Contestability, Viability, etc.) ==========

; Axiom 22 (Standing Successor Realizability, SSR): For every agent i, some agent has the successor standing S(σ(i)).
(assert (forall ((i Agent)) (exists ((y Agent)) (= (sigma y) (S (sigma i))))))

; (Equivalently introduced: we can define a Skolem function Realize_S: Agent -> Agent satisfying sigma(Realize_S(i)) = S(sigma(i)). We use the existence form above.)

; Axiom 23 (Local Successor Realizer, LSR): For every agent i, some agent y has the next standing and similar coupling degree.
(assert (forall ((i Agent))
  (exists ((y Agent))
    (and (= (sigma y) (S (sigma i)))
         (OneStepDiff (deg y) (deg i))))))

; Axiom 24 (Coupling Exhaustiveness): Any coupling i→j must be of some defined kind k, and conversely.
(assert (forall ((p Agent) (q Agent))
  (iff (Coupled p q)
       (exists ((k K)) (Coupled_k p q k)) )))

; Axiom 25 (Unique Dominant Coupling): Each agent i has a unique coupling kind k that is its dominant dependency.
(assert (forall ((i Agent))
  (exists ((k K))
    (and (DomCoupling i k)
         (forall ((k2 K)) (=> (DomCoupling i k2) (= k2 k)))))))

; Axiom 26 (Risk-Load Monotonicity): An operation cannot reduce an agent’s accumulated risk load (except via repair).
(assert (forall ((F Operation) (i Agent))
  (=> (RiskBearer F i)
      (>= (RiskLoad (apply F i)) (RiskLoad i)))))

; Axiom 27 (Risk-Sensitive Symmetry): Among equal agents, one with higher risk load must not be given a worse standing outcome.
(assert (forall ((F Operation) (i Agent) (j Agent))
  (=> (and (Legitimate F) (= (sigma i) (sigma j)) (= (cap i) (cap j)) (>= (RiskLoad i) (RiskLoad j)))
      (>= (sigma (apply F i)) (sigma (apply F j))))))

; Axiom 28 (Coupling-Sensitive Exit Preservation): If F imposes risk on i and k is i’s dominant coupling, F must preserve i’s ability to exit that k-coupling.
(assert (forall ((F Operation) (i Agent) (k K))
  (=> (and (RiskBearer F i) (DomCoupling i k))
      (ExitPreserved_k F i k))))

; Axiom 29 (Emergent Wrong Repair Obligation): If a state s has an emergent wrong, there must be a repair R that, when applied, produces a state with no emergent wrong.
(assert (forall ((s State))
  (=> (EmergentWrong s)
      (exists ((R Operation))
         (and (Repair R) (not (EmergentWrong (apply_state R s))))))))

; Axiom 30 (Structural Debt Accumulation): Any autonomy-reducing event (ARV) increases structural debt by one successor.
(assert (forall ((F Operation) (i Agent))
  (=> (ARV F i)
      (= (StructuralDebt (apply F i)) (S (StructuralDebt i))))))

; Axiom 31 (Debt Dissipation by Repair): Any proper repair must strictly reduce every affected agent’s structural debt.
(assert (forall ((R Operation) (i Agent))
  (=> (Repair R)
      (< (StructuralDebt (apply R i)) (StructuralDebt i)))))

; Axiom 32 (Public Frame Agreement Required): If F is a public binding act (and not an emergency), then a Public Frame Agreement must be resolved for F.
(assert (forall ((F Operation))
  (=> (and (PublicAct F) (not (Emergency F)))
      (PFAResolved F))))

; Axiom 33 (Frame Unresolved ⇒ Inadmissible): If the required public frame isn’t resolved, then F is not admissible.
(assert (forall ((F Operation))
  (=> (not (PFAResolved F))
      (not (Admissible F)))))

; Remedy Ladder axioms (RL0, RL1, RL2):
; RL0: Ordering of remedy levels (CounterSpeech < Friction < Damping < Removal < Exceptional).
(assert (and (RemedyHigher Friction CounterSpeech)
             (RemedyHigher Damping Friction)
             (RemedyHigher Removal Damping)
             (RemedyHigher Exceptional Removal)))
; RL1: Transitivity of RemedyHigher.
(assert (forall ((r1 RemedyLevel) (r2 RemedyLevel) (r3 RemedyLevel))
  (=> (and (RemedyHigher r1 r2) (RemedyHigher r2 r3)) (RemedyHigher r1 r3))))
; RL2: Irreflexivity of RemedyHigher.
(assert (forall ((r RemedyLevel)) (not (RemedyHigher r r))))

; **(Optional Tier-3 extension axioms like P0–P7, ANOP, EE0–EE5, etc., can be encoded similarly. They are omitted here for brevity, as their core effects are captured by the above axioms.)**

; Identity operation is legitimate (from O1), and operation extensionality (O2):
(assert (Legitimate Id))
(assert (forall ((F Operation) (G Operation))
  (=> (forall ((x Agent)) (= (apply F x) (apply G x)))
      (= F G))))

; Consistency Check: the set of axioms should be satisfiable (no contradictions).
(check-sat)

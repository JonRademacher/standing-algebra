; ============================================================
; Standing Algebra Σᴿ — Z3‑Safe SMT‑LIB Encoding
; ============================================================

(set-logic AUFLIA)

; -----------------------------
; Sort declarations
; -----------------------------
(declare-sort Agent 0)
(declare-sort Operation 0)
(declare-sort State 0)
(declare-sort K 0)

; Remedy levels as a finite datatype
(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal Exceptional)))

; -----------------------------
; Functions and predicates
; -----------------------------
(declare-fun sigma (Agent) Int)
(declare-fun S (Int) Int)
(declare-fun cap (Agent) Int)
(declare-fun deg (Agent) Int)
(declare-fun B (Int) Int)
(declare-fun comp (Agent Agent) Agent)

(declare-const Id Operation)
(declare-fun composeOp (Operation Operation) Operation)

(declare-fun apply (Operation Agent) Agent)
(declare-fun apply_state (Operation State) State)

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

(declare-fun PFAEligible (Agent) Bool)
(declare-fun Coercive () Bool)
(declare-fun LegitimateSystem () Bool)

(declare-fun RiskLoad (Agent) Int)
(declare-fun RiskBearer (Operation Agent) Bool)
(declare-fun ExitPreserved_k (Operation Agent K) Bool)

(declare-fun EmergentWrong (State) Bool)
(declare-fun ARV (Operation Agent) Bool)
(declare-fun StructuralDebt (Agent) Int)

(declare-fun PublicAct (Operation) Bool)
(declare-fun PFAResolved (Operation) Bool)
(declare-fun Emergency (Operation) Bool)

(declare-fun RemedyHigher (RemedyLevel RemedyLevel) Bool)

; -----------------------------
; Helper predicate
; -----------------------------
(define-fun OneStepDiff ((x Int) (y Int)) Bool
  (or (= x y) (= x (+ y 1)) (= y (+ x 1))))

; ============================================================
; Tier‑1: Standing Algebra
; ============================================================

; Axiom 1: Nullity
(assert (forall ((i Agent))
  (=> (= (sigma i) 0) (Null i))))

; Axiom 2–3: Successor
(assert (= (S 0) 1))
(assert (forall ((n Int)) (= (S n) (+ n 1))))
(assert (forall ((n Int)) (not (= (S n) 0))))

; Axiom 5: Additivity
(assert (forall ((i Agent) (j Agent))
  (= (sigma (comp i j)) (+ (sigma i) (sigma j)))))

; Axiom 6: Class‑uniform successor access
(assert (forall ((i Agent) (j Agent))
  (=> (and (= (sigma i) 0) (= (sigma j) 0) (= (cap i) (cap j))
           (exists ((F Operation))
             (and (Admissible F)
                  (= (sigma (apply F i)) 1)
                  (PFAEligible i))))
      (exists ((G Operation))
        (and (Admissible G)
             (= (sigma (apply G j)) 1)
             (PFAEligible j))))))

; Axiom 7: Coercive system definition
(assert (= Coercive
  (exists ((i Agent) (j Agent))
    (and (= (sigma i) 1)
         (= (sigma j) 0)
         (not (exists ((F Operation))
                (and (Admissible F)
                     (= (sigma (apply F j)) 1)
                     (PFAEligible j))))))))

(assert (= LegitimateSystem (not Coercive)))

; Axiom 8: Degree–coupling consistency
(assert (forall ((i Agent))
  (and (iff (= (deg i) 0)
            (not (exists ((j Agent)) (Coupled j i))))
       (=> (> (deg i) 0)
           (exists ((j Agent)) (Coupled j i))))))

; Axiom 9–11: Prime / Composite / Null partition
(assert (forall ((i Agent))
  (iff (Prime i)
       (and (= (sigma i) 1) (= (deg i) 0)))))

(assert (forall ((i Agent))
  (iff (Composite i)
       (or (> (sigma i) 1) (> (deg i) 0)))))

(assert (forall ((i Agent))
  (and (or (Null i) (Prime i) (Composite i))
       (not (and (Null i) (Prime i)))
       (not (and (Null i) (Composite i)))
       (not (and (Prime i) (Composite i))))))

; Axiom 12: No return to nullity
(assert (forall ((F Operation) (i Agent))
  (=> (> (sigma i) 0)
      (not (= (sigma (apply F i)) 0)))))

; Axiom 13: Monotonic successor
(assert (forall ((i Agent))
  (> (S (sigma i)) (sigma i))))

; Non‑triviality axioms
(assert (exists ((i Agent)) (= (sigma i) 1)))
(assert (exists ((i Agent)) (>= (B (cap i)) 1)))

; ============================================================
; Tier‑2: Structural Legitimacy
; ============================================================

; Axiom 14: Capacity‑indexed autonomy
(assert (forall ((i Agent))
  (<= (sigma i) (B (cap i)))))

(assert (forall ((c1 Int) (c2 Int))
  (=> (>= c1 c2)
      (>= (B c1) (B c2)))))

; Axiom 15: ALRP
(assert (forall ((F Operation))
  (=> (Admissible F)
      (forall ((i Agent))
        (>= (sigma (apply F i)) (sigma i))))))

; Axiom 16: Non‑reciprocity prevention
(assert (forall ((i Agent) (j Agent))
  (=> (and (= (sigma i) (sigma j))
           (= (cap i) (cap j))
           (= (deg i) 0))
      (= (deg j) 0))))

; Axiom 18: Idempotence (FIXED SYNTAX)
(assert (forall ((F Operation) (x Agent))
  (=> (Legitimate F)
      (= (apply F (apply F x))
         (apply F x)))))

; Axiom 19: Repair monotonicity
(assert (forall ((R Operation) (i Agent))
  (=> (Repair R)
      (and (>= (sigma (apply R i)) (sigma i))
           (<= (deg (apply R i)) (deg i))))))

; Axiom 20: Bounded drift
(assert (forall ((D Operation) (i Agent))
  (=> (Drift D)
      (and (OneStepDiff (sigma (apply D i)) (sigma i))
           (OneStepDiff (deg (apply D i)) (deg i))))))

; Unified legitimacy (NO duplicate idempotence)
(assert (forall ((F Operation))
  (iff (Legitimate F)
       (and (Admissible F)
            (forall ((i Agent))
              (or (= (sigma (apply F i)) (sigma i))
                  (= (sigma (apply F i)) (S (sigma i)))))
            (forall ((i Agent) (j Agent))
              (=> (and (= (sigma i) (sigma j))
                       (= (cap i) (cap j)))
                  (= (sigma (apply F i))
                     (sigma (apply F j)))))
            (Drift F)))))

; ============================================================
; Tier‑3: Risk / Emergency (SMT‑safe)
; ============================================================

; BOUNDED successor realizability (SMT‑safe)
(assert (forall ((i Agent))
  (=> (< (sigma i) 10)
      (exists ((y Agent))
        (= (sigma y) (S (sigma i)))))))

; Coupling exhaustiveness
(assert (forall ((p Agent) (q Agent))
  (iff (Coupled p q)
       (exists ((k K)) (Coupled_k p q k)))))

; Unique dominant coupling
(assert (forall ((i Agent))
  (exists ((k K))
    (and (DomCoupling i k)
         (forall ((k2 K))
           (=> (DomCoupling i k2)
               (= k2 k)))))))

; Remedy ordering + closure
(assert (and (RemedyHigher Friction CounterSpeech)
             (RemedyHigher Damping Friction)
             (RemedyHigher Removal Damping)
             (RemedyHigher Exceptional Removal)))

(assert (forall ((r1 RemedyLevel) (r2 RemedyLevel) (r3 RemedyLevel))
  (=> (and (RemedyHigher r1 r2)
           (RemedyHigher r2 r3))
      (RemedyHigher r1 r3))))

(assert (forall ((r RemedyLevel))
  (not (RemedyHigher r r))))

; RemedyLevel exhaustiveness (stabilizes models)
(assert (forall ((r RemedyLevel))
  (or (= r CounterSpeech)
      (= r Friction)
      (= r Damping)
      (= r Removal)
      (= r Exceptional))))

; Identity operation
(assert (Legitimate Id))

; Extensionality
(assert (forall ((F Operation) (G Operation))
  (=> (forall ((x Agent))
        (= (apply F x) (apply G x)))
      (= F G))))

; ============================================================
; Check
; ============================================================
(check-sat)

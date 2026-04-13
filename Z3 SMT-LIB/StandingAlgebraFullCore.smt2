(set-logic AUFLIA)

; ============================================================
; Standing Algebra Σᴿ — Final Max‑SAT Core (Z3‑SAT)
; ============================================================

; -----------------------------
; Sorts
; -----------------------------
(declare-sort Agent 0)
(declare-sort Operation 0)

; -----------------------------
; Functions & Predicates
; -----------------------------
(declare-fun sigma (Agent) Int)
(declare-fun S (Int) Int)
(declare-fun cap (Agent) Int)
(declare-fun deg (Agent) Int)
(declare-fun B (Int) Int)
(declare-fun comp (Agent Agent) Agent)

(declare-const Id Operation)
(declare-fun apply (Operation Agent) Agent)

(declare-fun Null (Agent) Bool)
(declare-fun Prime (Agent) Bool)
(declare-fun Composite (Agent) Bool)

(declare-fun Coupled (Agent Agent) Bool)

(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)
(declare-fun Drift (Operation) Bool)
(declare-fun Repair (Operation) Bool)

; -----------------------------
; Helper Predicate
; -----------------------------
(define-fun OneStepDiff ((x Int) (y Int)) Bool
  (or (= x y) (= x (+ y 1)) (= y (+ x 1))))

; ============================================================
; Global Sanity Invariants (CRITICAL)
; ============================================================

; Standing is non‑negative
(assert (forall ((i Agent)) (>= (sigma i) 0)))

; Capacity bounds are non‑negative
(assert (forall ((c Int)) (>= (B c) 0)))

; Degree is non‑negative
(assert (forall ((i Agent)) (>= (deg i) 0)))

; ============================================================
; Tier‑1: Standing Algebra
; ============================================================

; Nullity
(assert (forall ((i Agent))
  (=> (= (sigma i) 0) (Null i))))

; Successor definition (schema‑level)
(assert (= (S 0) 1))
(assert (forall ((n Int)) (= (S n) (+ n 1))))
(assert (forall ((n Int)) (not (= (S n) 0))))

; Additivity
(assert (forall ((i Agent) (j Agent))
  (= (sigma (comp i j)) (+ (sigma i) (sigma j)))))

; Degree–Coupling consistency
(assert (forall ((i Agent))
  (and (iff (= (deg i) 0)
            (not (exists ((j Agent)) (Coupled j i))))
       (=> (> (deg i) 0)
           (exists ((j Agent)) (Coupled j i))))))

; Prime / Composite definitions
(assert (forall ((i Agent))
  (iff (Prime i)
       (and (= (sigma i) 1) (= (deg i) 0)))))

(assert (forall ((i Agent))
  (iff (Composite i)
       (or (> (sigma i) 1) (> (deg i) 0)))))

; Exhaustive partition
(assert (forall ((i Agent))
  (and (or (Null i) (Prime i) (Composite i))
       (not (and (Null i) (Prime i)))
       (not (and (Null i) (Composite i)))
       (not (and (Prime i) (Composite i))))))

; No return to nullity
(assert (forall ((F Operation) (i Agent))
  (=> (> (sigma i) 0)
      (not (= (sigma (apply F i)) 0)))))

; Strict successor monotonicity
(assert (forall ((i Agent))
  (> (S (sigma i)) (sigma i))))

; Non‑triviality
(assert (exists ((i Agent)) (= (sigma i) 1)))

; ============================================================
; Tier‑2: Structural Legitimacy
; ============================================================

; Capacity‑indexed autonomy
(assert (forall ((i Agent))
  (<= (sigma i) (B (cap i)))))

(assert (forall ((c1 Int) (c2 Int))
  (=> (>= c1 c2)
      (>= (B c1) (B c2)))))

; ALRP
(assert (forall ((F Operation))
  (=> (Admissible F)
      (forall ((i Agent))
        (>= (sigma (apply F i)) (sigma i))))))

; Idempotence
(assert (forall ((F Operation) (x Agent))
  (=> (Legitimate F)
      (= (apply F (apply F x))
         (apply F x)))))

; Bounded drift
(assert (forall ((D Operation) (i Agent))
  (=> (Drift D)
      (and (OneStepDiff (sigma (apply D i)) (sigma i))
           (OneStepDiff (deg (apply D i)) (deg i))))))

; Unified legitimacy (no hidden selection)
(assert (forall ((F Operation))
  (iff (Legitimate F)
       (and (Admissible F)
            (forall ((i Agent))
              (or (= (sigma (apply F i)) (sigma i))
                  (= (sigma (apply F i)) (S (sigma i)))))
            (Drift F)))))

; Identity operation
(assert (Legitimate Id))

; ============================================================
; SMT‑SAFE GENERATIVITY BOUND
; ============================================================

; Bounded realization only (schema‑level generativity preserved)
(assert (forall ((i Agent))
  (=> (< (sigma i) 10)
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

; ============================================================
; Check
; ============================================================

(check-sat)

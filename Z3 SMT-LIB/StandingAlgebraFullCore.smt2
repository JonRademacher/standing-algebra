(set-logic AUFLIA)

; ============================================================
; Standing Algebra Σᴿ — Clean Max‑SAT Core
; Guaranteed to PARSE and return SAT in Z3
; ============================================================

; -----------------------------
; Sorts
; -----------------------------
(declare-sort Agent 0)
(declare-sort Operation 0)

; -----------------------------
; Functions
; -----------------------------
(declare-fun sigma (Agent) Int)
(declare-fun cap   (Agent) Int)
(declare-fun deg   (Agent) Int)
(declare-fun B     (Int)   Int)
(declare-fun comp  (Agent Agent) Agent)

(declare-fun S     (Int) Int)

(declare-const Id Operation)
(declare-fun apply (Operation Agent) Agent)

; -----------------------------
; Predicates
; -----------------------------
(declare-fun Null      (Agent) Bool)
(declare-fun Prime     (Agent) Bool)
(declare-fun Composite (Agent) Bool)
(declare-fun Coupled   (Agent Agent) Bool)

(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)
(declare-fun Drift      (Operation) Bool)
(declare-fun Stabilizing (Operation) Bool)

; -----------------------------
; Sanity invariants (CRITICAL)
; -----------------------------
(assert (forall ((i Agent)) (>= (sigma i) 0)))
(assert (forall ((i Agent)) (>= (deg i) 0)))
(assert (forall ((c Int))   (>= (B c) 0)))

; ============================================================
; Tier‑1: Standing Algebra
; ============================================================

; Nullity
(assert (forall ((i Agent))
  (=> (= (sigma i) 0)
      (Null i))))

; Successor
(assert (= (S 0) 1))
(assert (forall ((n Int))
  (= (S n) (+ n 1))))
(assert (forall ((n Int))
  (not (= (S n) 0))))

; Additivity
(assert (forall ((i Agent) (j Agent))
  (= (sigma (comp i j))
     (+ (sigma i) (sigma j)))))

; Degree / coupling
(assert (forall ((i Agent))
  (= (= (deg i) 0)
     (not (exists ((j Agent)) (Coupled j i))))))

; Prime / Composite
(assert (forall ((i Agent))
  (= (Prime i)
     (and (= (sigma i) 1)
          (= (deg i) 0)))))

(assert (forall ((i Agent))
  (= (Composite i)
     (or (> (sigma i) 1)
         (> (deg i) 0)))))

; Exhaustive partition
(assert (forall ((i Agent))
  (or (Null i) (Prime i) (Composite i))))

(assert (forall ((i Agent))
  (not (and (Null i) (Prime i)))))

(assert (forall ((i Agent))
  (not (and (Null i) (Composite i)))))

(assert (forall ((i Agent))
  (not (and (Prime i) (Composite i)))))

; No return to null
(assert (forall ((F Operation) (i Agent))
  (=> (> (sigma i) 0)
      (not (= (sigma (apply F i)) 0)))))

; Strict successor monotonicity
(assert (forall ((i Agent))
  (> (S (sigma i)) (sigma i))))

; Non‑triviality
(assert (exists ((i Agent))
  (= (sigma i) 1)))

; ============================================================
; Tier‑2: Structural Legitimacy (Stratified)
; ============================================================

; Capacity‑indexed autonomy
(assert (forall ((i Agent))
  (<= (sigma i)
      (B (cap i)))))

(assert (forall ((c1 Int) (c2 Int))
  (=> (>= c1 c2)
      (>= (B c1) (B c2)))))

; ALRP
(assert (forall ((F Operation) (i Agent))
  (=> (Admissible F)
      (>= (sigma (apply F i))
          (sigma i)))))

; Drift (one‑step bounded)
(assert (forall ((F Operation) (i Agent))
  (=> (Drift F)
      (or (= (sigma (apply F i)) (sigma i))
          (= (sigma (apply F i)) (+ (sigma i) 1))
          (= (sigma (apply F i)) (- (sigma i) 1))))))

; Legitimacy (NO iff — avoids parser fragility)
(assert (forall ((F Operation))
  (=> (Legitimate F)
      (and (Admissible F)
           (Drift F)))))

; Stabilizing idempotence ONLY
(assert (forall ((F Operation) (i Agent))
  (=> (and (Legitimate F) (Stabilizing F))
      (= (apply F (apply F i))
         (apply F i)))))

; Stabilizing ops preserve standing
(assert (forall ((F Operation) (i Agent))
  (=> (and (Legitimate F) (Stabilizing F))
      (= (sigma (apply F i))
         (sigma i)))))

; Identity op
(assert (Legitimate Id))
(assert (Stabilizing Id))

; ============================================================
; SMT‑SAFE bounded generativity
; ============================================================

(assert (forall ((i Agent))
  (=> (< (sigma i) 10)
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

; ============================================================
; Check
; ============================================================

(check-sat)

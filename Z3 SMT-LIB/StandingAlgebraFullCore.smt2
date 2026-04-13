(set-logic AUFLIA)

; ============================================================
; Standing Algebra Σᴿ — Ultra‑Safe Max‑SAT Core
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

(declare-fun S     (Int) Int)

(declare-fun apply (Operation Agent) Agent)
(declare-const Id Operation)

; -----------------------------
; Predicates
; -----------------------------
(declare-fun Null (Agent) Bool)
(declare-fun Prime (Agent) Bool)
(declare-fun Composite (Agent) Bool)

(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)

; -----------------------------
; GLOBAL SANITY CONSTRAINTS
; -----------------------------
(assert (forall ((i Agent)) (>= (sigma i) 0)))
(assert (forall ((i Agent)) (>= (deg i) 0)))
(assert (forall ((c Int))   (>= (B c) 0)))

; ============================================================
; Tier‑1: Standing Algebra (SAFE)
; ============================================================

; Nullity (one‑way, safe)
(assert (forall ((i Agent))
  (=> (= (sigma i) 0)
      (Null i))))

; Successor (pure arithmetic, no existence)
(assert (= (S 0) 1))
(assert (forall ((n Int))
  (= (S n) (+ n 1))))
(assert (forall ((n Int))
  (> (S n) n)))

; Prime definition
(assert (forall ((i Agent))
  (=> (Prime i)
      (= (sigma i) 1))))

; Composite definition
(assert (forall ((i Agent))
  (=> (Composite i)
      (> (sigma i) 1))))

; Exhaustive but NOT biconditional (safe partition)
(assert (forall ((i Agent))
  (or (Null i) (Prime i) (Composite i))))

(assert (forall ((i Agent))
  (not (and (Null i) (Prime i)))))

(assert (forall ((i Agent))
  (not (and (Null i) (Composite i)))))

(assert (forall ((i Agent))
  (not (and (Prime i) (Composite i)))))

; Non‑triviality
(assert (exists ((i Agent))
  (= (sigma i) 1)))

; ============================================================
; Tier‑2: Structural Legitimacy (SAFE)
; ============================================================

; Capacity bound
(assert (forall ((i Agent))
  (<= (sigma i)
      (B (cap i)))))

; Capacity monotonicity
(assert (forall ((c1 Int) (c2 Int))
  (=> (>= c1 c2)
      (>= (B c1) (B c2)))))

; ALRP (safe, one‑directional)
(assert (forall ((F Operation) (i Agent))
  (=> (Admissible F)
      (>= (sigma (apply F i))
          (sigma i)))))

; Legitimacy is a subset of admissibility
(assert (forall ((F Operation))
  (=> (Legitimate F)
      (Admissible F))))

; Identity operation is legitimate
(assert (Legitimate Id))

; ============================================================
; CHECK
; ============================================================

(check-sat)

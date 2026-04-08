(set-logic AUFLIA)
; AUF = Uninterpreted Functions
; LIA = Linear Integer Arithmetic

; =========================
; Sort Declarations
; =========================
(declare-sort Agent 0)
(declare-sort State 0)
(declare-sort Operation 0)

; =========================
; Function Symbols
; =========================
(declare-fun sigma (Agent) Int)              ; standing
(declare-fun Apply (Operation Agent) Agent)  ; defunctionalized operation
(declare-fun DomPressure (State) Int)         ; domination pressure
(declare-fun L (Operation) Operation)         ; legitimacy envelope

; =========================
; Predicate Symbols
; =========================
(declare-fun Coupled (Agent Agent) Bool)
(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)
(declare-fun Repair (Operation) Bool)

; =========================
; Standing Constraints
; =========================

; Standing is always non-negative
(assert (forall ((a Agent))
  (>= (sigma a) 0)))

; Successor monotonicity: successor is strictly greater
(assert (forall ((a Agent))
  (> (+ (sigma a) 1) (sigma a))))

; =========================
; ALRP — Standing Preservation
; =========================
(assert (forall ((F Operation) (a Agent))
  (=> (Admissible F)
      (>= (sigma (Apply F a))
          (sigma a)))))

; =========================
; STC5 — Symmetry of Equals
; =========================
(assert (forall ((F Operation) (a Agent) (b Agent))
  (=> (and (Legitimate F)
           (= (sigma a) (sigma b)))
      (= (sigma (Apply F a))
         (sigma (Apply F b))))))

; =========================
; Rerunnability (Idempotence)
; =========================
(assert (forall ((F Operation) (a Agent))
  (=> (Legitimate F)
      (= (Apply F (Apply F a))
         (Apply F a)))))

; =========================
; Bounded Drift
; =========================
(assert (forall ((F Operation) (a Agent))
  (=> (Admissible F)
      (or (= (sigma (Apply F a)) (sigma a))
          (= (sigma (Apply F a)) (+ (sigma a) 1))))))

; =========================
; Directed Repair (Existential)
; =========================
(assert (forall ((a Agent) (b Agent))
  (=> (< (sigma a) (sigma b))
      (exists ((R Operation))
        (and (Repair R)
             (>= (sigma (Apply R a))
                 (sigma a)))))))

; =========================
; Domination Pressure Monotonicity
; =========================
(assert (forall ((F Operation) (s State))
  (=> (Admissible F)
      (<= (DomPressure (s))
          (DomPressure (s)))))) ; identity placeholder

; NOTE:
; Apply-to-State interaction can be extended later if you want
; State-level application was intentionally kept minimal here

(check-sat)
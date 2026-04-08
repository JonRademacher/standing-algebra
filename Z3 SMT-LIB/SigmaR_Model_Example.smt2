(set-logic AUFLIA)

; =========================
; Sorts
; =========================
(declare-sort Agent 0)
(declare-sort State 0)
(declare-sort Operation 0)

; =========================
; Constants
; =========================
(declare-const a1 Agent)
(declare-const a2 Agent)
(declare-const s0 State)
(declare-const F Operation)

; =========================
; Functions
; =========================
(declare-fun sigma (Agent) Int)
(declare-fun Apply (Operation Agent) Agent)
(declare-fun DomPressure (State) Int)
(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)

; =========================
; Standing assignments
; =========================
(assert (= (sigma a1) 1))
(assert (= (sigma a2) 1))

; Application is identity
(assert (= (Apply F a1) a1))
(assert (= (Apply F a2) a2))

; Domination pressure
(assert (= (DomPressure s0) 0))
(assert (= (DomPressure s0) (DomPressure s0)))

; Operation F is both admissible and legitimate
(assert (Admissible F))
(assert (Legitimate F))

; =========================
; ALRP — Standing preservation
; =========================
(assert
  (forall ((a Agent))
    (>= (sigma (Apply F a)) (sigma a))))

; =========================
; Domination monotonicity
; =========================
(assert
  (forall ((s State))
    (<= (DomPressure s) (DomPressure s))))

; =========================
; Check consistency
; =========================
(check-sat)
(get-model)
``
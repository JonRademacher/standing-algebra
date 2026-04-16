(set-logic AUFLIA)

; ---------------------------------
; Goodhart + Standing Algebra (UNSAT)
; ---------------------------------

(declare-fun true_value (Int) Int)
(declare-fun proxy (Int) Int)

; Interpret true_value as standing
(define-fun sigma ((t Int)) Int (true_value t))

; Proxy improvement implies admissible transition
(assert (forall ((t Int))
  (=> (> (proxy (+ t 1)) (proxy t))
      (>= (sigma (+ t 1)) (sigma t)))))

; ---- Original Goodhart assumptions ----

(assert (forall ((t Int))
  (=> (and (>= t 0) (< t 10))
      (>= (proxy (+ t 1)) (proxy t)))))

(assert (forall ((t Int))
  (<= (proxy t) 100)))

(assert (forall ((t Int))
  (>= (true_value t) 0)))

; ---- Goodhart collapse witness ----
(assert (exists ((t Int))
  (and
    (>= t 0)
    (< t 10)
    (> (proxy (+ t 1)) (proxy t))
    (< (true_value (+ t 1)) (true_value t)))))

(check-sat)

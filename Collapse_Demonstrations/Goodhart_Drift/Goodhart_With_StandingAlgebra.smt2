(set-logic AUFLIA)

(declare-fun true_value (Int) Int)
(declare-fun proxy (Int) Int)

; Standing Algebra invariant:
; legitimate improvement cannot reduce true value
(assert (forall ((t Int))
  (=> (> (proxy (+ t 1)) (proxy t))
      (>= (true_value (+ t 1)) (true_value t)))))

; Proxy improvement still required
(assert (forall ((t Int))
  (> (proxy (+ t 1)) (proxy t))))

; Bounded proxy
(assert (forall ((t Int))
  (<= (proxy t) 100)))

; Attempt Goodhart collapse
(assert (exists ((t Int))
  (< (true_value (+ t 1)) (true_value t))))

(check-sat)

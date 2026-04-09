(set-logic AUFLIA)

(declare-fun autonomy (Int) Int)

; Standing Algebra invariant
(assert (forall ((t Int))
  (>= (autonomy (+ t 2)) (autonomy t))))

; Same finite bound
(assert (forall ((t Int))
  (<= (autonomy t) 100)))

; Same collapse attempt
(assert (exists ((t Int))
  (< (autonomy (+ t 2)) (autonomy t))))

(check-sat)

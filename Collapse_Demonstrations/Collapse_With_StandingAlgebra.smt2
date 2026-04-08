(set-logic AUFLIA)

(declare-fun autonomy (Int) Int)

; Standing Algebra invariant:
; autonomy must not decrease under composition
(assert (forall ((t Int))
  (>= (autonomy (+ t 2)) (autonomy t))))

; Local legitimacy still holds
(assert (forall ((t Int))
  (>= (autonomy (+ t 1)) (autonomy t))))

; Finite bounds
(assert (forall ((t Int))
  (<= (autonomy t) 100)))

; Attempt the same collapse
(assert (exists ((t Int))
  (< (autonomy (+ t 2)) (autonomy t))))

(check-sat)

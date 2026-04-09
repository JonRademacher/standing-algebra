(set-logic AUFLIA)

(declare-fun autonomy (Int) Int)

; Finite bound so things don’t go infinite
(assert (forall ((t Int))
  (<= (autonomy t) 100)))

; Collapse definition: autonomy decreases over +2
(assert (exists ((t Int))
  (< (autonomy (+ t 2)) (autonomy t))))

(check-sat)
(get-model)

(set-logic AUFLIA)

; Autonomy level indexed by time
(declare-fun autonomy (Int) Int)

; Each individual step is legitimate:
; autonomy never decreases locally
(assert (forall ((t Int))
  (>= (autonomy (+ t 1)) (autonomy t))))

; Autonomy is bounded (finite system)
(assert (forall ((t Int))
  (<= (autonomy t) 100)))

; But there exists a compositional collapse:
; over two steps, autonomy strictly decreases
(assert (exists ((t Int))
  (< (autonomy (+ t 2)) (autonomy t))))

(check-sat)

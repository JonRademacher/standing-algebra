(set-logic AUFLIA)

; True value and proxy metric
(declare-fun true_value (Int) Int)
(declare-fun proxy (Int) Int)

; Each step legitimately improves the proxy
(assert (forall ((t Int))
  (> (proxy (+ t 1)) (proxy t))))

; The proxy is bounded (finite system)
(assert (forall ((t Int))
  (<= (proxy t) 100)))

; True value is initially aligned
(assert (forall ((t Int))
  (>= (true_value t) 0)))

; Goodhart collapse:
; there exists a time where proxy improves but true value worsens
(assert (exists ((t Int))
  (and
    (> (proxy (+ t 1)) (proxy t))
    (< (true_value (+ t 1)) (true_value t)))))

(check-sat)

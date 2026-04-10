(set-logic AUFLIA)

; ---------------------------------
; Goodhart system (finite witness, SAT)
; ---------------------------------

(declare-fun true_value (Int) Int)
(declare-fun proxy (Int) Int)

; ---- Proxy is non-decreasing over the window [0,10) ----
(assert (forall ((t Int))
  (=> (and (>= t 0) (< t 10))
      (>= (proxy (+ t 1)) (proxy t)))))

; ---- Proxy is bounded ----
(assert (forall ((t Int))
  (<= (proxy t) 100)))

; ---- True value is non-negative ----
(assert (forall ((t Int))
  (>= (true_value t) 0)))

; ---- Goodhart collapse exists ----
; At some step in the window, proxy improves
; while true value worsens
(assert (exists ((t Int))
  (and
    (>= t 0)
    (< t 10)
    (> (proxy (+ t 1)) (proxy t))
    (< (true_value (+ t 1)) (true_value t)))))

(check-sat)
(get-model)

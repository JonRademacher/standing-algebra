(set-logic AUFLIA)

; ---------------------------------
; Finite Goodhart system (SAT)
; ---------------------------------

(declare-fun true_value (Int) Int)
(declare-fun proxy (Int) Int)

; ---- Finite time domain ----
(assert (forall ((t Int))
  (and (>= t 0) (<= t 10))))

; ---- Proxy is non-decreasing (not strictly) ----
(assert (forall ((t Int))
  (=> (and (>= t 0) (< t 10))
      (>= (proxy (+ t 1)) (proxy t)))))

; ---- Proxy is bounded ----
(assert (forall ((t Int))
  (<= (proxy t) 100)))

; ---- True value initially non-negative ----
(assert (forall ((t Int))
  (>= (true_value t) 0)))

; ---- Goodhart collapse exists ----
; At some step, proxy improves while true value worsens
(assert (exists ((t Int))
  (and
    (>= t 0)
    (< t 10)
    (> (proxy (+ t 1)) (proxy t))
    (< (true_value (+ t 1)) (true_value t)))))

(check-sat)
(get-model)

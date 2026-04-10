(set-logic AUFLIA)

; ---------------------------------
; Finite Goodhart system (bounded)
; ---------------------------------

(declare-fun true_value (Int) Int)
(declare-fun proxy (Int) Int)

; ---- Finite time domain ----
; We restrict time to a small finite window
(assert (forall ((t Int))
  (and (>= t 0) (<= t 10))))

; ---- Proxy improves locally ----
(assert (forall ((t Int))
  (=> (and (>= t 0) (< t 10))
      (> (proxy (+ t 1)) (proxy t)))))

; ---- Proxy is bounded (finite system) ----
(assert (forall ((t Int))
  (<= (proxy t) 100)))

; ---- True value initially non-negative ----
(assert (forall ((t Int))
  (>= (true_value t) 0)))

; ---- Goodhart collapse ----
; There exists a step where proxy improves
; but true value worsens
(assert (exists ((t Int))
  (and
    (>= t 0)
    (< t 10)
    (> (proxy (+ t 1)) (proxy t))
    (< (true_value (+ t 1)) (true_value t)))))

(check-sat)
(get-model)

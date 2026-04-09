(set-logic AUFLIA)

(declare-sort Agent 0)
(declare-sort State 0)
(declare-sort Operation 0)

(declare-fun sigma (Agent) Int)
(declare-fun Apply (Operation Agent) Agent)
(declare-fun ApplyS (Operation State) State)
(declare-fun DomPressure (State) Int)
(declare-fun L (Operation) Operation)

(declare-fun Coupled (Agent Agent) Bool)
(declare-fun Admissible (Operation) Bool)
(declare-fun Legitimate (Operation) Bool)
(declare-fun Repair (Operation) Bool)

;; Standing non-negative
(assert (forall ((a Agent))
  (>= (sigma a) 0)))

;; Arithmetic successor monotonicity (tautology)
(assert (forall ((a Agent))
  (> (+ (sigma a) 1) (sigma a))))

;; ALRP
(assert (forall ((F Operation) (a Agent))
  (=> (Admissible F)
      (>= (sigma (Apply F a)) (sigma a)))))

;; STC5
(assert (forall ((F Operation) (a Agent) (b Agent))
  (=> (and (Legitimate F)
           (= (sigma a) (sigma b)))
      (= (sigma (Apply F a))
         (sigma (Apply F b))))))

;; Idempotence
(assert (forall ((F Operation) (a Agent))
  (=> (Legitimate F)
      (= (Apply F (Apply F a))
         (Apply F a)))))

;; Bounded drift
(assert (forall ((F Operation) (a Agent))
  (=> (Admissible F)
      (or (= (sigma (Apply F a)) (sigma a))
          (= (sigma (Apply F a)) (+ (sigma a) 1))))))

;; Domination pressure placeholder
(assert (forall ((F Operation) (s State))
  (=> (Admissible F)
      (<= (DomPressure s) (DomPressure s)))))

(check-sat)

; StandingAlgebra_Drift.smt2
(set-logic AUFLIA)

(include "StandingAlgebraFullCore.smt2")

(declare-const DriftEnabled Bool)
(assert DriftEnabled)

(assert (forall ((F Operation) (i Agent))
  (=> (and DriftEnabled (Drift F))
      (or (= (sigma (apply F i)) (sigma i))
          (= (sigma (apply F i)) (+ (sigma i) 1))
          (and (> (sigma i) 0)
               (= (sigma (apply F i)) (- (sigma i) 1)))))))

(check-sat)

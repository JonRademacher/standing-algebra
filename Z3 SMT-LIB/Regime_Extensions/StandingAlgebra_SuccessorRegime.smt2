; StandingAlgebra_Successor.smt2
(set-logic AUFLIA)

(include "StandingAlgebraFullCore.smt2")

; Enable successor realization only under a guard
(declare-const SuccessorEnabled Bool)

(assert SuccessorEnabled)

(assert (forall ((i Agent))
  (=> (and SuccessorEnabled (< (sigma i) 10))
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

(check-sat)

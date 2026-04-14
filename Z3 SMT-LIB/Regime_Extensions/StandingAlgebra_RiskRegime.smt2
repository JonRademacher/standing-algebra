; StandingAlgebra_Risk.smt2
(set-logic AUFLIA)

(include "StandingAlgebra_MaxSAT_UltraSafe.smt2")

(declare-fun RiskLoad (Agent) Int)
(declare-const RiskEnabled Bool)
(assert RiskEnabled)

(assert (forall ((i Agent)) (>= (RiskLoad i) 0)))

(assert (forall ((F Operation) (i Agent))
  (=> (and RiskEnabled (Admissible F))
      (>= (RiskLoad (apply F i))
          (RiskLoad i)))))

(check-sat)
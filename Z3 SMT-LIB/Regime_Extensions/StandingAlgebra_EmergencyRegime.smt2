; StandingAlgebra_Emergency.smt2
(set-logic AUFLIA)

(include "StandingAlgebra_MaxSAT_UltraSafe.smt2")

(declare-const EmergencyEnabled Bool)
(assert EmergencyEnabled)

(declare-fun Emergency (Operation) Bool)

(assert (forall ((F Operation))
  (=> (and EmergencyEnabled (Emergency F))
      (Admissible F))))

(check-sat)
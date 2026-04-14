; StandingAlgebra_Remedy.smt2
(set-logic AUFLIA)

(include "StandingAlgebra_MaxSAT_UltraSafe.smt2")

(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal Exceptional)))

(declare-fun RemedyHigher (RemedyLevel RemedyLevel) Bool)
(declare-const RemedyEnabled Bool)
(assert RemedyEnabled)

(assert (and (RemedyHigher Friction CounterSpeech)
             (RemedyHigher Damping Friction)
             (RemedyHigher Removal Damping)
             (RemedyHigher Exceptional Removal)))

(assert (forall ((r RemedyLevel))
  (not (RemedyHigher r r))))

(check-sat)
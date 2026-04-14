(set-logic AUFLIA)

(include "../Core/StandingAlgebraFullCore.smt2")

; -----------------------------
; Risk regime
; -----------------------------
(declare-const RiskEnabled Bool)
(assert RiskEnabled)

(declare-fun RiskLoad (Agent) Int)
(declare-fun RiskBearer (Operation Agent) Bool)

(assert (forall ((i Agent)) (>= (RiskLoad i) 0)))

; -----------------------------
; Emergency regime
; -----------------------------
(declare-const EmergencyEnabled Bool)
(assert (=> EmergencyEnabled RiskEnabled))

(declare-fun Emergency (Operation) Bool)

; Emergency only if risk exists
(assert (forall ((F Operation) (i Agent))
  (=> (and EmergencyEnabled (Emergency F))
      (RiskBearer F i))))

; -----------------------------
; Remedy regime (enabled only by emergency)
; -----------------------------
(declare-const RemedyEnabled Bool)
(assert (=> RemedyEnabled EmergencyEnabled))

(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal Exceptional)))

(declare-fun RemedyLevelOf (Operation) RemedyLevel)

; Remedy must be defined for emergency operations
(assert (forall ((F Operation))
  (=> (and RemedyEnabled (Emergency F))
      (or (= (RemedyLevelOf F) CounterSpeech)
          (= (RemedyLevelOf F) Friction)
          (= (RemedyLevelOf F) Damping)
          (= (RemedyLevelOf F) Removal)
          (= (RemedyLevelOf F) Exceptional)))))

(check-sat)

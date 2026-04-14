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

(assert (forall ((F Operation) (i Agent))
  (=> (and RiskEnabled (RiskBearer F i))
      (>= (RiskLoad (apply F i)) (RiskLoad i)))))

; -----------------------------
; Emergency regime (informed by risk)
; -----------------------------
(declare-const EmergencyEnabled Bool)

; Emergency cannot activate unless risk exists
(assert (=> EmergencyEnabled RiskEnabled))

(declare-fun Emergency (Operation) Bool)

; Emergency only applies to risk-bearing operations
(assert (forall ((F Operation) (i Agent))
  (=> (and EmergencyEnabled (Emergency F))
      (RiskBearer F i))))

; Emergency implies admissibility (but not legitimacy)
(assert (forall ((F Operation))
  (=> (and EmergencyEnabled (Emergency F))
      (Admissible F))))

(check-sat)

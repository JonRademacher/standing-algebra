(set-logic AUFLIA)

; ============================================================
; Drift with Bounded Remedy (No Emergency)
; ============================================================

(include "../Core/StandingAlgebraFullCore.smt2")

; -----------------------------
; Drift regime
; -----------------------------
(declare-const DriftEnabled Bool)
(assert DriftEnabled)

(declare-fun DriftEvent (Operation Agent) Bool)

; Drift produces bounded standing change
(assert (forall ((F Operation) (i Agent))
  (=> (and DriftEnabled (DriftEvent F i))
      (or (= (sigma (apply F i)) (sigma i))
          (= (sigma (apply F i)) (+ (sigma i) 1))
          (and (> (sigma i) 0)
               (= (sigma (apply F i)) (- (sigma i) 1)))))))

; -----------------------------
; Remedy regime (bounded, proportional)
; -----------------------------
(declare-const RemedyEnabled Bool)
(assert RemedyEnabled)

(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal)))

(declare-fun RemedyApplied (Operation Agent) Bool)
(declare-fun RemedyLevelOf (Operation) RemedyLevel)

; Remedy can only apply if drift occurred
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (DriftEvent F i))))

; Remedy must not worsen standing
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (>= (sigma (apply F i)) (sigma i)))))

; Remedy must be bounded (no exceptional action)
(assert (forall ((F Operation))
  (=> RemedyEnabled
      (or (= (RemedyLevelOf F) CounterSpeech)
          (= (RemedyLevelOf F) Friction)
          (= (RemedyLevelOf F) Damping)
          (= (RemedyLevelOf F) Removal)))))

; -----------------------------
; System integrity preservation
; -----------------------------

; Remedy does not create emergency
(declare-const EmergencyEnabled Bool)
(assert (not EmergencyEnabled))

; Remedy does not revoke admissibility
(assert (forall ((F Operation))
  (=> (and RemedyEnabled (RemedyApplied F))
      (Admissible F))))

(check-sat)

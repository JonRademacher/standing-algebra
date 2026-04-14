(set-logic AUFLIA)

; ============================================================
; Successor → Drift → Bounded Remedy
; (No Emergency, System Integrity Preserved)
; ============================================================

(include "../Core/StandingAlgebraFullCore.smt2")

; -----------------------------
; Successor regime
; -----------------------------
(declare-const SuccessorEnabled Bool)
(assert SuccessorEnabled)

; Local successor realization (bounded, SMT‑safe)
(assert (forall ((i Agent))
  (=> (and SuccessorEnabled (< (sigma i) 10))
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

; -----------------------------
; Drift regime (induced by successor)
; -----------------------------
(declare-const DriftEnabled Bool)
(assert DriftEnabled)

(declare-fun DriftEvent (Operation Agent) Bool)

; Drift only occurs if successor is active
(assert (forall ((F Operation) (i Agent))
  (=> (DriftEvent F i)
      SuccessorEnabled)))

; Drift produces bounded deviation
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

; Remedy only applies if drift occurred
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (DriftEvent F i))))

; Remedy must not worsen standing
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (>= (sigma (apply F i)) (sigma i)))))

; Remedy is bounded (no exceptional escalation)
(assert (forall ((F Operation))
  (=> RemedyEnabled
      (or (= (RemedyLevelOf F) CounterSpeech)
          (= (RemedyLevelOf F) Friction)
          (= (RemedyLevelOf F) Damping)
          (= (RemedyLevelOf F) Removal)))))

; -----------------------------
; Explicitly forbid emergency
; -----------------------------
(declare-const EmergencyEnabled Bool)
(assert (not EmergencyEnabled))

(check-sat)

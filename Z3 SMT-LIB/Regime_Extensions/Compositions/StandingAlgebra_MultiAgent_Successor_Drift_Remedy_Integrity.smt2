(set-logic AUFLIA)

; ============================================================
; Multi‑Agent Successor + Drift + Remedy
; Structural Integrity Under Conflict (No Emergency)
; ============================================================

(include "../Core/StandingAlgebraFullCore.smt2")

; ------------------------------------------------------------
; Global structural integrity invariants
; ------------------------------------------------------------

; Standing always remains within capacity
(assert (forall ((i Agent))
  (<= (sigma i) (B (cap i)))))

; ------------------------------------------------------------
; Successor regime (uniform, plural, non‑selective)
; ------------------------------------------------------------

(declare-const SuccessorEnabled Bool)
(assert SuccessorEnabled)

; Every agent may advance locally (bounded for SMT)
(assert (forall ((i Agent))
  (=> (and SuccessorEnabled (< (sigma i) 10))
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

; ------------------------------------------------------------
; Drift regime (conflict‑generating side‑effects)
; ------------------------------------------------------------

(declare-const DriftEnabled Bool)
(assert DriftEnabled)

(declare-fun DriftEvent (Operation Agent) Bool)

; Drift may occur for multiple agents simultaneously
(assert (forall ((F Operation) (i Agent))
  (=> (and DriftEnabled (DriftEvent F i))
      SuccessorEnabled)))

; Drift is bounded but may push toward capacity limits
(assert (forall ((F Operation) (i Agent))
  (=> (and DriftEnabled (DriftEvent F i))
      (or (= (sigma (apply F i)) (sigma i))
          (= (sigma (apply F i)) (+ (sigma i) 1))
          (and (> (sigma i) 0)
               (= (sigma (apply F i)) (- (sigma i) 1)))))))

; ------------------------------------------------------------
; Remedy regime (local, proportional, integrity‑preserving)
; ------------------------------------------------------------

(declare-const RemedyEnabled Bool)
(assert RemedyEnabled)

(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal)))

(declare-fun RemedyApplied (Operation Agent) Bool)
(declare-fun RemedyLevelOf (Operation) RemedyLevel)

; Remedy applies wherever drift threatens integrity
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (DriftEvent F i))))

; Remedy never worsens standing
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (>= (sigma (apply F i)) (sigma i)))))

; Remedy is bounded and non‑exceptional
(assert (forall ((F Operation))
  (=> RemedyEnabled
      (or (= (RemedyLevelOf F) CounterSpeech)
          (= (RemedyLevelOf F) Friction)
          (= (RemedyLevelOf F) Damping)
          (= (RemedyLevelOf F) Removal)))))

; ------------------------------------------------------------
; Explicitly forbid emergency escalation
; ------------------------------------------------------------

(declare-const EmergencyEnabled Bool)
(assert (not EmergencyEnabled))

(check-sat)

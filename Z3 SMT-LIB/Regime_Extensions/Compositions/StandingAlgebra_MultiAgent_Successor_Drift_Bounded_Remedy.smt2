(set-logic AUFLIA)

; ============================================================
; Multi‑Agent Successor + Drift + Bounded Remedy
; Structural Integrity Preserved (No Emergency)
; ============================================================

(include "../Core/StandingAlgebraFullCore.smt2")

; ------------------------------------------------------------
; Global invariants (structural integrity)
; ------------------------------------------------------------

; Standing stays within capacity for all agents
(assert (forall ((i Agent))
  (<= (sigma i) (B (cap i)))))

; ------------------------------------------------------------
; Successor regime (uniform, no selection)
; ------------------------------------------------------------

(declare-const SuccessorEnabled Bool)
(assert SuccessorEnabled)

; Every agent may advance locally (bounded for SMT)
(assert (forall ((i Agent))
  (=> (and SuccessorEnabled (< (sigma i) 10))
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

; ------------------------------------------------------------
; Drift regime (local side‑effects of successor)
; ------------------------------------------------------------

(declare-const DriftEnabled Bool)
(assert DriftEnabled)

(declare-fun DriftEvent (Operation Agent) Bool)

; Drift only occurs when successor is active
(assert (forall ((F Operation) (i Agent))
  (=> (DriftEvent F i)
      SuccessorEnabled)))

; Drift is bounded and local
(assert (forall ((F Operation) (i Agent))
  (=> (and DriftEnabled (DriftEvent F i))
      (or (= (sigma (apply F i)) (sigma i))
          (= (sigma (apply F i)) (+ (sigma i) 1))
          (and (> (sigma i) 0)
               (= (sigma (apply F i)) (- (sigma i) 1)))))))

; ------------------------------------------------------------
; Remedy regime (bounded containment, no escalation)
; ------------------------------------------------------------

(declare-const RemedyEnabled Bool)
(assert RemedyEnabled)

(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal)))

(declare-fun RemedyApplied (Operation Agent) Bool)
(declare-fun RemedyLevelOf (Operation) RemedyLevel)

; Remedy applies only where drift occurred
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (DriftEvent F i))))

; Remedy never worsens standing
(assert (forall ((F Operation) (i Agent))
  (=> (and RemedyEnabled (RemedyApplied F i))
      (>= (sigma (apply F i)) (sigma i)))))

; Remedy is bounded (no exceptional action)
(assert (forall ((F Operation))
  (=> RemedyEnabled
      (or (= (RemedyLevelOf F) CounterSpeech)
          (= (RemedyLevelOf F) Friction)
          (= (RemedyLevelOf F) Damping)
          (= (RemedyLevelOf F) Removal)))))

; ------------------------------------------------------------
; Explicitly forbid emergency or authority escalation
; ------------------------------------------------------------

(declare-const EmergencyEnabled Bool)
(assert (not EmergencyEnabled))

(check-sat)

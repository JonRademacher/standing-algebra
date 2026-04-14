(set-logic AUFLIA)

; ============================================================
; Multi‑Agent Direct Conflict with Bounded Remedy
; Structural Integrity Preserved (No Emergency)
; ============================================================

(include "../Core/StandingAlgebraFullCore.smt2")

; ------------------------------------------------------------
; Global structural integrity invariants
; ------------------------------------------------------------

; Standing remains within capacity for all agents
(assert (forall ((i Agent))
  (<= (sigma i) (B (cap i)))))

; ------------------------------------------------------------
; Successor regime (plural, uniform)
; ------------------------------------------------------------

(declare-const SuccessorEnabled Bool)
(assert SuccessorEnabled)

; Both agents may advance (bounded)
(assert (forall ((i Agent))
  (=> (and SuccessorEnabled (< (sigma i) 10))
      (exists ((j Agent))
        (= (sigma j) (S (sigma i)))))))

; ------------------------------------------------------------
; Conflict‑inducing drift (interactional)
; ------------------------------------------------------------

(declare-const DriftEnabled Bool)
(assert DriftEnabled)

(declare-fun DriftEvent (Operation Agent Agent) Bool)

; Drift arises from interaction between agents
(assert (forall ((F Operation) (i Agent) (j Agent))
  (=> (DriftEvent F i j)
      (and SuccessorEnabled
           (not (= i j))))))

; Drift affects both agents symmetrically
(assert (forall ((F Operation) (i Agent) (j Agent))
  (=> (and DriftEnabled (DriftEvent F i j))
      (and
        (or (= (sigma (apply F i)) (sigma i))
            (= (sigma (apply F i)) (+ (sigma i) 1))
            (and (> (sigma i) 0)
                 (= (sigma (apply F i)) (- (sigma i) 1))))
        (or (= (sigma (apply F j)) (sigma j))
            (= (sigma (apply F j)) (+ (sigma j) 1))
            (and (> (sigma j) 0)
                 (= (sigma (apply F j)) (- (sigma j) 1))))))))

; ------------------------------------------------------------
; Remedy regime (conflict‑bounded, symmetric)
; ------------------------------------------------------------

(declare-const RemedyEnabled Bool)
(assert RemedyEnabled)

(declare-datatypes ((RemedyLevel 0))
  ((RemedyLevel CounterSpeech Friction Damping Removal)))

(declare-fun RemedyApplied (Operation Agent) Bool)
(declare-fun RemedyLevelOf (Operation) RemedyLevel)

; Remedy applies to both sides of a conflict
(assert (forall ((F Operation) (i Agent) (j Agent))
  (=> (and RemedyEnabled (DriftEvent F i j))
      (and (RemedyApplied F i)
           (RemedyApplied F j)))))

; Remedy preserves standing for both agents
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

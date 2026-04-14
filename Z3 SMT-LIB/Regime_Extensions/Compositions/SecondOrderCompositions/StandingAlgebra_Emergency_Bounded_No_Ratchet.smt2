(set-logic AUFLIA)

; ============================================================
; Emergency Bounded, No‑Ratchet
; Second‑Order Integrity Preservation
; ============================================================

(include "../../../Core/StandingAlgebraFullCore.smt2")

; ------------------------------------------------------------
; Emergency assumed enabled by remedy failure
; ------------------------------------------------------------

(declare-const EmergencyEnabled Bool)
(declare-fun Emergency (Operation) Bool)

; Structural integrity predicate
(declare-fun StructuralIntegrityHolds () Bool)

; ------------------------------------------------------------
; Bounded emergency action
; ------------------------------------------------------------

; Emergency actions must preserve standing bounds
(assert (forall ((F Operation) (i Agent))
  (=> (and EmergencyEnabled (Emergency F))
      (<= (sigma (apply F i))
          (B (cap i))))))

; Emergency actions must not reduce standing below current
(assert (forall ((F Operation) (i Agent))
  (=> (and EmergencyEnabled (Emergency F))
      (>= (sigma (apply F i))
          (sigma i)))))

; ------------------------------------------------------------
; No‑ratchet guarantee
; ------------------------------------------------------------

; Once integrity is restored, emergency must deactivate
(assert
  (=> StructuralIntegrityHolds
      (not EmergencyEnabled)))

(check-sat)

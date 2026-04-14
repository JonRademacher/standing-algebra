(set-logic AUFLIA)

; ============================================================
; Emergency Triggered by Remedy Failure
; Second‑Order Composition
; ============================================================

(include "../../../Core/StandingAlgebraFullCore.smt2")

; ------------------------------------------------------------
; Assume first‑order regimes exist
; ------------------------------------------------------------

(declare-const RemedyEnabled Bool)
(assert RemedyEnabled)

(declare-fun RemedyApplied (Operation Agent) Bool)

; Structural integrity predicate (system‑level)
(declare-fun StructuralIntegrityHolds () Bool)

; Remedy failure: remedy applied but integrity still violated
(declare-fun RemedyFailure () Bool)

; Remedy failure definition (purely structural)
(assert
  (= RemedyFailure
     (and RemedyEnabled
          (not StructuralIntegrityHolds))))

; ------------------------------------------------------------
; Emergency regime (second‑order)
; ------------------------------------------------------------

(declare-const EmergencyEnabled Bool)
(declare-fun Emergency (Operation) Bool)

; Emergency is triggered iff remedy fails
(assert
  (= EmergencyEnabled RemedyFailure))

; Emergency operations exist only when enabled
(assert (forall ((F Operation))
  (=> (Emergency F)
      EmergencyEnabled)))

; Emergency does not imply legitimacy, only admissibility
(assert (forall ((F Operation))
  (=> (and EmergencyEnabled (Emergency F))
      (Admissible F))))

(check-sat)

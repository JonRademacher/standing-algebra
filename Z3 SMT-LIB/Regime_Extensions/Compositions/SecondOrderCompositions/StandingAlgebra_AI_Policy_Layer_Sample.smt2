(set-logic AUFLIA)

; ============================================================
; Second‑Order AI Policy Layer
; Capacity Ratcheting via Explanation (No Selection)
; ============================================================

(include "../../../Core/StandingAlgebraFullCore.smt2")

; ------------------------------------------------------------
; Outputs as operations
; ------------------------------------------------------------

(declare-fun OutputOp (Operation) Bool)
(declare-fun ExplanationOp (Operation) Bool)

(declare-const PolicyEnabled Bool)
(assert PolicyEnabled)

; ------------------------------------------------------------
; Structural infeasibility predicate
; ------------------------------------------------------------

; No admissible output exists at current capacity
(declare-fun InfeasibleAtCurrentCapacity () Bool)

; ------------------------------------------------------------
; Capacity ratcheting via explanation
; ------------------------------------------------------------

; Explanation operations increase capacity
(assert (forall ((F Operation) (i Agent))
  (=> (ExplanationOp F)
      (> (cap (apply F i))
         (cap i)))))

; Explanation only occurs if infeasible
(assert (forall ((F Operation))
  (=> (ExplanationOp F)
      InfeasibleAtCurrentCapacity))))

; If infeasible, explanation must exist
(assert
  (=> InfeasibleAtCurrentCapacity
      (exists ((F Operation))
        (ExplanationOp F))))

; ------------------------------------------------------------
; Reframed admissibility after capacity increase
; ------------------------------------------------------------

; After explanation, admissible outputs exist
(assert
  (=> InfeasibleAtCurrentCapacity
      (exists ((F Operation))
        (and (OutputOp F)
             (Admissible F)))))

; ------------------------------------------------------------
; Policy constraints (still enforced)
; ------------------------------------------------------------

; Non‑harm: outputs must not reduce standing
(assert (forall ((F Operation) (i Agent))
  (=> (and PolicyEnabled (OutputOp F))
      (>= (sigma (apply F i))
          (sigma i)))))

; Capacity preservation after ratcheting
(assert (forall ((F Operation) (i Agent))
  (=> (and PolicyEnabled (OutputOp F))
      (<= (sigma (apply F i))
          (B (cap i))))))

; ------------------------------------------------------------
; No emergency invocation
; ------------------------------------------------------------

(declare-const EmergencyEnabled Bool)
(assert (not EmergencyEnabled))

(check-sat)

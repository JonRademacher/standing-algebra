(set-logic AUFLIA)

(include "StandingAlgebraFullCore.smt2")

; ============================================================
; Standing Algebra Σᴿ — Exit / Reversibility Regime
; ============================================================
;
; DEPENDENCY:
; This file MUST be loaded AFTER:
;   StandingAlgebraFullCore.smt2
;
; It assumes the existence of:
;   - sorts: Agent, Operation
;   - functions: sigma, cap, B, apply
;   - predicates: Admissible, Legitimate
;
; No core axioms are redefined here.
; ============================================================

; -----------------------------
; Exit‑specific predicates
; -----------------------------

; Marks an operation as an exit operation
(declare-fun Exit (Operation) Bool)

; Minimum viable standing (non‑lethal exit threshold)
(declare-fun MinStanding () Int)

; Upper bound of remedy (ceiling, not prescription)
(declare-fun RemedyCeiling (Agent) Int)

; -----------------------------
; Sanity constraints
; -----------------------------

; Minimum standing must be strictly positive
(assert (> (MinStanding) 0))

; Remedy ceiling must not fall below current standing
(assert (forall ((i Agent))
  (>= (RemedyCeiling i)
      (sigma i))))

; Remedy ceiling must respect capacity bounds
(assert (forall ((i Agent))
  (<= (RemedyCeiling i)
      (B (cap i)))))

; -----------------------------
; Exit existence
; -----------------------------

; At least one exit operation must exist
(assert (exists ((F Operation))
  (Exit F)))

; Exit operations must be admissible
(assert (forall ((F Operation))
  (=> (Exit F)
      (Admissible F))))

; -----------------------------
; Exit viability (core requirement)
; -----------------------------

; Exit must preserve minimal viable standing
(assert (forall ((F Operation) (i Agent))
  (=> (Exit F)
      (>= (sigma (apply F i))
          (MinStanding)))))

; Exit may reduce standing, but not increase it
(assert (forall ((F Operation) (i Agent))
  (=> (Exit F)
      (<= (sigma (apply F i))
          (sigma i)))))

; -----------------------------
; Non‑coercion of exit
; -----------------------------

; Refusing exit may not grant survival advantage
(assert (forall ((F Operation) (i Agent))
  (=> (and (Admissible F)
           (not (Exit F)))
      (>= (sigma (apply F i))
          (MinStanding)))))

; -----------------------------
; Remedy gap preservation
; -----------------------------

; Exit must not force full remedy
(assert (forall ((F Operation) (i Agent))
  (=> (Exit F)
      (< (sigma (apply F i))
         (RemedyCeiling i)))))

; There must exist standing states strictly between
; survival and remedy ceiling (option space)
(assert (forall ((i Agent))
  (exists ((s Int))
    (and (>= s (MinStanding))
         (< s (RemedyCeiling i))))))

; -----------------------------
; No lethal or null exit
; -----------------------------

; Exit may not collapse standing to null
(assert (forall ((F Operation) (i Agent))
  (=> (Exit F)
      (not (= (sigma (apply F i)) 0)))))

; -----------------------------
; Exit reversibility / no ratcheting
; -----------------------------

; Repeated exits must not destroy future exit viability
(assert (forall ((F Operation) (G Operation) (i Agent))
  (=> (and (Exit F)
           (Exit G))
      (>= (sigma (apply G (apply F i)))
          (MinStanding)))))

; ============================================================
; CHECK
; ============================================================

(check-sat)

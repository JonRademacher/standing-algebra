(set-logic AUFLIA)
; Standing Algebra (Σᴿ)
; Derived Properties / Basics Layer
;
; This file assumes SigmaR_Core.smt2 has already been loaded.
; It introduces no new axioms — only derived constraints.

; =========================================================
; Derived predicate abbreviations (commentary only)
; =========================================================
; StandingPreserved(F) :=
;   forall a. sigma(Apply(F,a)) >= sigma(a)

; =========================================================
; Derived Constraints (Theorem Analogues)
; =========================================================

; ---------------------------------------------------------
; Derived Property 1:
; Legitimate operations are standing-preserving
; (relies on design invariant: Legitimate ⇒ Admissible)
; ---------------------------------------------------------

(declare-fun LegitimateImpliesAdmissible (Operation) Bool)

; design invariant (explicit for SMT)
(assert
  (forall ((F Operation))
    (=> (Legitimate F)
        (Admissible F))))

; standing preservation under legitimacy
(assert
  (forall ((F Operation) (a Agent))
    (=> (Legitimate F)
        (>= (sigma (ApplyS F a))
            (sigma a)))))

; ---------------------------------------------------------
; Derived Property 2:
; Legitimate operations cannot increase DomPressure
; (this corresponds to the Lean theorem we proved)
; ---------------------------------------------------------

(assert
  (forall ((F Operation) (s State))
    (=> (Legitimate F)
        (<= (DomPressure (ApplyS F s))
            (DomPressure s)))))

; ---------------------------------------------------------
; Derived Property 3:
; Rerunnability prevents cumulative escalation
; ---------------------------------------------------------

(assert
  (forall ((F Operation) (a Agent))
    (=> (Legitimate F)
        (= (Apply F (ApplyS F a))
           (ApplyS F a)))))

; ---------------------------------------------------------
; Sanity Check:
; There exists at least one legitimate, non-escalating operation
; ---------------------------------------------------------

(assert
  (exists ((F Operation))
    (and
      (Legitimate F)
      (Admissible F))))

(check-sat)
; ===============================================
; UNIVERSALITY CHECK (Contrapositive)
; ===============================================

; Assume an operation violates admissibility
(declare-const F_bad Operation)
(declare-const s_bad State)

(assert (not (Admissible F_bad)))

; Assume domination does NOT escalate
(assert (not (> (DomPressure (apply F_bad s_bad))
                (DomPressure s_bad))))

; But violation implies escalation (universality axiom)
(assert
  (forall ((F Operation) (s State))
    (=> (not (Admissible F))
        (> (DomPressure (apply F s))
           (DomPressure s)))))

(check-sat)

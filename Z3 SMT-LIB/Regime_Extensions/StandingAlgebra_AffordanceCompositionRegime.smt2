(set-logic AUFLIA)

(include "StandingAlgebraFullCore.smt2")

; ============================================================
; Standing Algebra Σᴿ — Composition via Affordance Reshaping
; ============================================================
;
; DEPENDENCY:
;   StandingAlgebraFullCore.smt2
;   StandingAlgebraExitRegime.smt2
; ============================================================

; -----------------------------
; Sorts
; -----------------------------

(declare-sort Affordance 0)
(declare-sort Context 0)

; -----------------------------
; Predicates
; -----------------------------

; Agent can exercise an affordance in a context
(declare-fun Enables (Context Affordance Agent) Bool)

; Two affordances are incompatible in a context
(declare-fun Incompatible (Context Affordance Affordance) Bool)

; Context is admissible
(declare-fun ContextAdmissible (Context) Bool)

; Operation reshapes the space (not the agents)
(declare-fun Reshape (Operation) Bool)

; -----------------------------
; Conflict Definition
; -----------------------------

; Conflict exists if two agents can exercise incompatible affordances
(declare-fun Conflict () Bool)

(assert
  (= Conflict
     (exists ((c Context) (a1 Affordance) (a2 Affordance)
              (i1 Agent) (i2 Agent))
       (and (ContextAdmissible c)
            (Enables c a1 i1)
            (Enables c a2 i2)
            (Incompatible c a1 a2)
            (not (= i1 i2))))))

; -----------------------------
; Lawful Responses to Conflict
; -----------------------------

; Any reshaping operation must be admissible
(assert (forall ((F Operation))
  (=> (Reshape F)
      (Admissible F))))

; Reshaping may not change standing
(assert (forall ((F Operation) (i Agent))
  (=> (Reshape F)
      (= (sigma (apply F i))
         (sigma i)))))

; -----------------------------
; Downward Ratcheting (Restriction)
; -----------------------------

; Reshaping may remove affordances to eliminate conflict
(assert (forall ((F Operation) (c Context))
  (=> (and (Reshape F)
           Conflict)
      (ContextAdmissible c))))

; -----------------------------
; Symmetric Space Reshaping
; -----------------------------

; Reshaping may introduce new contexts
; such that incompatible affordances no longer collide
(assert (forall ((F Operation) (a Affordance) (i1 Agent) (i2 Agent))
  (=> (and (Reshape F)
           Conflict)
      (exists ((c1 Context) (c2 Context))
        (and (ContextAdmissible c1)
             (ContextAdmissible c2)
             (Enables c1 a i1)
             (Enables c2 a i2)
             (not (= c1 c2)))))))

; -----------------------------
; No Privileging
; -----------------------------

; Reshaping must preserve symmetry
(assert (forall ((F Operation) (i1 Agent) (i2 Agent))
  (=> (Reshape F)
      (= (sigma (apply F i1))
         (sigma (apply F i2))))))

; -----------------------------
; Exit Preservation
; -----------------------------

; Conflict resolution must not foreclose exit
(assert
  (=> Conflict
      (exists ((F Operation))
        (Exit F))))

; ============================================================
; CHECK
; ============================================================

(check-sat)

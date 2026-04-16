(set-logic AUFLIA)

(include "StandingAlgebraFullCore.smt2")

; ============================================================
; Standing Algebra Σᴿ — Adapter / Observation / Evidence Regime
; ============================================================
;
; DEPENDENCY:
; This file MUST be loaded AFTER:
;   StandingAlgebraFullCore.smt2
;
; It assumes the existence of:
;   - sorts: Agent, Operation
;   - functions: sigma, apply
;   - predicates: Admissible, Legitimate
;
; ============================================================

; -----------------------------
; Sorts
; -----------------------------

(declare-sort Adapter 0)
(declare-sort Claim 0)
(declare-sort Observation 0)

; -----------------------------
; Functions
; -----------------------------

; Adapter produces claims from observations
(declare-fun observe (Adapter Agent) Observation)
(declare-fun interpret (Adapter Observation) Claim)

; Claims may be referenced by operations
(declare-fun usesClaim (Operation Claim) Bool)

; -----------------------------
; Predicates
; -----------------------------

; Evidence marks diagnostic information
(declare-fun Evidence (Claim) Bool)

; Authority marks illegitimate justificatory power
(declare-fun Authority (Claim) Bool)

; -----------------------------
; Structural Constraints
; -----------------------------

; Claims are not truth-valued
; (No truth predicate is defined by design)

; Evidence and Authority are mutually exclusive
(assert (forall ((c Claim))
  (not (and (Evidence c) (Authority c)))))

; Claims default to evidence, never authority
(assert (forall ((c Claim))
  (=> (not (Authority c))
      (Evidence c))))

; -----------------------------
; No Claim May Authorize Admissibility
; -----------------------------

; Claims may not imply admissibility of operations
(assert (forall ((F Operation) (c Claim))
  (=> (usesClaim F c)
      (not (Authority c)))))

; No operation becomes admissible solely due to claims
(assert (forall ((F Operation) (c Claim))
  (=> (and (usesClaim F c)
           (Authority c))
      (false))))

; -----------------------------
; Observations Are Structurally Neutral
; -----------------------------

; Observations do not alter standing directly
(assert (forall ((A Adapter) (i Agent))
  (= (sigma i)
     (sigma i))))

; -----------------------------
; Adapter Non-Domination
; -----------------------------

; Adapters may not reduce standing
(assert (forall ((A Adapter) (i Agent))
  (>= (sigma i)
      (sigma i))))

; Adapters may not increase standing
(assert (forall ((A Adapter) (i Agent))
  (<= (sigma i)
      (sigma i))))

; (Standing is invariant under observation)

; -----------------------------
; Symmetry of Observation
; -----------------------------

; Observations must not be agent-asymmetric
(assert (forall ((A Adapter) (i1 Agent) (i2 Agent))
  (= (observe A i1)
     (observe A i2))))

; -----------------------------
; Adapter Output Cannot Persist Leverage
; -----------------------------

; Claims may not persist standing change across operations
(assert (forall ((F Operation) (c Claim) (i Agent))
  (=> (usesClaim F c)
      (= (sigma (apply F i))
         (sigma i)))))

; -----------------------------
; CHECK
; -----------------------------

(check-sat)

module

public import ICG.ComparativeAnalysis

@[expose] public section

namespace ICG

universe u v w x y z

/-- A measurement model maps latent architectures to observed records. -/
structure MeasurementModel (Architecture : Type u) (Observation : Type v) where
  observe : Architecture → Observation

namespace MeasurementModel

variable {Architecture : Type u} {Observation : Type v}
  (model : MeasurementModel Architecture Observation)

def ObservationallyEquivalent (left right : Architecture) : Prop :=
  model.observe left = model.observe right

/-- A quantity is identifiable exactly when it is constant on every fiber of
the measurement map. -/
def Identifiable {Quantity : Type w} (quantity : Architecture → Quantity) : Prop :=
  ∀ left right, model.observe left = model.observe right →
    quantity left = quantity right

theorem identifiable_of_injective_observation {Quantity : Type w}
    (quantity : Architecture → Quantity)
    (hinjective : ∀ left right, model.observe left = model.observe right →
      left = right) :
    model.Identifiable quantity := by
  intro left right hobservations
  rw [hinjective left right hobservations]

theorem identifiable_iff_constant_on_fibers {Quantity : Type w}
    (quantity : Architecture → Quantity) :
    model.Identifiable quantity ↔
      ∀ left right, model.ObservationallyEquivalent left right →
        quantity left = quantity right :=
  Iff.rfl

/-- Architectures compatible with one observed record form a fiber, not
necessarily a singleton. -/
def compatibleArchitectures (observation : Observation) : Set Architecture :=
  {architecture | model.observe architecture = observation}

/-- Propagate architectural uncertainty by taking the image of the entire
admissible family under the quantity of interest. -/
def propagatedValues {Quantity : Type w}
    (quantity : Architecture → Quantity) (architectures : Set Architecture) :
    Set Quantity :=
  quantity '' architectures

theorem propagatedValues_membership_iff {Quantity : Type w}
    (quantity : Architecture → Quantity) (architectures : Set Architecture)
    (value : Quantity) :
    value ∈ propagatedValues quantity architectures ↔
      ∃ architecture, architecture ∈ architectures ∧
        quantity architecture = value := by
  simp [propagatedValues, eq_comm]

/-- An exact estimator cannot recover distinct target values from identical
observations. -/
theorem no_exact_estimator_for_nonidentifiable_quantity
    {Quantity : Type w} (quantity : Architecture → Quantity)
    (left right : Architecture)
    (sameObservation : model.observe left = model.observe right)
    (differentQuantities : quantity left ≠ quantity right) :
    ¬ ∃ estimator : Observation → Quantity,
      ∀ architecture, estimator (model.observe architecture) =
        quantity architecture := by
  rintro ⟨estimator, exact⟩
  apply differentQuantities
  calc
    quantity left = estimator (model.observe left) := (exact left).symm
    _ = estimator (model.observe right) := congrArg estimator sameObservation
    _ = quantity right := exact right

theorem nonidentifiable_precludes_unique_architecture_estimation
    (left right : Architecture)
    (sameObservation : model.observe left = model.observe right)
    (differentArchitectures : left ≠ right) :
    ¬ ∃ estimator : Observation → Architecture,
      ∀ architecture, estimator (model.observe architecture) = architecture :=
  model.no_exact_estimator_for_nonidentifiable_quantity
    (fun architecture => architecture) left right sameObservation
    differentArchitectures

end MeasurementModel

/-- Provenance and missingness metadata remain attached to each observation
instead of being silently discarded during analysis. -/
structure MeasurementDatum (Observation : Type u) (Time : Type v)
    (Context : Type w) (Provenance : Type x) (Missingness : Type y)
    (ReviewState : Type z) where
  value : Observation
  time : Time
  context : Context
  provenance : Provenance
  missingness : Missingness
  reviewState : ReviewState

/-- A transformation rule carries a proof that it preserves the declared
validity predicate. -/
structure SoundAuditRule (Conclusion : Type u) (Valid : Conclusion → Prop) where
  apply : Conclusion → Conclusion
  preservesValidity : ∀ conclusion, Valid conclusion → Valid (apply conclusion)

/-- A finite derivation chain starts at interpreted observation and records
validity-preserving rules at every subsequent step. -/
inductive AuditDerivation (Observation : Type u) (Conclusion : Type v)
    (interpret : Observation → Conclusion) (Valid : Conclusion → Prop) :
    Conclusion → Type (max u v)
  | observed (observation : Observation)
      (evidenceValid : Valid (interpret observation))
      : AuditDerivation Observation Conclusion interpret Valid
          (interpret observation)
  | transformed {conclusion : Conclusion}
      (rule : SoundAuditRule Conclusion Valid)
      (prior : AuditDerivation Observation Conclusion interpret Valid conclusion)
      : AuditDerivation Observation Conclusion interpret Valid
          (rule.apply conclusion)

namespace AuditDerivation

variable {Observation : Type u} {Conclusion : Type v}
  {interpret : Observation → Conclusion}
  {Valid : Conclusion → Prop}

def depth : {conclusion : Conclusion} →
    AuditDerivation Observation Conclusion interpret Valid conclusion → Nat
  | _, .observed _ _ => 0
  | _, .transformed _ prior => prior.depth + 1

theorem depth_nonnegative {conclusion : Conclusion}
    (derivation : AuditDerivation Observation Conclusion interpret Valid conclusion) :
    0 ≤ derivation.depth := Nat.zero_le _

theorem sound {conclusion : Conclusion}
    (derivation : AuditDerivation Observation Conclusion interpret Valid conclusion) :
    Valid conclusion := by
  induction derivation with
  | observed _ evidenceValid =>
      exact evidenceValid
  | transformed rule _ ih =>
      exact rule.preservesValidity _ ih

end AuditDerivation

/-- A coarse measurement can leave distinct latent architectures
observationally indistinguishable. -/
def coarseArchitectureMeasurement : MeasurementModel Bool Unit where
  observe := fun _ => ()

theorem coarse_measurement_is_noninjective :
    coarseArchitectureMeasurement.observe false =
        coarseArchitectureMeasurement.observe true ∧
      false ≠ true := by
  exact ⟨rfl, by decide⟩

theorem coarse_measurement_cannot_recover_architecture :
    ¬ ∃ estimator : Unit → Bool,
      ∀ architecture,
        estimator (coarseArchitectureMeasurement.observe architecture) =
          architecture := by
  exact MeasurementModel.nonidentifiable_precludes_unique_architecture_estimation
      coarseArchitectureMeasurement
      false true rfl (by decide)

end ICG

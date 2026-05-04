import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Structural Interfaces (Signature Closure)
###############################################################################

This file centralizes *all* cross-layer structural interface symbols used by
SigmaR valuation layers:

• WellFormedness
• MeasurementLimits
• Relevance / Framing
• AntiOptimization
• Equivalence
• NonComparability
• Independence (ALL inference firewalls)
• Monotonicity (ALL structural and contract predicates)
• Admissibility (ALL permission-to-reason predicates)
• ResponseSemantics (ALL response structure and firewalls)

This is a **pure signature file**:
• no axioms
• no theorems
• no definitions

Its sole purpose is to make *all inference, evolution, permission,
and response boundaries explicit and reviewable*.
Nothing here asserts truth, causation, legitimacy, optimization,
authority, obligation, or necessity.
###############################################################################
-/

namespace SigmaR

/-!
------------------------------------------------------------------------------
0. Canonical type aliases
------------------------------------------------------------------------------
-/

abbrev Val : Type := Nat
abbrev Measure : Type := Agent → State → Val
abbrev PredAS : Type := Agent → State → Prop
abbrev PredS  : Type := State → Prop
abbrev Obj    : Type := State → Val

/-!
------------------------------------------------------------------------------
1. WellFormedness interfaces
------------------------------------------------------------------------------
-/

constant WellFormed : Measure → Prop
constant IsMeasure : Measure → Prop

constant ContextBound : Measure → Prop
constant IsGlobalScope : Measure → Prop
constant IsLocalScope : Measure → Prop

constant RestrictsDomain : Measure → Prop
constant StructurallyConstant : Measure → Prop

constant CompatibleDomainCodomain : Measure → Measure → Prop
constant DependsOn : Measure → Measure → Prop

constant Project : Measure → Measure
constant Restrict : Measure → PredAS → Measure

/-!
------------------------------------------------------------------------------
2. Cross-layer meta predicates (blocked by WellFormedness)
------------------------------------------------------------------------------
-/

constant TrueMeasure : Measure → Prop
constant ValidMeasure : Measure → Prop
constant LegitimateMeasure : Measure → Prop
constant ConstrainsInterpretation : Measure → Prop

/-!
------------------------------------------------------------------------------
3. Monotonicity: core ordering
------------------------------------------------------------------------------
-/

constant StateLe : State → State → Prop

/-!
------------------------------------------------------------------------------
4. MeasurementLimits interfaces
------------------------------------------------------------------------------
-/

constant Observable : Agent → State → Prop
constant Measured : Agent → State → Val

constant PerfectMeasurement : Agent → State → Prop
constant Noisy : Agent → State → Prop
constant Error : Agent → State → Prop

constant Understands : Agent → State → Prop
constant Controls : Agent → State → Prop

constant Optimizes : Obj → Prop

constant Causes : State → State → Prop
constant StateExists : PredS

constant MeasurementLimited : Agent → State → Prop
constant ConstrainsState : PredS

constant SystemInvalid : Prop
constant Failure : PredS

/-!
------------------------------------------------------------------------------
5. Relevance / Frame interfaces
------------------------------------------------------------------------------
-/

constant IPFA : Agent → State → Prop
constant PFA : Set Agent → State → Prop

constant Frame : Type
constant ObservableInFrame : Agent → Frame → State → Prop
constant FrameSucc : Frame → Frame → Prop

/-!
------------------------------------------------------------------------------
6. AntiOptimization interfaces
------------------------------------------------------------------------------
-/

constant GlobalObjective : Obj → Prop
constant GeneratedFromMeasure : Obj → Measure → Prop
constant TargetsMeasure : Obj → Measure → Prop

constant AggregatesFromMeasure : Obj → Measure → Prop
constant Scalarizes : Set Measure → Obj → Prop

constant Compensates : Measure → Measure → Prop
constant TradeoffJustifies : Measure → Measure → Prop
constant ProxiesFor : Measure → Measure → Prop
constant InducesRanking : Measure → Prop

constant TreatedAsUtility : Measure → Prop
constant TreatedAsWelfare : Measure → Prop
constant InterpretedAsImprovement : Measure → Prop

constant Converges : Measure → Prop
constant HasEquilibrium : Measure → Prop
constant HasFixedPoint : Measure → Prop
constant GuaranteesProgress : Measure → Prop
constant AssumesSelection : Measure → Prop

constant GamesMetric : Obj → Measure → Prop

/-!
------------------------------------------------------------------------------
7. Equivalence interfaces
------------------------------------------------------------------------------
-/

constant EquivalentMeasures : Measure → Measure → Prop
constant EquivalenceInducesOrdering : Measure → Measure → Prop

constant EquivalenceContext : Type
constant EquivalentInContext :
  EquivalenceContext → Measure → Measure → Prop

/-!
------------------------------------------------------------------------------
8. NonComparability interfaces
------------------------------------------------------------------------------
-/

constant NonComparable : Measure → Measure → Prop
constant BalancedAgainst : Measure → Measure → Prop

constant TreatedAsIgnorance : Measure → Measure → Prop
constant TreatedAsInaction : Measure → Measure → Prop

constant NonComparabilityContext : Type
constant NonComparableInContext :
  NonComparabilityContext → Measure → Measure → Prop

/-!
------------------------------------------------------------------------------
9. Independence misuse predicates
------------------------------------------------------------------------------
-/

-- Autonomy misuses
constant TreatedAsAutonomyFromStandingMeasure : Agent → State → Prop
constant TreatedAsAutonomyFromRoleState : Agent → State → Prop
constant TreatedAsAutonomyFromExitViable : Agent → State → Prop
constant TreatedAsAutonomyLostFromRiskLoad : Agent → State → Prop
constant TreatedAsAutonomyLostFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsAutonomyLostFromExitCollapse : Agent → State → Prop
constant TreatedAsAutonomyLostFromRiskInheritance : Agent → State → Prop
constant TreatedAsAutonomyFromDominationPressure : Agent → State → Prop

-- Capacity misuses
constant TreatedAsCapacityFromStandingMeasure : Agent → State → Prop
constant TreatedAsCapacityFromRoleState : Agent → State → Prop
constant TreatedAsCapacityFromExitViable : Agent → State → Prop
constant TreatedAsCapacityLostFromRiskLoad : Agent → State → Prop
constant TreatedAsCapacityLostFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsCapacityLostFromExitCollapse : Agent → State → Prop
constant TreatedAsCapacityLostFromRiskInheritance : Agent → State → Prop
constant TreatedAsCapacityLostFromDominationPressure : Agent → State → Prop

-- Consent misuses
constant TreatedAsConsentFromStandingMeasure : Agent → State → Prop
constant TreatedAsConsentFromRoleState : Agent → State → Prop
constant TreatedAsConsentFromExitViable : Agent → State → Prop
constant TreatedAsConsentInvalidFromRiskLoad : Agent → State → Prop
constant TreatedAsConsentInvalidFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsConsentInvalidFromExitCollapse : Agent → State → Prop
constant TreatedAsConsentInvalidFromRiskInheritance : Agent → State → Prop
constant TreatedAsConsentInvalidFromDominationPressure : Agent → State → Prop

-- Standing misuses
constant TreatedAsStandingFromRoleState : Agent → State → Prop
constant TreatedAsStandingFromExitViable : Agent → State → Prop
constant TreatedAsStandingFromRiskInheritance : Agent → State → Prop
constant TreatedAsStandingFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsStandingRevokedFromStructuralDebt : Agent → State → Prop
constant TreatedAsStandingRevokedFromExitCollapse : Agent → State → Prop
constant TreatedAsStandingRevokedFromDominationPressure : Agent → State → Prop

-- Structural debt misuses
constant TreatedAsStructuralDebtFromRiskLoad : Agent → State → Prop
constant TreatedAsStructuralDebtFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsStructuralDebtFromExitCollapse : Agent → State → Prop
constant TreatedAsStructuralDebtFromDominationPressure : Agent → State → Prop
constant TreatedAsStructuralDebtResolvedFromStandingMeasure : Agent → State → Prop
constant TreatedAsStructuralDebtResolvedFromRoleState : Agent → State → Prop

-- Exit viability / collapse misuses
constant TreatedAsExitViableFromStandingMeasure : Agent → State → Prop
constant TreatedAsExitViableFromRoleState : Agent → State → Prop
constant TreatedAsExitViableFromRiskLoad : Agent → State → Prop
constant TreatedAsExitViableFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsExitViableResolvedFromStructuralDebt : Agent → State → Prop
constant TreatedAsExitViableLostFromDominationPressure : Agent → State → Prop

constant TreatedAsExitCollapseFromStandingMeasure : Agent → State → Prop

-- Risk misuses
constant TreatedAsRiskFromStandingMeasure : Agent → State → Prop
constant TreatedAsRiskFromRoleState : Agent → State → Prop
constant TreatedAsRiskFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsRiskFromStructuralDebt : Agent → State → Prop
constant TreatedAsRiskFromDominationPressure : Agent → State → Prop
constant TreatedAsRiskFromExitViable : Agent → State → Prop

-- Temporal accumulation misuses
constant TreatedAsTemporalAccumulationFromStandingMeasure : Agent → State → Prop
constant TreatedAsTemporalAccumulationFromRiskLoad : Agent → State → Prop
constant TreatedAsTemporalAccumulationFromStructuralDebt : Agent → State → Prop
constant TreatedAsTemporalAccumulationFromExitViable : Agent → State → Prop
constant TreatedAsTemporalAccumulationResolvedFromRoleState : Agent → State → Prop

-- Domination pressure misuses
constant TreatedAsDominationPressureFromStandingMeasure : Agent → State → Prop
constant TreatedAsDominationPressureFromRiskLoad : Agent → State → Prop
constant TreatedAsDominationPressureFromStructuralDebt : Agent → State → Prop
constant TreatedAsDominationPressureFromExitViable : Agent → State → Prop
constant TreatedAsDominationPressureFromTemporalAccumulation : Agent → State → Prop

/-!
------------------------------------------------------------------------------
10. Monotonicity interfaces
------------------------------------------------------------------------------
-/

constant StructurallyMonotone : Measure → Prop
constant StructurallyAntitone : Measure → Prop

constant UpperBounded : Measure → Prop
constant Irreversible : Measure → Prop
constant RequiresEnablingStructure : Measure → Prop

constant MonotoneUnder : Measure → Measure → Prop
constant AntitoneUnder : Measure → Measure → Prop

constant MonotonicityIsContextual : Prop
constant MonotonicityRequiresScope : Prop
constant MonotonicityIsNonCausal : Prop
constant MonotonicityDoesNotGuaranteePersistence : Prop
constant MonotonicityAllowsNonTotalOrder : Prop
constant MonotonicityRespectsIndependence : Prop

/-!
------------------------------------------------------------------------------
11. Admissibility interfaces
------------------------------------------------------------------------------
-/

constant AdmissibleConfiguration : Prop
constant AdmissibleMeasure : Measure → Prop
constant AdmissibleMeasureSet : Set Measure → Prop
constant AdmissibleInference : Prop
constant AdmissibleComparison : Measure → Measure → Prop
constant AdmissibleEvolution : Measure → Prop
constant AdmissibleIrreversibility : Measure → Prop

constant AdmissibleUnderWellFormedness : Prop
constant AdmissibleUnderIndependence : Prop
constant AdmissibleUnderMonotonicity : Prop
constant AdmissibleMeasureUsage : Measure → Prop
constant AdmissibleContextBinding : Prop
constant AdmissibleFrame : Frame → Prop
constant AdmissibleAgentPerspective : Agent → Prop

constant AdmissibilityDoesNotImplyTruth : Prop
constant AdmissibilityDoesNotImplyValidity : Prop
constant AdmissibilityDoesNotImplyLegitimacy : Prop
constant AdmissibilityDoesNotImplyAuthority : Prop
constant AdmissibilityDoesNotImplyIntervention : Prop

constant AdmissibilityScope : Prop
constant AdmissibilityContract : Prop

/-!
------------------------------------------------------------------------------
12. ResponseSemantics interfaces
------------------------------------------------------------------------------
-/

-- Core response entities
constant Response : Type
constant ResponseSet : Type
constant ResponseKind : Response → Prop

-- Response–state relations
constant ResponsePrecondition : Response → State → Prop
constant ResponsePostcondition : Response → State → Prop
constant ResponseTransition : Response → State → State → Prop

-- Response effects on measures
constant ResponseAffectsMeasure : Response → Measure → Prop
constant ResponsePreservesMeasure : Response → Measure → Prop
constant ResponseAmplifiesMeasure : Response → Measure → Prop
constant ResponseDampensMeasure : Response → Measure → Prop
constant ResponseReversesMeasure : Response → Measure → Prop

-- Structural properties of responses
constant ResponseReversible : Response → Prop
constant ResponseIrreversible : Response → Prop
constant ResponseIdempotent : Response → Prop
constant ResponseComposable : Response → Response → Prop
constant ResponseInterfering : Response → Response → Prop

-- Response interaction & compliance
constant ResponseConflicts : Response → Response → Prop
constant ResponseOverrides : Response → Response → Prop
constant ResponseRequiresStructure : Response → Prop
constant ResponseAdmissible : Response → Prop
constant ResponseRespectsMonotonicity : Response → Prop
constant ResponseRespectsIndependence : Response → Prop

-- Response non-implication firewalls & contracts
constant ResponseDoesNotImplyAuthority : Prop
constant ResponseDoesNotImplyIntervention : Prop
constant ResponseDoesNotImplyLegitimacy : Prop
constant ResponseDoesNotImplyMorality : Prop
constant ResponseScope : Prop
constant ResponseSemanticsContract : Prop

/-!
------------------------------------------------------------------------------
13. DerivedValuations interfaces
------------------------------------------------------------------------------
-/

-- Core derived valuation entities
constant DerivedValuation : Type
constant ValuationFunction : Agent → State → DerivedValuation

-- Autonomy-specific derived valuation
constant AutonomyValuation : Type
constant AutonomyState : Agent → State → AutonomyValuation
constant AutonomyLevel : AutonomyValuation → Val

-- Structural dependencies of autonomy valuation
constant AutonomyDependsOnMeasure :
  AutonomyValuation → Measure → Prop
constant AutonomyDependsOnResponse :
  AutonomyValuation → Response → Prop
constant AutonomyDependsOnContext :
  AutonomyValuation → Prop

-- Aggregation semantics
constant ValuationAggregation :
  DerivedValuation → DerivedValuation → DerivedValuation → Prop
constant AutonomyAggregation :
  AutonomyValuation → AutonomyValuation → AutonomyValuation → Prop

-- Loss and degradation semantics
constant ValuationLoss :
  DerivedValuation → DerivedValuation → Prop
constant AutonomyLoss :
  AutonomyValuation → AutonomyValuation → Prop
constant AutonomyFragility :
  AutonomyValuation → Prop

-- Irreversibility and hysteresis
constant ValuationIrreversibility :
  DerivedValuation → Prop
constant AutonomyIrreversibility :
  AutonomyValuation → Prop
constant AutonomyHysteresis :
  AutonomyValuation → Prop

-- Response effects on valuation
constant ResponseAffectsValuation :
  Response → DerivedValuation → Prop
constant ResponseAffectsAutonomy :
  Response → AutonomyValuation → Prop

-- Thresholds and collapse
constant AutonomyThreshold :
  AutonomyValuation → Prop
constant AutonomyCollapse :
  AutonomyValuation → Prop

-- Comparability
constant ValuationComparable :
  DerivedValuation → DerivedValuation → Prop
constant AutonomyComparable :
  AutonomyValuation → AutonomyValuation → Prop

-- Compliance with prior layers
constant ValuationAdmissible :
  DerivedValuation → Prop
constant ValuationRespectsMonotonicity :
  DerivedValuation → Prop
constant ValuationRespectsIndependence :
  DerivedValuation → Prop

-- Derived valuation non-implication firewalls
constant ValuationDoesNotImplyLegitimacy : Prop
constant ValuationDoesNotImplyAuthority : Prop
constant ValuationDoesNotImplyIntervention : Prop
constant ValuationDoesNotImplyMorality : Prop

-- Scope and contract
constant ValuationScope : Prop
constant DerivedValuationsContract : Prop

/-!
------------------------------------------------------------------------------
14. StandingValuation interfaces
------------------------------------------------------------------------------
-/

-- Core standing valuation entities
constant StandingValuation : Type
constant StandingState :
  Agent → State → StandingValuation
constant StandingLevel :
  StandingValuation → Val

-- Structural dependencies of standing valuation
constant StandingDependsOnMeasure :
  StandingValuation → Measure → Prop
constant StandingDependsOnResponse :
  StandingValuation → Response → Prop
constant StandingDependsOnContext :
  StandingValuation → Prop

-- Aggregation semantics
constant StandingAggregation :
  StandingValuation → StandingValuation → StandingValuation → Prop

-- Loss and degradation semantics
constant StandingLoss :
  StandingValuation → StandingValuation → Prop
constant StandingFragility :
  StandingValuation → Prop

-- Irreversibility and hysteresis
constant StandingIrreversibility :
  StandingValuation → Prop
constant StandingHysteresis :
  StandingValuation → Prop

-- Thresholds and collapse
constant StandingThreshold :
  StandingValuation → Prop
constant StandingCollapse :
  StandingValuation → Prop

-- Comparability
constant StandingComparable :
  StandingValuation → StandingValuation → Prop

-- Response effects on standing valuation
constant ResponseAffectsStanding :
  Response → StandingValuation → Prop

-- Compliance with prior layers
constant StandingValuationAdmissible :
  StandingValuation → Prop
constant StandingRespectsMonotonicity :
  StandingValuation → Prop
constant StandingRespectsIndependence :
  StandingValuation → Prop

-- Standing valuation non-implication firewalls
constant StandingValuationDoesNotImplyLegitimacy : Prop
constant StandingValuationDoesNotImplyAuthority : Prop
constant StandingValuationDoesNotImplyIntervention : Prop
constant StandingValuationDoesNotImplyMorality : Prop

-- Scope and contract
constant StandingValuationScope : Prop
constant StandingValuationContract : Prop

/-!
------------------------------------------------------------------------------
15. CouplingValuation interfaces
------------------------------------------------------------------------------
-/

-- Core coupling valuation entities
constant CouplingValuation : Type
constant CouplingState :
  Agent → State → CouplingValuation
constant CouplingWeight : Type

-- Structural dependencies of coupling valuation
constant CouplingDependsOnMeasure :
  CouplingValuation → Measure → Prop
constant CouplingDependsOnResponse :
  CouplingValuation → Response → Prop
constant CouplingDependsOnContext :
  CouplingValuation → Prop

-- Aggregation semantics
constant CouplingAggregation :
  CouplingValuation → CouplingValuation → CouplingValuation → Prop

-- Loss propagation and modulation
constant CouplingLossPropagation :
  CouplingValuation → CouplingValuation → Prop
constant CouplingAmplification :
  CouplingValuation → CouplingValuation → Prop
constant CouplingDampening :
  CouplingValuation → CouplingValuation → Prop

-- Irreversibility and hysteresis
constant CouplingIrreversibility :
  CouplingValuation → Prop
constant CouplingHysteresis :
  CouplingValuation → Prop

-- Thresholds and collapse
constant CouplingThreshold :
  CouplingValuation → Prop
constant CouplingCollapse :
  CouplingValuation → Prop

-- Comparability
constant CouplingComparable :
  CouplingValuation → CouplingValuation → Prop

-- Response effects on coupling valuation
constant ResponseAffectsCoupling :
  Response → CouplingValuation → Prop

-- Compliance with prior layers
constant CouplingValuationAdmissible :
  CouplingValuation → Prop
constant CouplingRespectsMonotonicity :
  CouplingValuation → Prop
constant CouplingRespectsIndependence :
  CouplingValuation → Prop

-- Coupling valuation non-implication firewalls
constant CouplingDoesNotImplyLegitimacy : Prop
constant CouplingDoesNotImplyAuthority : Prop
constant CouplingDoesNotImplyIntervention : Prop
constant CouplingDoesNotImplyMorality : Prop

-- Scope and contract
constant CouplingValuationScope : Prop
constant CouplingValuationContract : Prop

/-!
------------------------------------------------------------------------------
16. ExitCostValuation interfaces
------------------------------------------------------------------------------
-/

-- Core exit cost valuation entities
constant ExitCostValuation : Type
constant ExitCostState :
  Agent → State → ExitCostValuation
constant ExitCostLevel :
  ExitCostValuation → Val

-- Structural dependencies of exit cost valuation
constant ExitCostDependsOnMeasure :
  ExitCostValuation → Measure → Prop
constant ExitCostDependsOnResponse :
  ExitCostValuation → Response → Prop
constant ExitCostDependsOnContext :
  ExitCostValuation → Prop

-- Aggregation and accumulation semantics
constant ExitCostAggregation :
  ExitCostValuation → ExitCostValuation → ExitCostValuation → Prop
constant ExitCostAccumulation :
  ExitCostValuation → ExitCostValuation → Prop

-- Loss and fragility semantics
constant ExitCostLoss :
  ExitCostValuation → ExitCostValuation → Prop
constant ExitCostFragility :
  ExitCostValuation → Prop

-- Irreversibility and hysteresis
constant ExitCostIrreversibility :
  ExitCostValuation → Prop
constant ExitCostHysteresis :
  ExitCostValuation → Prop

-- Thresholds and collapse
constant ExitCostThreshold :
  ExitCostValuation → Prop
constant ExitCostCollapse :
  ExitCostValuation → Prop

-- Comparability
constant ExitCostComparable :
  ExitCostValuation → ExitCostValuation → Prop

-- Response effects on exit cost valuation
constant ResponseAffectsExitCost :
  Response → ExitCostValuation → Prop

-- Compliance with prior layers
constant ExitCostValuationAdmissible :
  ExitCostValuation → Prop
constant ExitCostRespectsMonotonicity :
  ExitCostValuation → Prop
constant ExitCostRespectsIndependence :
  ExitCostValuation → Prop

-- Exit cost valuation non-implication firewalls
constant ExitCostDoesNotImplyLegitimacy : Prop
constant ExitCostDoesNotImplyAuthority : Prop
constant ExitCostDoesNotImplyIntervention : Prop
constant ExitCostDoesNotImplyMorality : Prop

-- Scope and contract
constant ExitCostValuationScope : Prop
constant ExitCostValuationContract : Prop

end SigmaR

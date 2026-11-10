Standing Algebra (Σᴿ)
Standing Algebra (Σᴿ) is a formally specified, mechanically verified admissibility framework for autonomy‑preserving transformations in multi‑agent systems. The framework is validated across Lean, Coq, and SMT‑LIB (Z3) and is explicitly designed to enforce non‑domination structurally, without optimization objectives, outcome selection, or internal authority.
Overview
Σᴿ is a many‑sorted first‑order logical system that formalizes standing, autonomy, dependency, and structural legitimacy. Rather than scoring or selecting outcomes, Σᴿ classifies which transformations are admissible under autonomy‑preserving constraints. The framework is intentionally non‑optimizing and admits multiple models, preventing collapse into utility maximization or proxy objectives.
The theory is organized in layers:
Formal Core Provides the axiomatic skeleton: successor‑based standing, non‑dilution, composite formation, dependency structure, and operational predicates.
Structural Legitimacy (Tier‑2) Encodes invariants such as capacity‑indexed autonomy (CIA), the autonomy‑limiting reflex (ALRP), non‑reciprocity prevention (NRPP), standing preservation (STC‑5), bounded drift, rerunnability, and directed repair.
Valuation Layer Introduces valuation measures (e.g. standing, capacity, risk inheritance, structural debt, exit conditions) strictly as structural witnesses, not objectives.
Independence Guarantees A dedicated Lean‑verified layer proves that valuation dimensions are definitionally independent. No measure (e.g. risk, consent, capacity, standing, debt, exit) collapses into or substitutes for any other. This blocks proxy metrics, consent laundering, and value collapse at the formal level.
Soundness & Satisfiability The full axiom stack admits non‑trivial models. SMT‑based validation (Z3) demonstrates the existence of admissible structures satisfying all invariants simultaneously, while Lean and Coq enforce proof‑level discipline.
What Σᴿ Is (and Is Not)
Σᴿ is:
a structural filter on transformations,
non‑probabilistic and non‑optimizing,
compatible with pluralist systems and asynchronous inputs,
suitable as a validation or constraint layer.
Σᴿ is not:
a utility function,
a policy selector or decision engine,
a moral theory or preference aggregator,
an empirical or statistical model.
Applications
Σᴿ is applicable wherever structural guarantees of non‑domination matter, including:
AI alignment and safety layers,
governance and institutional design,
distributed and multi‑agent systems,
organizational and coordination analysis.
Because Σᴿ constrains form rather than outcome, it can coexist with domain‑specific decision procedures while enforcing hard autonomy and non‑domination bounds.
Status
✔ Formal core verified in Lean and Coq
✔ Satisfiability demonstrated in Z3
✔ Valuation measures and independence guarantees enforced at the type and axiom level
✔ Deliberately scoped to avoid optimization, selection, or reward semantics

Goodhart Drift Monitor Prototype
--------------------------------
The repository includes a dependency-free Python monitor in
[`goodhart_monitor.py`](goodhart_monitor.py). It compares a configured proxy
trend with an independently supplied goal signal, emits evidence-bearing
`allow` / `hold` / `review` decisions, and exposes a `run_guarded` API that
does not execute an action unless the latest decision is `allow`.
[`workflow_control.py`](workflow_control.py) adds a fail-closed workflow
controller that blocks a step, pauses the workflow, and requests evidence-backed
human review; resumption requires a review reference. The included adapter is
dry-run only. A production integration must connect these controls to the
workflow platform and handle in-flight work. This prototype is not a drift-proof
system or safety certification; it cannot determine whether the supplied goal
signal represents the true objective. Usage and limitations are documented in
[`Collapse_Demonstrations/Goodhart_Drift/README.md`](Collapse_Demonstrations/Goodhart_Drift/README.md).

Standing Guard
--------------
[`standing_guard/`](standing_guard/README.md) turns that monitor into a drop-in
governor for a running system. `StandingGuard.wrap(system)` discovers the proxy
and the standing signal from the object's own numeric attributes or step
outputs, latches drift on the windowed proxy-up / standing-down pattern, and
then admits only standing-preserving scalings of the requested action, blocking
the step and asking for review when none is admissible. `guard.report()`
returns what drifted, what was attempted, and what the guard did about it.

The same statistic also guards streams of trials, where a step cannot be
rescaled because the trial already ran: `MetricStream("tests_passing",
"user_value")` flags each trial whose score rose while the independent signal
fell, and `AuditLog` writes the verdicts to a hash-chained JSONL log that
`standing-guard audit` can verify afterwards (exit 2 on flagged drift, 1 if the
log was altered). `python Standing_Guard_Audit_Demo.py` shows a run that reports
0.99 while the independent signal falls to 0.15.

It is standard library only and needs no configuration. Run
`python Standing_Guard_Demo.py` to see the guarded and unguarded runs side by
side. As with the monitor, the guard enforces the hypothesis of
`noGoodhartDrift_under_StandingAlgebra` empirically; it is not a proof that the
signal it measures is the true objective.

AI Policy Layer
---------------
[`standing_policy.py`](standing_policy.py) is a single-file, standard-library
policy layer for AI systems: copy the one file into a project and route the
model's proposed actions through it before they run. Unlike the monitor and the
guard, nothing is inferred here. The policy is declared: the proxy the AI is
rewarded for, the standing signals it must not spend, and the floors those
signals may not fall below.

```python
from standing_policy import Policy, StandingPolicy

policy = StandingPolicy(Policy.from_dict({
    "name": "assistant-tools",
    "proxy": {"name": "engagement", "direction": "maximize"},
    "standing": [{"name": "user_value", "floor": 0.35}],
}))

decision = policy.check(
    {"engagement": 0.71, "user_value": 0.52},
    {"action": "push_notifications", "scale": 1.0,
     "expected": {"engagement": 0.20, "user_value": 0.00},
     "evidence": "abtest-117"},
)
if decision.admitted:
    run(decision.action, scale=decision.scale)   # dampened when drift is latched
```

Every proposal must state its expected effect on each standing signal, so the
policy always has an explicit claim to test rather than a model's assurance. It
answers `allow`, `dampen` (admissible only at a reduced scale), `hold` (cannot be
evaluated, or evidence missing: fail closed) or `block` (a declared or measured
standing loss), with a reason code and the statistics behind it. The rules are
ordered and named: a declared standing decrease is blocked, a breached floor
admits only a declared repair, an undeclared standing effect is held, and latched
drift requires cited evidence and caps the scale.

For an agent loop, `@policy.tool()` wraps a function so it raises
`PolicyViolation` unless the call is admitted, `policy.system_prompt()` renders
the same policy as text for the model's system prompt, `policy.judge` accepts the
model's JSON directly, and a `ReceiptLog` writes every decision to a hash-chained
JSONL file that `python standing_policy.py verify` re-checks. The command line
screens one proposal (`screen`, exit 0 admissible, 2 held or blocked) so the same
policy can gate a CI step or a workflow runner:

```text
python Standing_Policy_Demo.py
python standing_policy.py prompt --policy policy.json
python standing_policy.py screen --policy policy.json --observation obs.json --proposal p.json
```

The layer enforces the hypothesis of `noGoodhartDrift_under_StandingAlgebra`
against signals you declare; it does not establish that those signals are the
true objective.

Interoperability Constraint Geometry (ICG)
------------------------------------------
`ICG.lean` is the aggregate import for the additive `ICG` Lean library. It builds on the original interaction-closure and polynomial/Nullstellensatz layer with generic formalizations of derivation structure, obstruction, envelope geometry, and dynamics.

The package currently includes:

| Module | Formalized content |
| --- | --- |
| `ConstraintClosure` | Interaction systems, inductive derivability, least stable closure, idempotence, and admissible-state monotonicity |
| `ClosureFiltration` | Finite interaction stages and equivalence between stage membership and finite derivability |
| `BoundaryInteraction` | Directed cross-system interactions, internal/boundary decomposition, combined-interaction decomposition, and boundary inclusion in closure |
| `ConstraintSemantics` | Constraint satisfaction, sound interaction rules, survivor stages, and preservation of satisfying states |
| `ClosureFiltrationArchitecture` | Justified survivor filtering, elimination witnesses, zero/unique/plural survivor trichotomy, and reopening after updated admissibility evidence |
| `FiniteFiltration` | Witness-accountable finite candidate filtering, per-stage elimination sets, explicit witness accounting for every strict reduction, strict cardinality decrease, a stabilization bound of at most the initial landscape cardinality, and a plural fixed-point example |
| `InteroperabilitySurface` | Constraint-defined positive and negative regions, neighborhood characterization and interior stability of the topological boundary, continuous-path boundary crossing, boundary fibers for latent realizations, surface coverage, compatibility localization, and certificates for induced architectures |
| `BoundaryGeometry` | Continuous surface-admissible transition trajectories, boundary-access certificates, reachable-boundary sets, and boundary corridors under an explicit path-connectedness hypothesis |
| `ConstraintArchitectureBridge` | Constraint-generated admissibility, classification-equivalent realizations, topological boundary transport under classification-preserving homeomorphisms, and agreement between the generic constraint boundary and `InteroperabilityGeometry` |
| `MinimalConstraintGeneration` | Existence of an inclusion-minimal finite subfamily generating a given boundary, invariance under adding universally satisfied constraints, and a witness that classifications need not uniquely identify their generating constraints |
| `AdmissibleReachability` | Finite transition-chain reachability, admissibility preservation, and equivalence classes under explicit admissibility-preservation and reversibility conditions |
| `BoundaryParticipation` | Local boundary reduction under a dominance condition, plus typed pressure/susceptibility and representation/legitimacy observables with explicit calibration assumptions |
| `UnifiedProjection` | A common state-space record for eight architectural coordinates, projection information refinement, and shared admissibility filtering for future trajectories |
| `ComparativeAnalysis` | Same-evidence analytical portfolios, conditional strict cross-projection filtering, joint trajectory admissibility, Pareto-survivor definitions, and a plural Pareto example |
| `MeasurementIdentifiability` | Measurement fibers, estimand identifiability, impossibility of exact estimation under observational equivalence, uncertainty propagation by image sets, and finite audit-trace structures |
| `ClosureCertificate` | Finite filtration lineage, witnessed eliminations, terminal admissibility and stability, residual preservation, and an explicitly separate winner-selection certificate |
| `FiltrationOperators` | Regime-relative witness filtering, elimination equivalence, contractive composition, pointwise and relational monotonicity conditions, fixed-point persistence, staged elimination, and endpoint/provenance separation |
| `EliminationWitnessArchitecture` | Sufficient, applicable, currently valid witness records; scope conservation; correction-driven reopening; redundant-witness persistence; and elimination-ledger reconstruction |
| `ClosurePreference` | Mechanism-typed structural preference, unwarranted-selector exclusion, survivor preservation without candidate ranking, and a witnessed example showing that faithful closure is not cardinality maximization |
| `ObstructionGeometry` | Derivation trees, leaves, ancestry, depth, interaction counts, mixed subsystem ancestry, and emergent consequences |
| `ObstructionClassification` | Internal/emergent strong obstruction and a separate weak-tension predicate |
| `ObstructionInvariants` | Earliest closure stage, minimum derivation-tree depth, and finite derivation-local boundary-density bounds and endpoint characterizations |
| `ObstructionInformation` | Derivation certificates and a concrete example where distinct histories share an outcome but retain different ancestry |
| `PolynomialConstraints` | Ideal derivations, polynomial closure, zero loci, and Mathlib's proved Nullstellensatz result |
| `EnvelopeGeometry` | Finite real envelopes, orthogonal projection, residual decomposition, best approximation, and Pythagorean identity |
| `DirectedPhaseGeometry` | Abstract directed separation/phase and Euclidean angle/cosine interfaces |
| `TrigonometricGeometry` | Alignment, trigonometric identity, and orthogonal residual results |
| `SupportGeometry` | Coordinate support, support bounds, sparsity size, and primitive derivation support |
| `RotationDynamics` | Isometric transport of geometric quantities and projection equivariance |
| `EnergyResonance` | Projection amplitude/energy decomposition and real linear resonance modes/spectrum |
| `DomainTransfer` | Transfer of derivations and closures under interaction-preserving maps |
| `AttractorDynamics` | Discrete orbits, invariant regions, fixed points, attractor interfaces, and parameterized evolution |

Build the full ICG aggregate with:

```text
lake build ICG
```

**Coverage boundary:** The library is not yet a complete formal transcription of every ICG definition, hypothesis, example, or theorem in the source. It covers selected core constructions across §§3.1–3.13, survivor monotonicity and witness-accountable finite stabilization in §§3.15.5–3.15.6, foundational surface definitions and boundary results from §§3.14.1–3.14.2, selected path-accessibility and boundary-corridor results from §3.14.3, selected constraint/boundary representation, finite reachability, and local boundary-reduction results from §3.14.4, selected projection/unification results from §3.14.5, conditional comparative and trajectory/Pareto results from §3.14.6, measurement-fiber identifiability and uncertainty propagation from §3.14.7, and operator, witness-certificate, and closure-preference results in §§3.15.3–3.15.8. The source's remaining §3.14 architectures and demonstrations and several results across §§3.15.1–3.15.8 still require source-by-source formalization. The §3.14.6 results formalize conditional structural filtering and Pareto survival; they do not establish comparative empirical superiority or operational gain for the organizational example. The §3.14.7 results formalize identifiability, information-loss, and audit-trace interfaces, not empirical measurement scales, estimator calibration, validation studies, missing-data mechanisms, governance, or implementation complexity. In §3.14.3, accessibility and boundary connectivity are represented by explicit continuous-path certificates; path-connectedness is required for corridors, since ordinary connectedness alone does not generally imply path-connectedness. The source's curvature and thickness quantities still need precise definitions and hypotheses before their sensitivity and robustness claims can be formalized. The boundary crossing theorem assumes a continuous path whose endpoints have opposite classifications; the boundary-fiber ambiguity result likewise requires an explicitly non-injective latent realization at a boundary point. `ConstraintArchitectureBridge` proves boundary transport for classification-preserving homeomorphisms and boundary agreement for the singleton-constraint model; it does not establish the source's additional invariant-preservation claims such as curvature, thickness, or dimensionality. `ClosurePreference` compares witness-based closure and selector behavior at the mechanism/landscape level; it does not establish every preservation-coordinate or dominance claim in the source. `BoundaryParticipation` formalizes boundary reduction only under an explicit local dominance implication; its pressure and legitimacy observables require declared scales/calibration assumptions because the source supplies no operational units. `UnifiedProjection` models the source's multiple lenses as coordinates of a common state and proves full-coordinate information refinement, but does not claim strict information gain without a separating example or a non-injectivity hypothesis. In particular, `InteroperabilitySurface` makes the unification theorem's five induction certificates explicit inputs; it does not claim to derive those certificates from the earlier modules. `ClosureCertificate` separates filtration lineage, witness-accountable exclusion, survivor admissibility, stability, residual preservation, and external selection; `EliminationWitnessArchitecture` formalizes witness sufficiency, scope, current validity, and reopening, but does not establish that every source example satisfies those requirements. `AdmissibleReachability` formalizes reachability as finite chains of reversible admissible transitions; it does not identify arbitrary connected regions with path-connected components. The phase normalization and general linear-isometry model are explicit mathematical choices; they should not be mistaken for proofs that every source-specific normalization or orientation-preserving rotation construction has been formalized. The boundary-density development is a finite derivation-tree realization of the interaction-participation ratio, not a claim that all source definitions of obstruction geometry have been matched. A green build establishes compilation, not proof completeness; repository axioms remain explicit model assumptions rather than derived theorems.

Repository-backed Continuity and Improvement
--------------------------------------------
This repository also contains an evidence-bearing continuity integration in
[`kernel/`](kernel/KERNEL_CURRENT.md), [`continuity/`](continuity/CURRENT_STATE.md),
[`learning/`](learning/FAILURE_SHAPES.md), and [`governance/`](governance/CHANGE_PROTOCOL.md).
Standing Algebra and ICG remain distinct peer frameworks. The integration does
not claim hidden model-state transfer, background autonomous improvement, or
behavioral identity; it records versioned repository changes and validation.

To resume work, read [`continuity/CONTEXT_BUNDLE.md`](continuity/CONTEXT_BUNDLE.md)
and verify it against [`continuity/CURRENT_STATE.md`](continuity/CURRENT_STATE.md),
the checkpoint and receipt manifests, and the live source files. Rebuild the
bounded bundle and run all local integrity checks with:

```text
python Scripts/build_context_bundle.py
python -m unittest discover -s Tests -v
python Scripts/check_links.py
python Scripts/verify_hashes.py
python Scripts/validate_continuity.py --release
```

Candidate process changes must follow
[`governance/CHANGE_PROTOCOL.md`](governance/CHANGE_PROTOCOL.md); failure
recovery uses [`continuity/FUTURE_FORENSICS.md`](continuity/FUTURE_FORENSICS.md).
The isolated [`continuity/CAPABILITY_GYM/`](continuity/CAPABILITY_GYM/README.md)
fixtures do not alter canonical framework state. Generate an initialized
checkpoint and integrity manifest only after recording observed receipts:

```text
python Scripts/make_checkpoint.py
```

The generator defaults to `initialized_candidate`. `--canonical` is available
only when every required validation receipt is explicitly passed; even then,
the checkpoint is partial while its listed source and product residuals remain
open. GitHub Actions for the new continuity workflow are not considered passed
until the workflow runs on a pushed commit. The accessible source audit found
no standalone ICG or UCK repository. The 24 user-supplied research documents
are preserved as original DOCX files and readable text extractions under
[`corpus/source-documents/`](corpus/README.md); whether they form the complete
canonical UCK corpus remains unresolved. See
[`continuity/OPEN_RESIDUALS.md`](continuity/OPEN_RESIDUALS.md) and
[`manifests/CORPUS_MANIFEST.yaml`](manifests/CORPUS_MANIFEST.yaml).

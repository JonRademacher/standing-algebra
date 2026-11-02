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

**Coverage boundary:** The library now spans the core algebraic and obstruction constructions (source §§2.1–2.15) and gives Lean models for the principal geometric topics (source §§3.1–3.13), but this is not yet a complete formal transcription of every section or theorem. The treatise's later ICG structure and closure–filtration chapters (§§3.14–3.15) introduce many further source-specific architectures, definitions, hypotheses, and results beyond the generic survivor-filtering and dynamics interfaces listed above. The phase normalization and general linear-isometry model are explicit mathematical choices; they should not be mistaken for proofs that every source-specific normalization or orientation-preserving rotation construction has been formalized. The boundary-density development is a finite derivation-tree realization of the interaction-participation ratio, not a claim that all source definitions of obstruction geometry have been matched. A green build establishes compilation, not proof completeness; existing `sorry` declarations and axioms elsewhere in the repository remain outside this package's scope.

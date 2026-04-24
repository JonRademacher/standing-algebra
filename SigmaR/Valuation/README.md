# Valuation Layer (Σᴿ)

## Purpose

The **Valuation** layer defines and verifies *state-level quantities* used by Σᴿ
(e.g. admissibility invariants, risk bounds, structural debt, and exit viability).

Valuation **measures** and **checks soundness**.
It does **not** authorize actions, resolve conflicts, or impose legitimacy.

This layer exists to ensure that quantities referenced by regimes,
justifications, and operations are:
- well-defined,
- successor-native,
- non-aggregative,
- and preserved under admissible change.

---

## What Valuation Is

The Valuation layer:

- Defines **structural measures** over states and agents
  (risk, debt, exit viability, domination pressure, etc.).
- Proves **soundness conditions**:
  - monotonicity,
  - boundedness,
  - coherence under composition and normalization.
- Acts as a **semantic bridge** between the Formal Core
  (axioms and predicates) and the Operations layer
  (actual transformations).

Valuation answers questions of the form:

> “Is this quantity meaningful, stable, and preserved under admissible operations?”

---

## What Valuation Is Not

Valuation does **not**:

- declare operations legitimate or illegitimate,
- select among alternatives,
- impose regimes or priorities,
- authorize enforcement,
- or prescribe what *should* be done.

Valuation has **no executable power**.
It cannot trigger an operation, forbid an operation, or justify coercion.


- The **Formal Core** defines what standing, capacity, and coupling *are*.
- **Valuation** ensures measurements over those concepts are coherent.
- **Regimes** constrain operations using those measurements.
- **Operations** are the only place where actions occur.

---

## Folder Structure

---

## Layer Position in Σᴿ

``
Valuation/
├── README.md
│
├── Core/
│   ├── AdmissibilityInvariant.lean
│   ├── ExitThresholdSoundness.lean
│   ├── DebtCoherence.lean
│   └── RiskBoundSoundness.lean
│
├── Measures/
│   ├── StructuralDebt_Definition.lean
│   ├── RiskLoad_Definition.lean
│   ├── ExitViability_Definition.lean
│   └── DominationPressure_Definition.lean   (optional / Σᴿ⁺)
│
├── WellFormedness/
│   ├── StandingWellDefined.lean
│   ├── DegreeWellDefined.lean
│   ├── CapacityWellDefined.lean
│   └── MeasureMonotonicity.lean
│
├── Soundness/
│   ├── ValuationPreservedUnderOperation.lean
│   ├── ValuationPreservedUnderComposition.lean
│   └── ValuationPreservedUnderNormalization.lean
│
└── Interfaces/
├── ValuationInterface.lean
└── ValuationToOperationsBridge.lean

---

## Core Valuation Files

The following files form the **valuation spine** and must remain
purely non-normative:

- `AdmissibilityInvariant.lean`  
  Ensures standing, capacity, and dependency invariants are preserved
  under admissible operations.

- `ExitThresholdSoundness.lean`  
  Ensures exit viability is well-defined, monotone, and non-vacuous.

- `DebtCoherence.lean`  
  Ensures structural debt accumulates and dissipates coherently
  (no phantom debt, no free repair).

- `RiskBoundSoundness.lean`  
  Ensures risk valuation is bounded, successor-native,
  and non-aggregative.

These files **do not** determine legitimacy.
They only guarantee that the quantities used elsewhere are meaningful.

---

## Design Constraints

The Valuation layer must satisfy the following constraints:

- **No authority**: valuation cannot compel or forbid action.
- **No aggregation**: no global optimization or summation.
- **No selection**: no ranking or preference among operations.
- **Successor-native**: all bounds and measures respect successor discipline.
- **Compositional safety**: valuation must survive operation sequencing.

Any file violating these constraints does not belong in Valuation.

---

## Relationship to Operations

Operations may **consult** valuation results,
but valuation may never **trigger** operations.

If no operation satisfies regime or operational constraints,
the correct behavior is defined in the Operations layer
(e.g. tragic acceptance / identity),
not here.

---

## Status

The Valuation layer is introduced **after** the Formal Core
and **before** Regimes and Operations.

At the point this README is added:
- Core semantics are frozen,
- Regimes and Operations are already closed,
- Valuation is the final semantic layer to be filled in
  before theorem development.

No theorems are proven here beyond soundness and preservation.

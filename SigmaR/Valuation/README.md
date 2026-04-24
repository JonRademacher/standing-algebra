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

---

## Layer Position in Σᴿ

``

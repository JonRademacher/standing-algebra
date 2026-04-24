# Valuation / Measures (Σᴿ)

## Purpose

The **Measures** sublayer of Valuation defines the *primitive diagnostic quantities*
used throughout Σᴿ, including:

- structural debt,
- risk exposure,
- exit viability,
- and domination pressure.

These quantities are **descriptive, not prescriptive**.

They do NOT:
- authorize action,
- determine legitimacy,
- select outcomes,
- or impose regimes.

They exist solely to ensure that references to “risk”, “debt”, “exit”, or “domination”
in later layers are mathematically well-defined and successor-native.

---

## Design Constraints (from the source material)

All measures in this folder satisfy the following constraints:

1. **Pure valuation**  
   Measures only record state; they do not trigger consequences.

2. **Successor-native**  
   All scalar measures use `Nat` and admit only successor-based reasoning.
   No subtraction, ratios, averages, or optimization appear.

3. **Non-aggregative**  
   There is no global utility, sum, maximum, or ranking.
   Measures are agent-relative and structural.

4. **Non-authorizing**  
   No file in this folder declares anything admissible, illegitimate,
   required, forbidden, or preferred.

5. **Source-faithful**  
   Every measure corresponds directly to concepts used in:
   - Standing Algebra (Σᴿ v6.x)
   - On Relevance
   with no added semantics.

---

## What Measures Are Used For

Measures defined here may later be:

- checked for **well-formedness**,
- proven **monotone or bounded** under admissible operations,
- referenced by **regimes** or **operations** as inputs to constraints.

All such use happens outside this folder.

---

## What Measures Are Not Used For

Measures are not:

- thresholds for action,
- criteria for legitimacy,
- optimization targets,
- or enforcement signals.

If a file introduces such behavior, it does not belong here.

---

## Files in This Folder

Each file defines exactly one primitive measure or closely related family
of measures, with only minimal invariants (e.g. non-negativity, decidability).

No dynamics, no composition, no regime logic appears here.

This folder is intentionally boring — and that is a feature.

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

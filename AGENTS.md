# Repository Agent Guide

Before substantive work, follow `.github/copilot-instructions.md` and rebuild
the relevant state from `continuity/CURRENT_STATE.md`,
`manifests/CURRENT_CHECKPOINT.yaml`, `continuity/OPEN_RESIDUALS.md`, and the
authoritative source files.

Standing Algebra Σᴿ (`SigmaR/`) and Interoperability Constraint Geometry ICG
(`ICG/`) are distinct peer frameworks. Preserve source, contributor, and
formalization provenance. The continuity integration is operational tooling,
not a claim that either framework proves the integration correct.

Run `python -m unittest discover -s Tests -v` and
`python Scripts/validate_continuity.py --release` for continuity changes. Run
the existing Lean, Coq, and Z3 workflows when their corresponding sources
change. Never promote a candidate checkpoint if required checks fail or their
receipts are unavailable.

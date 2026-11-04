# Project Graph

## Nodes

| Node | Identity and authority | Currentness | Relation |
|---|---|---|---|
| Standing Algebra Σᴿ | `https://github.com/JonRademacher/standing-algebra`; `SigmaR/`, root README, citation and attribution notice | Main source commit observed: `cbc4211baf0993d643e55398addabf9588120f3f`; Lean/Coq/Z3 Actions pass | Logical/relational framework; canonical source for Σᴿ |
| ICG | `ICG/` and `ICG.lean` in the same repository; manuscript snapshot `corpus/icg/Nullstellensatz_Via_SigmaR_and_ICG.txt` | Same repository commit as above; README explicitly documents partial coverage | Distinct geometric/algebraic peer framework; historically connected to Σᴿ |
| Unified Compatibility Kernel materials | User-provided package and prior continuity notes preserved under `corpus/kernel/` | Attachment snapshots; no standalone UCK repo or complete corpus found | Operational methodology source; does not replace either mathematical source |
| Continuity integration | This repository's `kernel/`, `continuity/`, `learning/`, `governance/`, scripts and workflows | Working-tree candidate at initialization | Tooling for reconstructable, evidence-bearing repository continuity |
| Non-Domination-Governance-Kernel | `https://github.com/JonRademacher/Non-Domination-Governance-Kernel` | Separate configured project; audit found derivative NDGK, not UCK/ICG; exact HEAD unconfirmed | Related but distinct implementation-derived project; source for cautionary continuity examples only |
| I2OS Structural Admissibility | `https://github.com/i2os-lab/I2OS-Structural-Admissibility` | Separate configured project; read-only audit found paper repo, not ICG | Not a source or dependency of ICG/UCK |
| Standing Algebra manuscript snapshot | `corpus/standing-algebra/Standing_Algebra_SigmaR.txt` | User-supplied session artifact; provenance hash in corpus manifest | Source claim/context, not automatically identical to current repo |

## Supported edges

- `Σᴿ --formalized_in--> SigmaR/` (repository paths and README).
- `ICG --formalized_in--> ICG/` (repository paths and README).
- `ICG --historically_connected_to--> Σᴿ` (ICG manuscript disclosure; does not imply equivalence).
- `continuity integration --uses_specification--> build package` (user instruction and preserved attachment).
- `continuity integration --uses_operational_notes--> prior Copilot continuity notes` (user-provided text artifact).
- `integration --records_sources_of--> Σᴿ, ICG, UCK materials` (this manifest and provenance files).
- `Non-Domination-Governance-Kernel --derived_from--> Σᴿ` (audited repository README; not a conclusion that it equals UCK).

No assertion is made that the UCK is mathematically derived from either source.

## Conflicts and missing lineage

- No accessible standalone ICG repository was found in the configured projects
  or `gh repo list JonRademacher`; current ICG files are an in-repository
  subtree.
- No standalone UCK repo was found. The package references additional transfer
  documents that are not physically present in the session file collection.
- The separate I2OS paper's README author and paper title page/bibliography do
  not agree; no I2OS content is promoted into the source graph.
- The Σᴿ manuscript snapshot and live formal source have different claim
  maturity; repository README scope and exact declarations govern formal
  status.

## Formalization-to-manuscript mapping

No comprehensive theorem-ID-to-Lean/Coq/Z3 crosswalk was found during audit.
ICG modules are described in the README and source code, but this is not a
verified per-theorem mapping. See residual `R-006`.

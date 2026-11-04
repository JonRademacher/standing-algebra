# Dependency Graph

Only consequence-bearing edges with an explicit source or witness are listed.

| From | To | Relation | Evidence / rule |
|---|---|---|---|
| `SigmaR/` declarations | Σᴿ Lean targets | compiled by | `.github/workflows/lean.yml` build command |
| `ICG/*.lean`, `ICG.lean` | ICG aggregate target | imported/built by | README build instructions and Lean workflow |
| Coq source files | Coq target | compiled by | `.github/workflows/coq.yml` commands |
| SMT-LIB files | Z3 checks | executed by | `.github/workflows/z3.yml` |
| `README.md` | ICG coverage boundary | documents | explicit coverage and caveats in repository README |
| source artifacts in `corpus/` | provenance records | preserved by | source inventory and SHA-256 manifest |
| canonical state | context bundle | summarizes | `Scripts/build_context_bundle.py` allowlisted inputs |
| checkpoint manifest | validators | input | continuity validation scripts and workflow |
| failure/discovery archives | candidate improvement proposal | informs | CHANGE_PROTOCOL and archive schemas |
| validation receipts | checkpoint promotion | required by | checkpoint schema and `release` validator |

## Edge admission rule

An edge requires a source path, workflow command, explicit rule, or labeled
reconstruction witness. Inference-only edges are marked as inference and must
not be used as source authority. Removing or changing an edge requires a
decision-log entry, updated affected nodes, and regression validation.

## Not inferred

- A Lean build is not a source-to-theorem proof map.
- A common constraint-first motivation is not a dependency between Σᴿ and ICG.
- The NDGK project is not treated as an UCK implementation.
- I2OS is not treated as ICG.
- The monitor's sample output is not evidence of production performance.

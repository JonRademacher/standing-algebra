# 08A — Lean baseline reproduction

## Objective

Reproduce a pinned Lean 4 / Mathlib formalization of Li's criterion and its normalization against the classical zero-sum coefficient.

## Required artifacts

- exact source repository URL and commit;
- `lean-toolchain`;
- `lake-manifest.json`;
- clean-cache build log;
- source scan for `sorry`, `admit`, forbidden axioms, and opaque escape routes;
- `#print axioms` output for the theorem of record;
- exact theorem names and definitions;
- dependency manifest and SHA-256 receipt.

## Commands

```bash
python scripts/reproduce_lean_baseline.py \
  --repo-url https://github.com/nicholasbulka/li-criterion-rh-equivalence-lean \
  --commit PIN_EXACT_COMMIT \
  --workdir receipts/li-baseline
```

Network access, Git, Elan, Lake, and the pinned Mathlib toolchain are required. The script refuses an unpinned commit.

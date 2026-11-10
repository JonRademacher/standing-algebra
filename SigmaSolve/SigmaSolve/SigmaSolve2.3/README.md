# ΣSolve

**A model-neutral, verifier-governed mathematical search layer.**

ΣSolve coordinates an AI agent, multiple proof candidates, Lean verification, localized repair, survivor preservation, and reproducible result bundles. It does **not** claim to turn every model into a frontier mathematical reasoner. Its purpose is to test which reasoning capabilities can be moved from model scale into explicit, inspectable search infrastructure.

## Current release

Version `0.1.0` is a complete vertical slice:

1. Load a structured problem contract.
2. Ask any compatible agent for several Lean proof candidates.
3. Write isolated Lean workspaces.
4. reject `sorry`, `admit`, and unsafe escape hatches.
5. Run Lean and classify diagnostics.
6. Preserve candidates and elimination evidence in an append-only ledger.
7. Repair localized failures under a bounded budget.
8. replay a successful proof in a clean directory.
9. emit a result bundle with SHA-256 receipts.

The included deterministic mock agent makes the package testable without an API key or network connection.

## Install

```bash
cd SigmaSolve
python -m pip install -e .
```

Optional development tools:

```bash
python -m pip install -e ".[dev]"
```

Lean verification requires `lake` or `lean` on `PATH`. The repository's existing `lean-toolchain` and `lakefile.lean` may be referenced from a problem contract.

## Quick start without Lean

This validates orchestration, branch accounting, and result packaging:

```bash
sigmasolve solve examples/mock_success.json --agent mock --no-verify
```

## Solve with Lean

```bash
sigmasolve solve examples/nat_add_zero.json --agent mock
```

Or use an OpenAI-compatible endpoint:

```bash
export SIGMASOLVE_API_KEY="..."
sigmasolve solve examples/nat_add_zero.json \
  --agent openai-compatible \
  --base-url https://api.example.com/v1 \
  --model your-model
```

## Experiment matrix

```bash
sigmasolve benchmark benchmarks/smoke.json --agent mock --no-verify
```

The benchmark runner emits per-problem results and a summary. Use the same model, problem set, and resource budget for fair comparisons among:

- C0: agent alone
- C1: agent plus raw verifier feedback
- C2: ordinary retry loop
- C3: ΣSolve survivor-preserving search

Only C3 is implemented in this release; the benchmark schema reserves all four conditions.

## Terminal states

- `PROVED`
- `DISPROVED`
- `COUNTEREXAMPLE_FOUND`
- `FORMALIZATION_UNRESOLVED`
- `PREMISE_MISSING`
- `REPRESENTATION_MISMATCH`
- `VERIFIER_UNAVAILABLE`
- `VERIFIER_TIMEOUT`
- `SEARCH_BUDGET_EXHAUSTED`
- `PARTIAL_LEMMAS_VERIFIED`
- `UNRESOLVED`

## Design invariants

- **No verifier, no proof claim.** `PROVED` requires successful clean replay unless verification is explicitly disabled for orchestration testing.
- **Failure is localized.** A failed candidate does not eliminate the theorem or unrelated branches.
- **Selection is not elimination.** Search scheduling may prefer a branch, but alternatives remain in the ledger unless an evidence-bearing elimination applies.
- **No unsafe Lean escapes.** `sorry`, `admit`, `unsafe`, `axiom`, and related bypasses are rejected by default.
- **Exact objective preservation.** The theorem name, declaration, imports, and completion contract remain attached to every candidate.
- **Reproducibility.** Every run emits inputs, candidate history, diagnostics, environment data, and SHA-256 hashes.

## Repository integration

Place this directory at `standing-algebra/SigmaSolve/`. ΣSolve is additive and does not modify the existing Lean, Coq, Z3, or Python baseline.

## Honest status

This is an experimental solver substrate. Version 0.1 establishes an executable and testable architecture. It does not establish cross-model uplift, model-scale substitution, mathematical novelty, or superiority to LeanDojo, AlphaProof, or other theorem-proving systems. Those are benchmark questions.

See `docs/ARCHITECTURE.md`, `docs/EXPERIMENTS.md`, `docs/SECURITY.md`, and `docs/LIMITATIONS.md`.

## Version 0.2 research runtime

Run a capability audit:

```bash
sigmasolve doctor --output capabilities.json
```

Build the isolated Lean-capable runtime:

```bash
docker build -t sigmasolve:0.2.0 .
docker run --rm sigmasolve:0.2.0 doctor
```

Index a Lean repository:

```bash
sigmasolve index ../ --symbol RiemannHypothesis --output dependencies.json
```

Use optional research backends:

```bash
python -m pip install -e ".[research]"
sigmasolve research symbolic "expand((x + 1)**5)"
sigmasolve research z3 examples/z3_counterexample.smt2
sigmasolve research zeta-scan 0 --end 100 --steps 100
```

Research backend output is typed by scope. Numerical scans and symbolic checks are evidence generators, not automatic formal proofs.

## Integrated GEGA methodology (v0.4)

```bash
sigmasolve methodology-review examples/methodology_rh.json --output methodology-result.json
```

The methodology review is a control plane. It preserves provenance, epistemic type, survivors, residuals, and execution state; it never substitutes methodology for mathematical verification.

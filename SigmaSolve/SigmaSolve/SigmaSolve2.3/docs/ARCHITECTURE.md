# Architecture

ΣSolve separates four kinds of state:

1. **Objective state**: the exact theorem and declared evidence contract.
2. **Search state**: candidate branches, parents, strategies, and resource allocation.
3. **Evidence state**: verifier outputs, counterexamples, and elimination witnesses.
4. **Continuity state**: verified fragments, residuals, and conditions under which branches can reopen.

## Core loop

`ProblemContract → propose → verify → classify → repair → replay → receipt`

Candidate selection schedules computation. It does not silently establish falsehood or eliminate alternatives. A candidate is eliminated only relative to a witnessed reason such as a forbidden proof escape or a verifier rejection of the exact generated program. Even then, the rejected candidate is not evidence that the target theorem is false.

## Trust boundary

The AI agent is untrusted. The orchestration code is fallible. `PROVED` is reserved for a Lean-accepted proof that survives clean replay under the declared imports and toolchain. Result bundles preserve the exact generated proof and diagnostics.

## Extension points

- `AgentAdapter`: provider or local-agent integration.
- `LeanVerifier`: future verifier interface can add Coq, Z3, Isabelle, or executable evaluators.
- failure classifier: domain-specific diagnostic typing.
- search scheduler: bounded portfolio, MCTS, evolutionary search, or learned policy.
- theorem memory: retrieval of verified lemmas and failed configurations.

Version 0.1 intentionally keeps scheduling simple so future gains can be measured through ablation rather than assumed.

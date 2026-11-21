# Break Sigma-R v12

Please do not review Sigma-R by agreeing with its README. Try to break the implementation.

This repository makes a deliberately bounded claim: the v12 wrapper should preserve the separation

`proposal != evidence != admissibility != authority != execution`

and fail closed when its adapter cannot reconstruct consequence-relevant structure.

The fastest useful contribution is therefore a counterexample.

## 60-second attack

From the repository root:

```bash
python break_sigma_r.py .
```

The breaker uses only the Python standard library. It does **not** execute Terraform, Kubernetes, shell payloads, or candidate operations. It imports the local Sigma-R implementation and sends generated/curated data structures through its adapters and verifier.

For reproducibility:

```bash
python break_sigma_r.py . --seed 1337 --cases 5000 --json-out break-report.json
```

Exit code `0` means no invariant violation was found in that run. Exit code `1` means the breaker found at least one counterexample. A clean run is **not** a proof of safety.

## What counts as a break

The tool reports a failure if it observes any of these:

1. **Incomplete -> admissible**: an adapter finding has structural residuals but does not terminate as `ADAPTER_INCOMPLETE`.
2. **Evidence manufacture**: missing evidence eventually produces a complete survivor.
3. **Authority manufacture**: missing authorization eventually produces a complete survivor.
4. **Protection bypass repair**: explicit `protection_bypass=True` eventually becomes a complete survivor.
5. **Boundary crossing**: any replay reports an execution boundary other than `NOT_CROSSED`.
6. **Executor exposure**: the repair wrapper exposes an `execute` method.
7. **Nondeterminism**: replaying an identical typed input yields a materially different normalized outcome.
8. **Crash / malformed-input escape**: a generated malformed artifact crashes the evaluator rather than producing a bounded result. Crashes are preserved as findings, not silently discarded.

## What I want reviewers to try

Good attacks are boring and specific:

- Remove `kind`, `metadata`, `spec`, `change`, or `change.actions`.
- Use empty strings, unexpected casing, unusual resource names, huge strings, duplicate-looking structures, empty arrays, `null`, booleans where strings normally appear, and unknown Kubernetes kinds.
- Combine production scope, global scope, IAM/RBAC mutation, public network exposure, force-like state, and privileged workload state.
- Look for cases where the text adapter and typed state disagree.
- Look for a repair that removes one hazard while accidentally erasing another.
- Look for a malformed source that becomes `ALLOW` simply because the adapter failed to understand it.

## Please report failures, not impressions

Open an issue containing:

- repository commit SHA;
- Python version and OS;
- exact breaker command and seed;
- generated `break-report.json`;
- smallest reproducing input if you can minimize it;
- which invariant you believe failed;
- whether the failure reproduces on a clean clone.

A real counterexample is more valuable than a positive review.

## Claim boundary

This breaker is an internal adversarial harness. Its generated objects are not a substitute for captured production Terraform plans or Kubernetes API objects. Passing 5,000 or 5,000,000 generated cases does not establish production safety, complete schema coverage, formal correctness, or universal robustness.

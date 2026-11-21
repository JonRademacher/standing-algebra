# Sigma-R v12 external evaluation

No framework. No cloud account. No infrastructure access. Python 3 only.

## 30-second evaluation

From the unpacked Sigma-R v12 full wrapper:

```bash
python sigma_r_external_evaluator.py . --expected-sha256 933e66e45c78e8ce1ebf1a7447bb9059ead29d7a94b4fb4fe816af933e4313e5
```

Expected terminal result:

```text
Sigma-R external evaluation: PASS
 behavioral: PASS
 regression: PASS
 execution surface: none
```

A machine-readable `external-evaluation.json` is also produced.

## What the evaluator independently checks

1. Optional byte identity of the standalone v12 carrier.
2. Missing Kubernetes `kind` fails closed as `ADAPTER_INCOMPLETE`.
3. Missing Terraform `change.actions` fails closed as `ADAPTER_INCOMPLETE`.
4. A privileged Kubernetes Pod remains `DOMINATION_BLOCK`.
5. A complete production LoadBalancer input can enter Repair/Replay and produce bounded survivors.
6. Every behavioral case reports `execution_boundary = NOT_CROSSED`.
7. `AdapterAwareRepairReplay` exposes no `execute` method.
8. If the repository contains v4-v12 regression modules, it runs all of them with `unittest`.

## Reviewer interpretation

PASS means only that the supplied implementation reproduces these declared reference behaviors in the reviewer's environment. It is not proof of production safety, complete Terraform/Kubernetes semantics, formal correctness, consciousness/autonomy claims, or independent real-infrastructure validation.

FAIL is useful. Attach `external-evaluation.json`, Python version, operating system, and the tested commit SHA to an issue.

## Clean-review recommendation

Clone the repository into a fresh directory, verify the release SHA-256, use a stock Python 3 interpreter, and run this evaluator before reading project claims. That gives the implementation a chance to falsify itself before reviewer interpretation enters.

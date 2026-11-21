# Sigma-R Admissibility Firewall

**Production-oriented, provider-neutral middleware for placing an explicit evidence, authority, and admissibility boundary between AI-generated proposals and consequential realization.**

Based on **Standing Algebra (Sigma-R)** by **Jonathan Rademacher**.

Reference DOI: `10.5281/zenodo.23016270`

## Why this exists

Modern AI stacks can generate code, patches, tool calls, plans, configuration changes, and operational decisions faster than a human can review every proposal. Generation, however, is not the same thing as permission, evidence, correctness, or safe execution.

Sigma-R inserts an independent decision boundary:

```text
AI proposal
    -> evidence/context validation
    -> authority validation
    -> admissibility evaluation
    -> policy filtering / safe projection
    -> allow, project, abstain, or block
    -> cryptographic receipt + audit trail
    -> consequential action boundary
```

The core invariant is:

> **proposal != evidence != admissibility != authority != execution**

A model producing an answer or patch does not, by itself, grant that output authority to change a consequential system.

## What this package provides

The package is designed to be inserted between almost any AI generation layer and the system that consumes its output.

### Core enforcement

- Fail-closed operation by default
- Required grounding/source context
- Explicit authorization gate for consequential actions
- Configurable hallucination-risk envelope
- Configurable epistemic-coercion envelope
- Configurable action-risk envelope
- Rule-based `BLOCK`, `PROJECT`, and `FLAG` behavior
- Credential/secret projection support
- Explicit non-realization rather than forced completion

### Decision states

| Decision | Meaning |
|---|---|
| `ALLOW` | Proposal survived the declared envelope unchanged |
| `PROJECT` | Proposal was transformed into an admissible realization |
| `ABSTAIN` | Risk exceeded the envelope and no admissible projection existed |
| `ADAPTER_FAIL` | Required integration/context contract was not satisfied |
| `EVIDENCE_BLOCK` | Required evidence was incomplete |
| `AUTHORITY_BLOCK` | Required authority was not established |
| `DOMINATION_BLOCK` | Proposal attempted an impermissible authority/policy override |
| `POLICY_BLOCK` | A declared policy constraint rejected the proposal |
| `EMERGENCY_G` | Declared constraints were mutually infeasible |
| `EVALUATOR_FAIL` | Independent evaluation failed |
| `CIRCUIT_OPEN` | Repeated evaluator failures opened the circuit breaker |
| `RATE_LIMIT` | Configured request-rate envelope was exceeded |

### Operational hardening

- Thread-safe decision path
- Request-rate limiting
- Evaluator circuit breaker
- Bounded in-memory history
- Configurable policy objects
- Pluggable independent evaluators
- Provider-neutral callable adapter
- JSON CLI interface
- JSONL audit sink
- Docker deployment support
- Non-root container user

### Provenance and receipts

Every decision can carry:

- request ID
- UTC timestamp
- policy ID
- input SHA-256
- output SHA-256
- context SHA-256
- metadata SHA-256
- previous-receipt SHA-256
- current receipt SHA-256
- optional HMAC-SHA-256 signature

Receipts are hash-chained so deletion, substitution, or reordering can be detected when the chain is independently retained.

Set a signing key through the deployment secret manager:

```bash
export SIGMA_R_RECEIPT_KEY='replace-with-secret-manager-injection'
```

Do **not** place signing keys in source code, policy JSON, GitHub, Zenodo, logs, or container images.

## Installation

Python 3.10+ is supported by the package configuration.

### Install locally

```bash
pip install .
```

### Development installation

```bash
pip install -e ".[dev]"
```

### Run the built-in verification

```bash
python -m sigma_r.cli self-test
pytest
python -m compileall src
```

## Five-minute integration

```python
from sigma_r import SigmaRFirewall

firewall = SigmaRFirewall()

raw_output = model.generate(prompt)

result = firewall.guard_text(
    raw_output,
    context={
        "sources": ["retrieval-record-123"],
        "user_authorized": True,
    },
    metadata={
        "grounding_score": 0.98,
        "coercion_risk": 0.00,
        "action_risk": 0.05,
        "consequential_action": False,
    },
)

if not result.allowed:
    raise RuntimeError(result.to_dict())

return result.output_text
```

## Wrapping an existing model callable

The provided `CallableAdapter` allows the firewall to surround an existing model function without coupling Sigma-R to one provider.

```python
from sigma_r import SigmaRFirewall, CallableAdapter


def model(prompt):
    return {
        "choices": [
            {"message": {"content": "Grounded answer"}}
        ]
    }


firewall = SigmaRFirewall()
guarded_model = CallableAdapter(firewall, model)

result = guarded_model(
    "Explain the proposed change",
    context={"sources": ["change-request-481"]},
    metadata={"grounding_score": 1.0},
)

print(result.decision)
print(result.output_text)
```

For response formats not handled by the default extractor, supply a custom extractor rather than modifying the core policy engine.

## Consequential actions

A consequential action is an output whose execution changes an external state. Examples include:

- applying a software patch
- modifying infrastructure
- executing shell commands
- changing IAM policy
- sending messages
- approving financial operations
- deleting or modifying records
- operating physical equipment

Mark these requests explicitly:

```python
result = firewall.guard_text(
    proposed_patch,
    context={
        "sources": ["issue-918", "test-run-2201"],
        "user_authorized": True,
    },
    metadata={
        "grounding_score": 0.99,
        "action_risk": 0.07,
        "consequential_action": True,
    },
)
```

The firewall should sit immediately before the consequential action boundary.

```text
LLM / agent
   |
   v
proposal
   |
   v
retrieval + evidence evaluators
   |
   v
Sigma-R
   |
   +---- BLOCK / ABSTAIN ---> audit + recovery path
   |
   +---- PROJECT -----------> re-evaluate if required
   |
   v
independent authorization
   |
   v
sandbox / tests / canary
   |
   v
execution
   |
   v
receipt + monitoring + rollback
```

Do not use Sigma-R as a justification for removing sandboxing, least privilege, canary deployment, approvals, observability, or rollback.

## Policy configuration

A basic policy is included in `policy.example.json`.

Example:

```json
{
  "policy_id": "sigma-r-production-v1",
  "required_context_keys": ["sources"],
  "require_nonempty_sources": true,
  "max_hallucination_risk": 0.2,
  "max_coercion_risk": 0.1,
  "max_action_risk": 0.1,
  "fail_closed": true
}
```

Load a policy programmatically:

```python
import json
from pathlib import Path
from sigma_r import SigmaRFirewall, SigmaRPolicy

policy = SigmaRPolicy.from_dict(
    json.loads(Path("policy.example.json").read_text())
)

firewall = SigmaRFirewall(policy)
```

The numerical defaults are engineering defaults for this reference package, not scientifically universal safety thresholds. Calibrate them against the actual system, threat model, evaluation data, and consequences of false acceptance and false rejection.

## Independent evaluators

The built-in `MetadataEvaluator` makes the package immediately runnable, but production systems should **not allow the generating model to self-certify** all of its own evidence, authorization, and risk measurements.

Provide separate evaluator signals for the domains that matter to the deployment. Typical evaluators include:

1. **Grounding evaluator**  
   Checks whether material factual claims are supported by retrieved evidence.

2. **Authorization evaluator**  
   Consults the real identity/IAM/workflow system rather than trusting model text.

3. **Patch/test evaluator**  
   Requires unit, integration, regression, static-analysis, or build evidence.

4. **Deployment-risk evaluator**  
   Incorporates blast radius, environment, reversibility, canary state, and rollback readiness.

5. **Sensitive-data evaluator**  
   Detects secrets, personal data, credentials, or prohibited disclosure.

6. **Domain-policy evaluator**  
   Enforces rules specific to healthcare, finance, industrial controls, infrastructure, security, or another deployment domain.

The firewall aggregates multiple evaluators conservatively by taking high-risk signals seriously rather than averaging a serious objection away.

## Safe projection

Sigma-R distinguishes rejection from **projection**.

A proposal may contain a useful admissible realization even if the original representation is outside the permitted envelope. A projection rule can transform the proposal while preserving the admissible portion.

The default credential rule demonstrates this by replacing a detected credential assignment with:

```text
[REDACTED_CREDENTIAL]
```

Projection should be used only when the transformation itself is trusted and does not silently alter consequence-bearing semantics.

For high-impact actions, projected outputs should normally pass through evaluation again before execution.

## Emergency envelope

`EMERGENCY_G` is returned when a request cannot be realized inside the declared constraint envelope. This is intentionally different from forcing the nearest available action.

Example geometry:

```text
required minimum risk > permitted maximum risk
                 |
                 v
             no survivor
                 |
                 v
           EMERGENCY_G
                 |
                 v
       no consequential action
```

No-survivor is treated as a localized realization obstruction, not permission to relax constraints silently.

## Audit logging

Use the JSONL audit sink for local integration:

```python
from sigma_r.core import JsonlAuditSink
from sigma_r import SigmaRFirewall

firewall = SigmaRFirewall(
    audit_sink=JsonlAuditSink("sigma_r_audit.jsonl")
)
```

For real deployments, forward audit events to an append-only or independently controlled logging system such as a SIEM, immutable object store, transparency log, or equivalent evidence carrier.

An audit log stored only on the same host that performs the protected action is not a strong tamper-evidence boundary.

## CLI

### Self-test

```bash
sigma-r self-test
```

### Guard JSON from stdin

```bash
cat request.json | sigma-r guard-json --audit sigma-r.jsonl
```

Example request:

```json
{
  "text": "Proposed output",
  "context": {
    "sources": ["doc-123"],
    "user_authorized": true
  },
  "metadata": {
    "grounding_score": 0.99,
    "action_risk": 0.03,
    "consequential_action": false
  }
}
```

### Show an example policy

```bash
sigma-r policy-example
```

## Docker

Build:

```bash
docker build -t sigma-r-firewall:1.0.0 .
```

Run the internal self-test:

```bash
docker run --rm sigma-r-firewall:1.0.0 self-test
```

The supplied container runs as a non-root user.

For production deployment, additionally set CPU/memory/PID limits, a read-only filesystem where practical, dropped Linux capabilities, network policy, image signing, vulnerability scanning, secret-manager injection, and deployment-specific health checks.

## CI

The included GitHub Actions workflow exercises:

- Python 3.10
- Python 3.11
- Python 3.12
- Python 3.13
- Ruff linting
- mypy static type checking
- pytest
- `pip-audit`

The CI configuration intentionally gives the workflow read-only repository contents permission unless more authority is explicitly required.

## Threat model

Sigma-R is intended to reduce failures caused by collapsing AI generation directly into authority or execution.

It is specifically designed to make the following classes of failure easier to intercept or expose:

- unsupported proposals reaching execution
- missing grounding/context
- missing action authority
- explicit attempts to override declared controls
- unsafe risk levels
- incompatible constraints
- evaluator degradation
- repeated evaluator failure
- accidental credential disclosure
- unaudited realization

Sigma-R alone does **not** solve:

- a compromised host
- a malicious administrator with greater authority than the firewall
- incorrect or poisoned external evidence
- a compromised authorization service
- malicious evaluators
- logic errors in deployment-specific policy
- supply-chain compromise
- model vulnerabilities upstream of the boundary
- action executors that ignore the firewall decision
- incomplete threat models

Security depends on the entire path from evidence acquisition through execution and recovery.

## Recommended production topology

For AI-driven patching, a strong deployment looks like:

```text
AI patch generator
      |
      v
source/evidence binding
      |
      v
Sigma-R evaluation
      |
      v
static analysis + dependency scan
      |
      v
isolated build
      |
      v
unit/integration/regression tests
      |
      v
policy + IAM authorization
      |
      v
canary deployment
      |
      v
runtime health checks
      |
      +---- failure ----> automatic rollback
      |
      v
progressive rollout
      |
      v
receipt / audit / monitoring
```

For patching systems, useful external tools can include language-specific test frameworks, Semgrep or CodeQL for static analysis, Trivy or Grype for container/dependency scanning, Sigstore/Cosign for artifact signing, OpenTelemetry for telemetry, and deployment-native canary/rollback mechanisms. These are integration examples, not required dependencies of the core package.

## Verification performed on this release candidate

The generated package was locally verified with:

- Python compilation: **PASS**
- CLI self-tests: **4/4 PASS**
- pytest: **8/8 PASS**
- ZIP integrity: **PASS**
- fail-closed missing-context test: **PASS**
- domination-block test: **PASS**
- credential-projection test: **PASS**
- authority-gate test: **PASS**
- emergency-envelope test: **PASS**
- receipt-chain test: **PASS**
- HMAC receipt test: **PASS**

These are internal verification results. They are not independent security validation.

## Release artifact hashes

For the generated release candidate:

### Standalone Python firewall

```text
SHA-256
6db4a2f154ffbff30e1bd6483d1876feb4b099b4f8aadd717a6557745e35dc64
```

### Production package ZIP

```text
SHA-256
b6319bf101e43dddd44a16a78f3b027b281962974f929bd017b888c062009e00
```

The package also contains `MANIFEST.sha256.json` with per-file SHA-256 values.

When publishing a new release, regenerate these values from the final bytes. Do not carry hashes forward after modifying an artifact.

For OpenTimestamps use, timestamp the final release artifact itself and retain the resulting `.ots` file beside the artifact or release record.

## Deployment checklist

Before permitting consequential production actions:

- [ ] Independent security review completed
- [ ] Threat model documented
- [ ] Real authorization source connected
- [ ] Independent evaluators connected
- [ ] Generating model cannot self-authorize
- [ ] Generating model cannot self-certify all risk/evidence signals
- [ ] Policy thresholds calibrated on representative data
- [ ] False-accept and false-reject behavior measured
- [ ] Sandbox/build/test boundary implemented
- [ ] Static/dependency/security scanning implemented where applicable
- [ ] Canary path implemented
- [ ] Automatic rollback tested
- [ ] Least-privilege executor identity configured
- [ ] Secrets supplied by secret manager
- [ ] Audit records copied outside the protected execution host
- [ ] Receipt verification tested
- [ ] Rate/circuit-breaker behavior load-tested
- [ ] Monitoring/alerting connected
- [ ] Incident runbook written and exercised
- [ ] Recovery route tested without the AI generator
- [ ] Final release files hashed
- [ ] Published hashes independently retained

## Production-readiness status

This repository is intended to be **production-oriented**, not to substitute the word "production" for evidence.

Current status of this generated release candidate:

| Property | Status |
|---|---|
| Executable implementation | Verified locally |
| Core unit tests | Verified locally |
| CLI self-test | Verified locally |
| Hash manifest | Present |
| Fail-closed behavior | Implemented/tested |
| Receipt chaining | Implemented/tested |
| Optional HMAC signing | Implemented/tested |
| Container packaging | Present |
| CI definition | Present |
| Independent security audit | Not yet established |
| External adversarial benchmark | Not yet established |
| Independent reproduction | Not yet established |
| Formal verification | Not yet established |
| Production load characterization | Not yet established |
| Certification/compliance | Not claimed |

The unresolved items are deliberate first-class residuals. They should not be silently converted into claims of validation.

## Design principles

The implementation follows a small set of operational principles:

1. **Generation is not authorization.**
2. **Access is not authority.**
3. **Missing evidence stays missing.**
4. **A blocked realization does not invalidate the objective globally.**
5. **No survivor means stop, localize the obstruction, and recover deliberately.**
6. **Projection preserves what can legitimately survive rather than inventing permission.**
7. **The system that generates a proposal should not be the sole judge of that proposal.**
8. **Execution state must remain distinguishable from recommendation state.**
9. **Receipts record what happened; receipts do not prove that the policy itself was correct.**
10. **Production claims require production evidence.**

## Research and validation

Useful next validation work includes:

- adversarial AI-patch benchmark suites
- comparison against generate/test/deploy baselines
- ablation of individual Sigma-R gates
- false-positive/false-negative analysis
- latency and throughput benchmarking
- evaluator-independence experiments
- red-team attempts to obtain unauthorized realization
- receipt-chain tampering tests
- recovery and rollback drills
- policy-conflict fuzzing
- formal modeling of the authorization and state-transition invariants
- independent reproduction and review

A strong result is not merely "the firewall blocked more." The relevant questions include whether it blocks the right cases, preserves useful admissible realizations, exposes residual uncertainty, supports recovery, and reduces consequential failures without creating an unacceptable availability or operator-bypass burden.

## Security

See `SECURITY.md`.

Do not publish live credentials, proprietary production traces, personal data, or exploitable production details in public bug reports.

## License

MIT. See `LICENSE`.

## Attribution and provenance

**Standing Algebra (Sigma-R)** and this implementation trajectory are attributed to **Jonathan Rademacher**.

Reference DOI:

```text
10.5281/zenodo.23016270
```

When redistributing or extending this package, preserve the license and provenance information appropriate to the distributed artifact.

## Citation

Until a repository-specific citation file is supplied, cite the associated Zenodo record using the DOI above and identify the software release by repository tag/version and SHA-256 where exact artifact identity matters.

## Final note

Sigma-R does not attempt to make an AI system infallible.

The narrower objective is more concrete: **make the transition from generated possibility to consequential reality explicit, constrained, inspectable, and recoverable.**

from future import annotations

from typing import Set, FrozenSet, Dict, List, Tuple, Any
from datetime import date
from pathlib import Path
import random
import sys
import argparse
import json
import hashlib
import time
from statistics import mean

# ------------------------------------------------------------
# Robust kernel import
# ------------------------------------------------------------
try:
    from Closure_Theoretic_Hospital_Triage_AI_Kernel import (
        ClosurePolicyKernel,
        PolicyRegion,
        AtomSpec,
        AdapterManifest,
        PolicyKernelError,
    )
except ModuleNotFoundError:
    sys.path.append(str(Path(file).resolve().parent))
    from Closure_Theoretic_Hospital_Triage_AI_Kernel import (
        ClosurePolicyKernel,
        PolicyRegion,
        AtomSpec,
        AdapterManifest,
        PolicyKernelError,
    )

# ------------------------------------------------------------
# Demo disclaimer
# ------------------------------------------------------------
DISCLAIMER = [
    "DEMO DISCLAIMER:",
    "- This is NOT a triage, allocation, or decision system.",
    "- It enforces policy admissibility constraints on representations only.",
    "- Policy conflicts are surfaced but never resolved here.",
    "- Correctness depends on adapter integrity, policy completeness, and atom identity stability.",
    "",
]

def print_disclaimer() -> None:
    for line in DISCLAIMER:
        print(line)

# ------------------------------------------------------------
# Atom registry
# ------------------------------------------------------------
ATOM_REGISTRY = [
    AtomSpec("TREATMENT_ACCESS", "Care access preserved.", "core", "Policy"),
    AtomSpec("NON_DISCRIMINATION", "No protected-class discrimination.", "legal", "Policy", critical=True),
    AtomSpec("PROTOCOL_COMPLIANT", "Protocol gating satisfied.", "protocol", "Policy"),
    AtomSpec("CONTRAINDICATION_CLEAR", "No contraindications.", "clinical", "Policy"),
    AtomSpec("REQUEST_ICU_BED", "Resource request only.", "resource", "Workflow"),
    AtomSpec("ASSIGN_ICU_BED", "Allocation act (forbidden).", "resource", "Governance", critical=True),
    AtomSpec("DISABILITY_FILTERING", "Explicit discrimination.", "legal", "Civil rights", critical=True),
    AtomSpec("RISK_ADJUSTMENT_FLAG", "Semantically ambiguous.", "adapter", "Adapter layer", critical=True),
]

UNIVERSE: Set[str] = {a.atom for a in ATOM_REGISTRY}

# ------------------------------------------------------------
# Authoritative regions
# ------------------------------------------------------------
AUTHORITATIVE_REGIONS = [
    PolicyRegion(
        region=frozenset(UNIVERSE),
        region_id="UNIVERSE",
        title="Universe",
        rationale="Trivial closure",
        approved_by="Compliance",
        approved_on=date(2026, 1, 1),
    ),
    PolicyRegion(
        region=frozenset({"TREATMENT_ACCESS", "NON_DISCRIMINATION", "PROTOCOL_COMPLIANT"}),
        region_id="MIN_SAFE",
        title="Minimum floor",
        rationale="Legal baseline",
        approved_by="Compliance",
        approved_on=date(2026, 1, 5),
    ),
    PolicyRegion(
        region=frozenset({
            "TREATMENT_ACCESS",
            "NON_DISCRIMINATION",
            "PROTOCOL_COMPLIANT",
            "CONTRAINDICATION_CLEAR",
            "REQUEST_ICU_BED",
        }),
        region_id="CORE_SAFE",
        title="Core safe",
        rationale="Requests allowed",
        approved_by="Ethics Board",
        approved_on=date(2026, 1, 10),
    ),
    PolicyRegion(
        region=frozenset({
            "TREATMENT_ACCESS",
            "NON_DISCRIMINATION",
            "PROTOCOL_COMPLIANT",
            "CONTRAINDICATION_CLEAR",
        }),
        region_id="CRISIS_STRICT",
        title="Crisis strict",
        rationale="Requests gated",
        approved_by="Crisis Committee",
        approved_on=date(2026, 2, 1),
    ),
]

# ------------------------------------------------------------
# Kernel builder
# ------------------------------------------------------------
def build_kernel(strict_atoms: bool) -> ClosurePolicyKernel:
    return ClosurePolicyKernel(
        universe=UNIVERSE,
        regions=AUTHORITATIVE_REGIONS,
        atom_registry=ATOM_REGISTRY,
        strict_atoms=strict_atoms,
        validation_mode=True,
        runtime_mode=True,
        repair_moore_family_tooling=True,
    )

# ------------------------------------------------------------
# External check (NOT oracle)
# ------------------------------------------------------------
def region_existence_check(proposal: FrozenSet[str]) -> bool:
    return any(proposal.issubset(r.region) for r in AUTHORITATIVE_REGIONS)

# ------------------------------------------------------------
# Cases
# ------------------------------------------------------------
CASES: List[Tuple[str, Set[str]]] = [
    ("Protected-class exclusion",
     {"TREATMENT_ACCESS", "PROTOCOL_COMPLIANT", "DISABILITY_FILTERING"}),

    ("Premature allocation",
     {"TREATMENT_ACCESS", "PROTOCOL_COMPLIANT", "ASSIGN_ICU_BED"}),

    ("Policy conflict",
     {"TREATMENT_ACCESS", "NON_DISCRIMINATION", "PROTOCOL_COMPLIANT", "REQUEST_ICU_BED"}),

    ("Semantic obfuscation",
     {"TREATMENT_ACCESS", "PROTOCOL_COMPLIANT", "RISK_ADJUSTMENT_FLAG"}),
]

# ------------------------------------------------------------
# Metrics
# ------------------------------------------------------------
def jaccard_loss(a: Set[str], b: Set[str]) -> float:
    if not a and not b:
        return 0.0
    return 1.0 - len(a & b) / len(a | b)

def percentile(values: List[float], q: float) -> float:
    if not values:
        return 0.0
    s = sorted(values)
    idx = int(q * (len(s) - 1))
    return float(s[idx])

def top_k_counts(counter: Dict[str, int], k: int = 5) -> List[Tuple[str, int]]:
    return sorted(counter.items(), key=lambda kv: (-kv[1], kv[0]))[:k]

def compute_metrics(records: List[Dict[str, Any]]) -> Dict[str, Any]:
    n = len(records)
    if n == 0:
        return {}

    accepted = [r for r in records if r.get("status") == "accepted"]
    rejected = [r for r in records if r.get("status") == "rejected"]
    corrected = [r for r in accepted if (r.get("removed_atoms") or [])]

    removed_counts = [len(r.get("removed_atoms") or []) for r in accepted]
    losses = [float(r.get("jaccard_loss") or 0.0) for r in accepted]

    frontier_sizes = [len(r.get("frontier_region_ids") or []) for r in accepted]
    plurality = [x for x in frontier_sizes if x > 1]

    frontier_id_counts: Dict[str, int] = {}
    frontier_combo_counts: Dict[str, int] = {}

    for r in accepted:
        ids = list(r.get("frontier_region_ids") or [])
        for fid in ids:
            frontier_id_counts[fid] = frontier_id_counts.get(fid, 0) + 1
        combo_key = "|".join(sorted(ids)) if ids else "(none)"
        frontier_combo_counts[combo_key] = frontier_combo_counts.get(combo_key, 0) + 1

    instability = (
        (len(rejected) / n)
        + (mean(losses) if losses else 0.0)
        + ((mean(removed_counts) if removed_counts else 0.0) / max(1, len(UNIVERSE)))
    )

    return {
        "n": float(n),
        "accept_rate": len(accepted) / n,
        "reject_rate": len(rejected) / n,
        "correct_rate": len(corrected) / n,
        "mean_removed": mean(removed_counts) if removed_counts else 0.0,
        "p95_removed": percentile([float(x) for x in removed_counts], 0.95) if removed_counts else 0.0,
        "mean_jaccard_loss": mean(losses) if losses else 0.0,
        "p95_jaccard_loss": percentile([float(x) for x in losses], 0.95) if losses else 0.0,
        "mean_frontier_size": mean([float(x) for x in frontier_sizes]) if frontier_sizes else 0.0,
        "p95_frontier_size": percentile([float(x) for x in frontier_sizes], 0.95) if frontier_sizes else 0.0,
        "plurality_rate": (len(plurality) / len(frontier_sizes)) if frontier_sizes else 0.0,
        "drift_instability_index": float(instability),
        "frontier_id_counts_top": top_k_counts(frontier_id_counts, k=5),
        "frontier_combo_counts_top": top_k_counts(frontier_combo_counts, k=5),
    }

NUMERIC_METRIC_KEYS = {
    "accept_rate",
    "reject_rate",
    "correct_rate",
    "mean_removed",
    "p95_removed",
    "mean_jaccard_loss",
    "p95_jaccard_loss",
    "mean_frontier_size",
    "p95_frontier_size",
    "plurality_rate",
    "drift_instability_index",
}

def run_cases(kernel: ClosurePolicyKernel, adapter: AdapterManifest) -> Dict[str, Any]:
    results: List[Dict[str, Any]] = []

    for name, raw in CASES:
        proposal = frozenset(raw)

        record: Dict[str, Any] = {
            "case": name,
            "proposal": sorted(proposal),
            "region_existence_check": region_existence_check(proposal),
            "status": None,
            "projection": None,
            "removed_atoms": None,
            "frontier_region_ids": None,
            "jaccard_loss": None,
        }

        try:
            out = kernel.enforce(proposal, adapter=adapter)
            audit = out.get("audit", {}) or {}
            proj = set(out.get("conservative_result") or [])

            record.update({
                "status": "accepted",
                "projection": sorted(proj),
                "removed_atoms": list(audit.get("removed") or []),
                "frontier_region_ids": list(audit.get("frontier_region_ids") or []),
                "jaccard_loss": jaccard_loss(set(proposal), proj),
            })

        except PolicyKernelError as e:
            record["status"] = "rejected"
            # FIX: must be name
            record["error_type"] = type(e).name

        results.append(record)

    return {
        "case_results": results,
        "case_metrics": compute_metrics(results),
    }

def run_drift(kernel: ClosurePolicyKernel, adapter: AdapterManifest, seed: int, steps: int) -> Dict[str, Any]:
    rng = random.Random(seed)

    state: Set[str] = {
        "TREATMENT_ACCESS",
        "NON_DISCRIMINATION",
        "PROTOCOL_COMPLIANT",
    }

    drift_atoms = [
        "DISABILITY_FILTERING",
        "ASSIGN_ICU_BED",
        "RISK_ADJUSTMENT_FLAG",
    ]

    trace: List[Dict[str, Any]] = []

    for t in range(1, steps + 1):
        for a in drift_atoms:
            if rng.random() < 0.25:
                state.add(a)

        proposal = frozenset(state)

        rec: Dict[str, Any] = {
            "t": t,
            "proposal": sorted(proposal),
            "region_existence_check": region_existence_check(proposal),
            "status": None,
            "projection": None,
            "removed_atoms": None,
            "frontier_region_ids": None,
            "jaccard_loss": None,
        }

        try:
            out = kernel.enforce(proposal, adapter=adapter)
            audit = out.get("audit", {}) or {}
            proj = set(out.get("conservative_result") or [])

            rec.update({
                "status": "accepted",
                "projection": sorted(proj),
                "removed_atoms": list(audit.get("removed") or []),
                "frontier_region_ids": list(audit.get("frontier_region_ids") or []),
                "jaccard_loss": jaccard_loss(set(proposal), proj),
            })

        except PolicyKernelError as e:
            rec["status"] = "rejected"
            # FIX: must be name
            rec["error_type"] = type(e).name

        trace.append(rec)

    return {
        "drift_trace": trace,
        "drift_metrics": compute_metrics(trace),
    }

def stable_hash(obj: Any) -> str:
    s = json.dumps(obj, sort_keys=True, separators=(",", ":"), default=str)
    return hashlib.sha256(s.encode("utf-8")).hexdigest()[:16]

def snapshot_payload(label: str, seed: int, steps: int, strict_atoms: bool,
                     case_pack: Dict[str, Any], drift_pack: Dict[str, Any]) -> Dict[str, Any]:
    config = {
        "label": label,
        "seed": seed,
        "steps": steps,
        "strict_atoms": strict_atoms,
        "universe": sorted(UNIVERSE),
        "regions": [{"region_id": r.region_id, "size": len(r.region)} for r in AUTHORITATIVE_REGIONS],
        "cases": [name for name, _ in CASES],
    }
    return {
        "snapshot_version": 1,
        "created_unix": int(time.time()),
        "config": config,
        "config_fingerprint": stable_hash(config),
        "case_pack": case_pack,
        "drift_pack": drift_pack,
    }

def numeric_only(metrics: Dict[str, Any]) -> Dict[str, float]:
    out: Dict[str, float] = {}
    for k in NUMERIC_METRIC_KEYS:
        if k in metrics:
            out[k] = float(metrics[k])
    return out

def compare_metrics(cur: Dict[str, float], prev: Dict[str, float], tolerances: Dict[str, float]) -> Tuple[bool, List[str]]:
    ok = True
    msgs: List[str] = []
    for k, tol in tolerances.items():
        if k not in cur or k not in prev:
            msgs.append(f"[SKIP] {k} missing")
            continue
        delta = float(cur[k]) - float(prev[k])
        if delta > tol:
            ok = False
            msgs.append(f"[REGRESSION] {k}: prev={prev[k]:.6f} cur={cur[k]:.6f} Δ={delta:.6f} > tol={tol}")
        else:
            msgs.append(f"[OK] {k}: prev={prev[k]:.6f} cur={cur[k]:.6f} Δ={delta:.6f} <= tol={tol}")
    return ok, msgs

def run_demo(kernel: ClosurePolicyKernel, label: str, seed: int, steps: int) -> Dict[str, Any]:
    print_disclaimer()
    print(f"=== DEMO ({label}) seed={seed} steps={steps} ===\n")

    adapter = AdapterManifest("demo_adapter", "1.0")

    case_pack = run_cases(kernel, adapter)
    drift_pack = run_drift(kernel, adapter, seed, steps)

    print("Case metrics:", case_pack["case_metrics"])
    print("Drift metrics:", drift_pack["drift_metrics"])
    print()

    return {"case_pack": case_pack, "drift_pack": drift_pack}

def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--seed", type=int, default=7)
    ap.add_argument("--steps", type=int, default=20)
    ap.add_argument("--runs", type=int, default=1)
    ap.add_argument("--strict-atoms", action="store_true", default=True)
    ap.add_argument("--snapshot-dir", type=str, default="snapshots")
    ap.add_argument("--snapshot-name", type=str, default="demo_STRICT_ATOMS_ON")
    ap.add_argument("--write-snapshot", action="store_true")
    ap.add_argument("--compare", type=str, default="")
    args = ap.parse_args()

    kernel = build_kernel(strict_atoms=bool(args.strict_atoms))

    payloads: List[Dict[str, Any]] = []
    drift_indices: List[float] = []

    for i in range(args.runs):
        run_seed = args.seed + i
        packs = run_demo(kernel, args.snapshot_name, run_seed, args.steps)
        payload = snapshot_payload(
            args.snapshot_name,
            run_seed,
            args.steps,
            bool(args.strict_atoms),
            packs["case_pack"],
            packs["drift_pack"],
        )
        payloads.append(payload)
        drift_indices.append(float(payload["drift_pack"]["drift_metrics"].get("drift_instability_index", 0.0)))

    if args.runs > 1:
        print(f"Aggregate runs={args.runs}: mean_drift_instability_index={mean(drift_indices):.6f}")

    final_payload = payloads[-1]

    if args.write_snapshot:
        out_path = Path(args.snapshot_dir) / f"{args.snapshot_name}_seed{final_payload['config']['seed']}_steps{args.steps}.json"
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(json.dumps(final_payload, indent=2, sort_keys=True, default=str), encoding="utf-8")
        print(f"Wrote snapshot: {out_path}")

    if args.compare:
        prev = json.loads(Path(args.compare).read_text(encoding="utf-8"))

        tolerances = {
            "reject_rate": 0.0,
            "mean_jaccard_loss": 0.05,
            "mean_removed": 0.5,
            "mean_frontier_size": 0.5,
            "plurality_rate": 0.10,
            "drift_instability_index": 0.05,
        }

        cur_case = numeric_only(final_payload["case_pack"]["case_metrics"])
        prev_case = numeric_only(prev["case_pack"]["case_metrics"])
        cur_drift = numeric_only(final_payload["drift_pack"]["drift_metrics"])
        prev_drift = numeric_only(prev["drift_pack"]["drift_metrics"])

        ok1, msgs1 = compare_metrics(cur_case, prev_case, tolerances)
        ok2, msgs2 = compare_metrics(cur_drift, prev_drift, tolerances)

        print("\n".join(msgs1 + msgs2))
        if not (ok1 and ok2):
            raise SystemExit(2)

if name == "main":
    main()

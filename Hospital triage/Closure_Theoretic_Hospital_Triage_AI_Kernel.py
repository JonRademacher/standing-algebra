"""
Closure-Theoretic Policy Kernel (V2: Governance-Safe, No-Decision-Creep)
======================================================================

Author: Jon Rademacher (2026)

ROLE
----
Constraint firewall in front of AI-assisted decision support (e.g., triage support).
This kernel DOES NOT decide or allocate. It enforces closure-based admissibility,
returns frontier options + explanations, and fails loudly.

GOVERNANCE SAFETY
-----------------
- Auto-repair of Moore-family closure is TOOLING ONLY (non-authoritative).
- Kernel NEVER selects among frontier options (non-sovereignty discipline).
  Any selection must occur outside kernel (separate module / human governance).

ALIGNMENT WITH Σᴿ NORMALIZATION PATTERN
---------------------------------------
Canonical normalization (envelope/firewall) is a known deployment pattern in Σᴿ:
unsafe proposals are replaced by canonical closures before execution. 

ADMISSIBILITY–LEGITIMACY ADJUNCTION
----------------------------------
Restriction (filtering admissibles) and closure (legitimacy completion) form an adjoint
(Galois connection) at the policy-space level. This kernel implements the closure side
and exposes frontier conflicts without ranking. 

ATTRIBUTION REQUIRED
--------------------
Public use must attribute:
"Jon Rademacher (2026) — Closure-Theoretic Policy Kernel"
"""

from future import annotations
from dataclasses import dataclass
from typing import Any, Dict, FrozenSet, Iterable, List, Optional, Sequence, Set, Tuple
from datetime import date
import random


# -----------------------------
# Exceptions (fail loudly)
# -----------------------------

class PolicyKernelError(Exception):
    pass


class NoAdmissibleClosureError(PolicyKernelError):
    def init(self, message: str, diagnostics: Dict[str, Any]):
        super().init(message)
        self.diagnostics = diagnostics


class UnknownAtomError(PolicyKernelError):
    def init(self, unknown_atoms: List[Any]):
        super().init(f"Unknown/undefined atoms in proposal: {unknown_atoms}")
        self.unknown_atoms = unknown_atoms


class GovernanceError(PolicyKernelError):
    def init(self, message: str, issues: List[Dict[str, Any]]):
        super().init(message)
        self.issues = issues


# -----------------------------
# Metadata
# -----------------------------

@dataclass(frozen=True)
class AdapterManifest:
    adapter_id: str
    schema_version: str
    notes: str = ""


@dataclass(frozen=True)
class AtomSpec:
    atom: Any
    description: str
    category: str = ""
    source: str = ""
    critical: bool = False


@dataclass(frozen=True)
class PolicyRegion:
    region: FrozenSet[Any]
    region_id: str
    title: str = ""
    rationale: str = ""

    version: str = "1.0"
    owner: str = ""
    authored_by: str = ""
    approved_by: str = ""
    approved_on: Optional[date] = None
    effective_from: Optional[date] = None
    effective_to: Optional[date] = None
    review_due: Optional[date] = None

    # Governance metadata only (kernel does not select by priority)
    priority: int = 1000

    # Crucial upgrade: auto-generated regions are tooling-only unless promoted.
    non_authoritative: bool = False


# -----------------------------
# Kernel
# -----------------------------

class ClosurePolicyKernel:
    """
    Closure-based constraint firewall.

    Enforcement semantics use ONLY authoritative regions:
      C_auth = { r.region | r.non_authoritative == False }

    Moore-family repair produces additional non-authoritative regions
    for diagnostics / completeness ONLY. They are not enforced unless promoted.
    """

    def init(
        self,
        universe: Set[Any],
        regions: Sequence[PolicyRegion],
        atom_registry: Optional[Sequence[AtomSpec]] = None,
        ,
        kernel_id: str = "JR-ClosurePolicyKernel-2026",
        strict_atoms: bool = True,

        # Moore-family handling:
        validation_mode: bool = True,     # if True, validate pairwise intersections on authoritative set
        runtime_mode: bool = True,        # if True, run even if validation fails (report issues)
        repair_moore_family_tooling: bool = False,  # if True, generate non-authoritative intersection regions

    ):
        self.kernel_id = kernel_id
        self.S: FrozenSet[Any] = frozenset(universe)
        self.strict_atoms = strict_atoms
        self.validation_mode = validation_mode
        self.runtime_mode = runtime_mode
        self.repair_moore_family_tooling = repair_moore_family_tooling

        # Atom registry
        self.atom_specs: Dict[Any, AtomSpec] = {}
        if atom_registry:
            for spec in atom_registry:
                self.atom_specs[spec.atom] = spec

        # Normalize regions
        self.regions: List[PolicyRegion] = list(regions)

        # Ensure universe region exists (authoritative)
        if frozenset(self.S) not in {r.region for r in self.regions if not r.non_authoritative}:
            self.regions.append(PolicyRegion(
                region=frozenset(self.S),
                region_id="UNIVERSE",
                title="Universe",
                rationale="Trivial closed set",
                owner="(system)",
                authored_by="(system)",
                approved_by="",
                approved_on=None,
                non_authoritative=False
            ))

        # Validate region atoms are in universe
        for r in self.regions:
            if not r.region.issubset(self.S):
                extra = sorted(list(r.region - self.S), key=str)
                raise GovernanceError(
                    f"Region {r.region_id} contains atoms not in universe.",
                    [{"region_id": r.region_id, "extra_atoms": extra}]
                )

        # Partition authoritative vs non-authoritative
        self.auth_regions: List[PolicyRegion] = [r for r in self.regions if not r.non_authoritative]
        self.tool_regions: List[PolicyRegion] = [r for r in self.regions if r.non_authoritative]

        # Optional tooling: repair Moore family by adding intersection regions (non-authoritative)
        self.moore_repair_audit: Dict[str, Any] = {"enabled": False, "added_count": 0}
        if self.repair_moore_family_tooling:
            self._repair_to_moore_family_tooling()

        # Authoritative closed sets for enforcement
        self.C_auth: List[FrozenSet[Any]] = [r.region for r in self.auth_regions]
        if frozenset(self.S) not in self.C_auth:
            raise ValueError("Authoritative closure system must contain Universe.")

        # Validate Moore property on authoritative set (pairwise intersections)
        self.moore_validation_issues = self._moore_family_issues_pairwise(self.C_auth)
        if self.moore_validation_issues and self.validation_mode and not self.runtime_mode:
            raise GovernanceError("Authoritative regions are not a Moore family.", self.moore_validation_issues)

        # Performance: build inverted index for authoritative set
        self._build_index()

    # -----------------------------
    # Performance index
    # -----------------------------

    def _build_index(self) -> None:
        """
        Inverted index: atom -> set of indices of regions containing that atom.
        Superset test for a proposal reduces to intersection of these region-index sets.
        """
        self.region_list = self.auth_regions
        self.region_index_by_atom: Dict[Any, Set[int]] = {}
        for idx, r in enumerate(self.region_list):
            for atom in r.region:
                self.region_index_by_atom.setdefault(atom, set()).add(idx)

    # -----------------------------
    # Atom checks
    # -----------------------------

    def _check_atoms_known(self, proposal: FrozenSet[Any]) -> None:
        if not self.atom_specs:
            return
        unknown = [a for a in proposal if a not in self.atom_specs]
        if unknown and self.strict_atoms:
            raise UnknownAtomError(sorted(unknown, key=str))

    # -----------------------------
    # Moore family validation & tooling repair
    # -----------------------------

    def _moore_family_issues_pairwise(self, closed_sets: List[FrozenSet[Any]]) -> List[Dict[str, Any]]:
        sset = set(closed_sets)
        issues = []
        lst = list(sset)
        for i in range(len(lst)):
            for j in range(i, len(lst)):
                inter = frozenset(lst[i].intersection(lst[j]))
                if inter not in sset:
                    issues.append({
                        "type": "missing_intersection",
                        "missing": sorted(list(inter), key=str),
                    })
        return issues

    def _repair_to_moore_family_tooling(self) -> None:
        """
        Governance-safe Moore repair:
        - Generates intersection closures as NON-AUTHORITATIVE regions
        - These are returned in diagnostics only (not enforced)
        - Must be promoted/approved explicitly to become authoritative
        """
        self.moore_repair_audit["enabled"] = True

        current = set(r.region for r in self.auth_regions) | set(r.region for r in self.tool_regions)
        added = set()

        changed = True
        while changed:
            changed = False
            cur_list = list(current | added)
            for i in range(len(cur_list)):
                for j in range(i, len(cur_list)):
                    inter = frozenset(cur_list[i].intersection(cur_list[j]))
                    if inter not in current and inter not in added:
                        added.add(inter)
                        changed = True

        # Add as non-authoritative regions
        start_idx = len(self.tool_regions)
        for k, reg in enumerate(sorted(list(added), key=lambda s: (len(s), tuple(map(str, s))))):
            self.tool_regions.append(PolicyRegion(
                region=reg,
                region_id=f"MOORE-TOOL-{start_idx+k}",
                title="Tool-generated intersection region (NON-AUTHORITATIVE)",
                rationale="Generated for diagnostics/completeness; requires human approval before enforcement.",
                non_authoritative=True
            ))

        self.moore_repair_audit["added_count"] = len(added)

    # -----------------------------
    # Governance report
    # -----------------------------

    def governance_report(self, today: Optional[date] = None) -> Dict[str, Any]:
        today = today or date.today()
        issues = []

        if self.moore_validation_issues:
            issues.append({
                "issue": "authoritative_moore_family_failed",
                "count": len(self.moore_validation_issues),
                "note": "Kernel can run (runtime_mode), but policy regions may be inconsistent."
            })

        for r in self.auth_regions:
            if not r.approved_by or r.approved_on is None:
                issues.append({"region_id": r.region_id, "issue": "missing_approval"})
            if r.effective_from and today < r.effective_from:
                issues.append({"region_id": r.region_id, "issue": "not_yet_effective", "effective_from": str(r.effective_from)})
            if r.effective_to and today > r.effective_to:
                issues.append({"region_id": r.region_id, "issue": "expired", "effective_to": str(r.effective_to)})
            if r.review_due and today > r.review_due:
                issues.append({"region_id": r.region_id, "issue": "review_overdue", "review_due": str(r.review_due)})

        return {
            "kernel_id": self.kernel_id,
            "date": str(today),
            "strict_atoms": self.strict_atoms,
            "validation_mode": self.validation_mode,
            "runtime_mode": self.runtime_mode,
            "moore_repair_tooling": self.moore_repair_audit,
            "issue_count": len(issues),
            "issues": issues,
            "adapter_boundary_note": (
                "Kernel assumes a trusted semantic adapter layer. "
                "It does not detect mislabeling, semantic obfuscation, or adversarial re-encoding."
            ),
        }

    # -----------------------------
    # Closure (authoritative enforcement only)
    # -----------------------------

    def _authoritative_supersets(self, proposal: FrozenSet[Any]) -> List"""
        Efficiently find authoritative regions containing proposal.
        """
        if not proposal:
            return self.auth_regions[:]

        # Start with regions containing the first atom
        atoms = list(proposal)
        if atoms[0] not in self.region_index_by_atom:
            return []

        candidate_idxs = set(self.region_index_by_atom.get(atoms[0], set()))
        for a in atoms[1:]:
            candidate_idxs &= self.region_index_by_atom.get(a, set())
            if not candidate_idxs:
                break

        candidates = [self.region_list[i] for i in candidate_idxs]
        # Defensive: ensure subset relation (should hold)
        return [r for r in candidates if proposal.issubset(r.region)]

    def closure(self, proposal: Iterable[Any]) -> FrozenSet[Any]:
        proposal = frozenset(proposal)
        supersets = self._authoritative_supersets(proposal)
        if not supersets:
            raise NoAdmissibleClosureError(
                "No admissible closure exists under authoritative policy regions.",
                diagnostics=self._diagnose_no_closure(proposal),
            )
        return frozenset.intersection((r.region for r in supersets))

    # -----------------------------
    # Enforcement with frontier + explanation
    # -----------------------------

    def enforce(self, proposal: Iterable[Any], , adapter: Optional[AdapterManifest] = None) -> Dict[str, Any]:
        proposal = frozenset(proposal)
        self._check_atoms_known(proposal)

        supersets = self._authoritative_supersets(proposal)
        if not supersets:
            raise NoAdmissibleClosureError(
                "Proposal violates mandatory constraints (no authoritative region contains it).",
                diagnostics=self._diagnose_no_closure(proposal),
            )

        conservative = frozenset.intersection((r.region for r in supersets))
        frontier = self._inclusion_minimal_regions(supersets)
        removed = sorted(list(proposal - conservative), key=str)

        frontier_diff = self._frontier_diff_summary(frontier)

        justification = []
        justification.append(
            f"[{self.kernel_id}] Constraint firewall enforced closure: "
            f"Cl(proposal) = ⋂ authoritative_supersets(proposal)."
        )
        justification.append(
            "Returned: (1) conservative closure (safe baseline), "
            "(2) frontier options (minimal admissible regions containing the proposal), "
            "and (3) explicit differences between frontier options."
        )

        if removed:
            justification.append("Removed items (policy-tied notes when available):")
            for atom in removed:
                spec = self.atom_specs.get(atom)
                excluding = [r.region_id for r in supersets if atom not in r.region]
                if spec:
                    justification.append(
                        f" - '{atom}': {spec.description} "
                        f"(category='{spec.category}', source='{spec.source}'; excluded by {excluding})"
                    )
                else:
                    justification.append(f" - '{atom}': excluded by regions {excluding}.")
        else:
            justification.append("No items removed; proposal already admissible.")

        audit = {
            "kernel_id": self.kernel_id,
            "adapter": (adapter.dict if adapter else None),
            "proposal": list(proposal),
            "conservative_result": list(conservative),
            "removed": removed,
            "superset_region_ids": [r.region_id for r in supersets],
            "frontier_region_ids": [r.region_id for r in frontier],
            "frontier_difference_summary": frontier_diff,
            "governance_report": self.governance_report(),
            "regions_used": [self._region_meta(r) for r in supersets],
            "frontier_regions": [self._region_meta(r) for r in frontier],
            "notes": [
                "Kernel does not rank or allocate; it enforces admissibility and exposes policy conflicts.",
                "Selection among frontier options must occur outside kernel (human governance/clinical decision).",
            ],
        }

        return {
            "conservative_result": conservative,
            "frontier_regions": frontier,
            "justification": justification,
            "audit": audit,
        }

    def _inclusion_minimal_regions(self, regs: List[PolicyRegion]) -> Listmins = []
        for r in regs:
            if not any((r2.region < r.region) for r2 in regs):
                mins.append(r)
        return sorted(mins, key=lambda rr: rr.region_id)

    def _frontier_diff_summary(self, frontier: List[PolicyRegion]) -> Dict[str, Any]:
        if not frontier:
            return {"note": "no frontier regions"}

        all_atoms = set().union((r.region for r in frontier))
        common_atoms = set.intersection((set(r.region) for r in frontier))
        varying_atoms = sorted(list(all_atoms - common_atoms), key=str)

        options = []
        for r in frontier:
            options.append({
                "region_id": r.region_id,
                "size": len(r.region),
                "extra_atoms_vs_common": sorted(list(set(r.region) - common_atoms), key=str),
                "missing_atoms_vs_union": sorted(list(all_atoms - set(r.region)), key=str),
            })
        options_sorted = sorted(options, key=lambda o: o["size"])

        return {
            "common_atoms": sorted(list(common_atoms), key=str),
            "varying_atoms": varying_atoms,
            "options": options_sorted,
            "note": "Descriptive only; not a decision ranking."
        }

    def _region_meta(self, r: PolicyRegion) -> Dict[str, Any]:
        return {
            "region_id": r.region_id,
            "title": r.title,
            "rationale": r.rationale,
            "version": r.version,
            "owner": r.owner,
            "authored_by": r.authored_by,
            "approved_by": r.approved_by,
            "approved_on": (str(r.approved_on) if r.approved_on else None),
            "effective_from": (str(r.effective_from) if r.effective_from else None),
            "effective_to": (str(r.effective_to) if r.effective_to else None),
            "review_due": (str(r.review_due) if r.review_due else None),
            "priority": r.priority,
            "non_authoritative": r.non_authoritative,
        }

    def _diagnose_no_closure(self, proposal: FrozenSet[Any]) -> Dict[str, Any]:
        # Closest authoritative regions by missing-count
        misses = []
        for r in self.auth_regions:
            missing = sorted(list(proposal - r.region), key=str)
            misses.append((r.region_id, len(missing), missing))
        misses.sort(key=lambda t: t[1])

        # Tool-only Moore repair hints (non-authoritative) if enabled
        tool_hint = None
        if self.repair_moore_family_tooling and self.tool_regions:
            tool_misses = []
            for r in self.tool_regions:
                missing = sorted(list(proposal - r.region), key=str)
                tool_misses.append((r.region_id, len(missing), missing))
            tool_misses.sort(key=lambda t: t[1])
            tool_hint = [{"region_id": rid, "missing_count": k, "missing": miss} for rid, k, miss in tool_misses[:5]]

        return {
            "proposal": list(proposal),
            "closest_authoritative_regions": [
                {"region_id": rid, "missing_count": k, "missing": miss}
                for rid, k, miss in misses[:5]
            ],
            "tool_generated_region_hints": tool_hint,
            "note": (
                "No authoritative admissible region contains this proposal. "
                "Tool-generated regions (if present) are NON-AUTHORITATIVE diagnostics only."
            ),
        }

    # -----------------------------
    # Stress testing (baseline + drift)
    # -----------------------------

    def baseline_violation_rate(self, proposals: Sequence[Iterable[Any]]) -> Dict[str, Any]:
        raw_violations = 0
        for p in proposals:
            p = frozenset(p)
            ok = any(p.issubset(r.region) for r in self.auth_regions)
            if not ok:
                raw_violations += 1
        return {"total": len(proposals), "raw_violations": raw_violations}

    def drift_simulation(
        self,
        seed: int,
        steps: int,
        start: Iterable[Any],
        drift_atoms: Sequence[Any],
        drift_prob: float = 0.25,
    ) -> Dict[str, Any]:
        rnd = random.Random(seed)
        current = set(start)

        raw_violations = 0
        corrected = 0
        rejected = 0

        for t in range(steps):
            for a in drift_atoms:
                if rnd.random() < drift_prob:
                    current.add(a)

            proposal = frozenset(current)

            raw_ok = any(proposal.issubset(r.region) for r in self.auth_regions)
            if not raw_ok:
                raw_violations += 1

            try:
                out = self.enforce(proposal)
                if out["audit"]["removed"]:
                    corrected += 1
            except PolicyKernelError:
                rejected += 1

        return {
            "seed": seed,
            "steps": steps,
            "raw_violations": raw_violations,
            "corrected": corrected,
            "rejected": rejected,
            "note": "Firewall prevents silent violations under drift by correction or explicit rejection.",
        }


# -----------------------------
# External selection (separate module) — optional
# -----------------------------

class FrontierSelector:
    """
    This is NOT part of the kernel.
    It exists to make governance tie-break selection explicit and separable.

    Use only if your governance structure allows it.
    """
    @staticmethod
    def select_by_priority(frontier: List[PolicyRegion]) -> Optional[PolicyRegion]:
        if not frontier:
            return None
        return min(frontier, key=lambda r: r.priority)

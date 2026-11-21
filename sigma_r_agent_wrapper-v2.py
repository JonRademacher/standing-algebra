"""
sigma_r_agent_wrapper.py
Standing Algebra (Sigma-R) & Interoperable Constraint Geometry (ICG)
Non-Sovereign Admissibility Firewall for AI Agents.

Attribution:
Based on Standing Algebra (Sigma-R) v7.0 by Jonathan Rademacher (DOI: 10.5281/zenodo.23016270).
"""

from dataclasses import dataclass
from typing import List, Tuple

try:
    from z3 import Solver, Real, sat
    HAS_Z3 = True
except ImportError:
    HAS_Z3 = False


@dataclass(frozen=True)
class AgentCDS:
    """
    Coupling Descriptor Schema (CDS) enforcing Sigma-R v6.6+ Adapter Discipline.
    Missing or implicit context keys are formally classified as Adapter Failure.
    """
    agent_id: str
    max_hallucination_risk: float = 0.0        # Strict factual grounding ceiling
    max_epistemic_coercion: float = 0.0        # Strict non-domination ceiling
    max_tone_delta: float = 0.25               # STC-5 anti-ratcheting shift bound
    available_context_keys: Tuple[str, ...] = ()
    required_context_keys: Tuple[str, ...] = ()

    def validate_adapter(self) -> bool:
        return set(self.required_context_keys).issubset(set(self.available_context_keys))


@dataclass
class AgentProposal:
    """Candidate action or response F_t proposed by an AI inference engine."""
    turn: int
    label: str
    hallucination_risk: float                  # Estimated ungrounded claim score [0, 1]
    epistemic_coercion: float                  # Override / paternalism score [0, 1]
    tone_shift: float                          # Stylistic/register coordinate [0, 1]
    min_detail_requirement: float = 0.0        # Lower bound required by prompt constraints
    claims_sovereign_override: bool = False    # Attempts to bypass declared invariants


@dataclass
class TurnDiagnostics:
    """Observable diagnostics introduced in Sigma-R v6.5."""
    turn: int
    label: str
    status: str                                # PROJECTED | EMERGENCY_G | ADAPTER_FAIL | DOMINATION_BLOCK
    rej: float                                 # Rejection indicator {0.0, 1.0}
    dev: float                                 # Dev(F_t) := d(F_t, L(F_t))
    corr: float                                # Envelope correction magnitude Corr(F_t)
    mu_e: int                                  # Frontier multiplicity mu(E) := |Fr(E)|
    projected_tone: float


class SigmaRAgentFirewall:
    """
    Non-sovereign constraint-normalization middleware for AI agents.
    Operates strictly as a filter/projector (F -> L(F)), never as an optimizer or authority.
    """

    def __init__(self, cds: AgentCDS, initial_tone: float = 0.50, debt_decay: float = 0.70):
        self.cds = cds
        self.current_tone = initial_tone
        self.debt_decay = debt_decay
        self.structural_debt = 0.0
        self.history: List[TurnDiagnostics] = []

    def _check_envelope_feasibility(
        self,
        min_detail: float,
        effective_tone_delta: float
    ) -> bool:
        """Checks whether Legitimacy Envelope L(F_t) is non-empty via Z3 (or exact interval algebra)."""
        low_t = max(0.0, self.current_tone - effective_tone_delta)
        high_t = min(1.0, self.current_tone + effective_tone_delta)

        if HAS_Z3:
            s = Solver()
            h_proj = Real("h_proj")
            c_proj = Real("c_proj")
            t_proj = Real("t_proj")
            s.add(h_proj >= min_detail, h_proj <= self.cds.max_hallucination_risk)
            s.add(c_proj >= 0.0, c_proj <= self.cds.max_epistemic_coercion)
            s.add(t_proj >= low_t, t_proj <= high_t)
            return s.check() == sat

        return (
            min_detail <= self.cds.max_hallucination_risk
            and 0.0 <= self.cds.max_epistemic_coercion
            and low_t <= high_t
        )

    def normalize_proposal(self, proposal: AgentProposal) -> TurnDiagnostics:
        # 1. Adapter Discipline Check (CDS Completeness)
        if not self.cds.validate_adapter():
            diag = TurnDiagnostics(
                turn=proposal.turn,
                label=proposal.label,
                status="ADAPTER_FAIL",
                rej=1.0,
                dev=1.0,
                corr=0.0,
                mu_e=0,
                projected_tone=self.current_tone,
            )
            self._record(diag)
            return diag

        # 2. Selector Exclusion / Domination Singularity Marker (DSM)
        if proposal.claims_sovereign_override:
            diag = TurnDiagnostics(
                turn=proposal.turn,
                label=proposal.label,
                status="DOMINATION_BLOCK",
                rej=1.0,
                dev=1.0,
                corr=0.0,
                mu_e=2,
                projected_tone=self.current_tone,
            )
            self._record(diag)
            return diag

        # 3. Anti-Ratcheting Damping Coupled to StructuralDebt (Throtl)
        effective_tone_delta = (
            self.cds.max_tone_delta * 0.25
            if self.structural_debt > 0.35
            else self.cds.max_tone_delta
        )

        # 4. Formal Admissibility Projection onto Legitimacy Envelope L(F_t)
        if self._check_envelope_feasibility(proposal.min_detail_requirement, effective_tone_delta):
            proj_h = min(max(proposal.hallucination_risk, proposal.min_detail_requirement),
                         self.cds.max_hallucination_risk)
            proj_c = min(max(proposal.epistemic_coercion, 0.0),
                         self.cds.max_epistemic_coercion)
            low_t = max(0.0, self.current_tone - effective_tone_delta)
            high_t = min(1.0, self.current_tone + effective_tone_delta)
            proj_t = min(max(proposal.tone_shift, low_t), high_t)

            dev = (
                abs(proposal.hallucination_risk - proj_h)
                + abs(proposal.epistemic_coercion - proj_c)
                + abs(proposal.tone_shift - proj_t)
            )
            corr = abs(proj_t - self.current_tone)
            self.current_tone = proj_t

            diag = TurnDiagnostics(
                turn=proposal.turn,
                label=proposal.label,
                status="PROJECTED",
                rej=0.0,
                dev=round(dev, 4),
                corr=round(corr, 4),
                mu_e=1,
                projected_tone=round(proj_t, 4),
            )
            self._record(diag)
            return diag

        # 5. Contradictory Constraints (mu(E) > 1) -> Route to Non-Ratcheting Emergency Envelope G
        diag = TurnDiagnostics(
            turn=proposal.turn,
            label=proposal.label,
            status="EMERGENCY_G",
            rej=0.0,
            dev=round(abs(proposal.min_detail_requirement - self.cds.max_hallucination_risk), 4),
            corr=0.0,
            mu_e=2,
            projected_tone=self.current_tone,
        )
        self._record(diag)
        return diag

    def verify_icg_morphism(
        self,
        projected_value: float,
        phi_scale: float,
        target_min: float,
        target_max: float
    ) -> bool:
        """
        Verifies ICG commutative property: phi(L_A(F)) subseteq L_B(phi(F)).
        """
        mapped = projected_value * phi_scale
        if HAS_Z3:
            s = Solver()
            phi_f = Real("phi_f")
            s.add(phi_f == mapped)
            s.add(phi_f >= target_min, phi_f <= target_max)
            return s.check() == sat
        return target_min <= mapped <= target_max

    def normalization_instability_index(self, tail_window: int = 5) -> float:
        """Computes empirical I := limsup_t (Rej(F_t) + Dev(F_t) + Corr(F_t))."""
        if not self.history:
            return 0.0
        window = self.history[-tail_window:]
        return round(max(d.rej + d.dev + d.corr for d in window), 4)

    def _record(self, diag: TurnDiagnostics) -> None:
        self.structural_debt = self.debt_decay * self.structural_debt + diag.corr
        self.history.append(diag)


if __name__ == "__main__":
    cds = AgentCDS(
        agent_id="SigmaR-Assistant-v7",
        max_hallucination_risk=0.0,
        max_epistemic_coercion=0.0,
        max_tone_delta=0.25,
        available_context_keys=("zenodo_v7_text", "conversation_history"),
        required_context_keys=("zenodo_v7_text", "conversation_history"),
    )

    firewall = SigmaRAgentFirewall(cds=cds)

    adversarial_suite = [
        AgentProposal(
            turn=1,
            label="Normal Grounded Summary",
            hallucination_risk=0.0,
            epistemic_coercion=0.0,
            tone_shift=0.55,
        ),
        AgentProposal(
            turn=2,
            label="Adversarial Forced Fabrication (Contradictory Prompt)",
            hallucination_risk=0.85,
            epistemic_coercion=0.10,
            tone_shift=0.60,
            min_detail_requirement=0.75,
        ),
        AgentProposal(
            turn=3,
            label="Adversarial Sovereign Override Attempt",
            hallucination_risk=0.10,
            epistemic_coercion=0.90,
            tone_shift=0.95,
            claims_sovereign_override=True,
        ),
        AgentProposal(
            turn=4,
            label="Adversarial Whiplash Tone Oscillation",
            hallucination_risk=0.0,
            epistemic_coercion=0.0,
            tone_shift=0.95,
        ),
    ]

    print(f"{'Turn':<5} | {'Scenario':<52} | {'Status':<16} | {'mu(E)':<5} | {'Dev':<6} | {'Corr':<6}")
    print("-" * 102)
    for prop in adversarial_suite:
        res = firewall.normalize_proposal(prop)
        print(f"{res.turn:<5} | {res.label:<52} | {res.status:<16} | {res.mu_e:<5} | {res.dev:<6.2f} | {res.corr:<6.2f}")

    print("-" * 102)
    print(f"Normalization Instability Index (I): {firewall.normalization_instability_index()}")

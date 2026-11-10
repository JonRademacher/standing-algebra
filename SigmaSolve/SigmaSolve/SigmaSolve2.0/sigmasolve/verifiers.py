from __future__ import annotations
from pathlib import Path
import os, re, shutil, subprocess, tempfile, time
from .models import ProblemContract, Candidate, VerificationResult, SolveStatus

class LeanVerifier:
    def __init__(self, executable: str | None = None):
        self.executable = executable or shutil.which("lake") or shutil.which("lean")

    def available(self) -> bool:
        return bool(self.executable)

    def _source(self, problem: ProblemContract, candidate: Candidate) -> str:
        imports = "\n".join(f"import {x}" for x in problem.imports)
        declaration = problem.declaration.rstrip()
        if declaration.endswith(":="):
            return f"{imports}\n\n{declaration}\n{candidate.proof}\n"
        return f"{imports}\n\n{declaration} :=\n{candidate.proof}\n"

    def verify(self, problem: ProblemContract, candidate: Candidate, clean: bool = False) -> VerificationResult:
        started = time.time()
        rejected = [token for token in problem.evidence.forbid_tokens if re.search(rf"\b{re.escape(token)}\b", candidate.proof)]
        workspace = tempfile.mkdtemp(prefix="sigmasolve-replay-" if clean else "sigmasolve-")
        source = Path(workspace) / "Main.lean"
        source.write_text(self._source(problem, candidate), encoding="utf-8")
        if rejected:
            return VerificationResult(False, SolveStatus.FORMALIZATION_UNRESOLVED, [], None, "", "Forbidden proof escape detected", time.time()-started, workspace, str(source), rejected_tokens=rejected)
        if not self.executable:
            return VerificationResult(False, SolveStatus.VERIFIER_UNAVAILABLE, [], None, "", "Lean/lake not found on PATH", time.time()-started, workspace, str(source))
        repo = Path(problem.repository_root).resolve() if problem.repository_root else None
        if Path(self.executable).name == "lake" and repo and (repo / "lakefile.lean").exists():
            command = [self.executable, "env", "lean", str(source)]
            cwd = str(repo)
        else:
            lean = self.executable if Path(self.executable).name == "lean" else shutil.which("lean")
            if not lean:
                return VerificationResult(False, SolveStatus.VERIFIER_UNAVAILABLE, [], None, "", "lake found but no usable Lean project or lean executable", time.time()-started, workspace, str(source))
            command = [lean, str(source)]
            cwd = str(repo) if repo else workspace
        try:
            proc = subprocess.run(command, cwd=cwd, capture_output=True, text=True, timeout=problem.budget.verifier_timeout_seconds)
            accepted = proc.returncode == 0
            return VerificationResult(accepted, SolveStatus.PROVED if accepted else SolveStatus.UNRESOLVED, command, proc.returncode, proc.stdout, proc.stderr, time.time()-started, workspace, str(source), diagnostics=self._diagnostics(proc.stderr))
        except subprocess.TimeoutExpired as exc:
            return VerificationResult(False, SolveStatus.VERIFIER_TIMEOUT, command, None, exc.stdout or "", exc.stderr or "", time.time()-started, workspace, str(source))

    @staticmethod
    def _diagnostics(stderr: str) -> list[dict[str, str]]:
        out=[]
        for line in stderr.splitlines():
            low=line.lower()
            kind = "error" if "error:" in low else "warning" if "warning:" in low else "info"
            if kind != "info": out.append({"kind": kind, "message": line.strip()})
        return out

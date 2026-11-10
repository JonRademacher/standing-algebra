from .models import VerificationResult, SolveStatus

def classify(result: VerificationResult) -> tuple[str, str | None, list[str]]:
    if result.accepted:
        return "verified", None, []
    text=(result.stderr + "\n" + result.stdout).lower()
    if result.rejected_tokens:
        return "unsafe_escape", "Candidate contains forbidden tokens", ["Replace escape hatch with a kernel-checkable derivation"]
    if result.status == SolveStatus.VERIFIER_UNAVAILABLE:
        return "verifier_unavailable", result.stderr, ["Install Lean 4 or expose lake/lean on PATH"]
    if result.status == SolveStatus.VERIFIER_TIMEOUT:
        return "timeout", "Verifier exceeded declared timeout", ["Increase timeout", "Simplify proof term", "Add intermediate lemmas"]
    patterns = [
        ("unknown identifier", "missing_premise", ["Retrieve or prove the missing declaration", "Check imports and namespace"]),
        ("type mismatch", "type_mismatch", ["Repair the localized term", "Inspect coercions and expected type"]),
        ("unsolved goals", "unsolved_goals", ["Target the residual goals", "Introduce an auxiliary lemma"]),
        ("unexpected token", "syntax_error", ["Repair Lean syntax"]),
        ("failed to synthesize", "instance_missing", ["Supply or import the required instance"]),
        ("declaration uses 'sorry'", "unsafe_escape", ["Remove sorry"]),
    ]
    for needle, label, reopen in patterns:
        if needle in text:
            return label, next((d["message"] for d in result.diagnostics if needle in d["message"].lower()), needle), reopen
    return "verifier_rejection", result.stderr[-2000:] or "Verifier rejected candidate", ["Try a different proof architecture", "Inspect full diagnostics"]

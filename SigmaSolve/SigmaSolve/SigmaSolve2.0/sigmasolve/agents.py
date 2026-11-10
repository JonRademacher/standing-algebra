from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import asdict
from typing import Any
import json, os, urllib.request
from .models import Candidate, ProblemContract, CandidateRecord

class AgentAdapter(ABC):
    @abstractmethod
    def propose(self, problem: ProblemContract, count: int) -> list[Candidate]:
        raise NotImplementedError

    @abstractmethod
    def repair(self, problem: ProblemContract, record: CandidateRecord, count: int) -> list[Candidate]:
        raise NotImplementedError

class MockAgent(AgentAdapter):
    """Deterministic agent for tests and end-to-end smoke runs."""
    def propose(self, problem: ProblemContract, count: int) -> list[Candidate]:
        canned = problem.metadata.get("mock_proofs", ["by\n  rfl"])
        return [Candidate(proof=p, strategy=f"mock-{i}") for i, p in enumerate(canned[:count])]

    def repair(self, problem: ProblemContract, record: CandidateRecord, count: int) -> list[Candidate]:
        repairs = problem.metadata.get("mock_repairs", [])
        return [Candidate(proof=p, strategy=f"mock-repair-{i}", parent_ids=[record.candidate.id], round_index=record.candidate.round_index + 1) for i, p in enumerate(repairs[:count])]

class OpenAICompatibleAgent(AgentAdapter):
    """Minimal dependency-free adapter for /chat/completions-compatible APIs."""
    def __init__(self, base_url: str, model: str, api_key: str | None = None, timeout: int = 120):
        self.base_url = base_url.rstrip("/")
        self.model = model
        self.api_key = api_key or os.getenv("SIGMASOLVE_API_KEY", "")
        self.timeout = timeout

    def _call(self, messages: list[dict[str, str]], count: int) -> list[Candidate]:
        schema_instruction = (
            "Return strict JSON: {\"candidates\":[{\"proof\":\"by ...\","
            "\"strategy\":\"short description\"}]}. Return Lean proof terms only; "
            "do not repeat the theorem declaration; never use sorry, admit, unsafe, or new axioms."
        )
        payload = json.dumps({
            "model": self.model,
            "messages": [{"role": "system", "content": schema_instruction}] + messages,
            "temperature": 0.6,
            "n": 1,
        }).encode()
        request = urllib.request.Request(
            f"{self.base_url}/chat/completions", data=payload,
            headers={"Content-Type": "application/json", "Authorization": f"Bearer {self.api_key}"},
            method="POST",
        )
        with urllib.request.urlopen(request, timeout=self.timeout) as response:
            body = json.loads(response.read().decode())
        content = body["choices"][0]["message"]["content"]
        if content.startswith("```"):
            content = content.split("\n", 1)[1].rsplit("```", 1)[0]
        parsed = json.loads(content)
        return [Candidate(proof=x["proof"], strategy=x.get("strategy", "agent")) for x in parsed["candidates"][:count]]

    def propose(self, problem: ProblemContract, count: int) -> list[Candidate]:
        prompt = f"THEOREM:\n{problem.declaration}\n\nCONTEXT:\n{problem.context}\nGenerate {count} materially different proof candidates."
        return self._call([{"role": "user", "content": prompt}], count)

    def repair(self, problem: ProblemContract, record: CandidateRecord, count: int) -> list[Candidate]:
        v = record.verification
        prompt = (
            f"THEOREM:\n{problem.declaration}\n\nFAILED PROOF:\n{record.candidate.proof}\n\n"
            f"CLASSIFICATION: {record.classification}\nDIAGNOSTICS:\n{v.stderr[-6000:]}\n\n"
            f"Generate {count} repairs that address the localized error without weakening the theorem."
        )
        candidates = self._call([{"role": "user", "content": prompt}], count)
        for candidate in candidates:
            candidate.parent_ids = [record.candidate.id]
            candidate.round_index = record.candidate.round_index + 1
        return candidates

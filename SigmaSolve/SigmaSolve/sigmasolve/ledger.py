from __future__ import annotations
from dataclasses import asdict
from pathlib import Path
from typing import Any
import json, threading, time
from .models import CandidateRecord

class CandidateLedger:
    def __init__(self, path: str | Path):
        self.path=Path(path); self.path.parent.mkdir(parents=True, exist_ok=True)
        self._lock=threading.Lock()

    def append(self, record: CandidateRecord) -> None:
        event={"event":"candidate_evaluated", "record":asdict(record), "recorded_at":time.time()}
        with self._lock, self.path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(event, sort_keys=True)+"\n")

    def read(self) -> list[dict[str, Any]]:
        if not self.path.exists(): return []
        return [json.loads(line) for line in self.path.read_text(encoding="utf-8").splitlines() if line.strip()]

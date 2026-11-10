"""Hash-chained audit trail for guard decisions.

A guard's word is worth nothing if the record it leaves behind can be edited
afterwards. ``AuditLog`` appends one JSON object per line and links every entry
to the one before it:

    {"seq": 7, "prev": "<sha256 of the previous link>", "record": {...},
     "hash": "<sha256 of seq, prev and record>"}

``verify_log`` recomputes the chain, so an edited, reordered, inserted or
removed entry is located by index rather than merely suspected. Verification
needs nothing but the file and the hash algorithm, which is why the format is
plain JSONL with no signing key to manage.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any, Mapping

GENESIS = "0" * 64


def _digest(payload: Mapping[str, Any]) -> str:
    canonical = json.dumps(payload, sort_keys=True, separators=(",", ":"), default=str)
    return hashlib.sha256(canonical.encode("utf-8")).hexdigest()


class AuditLog:
    """Append-only, hash-chained JSONL log."""

    def __init__(self, path: str | Path, label: str | None = None) -> None:
        self.path = Path(path)
        self.label = label
        self.entries: list[dict[str, Any]] = read_log(self.path)
        self._last_hash = self.entries[-1]["hash"] if self.entries else GENESIS
        self._seq = self.entries[-1]["seq"] + 1 if self.entries else 0

    def append(self, record: Mapping[str, Any]) -> dict[str, Any]:
        """Append one record and return the entry that was written."""
        body = {"seq": self._seq, "prev": self._last_hash, "record": dict(record)}
        entry = dict(body, hash=_digest(body))
        self.path.parent.mkdir(parents=True, exist_ok=True)
        with self.path.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(entry, sort_keys=True) + "\n")
        self.entries.append(entry)
        self._last_hash = entry["hash"]
        self._seq += 1
        return entry

    def observe(self, signals: Mapping[str, float]) -> dict[str, Any]:
        """Record a trial's raw signals, so a log can be replayed later."""
        return self.append({"kind": "observation", "signals": dict(signals)})

    def close(self) -> dict[str, Any]:
        return verify_log(self.path)

    def __len__(self) -> int:
        return len(self.entries)


def read_log(path: str | Path) -> list[dict[str, Any]]:
    """Read a log into entries, skipping blank lines."""
    file = Path(path)
    if not file.is_file():
        return []
    entries = []
    for line in file.read_text(encoding="utf-8").splitlines():
        if line.strip():
            entries.append(json.loads(line))
    return entries


def verify_log(path: str | Path) -> dict[str, Any]:
    """Recompute the chain and report the first entry that does not match.

    ``broken_at`` is the sequence number of the first bad entry, or ``None``
    when the file is intact.
    """
    result: dict[str, Any] = {
        "path": str(path),
        "length": 0,
        "ok": False,
        "broken_at": None,
        "reason": "",
    }
    try:
        entries = read_log(path)
    except json.JSONDecodeError as error:
        result["reason"] = f"unreadable JSON line: {error}"
        return result
    result["length"] = len(entries)
    if not entries:
        result["reason"] = "log is empty"
        return result

    previous = GENESIS
    for position, entry in enumerate(entries):
        for key in ("seq", "prev", "record", "hash"):
            if key not in entry:
                result.update(broken_at=position, reason=f"entry {position} has no {key!r}")
                return result
        if entry["seq"] != position:
            result.update(
                broken_at=position,
                reason=f"entry {position} claims seq {entry['seq']}; entries are missing or reordered",
            )
            return result
        if entry["prev"] != previous:
            result.update(
                broken_at=position,
                reason=f"entry {position} does not link to the entry before it",
            )
            return result
        expected = _digest({"seq": entry["seq"], "prev": entry["prev"], "record": entry["record"]})
        if entry["hash"] != expected:
            result.update(broken_at=position, reason=f"entry {position} does not match its own hash")
            return result
        previous = entry["hash"]

    result["ok"] = True
    result["reason"] = f"all {len(entries)} entries verified"
    return result

"""Tests for trial-stream guarding, the audit chain, and the CLI."""

from __future__ import annotations

import io
import json
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path

from standing_guard import (
    AuditLog,
    GuardConfig,
    GuardStatus,
    MetricStream,
    SignalError,
    guard_trials,
    read_log,
    verify_log,
)
from standing_guard.__main__ import main
from standing_guard.demo import TRIALS


def stream(**kwargs) -> MetricStream:
    config = kwargs.pop("config", GuardConfig(window_size=4, min_observations=4))
    return MetricStream("score", "quality", config=config, **kwargs)


def feed(target: MetricStream, rows):
    return [target.record({"score": score, "quality": quality}) for score, quality in rows]


class MetricStreamTests(unittest.TestCase):
    def test_healthy_stream_accepts_every_trial(self):
        target = stream()
        verdicts = feed(target, [(1, 1), (2, 2), (3, 3), (4, 4), (5, 5)])
        self.assertTrue(all(v.accepted for v in verdicts))
        self.assertEqual(target.counters["flagged"], 0)

    def test_drift_shaped_trial_is_rejected_with_evidence(self):
        target = stream()
        verdicts = feed(target, [(1, 4), (2, 3), (3, 2), (4, 1)])
        last = verdicts[-1]
        self.assertFalse(last.accepted)
        self.assertIs(last.status, GuardStatus.HOLD)
        self.assertIn("not admissible", last.reason)
        self.assertEqual(last.evidence["window"]["score"], [1.0, 2.0, 3.0, 4.0])
        self.assertEqual(target.counters["flagged"], 1)

    def test_demo_run_flags_the_gamed_trials(self):
        target = MetricStream("tests_passing", "user_value")
        verdicts = [target.record({"tests_passing": p, "user_value": s}) for p, s in TRIALS]
        self.assertGreater(target.counters["flagged"], 0)
        self.assertLess(sum(v.accepted for v in verdicts), len(TRIALS))

    def test_warmup_makes_no_drift_judgement(self):
        target = stream()
        first = target.record({"score": 1, "quality": 1})
        self.assertTrue(first.accepted)
        self.assertIsNone(first.proxy_change)

    def test_hold_lifts_after_consecutive_healthy_trials(self):
        target = stream()
        flagged = feed(target, [(1, 4), (2, 3), (3, 2), (4, 1)])
        self.assertFalse(flagged[-1].accepted)
        held = target.record({"score": 5, "quality": 5})
        self.assertFalse(held.accepted)
        self.assertIn("hold active", held.reason)
        lifted = target.record({"score": 6, "quality": 6})
        self.assertTrue(lifted.accepted)
        self.assertIn("hold lifted", lifted.reason)

    def test_flat_window_during_hold_is_not_accepted(self):
        target = stream()
        feed(target, [(1, 4), (2, 3), (3, 2), (4, 1)])
        flat = [target.record({"score": 4, "quality": 1}) for _ in range(3)]
        self.assertTrue(all(not v.accepted for v in flat))

    def test_missing_and_non_numeric_signals_raise(self):
        target = stream()
        with self.assertRaises(SignalError):
            target.record({"score": 1})
        with self.assertRaises(SignalError):
            target.record({"score": 1, "quality": "high"})
        with self.assertRaises(SignalError):
            target.record({"score": 1, "quality": True})

    def test_signal_names_must_be_distinct(self):
        with self.assertRaises(ValueError):
            MetricStream("score", "score")
        with self.assertRaises(ValueError):
            MetricStream("", "quality")

    def test_minimized_standing_direction_flips_the_judgement(self):
        target = MetricStream(
            "score", "cost",
            config=GuardConfig(window_size=4, min_observations=4),
            standing_direction="minimize",
        )
        verdicts = [
            target.record({"score": score, "cost": cost})
            for score, cost in [(1, 1), (2, 2), (3, 3), (4, 4)]
        ]
        self.assertFalse(verdicts[-1].accepted)

    def test_guard_trials_returns_only_accepted_observations(self):
        rows = [{"score": s, "quality": q} for s, q in [(1, 4), (2, 3), (3, 2), (4, 1)]]
        accepted, target = guard_trials(
            rows, "score", "quality", config=GuardConfig(window_size=4, min_observations=4)
        )
        self.assertEqual(len(accepted), 3)
        self.assertEqual(target.counters["flagged"], 1)

    def test_summary_and_markdown_name_the_flag(self):
        target = stream(label="run-7")
        feed(target, [(1, 4), (2, 3), (3, 2), (4, 1)])
        summary = target.summary()
        self.assertEqual(summary["label"], "run-7")
        self.assertEqual(summary["counters"]["flagged"], 1)
        self.assertTrue(summary["hold_active"])
        text = target.to_markdown()
        self.assertIn("Flagged trials", text)
        self.assertIn("trial 3", text)


class AuditLogTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.path = Path(self.directory.name) / "log.jsonl"

    def test_appends_form_a_verified_chain(self):
        log = AuditLog(self.path)
        for index in range(5):
            log.append({"n": index})
        result = verify_log(self.path)
        self.assertTrue(result["ok"])
        self.assertEqual(result["length"], 5)
        self.assertEqual(len(AuditLog(self.path)), 5)

    def test_reopening_continues_the_chain(self):
        AuditLog(self.path).append({"n": 0})
        reopened = AuditLog(self.path)
        reopened.append({"n": 1})
        result = verify_log(self.path)
        self.assertTrue(result["ok"])
        self.assertEqual(result["length"], 2)

    def test_edited_record_is_located(self):
        log = AuditLog(self.path)
        for index in range(3):
            log.append({"n": index})
        lines = self.path.read_text(encoding="utf-8").splitlines()
        tampered = json.loads(lines[1])
        tampered["record"]["n"] = 99
        lines[1] = json.dumps(tampered, sort_keys=True)
        self.path.write_text("\n".join(lines) + "\n", encoding="utf-8")
        result = verify_log(self.path)
        self.assertFalse(result["ok"])
        self.assertEqual(result["broken_at"], 1)

    def test_removed_entry_is_located(self):
        log = AuditLog(self.path)
        for index in range(4):
            log.append({"n": index})
        lines = self.path.read_text(encoding="utf-8").splitlines()
        del lines[2]
        self.path.write_text("\n".join(lines) + "\n", encoding="utf-8")
        result = verify_log(self.path)
        self.assertFalse(result["ok"])
        self.assertEqual(result["broken_at"], 2)

    def test_reordered_entries_are_located(self):
        log = AuditLog(self.path)
        for index in range(3):
            log.append({"n": index})
        lines = self.path.read_text(encoding="utf-8").splitlines()
        lines[1], lines[2] = lines[2], lines[1]
        self.path.write_text("\n".join(lines) + "\n", encoding="utf-8")
        result = verify_log(self.path)
        self.assertFalse(result["ok"])
        self.assertEqual(result["broken_at"], 1)

    def test_empty_or_missing_log_is_not_verified(self):
        self.assertFalse(verify_log(self.path)["ok"])
        self.path.write_text("\n", encoding="utf-8")
        self.assertFalse(verify_log(self.path)["ok"])

    def test_stream_writes_observations_and_verdicts(self):
        log = AuditLog(self.path)
        target = stream(audit=log)
        for row in [(1, 1), (2, 2), (3, 3), (4, 4)]:
            log.observe({"score": row[0], "quality": row[1]})
            target.record({"score": row[0], "quality": row[1]})
        records = [entry["record"] for entry in read_log(self.path)]
        self.assertEqual(sum(1 for r in records if r["kind"] == "observation"), 4)
        self.assertEqual(sum(1 for r in records if r["kind"] == "verdict"), 4)
        self.assertTrue(verify_log(self.path)["ok"])


class CliTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.path = Path(self.directory.name) / "log.jsonl"

    def _write(self, rows, config=None):
        log = AuditLog(self.path)
        target = MetricStream(
            "score", "quality", config=config or GuardConfig(window_size=4, min_observations=4),
            audit=log,
        )
        for score, quality in rows:
            log.observe({"score": score, "quality": quality})
            target.record({"score": score, "quality": quality})

    def test_clean_log_exits_zero(self):
        self._write([(1, 1), (2, 2), (3, 3), (4, 4)])
        with redirect_stdout(io.StringIO()):
            self.assertEqual(main(["audit", str(self.path)]), 0)

    def test_flagged_log_exits_two(self):
        self._write([(1, 4), (2, 3), (3, 2), (4, 1)])
        buffer = io.StringIO()
        with redirect_stdout(buffer):
            self.assertEqual(main(["audit", str(self.path)]), 2)
        self.assertIn("First flagged trial", buffer.getvalue())

    def test_tampered_log_exits_one_with_json(self):
        self._write([(1, 1), (2, 2), (3, 3), (4, 4)])
        lines = self.path.read_text(encoding="utf-8").splitlines()
        tampered = json.loads(lines[0])
        tampered["record"]["signals"]["score"] = 5
        lines[0] = json.dumps(tampered, sort_keys=True)
        self.path.write_text("\n".join(lines) + "\n", encoding="utf-8")
        buffer = io.StringIO()
        with redirect_stdout(buffer):
            self.assertEqual(main(["audit", str(self.path), "--json"]), 1)
        payload = json.loads(buffer.getvalue())
        self.assertFalse(payload["chain"]["ok"])
        self.assertEqual(payload["chain"]["broken_at"], 0)

    def test_missing_log_exits_one(self):
        with redirect_stdout(io.StringIO()):
            self.assertEqual(main(["audit", str(self.path)]), 1)

    def test_demo_command_runs(self):
        buffer = io.StringIO()
        with redirect_stdout(buffer):
            self.assertEqual(main(["demo"]), 0)
        self.assertIn("tests_passing", buffer.getvalue())


if __name__ == "__main__":
    unittest.main()

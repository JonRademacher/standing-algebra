from __future__ import annotations

import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "Scripts"))

from build_context_bundle import build_bundle
from continuity_lib import (
    check_markdown_links,
    git_status_paths,
    sha256_file,
    verify_hash_manifest,
    write_hash_manifest,
)
from make_checkpoint import make_checkpoint
from validate_continuity import (
    validate_corpus,
    validate_dependency_references,
    validate_duplicate_checkpoint_ids,
)


class ContinuityToolTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary_directory.name)

    def tearDown(self) -> None:
        self.temporary_directory.cleanup()

    def test_hash_manifest_round_trip_and_known_exclusion(self) -> None:
        source = self.root / "source.txt"
        source.write_text("source\n", encoding="utf-8")
        git_metadata = self.root / ".git"
        git_metadata.write_text("gitdir: ../metadata\n", encoding="utf-8")
        excluded = self.root / "Collapse_Demonstrations/collapse.lean"
        excluded.parent.mkdir()
        excluded.write_text("preserved user change\n", encoding="utf-8")

        write_hash_manifest(self.root)

        self.assertEqual([], verify_hash_manifest(self.root))
        manifest = (self.root / "manifests/SHA256SUMS").read_text(encoding="utf-8")
        self.assertIn("source.txt", manifest)
        self.assertNotIn(".git", manifest)
        self.assertNotIn("Collapse_Demonstrations/collapse.lean", manifest)

    def test_hashes_are_stable_across_text_line_endings(self) -> None:
        lf = self.root / "lf.txt"
        crlf = self.root / "crlf.txt"
        lf.write_bytes(b"first\nsecond\n")
        crlf.write_bytes(b"first\r\nsecond\r\n")

        self.assertEqual(sha256_file(lf), sha256_file(crlf))

    def test_hashes_are_stable_for_extensionless_utf8_text_but_preserve_binary(self) -> None:
        extensionless_lf = self.root / "extensionless-lf"
        extensionless_crlf = self.root / "extensionless-crlf"
        binary_lf = self.root / "binary-lf.bin"
        binary_crlf = self.root / "binary-crlf.bin"
        extensionless_lf.write_bytes(b"first\nsecond\n")
        extensionless_crlf.write_bytes(b"first\r\nsecond\r\n")
        binary_lf.write_bytes(b"\x00first\nsecond\n")
        binary_crlf.write_bytes(b"\x00first\r\nsecond\r\n")

        self.assertEqual(sha256_file(extensionless_lf), sha256_file(extensionless_crlf))
        self.assertNotEqual(sha256_file(binary_lf), sha256_file(binary_crlf))

    def test_git_status_preserves_first_path_character(self) -> None:
        completed = subprocess.CompletedProcess(
            args=["git", "status"],
            returncode=0,
            stdout=" M Collapse_Demonstrations/collapse.lean\n?? new file.md\n",
            stderr="",
        )
        with patch("continuity_lib.subprocess.run", return_value=completed):
            self.assertEqual(
                [
                    "Collapse_Demonstrations/collapse.lean",
                    "new file.md",
                ],
                git_status_paths(self.root),
            )

    def test_hash_verifier_reports_missing_mismatch_duplicate_and_unsafe_paths(self) -> None:
        manifests = self.root / "manifests"
        manifests.mkdir()
        source = self.root / "source.txt"
        source.write_text("actual\n", encoding="utf-8")
        (manifests / "SHA256SUMS").write_text(
            f"{'0' * 64}  source.txt\n"
            f"{'0' * 64}  source.txt\n"
            f"{'0' * 64}  ../outside.txt\n",
            encoding="utf-8",
        )

        errors = verify_hash_manifest(self.root)

        self.assertTrue(any("hash mismatch: source.txt" in error for error in errors))
        self.assertTrue(any("duplicate hash entry: source.txt" in error for error in errors))
        self.assertTrue(any("unsafe hash path: ../outside.txt" in error for error in errors))

    def test_hash_verifier_reports_absent_manifest(self) -> None:
        self.assertEqual(
            ["missing manifests/SHA256SUMS"],
            verify_hash_manifest(self.root),
        )

    def test_markdown_links_accept_valid_internal_and_external_links(self) -> None:
        docs = self.root / "continuity"
        docs.mkdir()
        (docs / "target.md").write_text("# A Heading\n", encoding="utf-8")
        (self.root / "README.md").write_text(
            "[target](continuity/target.md#a-heading) [web](https://example.test)\n",
            encoding="utf-8",
        )

        self.assertEqual([], check_markdown_links(self.root))

    def test_markdown_links_reject_missing_targets_fragments_and_escape(self) -> None:
        (self.root / "README.md").write_text(
            "[missing](absent.md) [bad fragment](target.md#unknown) [escape](../outside.md)\n",
            encoding="utf-8",
        )
        (self.root / "target.md").write_text("# Present\n", encoding="utf-8")

        errors = check_markdown_links(self.root)

        self.assertTrue(any("broken link: absent.md" in error for error in errors))
        self.assertTrue(any("missing fragment: target.md#unknown" in error for error in errors))
        self.assertTrue(any("link escapes repository" in error for error in errors))

    def test_dependency_paths_are_platform_independent(self) -> None:
        graph = self.root / "continuity/DEPENDENCY_GRAPH.md"
        graph.parent.mkdir()
        graph.write_text("Command: `.github/workflows/lean.yml`\n", encoding="utf-8")
        workflow = self.root / ".github/workflows/lean.yml"
        workflow.parent.mkdir(parents=True)
        workflow.write_text("name: Lean\n", encoding="utf-8")

        self.assertEqual([], validate_dependency_references(self.root))

    def test_checkpoint_id_must_match_canonical_state(self) -> None:
        manifests = self.root / "manifests"
        manifests.mkdir()
        (manifests / "CURRENT_CHECKPOINT.yaml").write_text(
            json.dumps({"checkpoint_id": "UCK-2026-11-04-001"}),
            encoding="utf-8",
        )
        state = self.root / "continuity/CURRENT_STATE.md"
        state.parent.mkdir()
        state.write_text("**Checkpoint ID:** `UCK-2026-11-04-001`\n", encoding="utf-8")
        self.assertEqual([], validate_duplicate_checkpoint_ids(self.root))
        state.write_text("**Checkpoint ID:** `UCK-2026-11-04-002`\n", encoding="utf-8")
        self.assertTrue(validate_duplicate_checkpoint_ids(self.root))

    def test_context_bundle_respects_hard_character_bound(self) -> None:
        (self.root / "continuity").mkdir()
        (self.root / "continuity/CURRENT_STATE.md").write_text("state\n", encoding="utf-8")
        manifests = self.root / "manifests"
        manifests.mkdir()
        (manifests / "CURRENT_CHECKPOINT.yaml").write_text(
            json.dumps(
                {
                    "checkpoint_id": "UCK-2026-11-04-001",
                    "checkpoint_status": "canonical_partial",
                    "created_at": "2026-11-04T00:00:00Z",
                    "product": {"host_branch": "test", "host_head_at_generation": "abc"},
                    "validation": {"unit": {"status": "passed", "receipt_id": "test-1"}},
                    "residuals": [{"id": "R-001", "status": "open", "description": "source absent"}],
                }
            ),
            encoding="utf-8",
        )

        bundle = build_bundle(self.root, max_chars=2500)

        self.assertLessEqual(len(bundle), 2500)
        self.assertIn("state", bundle)
        self.assertIn("UCK-2026-11-04-001", bundle)
        self.assertIn("R-001 (open): source absent", bundle)
        with self.assertRaises(ValueError):
            build_bundle(self.root, max_chars=1000)

    def test_context_bundle_truncates_long_sources_without_exceeding_limit(self) -> None:
        continuity = self.root / "continuity"
        continuity.mkdir()
        (continuity / "CURRENT_STATE.md").write_text("token " * 5000, encoding="utf-8")

        bundle = build_bundle(self.root, max_chars=2000)

        self.assertLessEqual(len(bundle), 2000)
        self.assertIn("Truncated at bundle limit", bundle)
        self.assertTrue(bundle.split("\n[Truncated at bundle limit", 1)[0].endswith("token"))

    def test_context_bundle_indexes_supplied_source_documents(self) -> None:
        continuity = self.root / "continuity"
        manifests = self.root / "manifests"
        continuity.mkdir()
        manifests.mkdir()
        (continuity / "CURRENT_STATE.md").write_text("Current state.\n", encoding="utf-8")
        (manifests / "CORPUS_MANIFEST.yaml").write_text(
            json.dumps(
                {
                    "sources": [
                        {
                            "id": "SRC-TEST",
                            "title": "Supplied source",
                            "kind": "user_supplied_research_document",
                            "path": "corpus/source.docx",
                            "text_path": "corpus/source.txt",
                        }
                    ]
                }
            ),
            encoding="utf-8",
        )

        bundle = build_bundle(self.root, max_chars=6000)

        self.assertIn("Supplied source", bundle)
        self.assertIn("corpus/source.txt", bundle)

    def test_checkpoint_generation_records_corpus_hashes_and_writes_integrity_manifest(self) -> None:
        manifests = self.root / "manifests"
        manifests.mkdir()
        continuity = self.root / "continuity"
        continuity.mkdir()
        source = self.root / "source.txt"
        source.write_text("corpus source\n", encoding="utf-8")
        (continuity / "CURRENT_STATE.md").write_text(
            "**Checkpoint ID:** `UCK-2026-11-04-001`\n", encoding="utf-8"
        )
        (continuity / "OPEN_RESIDUALS.md").write_text(
            "| ID | Status | Description | Evidence |\n|---|---|---|---|\n",
            encoding="utf-8",
        )
        (manifests / "SOURCE_REPOSITORIES.json").write_text(
            json.dumps(
                {
                    "repositories": {
                        key: {"url": "https://example.test/repo", "status": "verified"}
                        for key in ("standing_algebra", "icg", "kernel")
                    }
                }
            ),
            encoding="utf-8",
        )
        (manifests / "VALIDATION_RECEIPTS.json").write_text(
            json.dumps({"required_receipts": {}, "receipts": {}}),
            encoding="utf-8",
        )
        (manifests / "CORPUS_MANIFEST.yaml").write_text(
            json.dumps({"sources": [{"id": "SRC-1", "path": "source.txt"}]}),
            encoding="utf-8",
        )

        checkpoint = make_checkpoint(self.root)
        corpus = json.loads((manifests / "CORPUS_MANIFEST.yaml").read_text(encoding="utf-8"))

        self.assertEqual("UCK-2026-11-04-001", checkpoint["checkpoint_id"])
        self.assertEqual(sha256_file(source), corpus["sources"][0]["sha256"])
        self.assertEqual([], verify_hash_manifest(self.root))

    def test_corpus_validation_checks_original_and_extracted_text_hashes(self) -> None:
        original = self.root / "corpus/source.docx"
        extracted = self.root / "corpus/source.txt"
        original.parent.mkdir(parents=True)
        original.write_bytes(b"docx bytes")
        extracted.write_text("extracted source\n", encoding="utf-8")
        manifest_path = self.root / "manifests/CORPUS_MANIFEST.yaml"
        manifest_path.parent.mkdir()
        manifest_path.write_text(
            json.dumps(
                {
                    "sources": [
                        {
                            "id": "SRC-TEST",
                            "path": "corpus/source.docx",
                            "sha256": sha256_file(original),
                            "text_path": "corpus/source.txt",
                            "text_sha256": sha256_file(extracted),
                            "provenance": "test fixture",
                            "status": "preserved_source_snapshot",
                        }
                    ]
                }
            ),
            encoding="utf-8",
        )

        self.assertEqual([], validate_corpus(self.root))
        extracted.write_text("modified text\n", encoding="utf-8")
        self.assertEqual(
            ["SRC-TEST: text_sha256 mismatch"],
            validate_corpus(self.root),
        )


if __name__ == "__main__":
    unittest.main()

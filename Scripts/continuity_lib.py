"""Standard-library helpers shared by continuity validation tools."""

from __future__ import annotations

import hashlib
import json
import os
import re
import subprocess
from pathlib import Path
from typing import Any
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[1]
HASH_FILE = Path("manifests/SHA256SUMS")
HASH_EXCLUDES = {
    HASH_FILE.as_posix(),
    "manifests/CURRENT_CHECKPOINT.yaml",
    "Collapse_Demonstrations/collapse.lean",
}
SCAN_DIRS = (".github", "continuity", "governance", "kernel", "learning", "Scripts")
SCAN_FILES = ("README.md", "AGENTS.md")
LINK_RE = re.compile(r"!?\[[^\]]*\]\((?:<([^>]+)>|([^\s)]+))(?:\s+[^)]*)?\)")
TEXT_SUFFIXES = {
    ".bib",
    ".bat",
    ".cff",
    ".cfg",
    ".csv",
    ".html",
    ".ini",
    ".json",
    ".lean",
    ".md",
    ".py",
    ".sh",
    ".smt2",
    ".tex",
    ".toml",
    ".txt",
    ".v",
    ".xml",
    ".yaml",
    ".yml",
}
TEXT_FILENAMES = {
    ".editorconfig",
    ".gitignore",
    "AGENTS",
    "LICENSE",
    "Makefile",
    "README",
    "lakefile",
}


def load_json_yaml(path: Path) -> Any:
    """Load JSON, a strict YAML subset, so CI has no third-party dependency."""
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise ValueError(f"{path}: expected valid JSON-compatible YAML: {error}") from error


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    if path.suffix.lower() in TEXT_SUFFIXES or path.name in TEXT_FILENAMES:
        digest.update(path.read_bytes().replace(b"\r\n", b"\n"))
        return digest.hexdigest()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def managed_files(root: Path = ROOT) -> list[Path]:
    excluded_dirs = {".git", ".lake", "__pycache__", ".venv", "venv"}
    excluded_names = {"SHA256SUMS", "CURRENT_CHECKPOINT.yaml"}
    result: list[Path] = []
    for current, dirs, files in os.walk(root):
        dirs[:] = sorted(d for d in dirs if d not in excluded_dirs)
        current_path = Path(current)
        for name in sorted(files):
            path = current_path / name
            relative = path.relative_to(root).as_posix()
            if relative in HASH_EXCLUDES:
                continue
            if name in excluded_names and relative.startswith("manifests/"):
                continue
            if path.suffix in {".pyc", ".pyo"}:
                continue
            result.append(path)
    return sorted(result, key=lambda p: p.relative_to(root).as_posix())


def write_hash_manifest(root: Path = ROOT) -> list[str]:
    lines: list[str] = []
    for path in managed_files(root):
        relative = path.relative_to(root).as_posix()
        if relative in HASH_EXCLUDES:
            continue
        lines.append(f"{sha256_file(path)}  {relative}")
    output = root / HASH_FILE
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("w", encoding="utf-8", newline="\n") as stream:
        stream.write("\n".join(lines) + "\n")
    return lines


def verify_hash_manifest(root: Path = ROOT) -> list[str]:
    manifest = root / HASH_FILE
    if not manifest.is_file():
        return [f"missing {HASH_FILE.as_posix()}"]
    errors: list[str] = []
    seen: set[str] = set()
    for line_number, line in enumerate(manifest.read_text(encoding="utf-8").splitlines(), 1):
        if not line.strip():
            continue
        match = re.fullmatch(r"([0-9a-f]{64})  (.+)", line)
        if not match:
            errors.append(f"{HASH_FILE.as_posix()}:{line_number}: malformed checksum entry")
            continue
        expected, relative = match.groups()
        if relative in seen:
            errors.append(f"duplicate hash entry: {relative}")
            continue
        seen.add(relative)
        candidate = Path(relative)
        if candidate.is_absolute() or ".." in candidate.parts:
            errors.append(f"unsafe hash path: {relative}")
            continue
        path = root / candidate
        if not path.is_file():
            errors.append(f"hashed file missing: {relative}")
        elif sha256_file(path) != expected:
            errors.append(f"hash mismatch: {relative}")

    expected_files = {
        path.relative_to(root).as_posix()
        for path in managed_files(root)
        if path.relative_to(root).as_posix() not in HASH_EXCLUDES
    }
    for relative in sorted(expected_files - seen):
        errors.append(f"file is not hashed: {relative}")
    for relative in sorted(seen - expected_files):
        errors.append(f"hash entry is not a managed file: {relative}")
    return errors


def markdown_files(root: Path = ROOT) -> list[Path]:
    files = [root / name for name in SCAN_FILES if (root / name).is_file()]
    for directory in SCAN_DIRS:
        base = root / directory
        if base.is_dir():
            files.extend(sorted(base.rglob("*.md")))
    return sorted(set(files))


def check_markdown_links(root: Path = ROOT) -> list[str]:
    errors: list[str] = []
    for file_path in markdown_files(root):
        text = file_path.read_text(encoding="utf-8")
        for match in LINK_RE.finditer(text):
            target = unquote(match.group(1) or match.group(2) or "")
            if not target or target.startswith("#"):
                continue
            if re.match(r"^[A-Za-z][A-Za-z0-9+.-]*:", target):
                continue
            path_text, _, fragment = target.partition("#")
            candidate = (file_path.parent / path_text).resolve()
            root_resolved = root.resolve()
            try:
                candidate.relative_to(root_resolved)
            except ValueError:
                errors.append(f"{file_path.relative_to(root).as_posix()}: link escapes repository: {target}")
                continue
            if not candidate.exists():
                errors.append(f"{file_path.relative_to(root).as_posix()}: broken link: {target}")
                continue
            if fragment and candidate.is_file() and candidate.suffix.lower() == ".md":
                headings = {
                    re.sub(r"[^\w -]", "", line.lstrip("#").strip().lower())
                    .replace(" ", "-")
                    for line in candidate.read_text(encoding="utf-8").splitlines()
                    if line.startswith("#")
                }
                if fragment.lower() not in headings:
                    errors.append(
                        f"{file_path.relative_to(root).as_posix()}: missing fragment: {target}"
                    )
    return errors


def git_value(root: Path, *args: str) -> str | None:
    try:
        result = subprocess.run(
            ["git", "-C", str(root), *args],
            check=True,
            capture_output=True,
            text=True,
            encoding="utf-8",
        )
    except (OSError, subprocess.CalledProcessError):
        return None
    return result.stdout.strip()


def git_status_paths(root: Path) -> list[str] | None:
    try:
        result = subprocess.run(
            ["git", "-C", str(root), "status", "--porcelain", "--untracked-files=all"],
            check=True,
            capture_output=True,
            text=True,
            encoding="utf-8",
        )
    except (OSError, subprocess.CalledProcessError):
        return None
    return [line[3:] for line in result.stdout.splitlines() if len(line) > 3]

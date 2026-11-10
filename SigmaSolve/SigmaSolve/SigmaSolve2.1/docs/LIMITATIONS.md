# Limitations

- Version 0.1 does not inspect Lean proof states interactively; it compiles complete candidate proofs.
- It does not yet extract verified intermediate lemmas automatically.
- The OpenAI-compatible adapter assumes a conventional chat-completions JSON shape.
- Clean replay uses a fresh temporary source file but shares the declared Lean project dependencies.
- `--no-verify` is only an orchestration test and must never support a public proof claim.
- No evidence yet shows cross-model uplift, scale substitution, open-problem discovery, or superiority to established theorem-proving systems.
- A model can submit a valid proof copied from training or retrieval; kernel acceptance establishes correctness, not originality.

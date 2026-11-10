# Security

Generated proof text is untrusted input.

Version 0.1 writes generated Lean into temporary directories and invokes Lean with subprocess argument lists rather than a shell. Do not give agent-created tools unrestricted shell access. Run external agents and formal tools in a container or sandbox with resource ceilings, no secrets, read-only source mounts, and a writable disposable workspace.

The OpenAI-compatible adapter sends the theorem, context, and verifier diagnostics to the configured endpoint. Do not include private or regulated material unless that endpoint is authorized to receive it.

Potential prompt injection inside theorem comments, repository files, retrieved documentation, or model output must be treated as untrusted content rather than authority.

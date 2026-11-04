Prepare a checkpoint only after all declared release-blocking checks pass.

Verify exact repository identities/commits, clean or explicitly described
worktree state, source provenance, graph and link integrity, manifest schema,
hashes, dependency references, theorem mappings, applicable tests/builds, and
receipts. Keep unresolved items open. Generate the checkpoint and bounded
context bundle only from observed state. If any gate is unavailable or fails,
mark the checkpoint candidate and state why it is not promoted.

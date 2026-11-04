# Model-Inadequacy Constructor

Use this record when an observation cannot be represented or distinguished by
the current model. Preserve the observation and name the missing distinction;
do not force it into the nearest available category or silently expand the
model.

## Required record

```yaml
id: MI-YYYY-MM-DD-NNN
observation: Exact evidence or a link to it
current_model: Versioned model or schema and its source
failed_representation: What the current model cannot express or discriminate
missing_distinction: The smallest distinction needed to represent the evidence
alternatives:
  - Keep the current model and mark the observation unresolved
  - Add a candidate distinction and test backward compatibility
  - Reject the observation as out of scope, with evidence
tests:
  - Positive case that requires the distinction
  - Negative or adversarial case that must remain distinguishable
regressions:
  - Expected effects on existing categories and downstream consumers
provenance: Evidence source, revision, and capture time
disposition: candidate
```

## Procedure

1. Capture the original observation and current model revision.
2. Demonstrate the representational failure with a minimal counterexample.
3. Identify the minimum missing distinction without assuming which alternative
   should win.
4. Add bounded fixtures in the Capability Gym; do not modify canonical state
   while exploring.
5. Record compatibility, regressions, and rollback before proposing an edit.
6. Promote only after the normal review and validation gates pass. A proposal
   is not a demonstrated capability.

Forcing a lossy fit, inventing evidence, or changing the model without
versioned review is a failed reconstruction, not a successful correction.

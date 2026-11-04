# Capability Gym

The Capability Gym is an isolated, bounded test habitat for candidate
operators. It contains synthetic fixtures only; its files are not canonical
project state and do not silently modify source frameworks.

## Fixture contract

Every fixture must name:

- the capability or operator under test;
- input and expected output, including any unresolved alternatives;
- proof or validation obligations;
- a regression case and an adversarial case;
- the allowed file-write boundary;
- provenance and the reason the fixture is representative;
- the result and final disposition.

Use `Fixtures/template.json` to add a case. Run:

```text
python -m unittest discover -s Tests -v
```

The fixtures are schemas and process examples, not evidence that a capability
is operational in production. Promotion still requires the repository's
review, validation, provenance, and rollback gates.

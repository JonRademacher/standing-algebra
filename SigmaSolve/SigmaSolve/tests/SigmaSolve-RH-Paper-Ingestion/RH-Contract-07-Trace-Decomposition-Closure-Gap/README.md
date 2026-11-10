# RH Contract 07 — Trace Decomposition Closure Gap

This contract records the attempted full RH closure using Contracts 01–06 and represents the minimum structure missing after that attempt.

It is an **additional child contract**, not a replacement for Contract 06.

## Attempted closure

```text
not RH
  -> finite negative Li witness            [Contracts 04–05]
  -> universal independent Li positivity   [Contract 06 candidate]
  -> contradiction
  -> RH
```

The solve fails at the independent barrier. This contract localizes that failure to three atomic obligations in the trace-operator candidate: A2, A3, and A5.

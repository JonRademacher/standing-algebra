# RH Contract 04 — Li Negative-Witness Detector

This is an **additional child contract** under Contract 03. It advances only the detector lane W1-W4.

It does not attempt the independent positivity barrier P1-P2 and therefore cannot close RH by itself.

## Objective

Bind an off-critical-line zero/count jump to a finite negative Keiper-Li coefficient witness:

```text
not RH -> exists n >= 1, lambda_n < 0
```

The contract separates three levels:

1. established external criterion to be reconstructed and formally bound;
2. a finite-model amplification theorem that SigmaSolve can prove directly;
3. the infinite-zero-set transfer conditions required for the actual zeta function.

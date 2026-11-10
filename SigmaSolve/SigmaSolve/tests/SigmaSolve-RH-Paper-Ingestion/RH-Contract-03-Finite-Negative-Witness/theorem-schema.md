# Theorem schema

Let RH denote the exact Riemann Hypothesis and let W : I -> R be a witness family indexed by finite objects.

## Detector theorem

```text
not RH -> exists i : I, W(i) < 0
```

The existential witness is finite because `i` is a natural number or a finitely encoded test function.

## Independent barrier theorem

```text
forall i : I, 0 <= W(i)
```

The proof must not depend on RH, on `not RH -> exists i, W(i)<0`, or on an equivalent restatement of universal positivity.

## Closure theorem

Assume `not RH`. The detector supplies `i` with `W(i)<0`. The barrier supplies `0<=W(i)`. Contradiction. Therefore RH.

## Preferred Li instantiation

```text
I = positive natural numbers
W(n) = lambda_n
not RH -> exists n, lambda_n < 0
forall n, lambda_n >= 0
```

The first implication is the contrapositive content of Li's criterion. The second line is the unsolved core unless a genuinely independent positivity proof is established.

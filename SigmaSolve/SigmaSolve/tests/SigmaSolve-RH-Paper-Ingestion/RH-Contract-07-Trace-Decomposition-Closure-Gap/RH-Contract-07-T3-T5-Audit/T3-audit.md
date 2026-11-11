# T3 audit — trace on the orthogonal component

The candidate's proof obtains an absolutely convergent sum of the form

\[
\operatorname{tr}_{E_S(Q_\Lambda^\perp)}(T_h)
=-\sum_{\xi\in O_S^*} c,
\]

where the variable changes \(x\mapsto\xi^{-1}x\) and \(u\mapsto u\xi\) are claimed to turn every summand into the same scalar \(c\). The manuscript then uses finiteness of the trace and infinitude of the index set to infer \(c=0\).

## Abstract lemma

If \(I\) is infinite and \(\sum_{i\in I}c\) converges absolutely as an ordinary scalar sum, then \(c=0\).

This implication is correct. For any finite subset \(F\subset I\), absolute summability gives

\[
|F|\,|c|\le\sum_{i\in I}|c|<\infty.
\]

Letting \(|F|\to\infty\) forces \(c=0\).

## Audit determination

T3's final inference is not itself a logical error. The burden lies entirely in the prerequisites:

1. the series is genuinely absolutely convergent;
2. the fundamental-domain decomposition is disjoint and complete;
3. the change of variables preserves additive/multiplicative measures;
4. the cutoff conditions remain invariant because \(|\xi|_S=1\);
5. the characters transform exactly as written;
6. \(O_S^*\) is infinite;
7. the finite total is the trace of a trace-class compressed operator.

The current audit preserves T3 as a conditional survivor, not a proved theorem.

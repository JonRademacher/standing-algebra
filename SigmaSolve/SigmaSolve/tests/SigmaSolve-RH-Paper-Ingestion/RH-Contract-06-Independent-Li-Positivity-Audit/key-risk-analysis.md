# Key risk analysis

## 1. Positive kernel claim

The candidate writes the quadratic form of `VS(h)` as an integral over `y` of a product of two transforms. To establish positivity, the second factor must be the complex conjugate of the first under the declared inner-product convention. This is plausible because `g` is real, but the equality, measure factors, and extension from compact support must be reconstructed exactly.

## 2. Compression versus positivity

Even if `VS(h)` is positive, `VS(h) S_Lambda` need not be positive because a positive operator multiplied by a projection on only one side is not generally self-adjoint. The manuscript does not simply assert this product is positive; it decomposes the trace into a positive compressed term plus a cross term. Therefore the cross-term trace identity and its claimed vanishing are essential, not cosmetic.

## 3. Infinite-repeat argument

The manuscript twice obtains an expression described as an infinite sum of the same number and concludes that the common number is zero because the total sum is finite. Abstractly, this inference is valid only if:

- the index set is genuinely infinite;
- every term is exactly equal after legal changes of variables;
- the displayed sum is an ordinary/absolutely convergent sum rather than a quotient identity or distributional expression;
- no multiplicity or normalization factor has been lost;
- the total is independently known to be finite.

These are the highest-risk proof obligations in A3 and A5.

## 4. Limit to Li coefficients

Even a correct nonnegative trace formula does not imply Li positivity until the special test functions are proved to satisfy:

\[
\widehat h_{n,\varepsilon}(0)=\widehat h_{n,\varepsilon}(1)=0
\]

and

\[
\Delta(h_{n,\varepsilon})\to2\lambda_n.
\]

Support expands as epsilon tends to zero, so the limit cannot be accepted through an unstated fixed dominating function.

## 5. Current audit conclusion

No decisive contradiction was derived from the available text alone. Equally, the candidate proof is not validated. A3, A5, and A2 remain the minimum critical reconstruction frontier. Until those close, the operator lane cannot serve as Contract 03's independent barrier.

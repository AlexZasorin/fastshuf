fastshuf.jl
================
Optimal implementation of reservoir sampling algorithm in Julia.

Usage
================
This application functions similarly to the `shuf` command-line utility. It does not take any command-line flags, only a single argument to specify reservoir size.

It will accept a stream of elements and randomly sample these elements into a reservoir of the specified size.

Example:
```
alex@PC:/home/alex/julia-projects$ seq 100 | julia fastshuf.jl 10
53
82
6
22
55
39
77
95
48
72
```

Requirements
================
- [Julia 1.6.0 or later](https://julialang.org/downloads/)

Earlier versions may function but have not been tested.


Proof
================
Here is a proof I wrote for a class that shows why the naive reservoir sampling algorithm yields a random sample.

Let $r$ be our reservoir size and $n$ be the number of input elements we have seen so far. Whenever $n <= r$, we set $r = n$, as per the reservoir sampling algorithm. As our base case, let's use $n = r$. Each item chosen to be in the reservoir will have had a $\frac{r}{n} = 1$ chance to be chosen. By definition, our sample is a simple random sample.

For our inductive hypothesis, we will say that the algorithm produces a simple random sample for some $k = r$. We will try to show that this is true for $k+1$.

Consider the step where we read in the $(k+1)$\-th element. According to the algorithm, we will pick a number $s$ between 1 and our current iteration which is $k+1$. If $s$ is less than or equal to $r$, we will replace the element at the index $s$ with the $(k+1)$\-th element of the stream. Therefore, the $(k+1)$\-th element has a $\frac{r}{k+1}$ probability of being chosen to be in the reservoir. Given that the $(k+1)$\-th element has been chosen to replace an element, the probability that any element already in the reservoir gets removed is $\frac{1}{r}$. This makes the probability of an element to be removed at this step $\frac{r}{k+1}\cdot\frac{1}{r}$. The total probabilty of having been chosen initially and not being removed at this step becomes $\frac{r}{k}\cdot(1-\frac{r}{k+1}\cdot\frac{1}{r})$. Remember that $\frac{r}{k} = 1$. This simplifies to $1\cdot(1-\frac{1}{k+1}) = \frac{k}{k+1}$. Therefore, all elements in the reservoir, including the $(k+1)$\-th element, have the same probability to be chosen and the sample is a simple random sample.

The implementation in the code differs from the naive algorithm. Instead of randomly deciding whether to keep a particular element, we model the geometric distribution to calculate how many elements to skip before accepting an element. The number of skips is easily computed in constant time.

I have not attempted a proof for this, but hope to do so when I get a chance.
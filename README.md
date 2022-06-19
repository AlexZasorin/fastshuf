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
# Getting Started

## Installation


To install the package run one of the following commands in the Julia REPL.

Using SSH:
```julia
using Pkg
Pkg.add(url="git@git.rwth-aachen.de:nick1/BeadPull-jl.git")
```

Using HTTPS:
```julia
using Pkg
Pkg.add(url="https://git.rwth-aachen.de/nick1/BeadPull-jl.git")
```


## Example usage

A simple example on how to use the Package.
Connecting to the VNA and performing a sweep.

```julia
include("src/KeyVNA.jl")
import .KeyVNA

# Connect to the VNA using the IP
vna = KeyVNA.connect("127.0.0.1")

# Perform a single trace
# Returns the scattering parameter for each frequency point as a
# Vector{ComplexF64}
data = KeyVNA.getTrace(vna)

# Returns the frequency points
freq = KeyVNA.getFrequencies(vna)
```
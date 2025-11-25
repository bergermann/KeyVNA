# KeyVNA

KeyVNA is an API for Keysight Vector Network Analyzers. Based on the [SCPI protocoll](https://rfmw.em.keysight.com/wireless/helpfiles/e5080a/programming/gp-ib_command_finder/scpi_command_tree.htm).

This module was created as part of the MADMAX project at RWTH Aachen
and is used to interface a N5224B PNA network analyzer. It was only
used and tested on this device. But it probably can be used for other
network analyzers by keysight as it relies on the SCPI protocoll.
The functionality is suited to the needs of one project and therefore
offers not yet the full functionality possible.

## Installation


To install the package run the following commands in the Julia REPL.

```julia
using Pkg
Pkg.add(url="https://github.com/bergermann/KeyVNA")
```


## Example usage

A simple example on how to use the Package.
Connecting to the VNA and performing a sweep.

```julia
using KeyVNA

# Connect to the VNA using the IP
vna = connect("127.0.0.1")

# Perform a single trace
# Returns the scattering parameter for each frequency point as a
# Vector{ComplexF64}
data = getTrace(vna)

# Returns the frequency points
freq = getFrequencies(vna)
```


## Contact
- [Dominik Bergermann](mailto:dominik.bergermann@rwth-aachen.de)

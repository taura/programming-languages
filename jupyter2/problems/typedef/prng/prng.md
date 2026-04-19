# <font color="green">Pseudo Random Number Generator</font>

* Define a data type, `prng` (or `Prng`), that represents a pseudo random number generator based on linear congruence
* Specifically, given a _seed_ $s$, a generator internally holds a 48-bit integer state $x$ that is initialized with $s$ and updated each time a random number is generated as follows
$$ x := (a x + b) \mod m $$
where $a = {\rm (0x5DEECE66D)}_{16}, b = {\rm (0xB)}_{16}, m = 2^{48}$

* A random number returned is the highest 31 bits of the value of $x$ _after_ updated as above

* Define a function `mk_prng` (or `mkPrng`) that takes a non-negative integer $s$ ($< 2^{48}$) and returns a random number generator (of `prng` type) initialized with $s$

* Define a function `nrand48` that takes a random number generator and returns the next random number

* In Python, it could look like this

```
class prng:
    def __init__(self, seed):
        self.x = seed

def mk_prng(seed):
    return prng(seed)
        
def nrand48(rg):
    y = (0x5DEECE66D * rg.x + 0xB) & 0xFFFFFFFFFFFF
    rg.x = y
    return y >> 17
```

* Boilerplate source files `{go,jl,ml,rs}/prng.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.

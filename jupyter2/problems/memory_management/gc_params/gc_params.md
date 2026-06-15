# <font color="green">Garbage Collector Knobs</font>

- Garbage collectors periodically traverse all data reachable from the *root* (live local variables in active functions and global variables) and reclaim memory occupied by unreachable data.
- Beyond the reachable data itself, a GC requires additional working space. The most basic tuning knob controls how much extra space is permitted, typically expressed as a multiple of the observed reachable data size (e.g., 1.5 x reachable data).
- Learn how to adjust this knob for each language (consulting AI is fine) and experiment with different settings.
- We use the same program used for previous problems.

## Work

- Compile (if necessary) and run each program.
- Suggested parameters: $S = 20000$, $M = 1000$, and $N = 10000$.
- Adjust GC knobs to reduce the reported time per allocation.
- Go uses separate threads for GC, which gives Go an unfair advantage over other languages that use GC and user computation in the same thread
  - GOMAXPROCS=1 disables this behavior


# <font color="green">Observe Memory Management</font>

- Witness memory management in action.
- Write a program that repeatedly allocates a block of memory (an $S$-element array of 64-bit integers) and maintains a reference to the last $M$ allocated blocks via an outer array (an array of arrays). Perform $N > M$ allocations in total.
- Programs are given in C/C++ and in your assigned languages (Go, Julia, OCaml, Rust); measure the memory consumption of each program.
- Note: Julia has a significantly larger baseline memory footprint than the other languages due to its JIT compiler.

## Work

- For given $S$, $M$, and $N$, how much memory is reachable from the root once the outer array is fully populated?
- Measure actual memory consumption by running each program. Use the `/usr/bin/time` command and record the `maxresident` value. For example, the following output indicates that `ls` consumed 3996 kB:

```
$ /usr/bin/time ls
   ...
0.00user 0.00system 0:00.00elapsed 100%CPU (0avgtext+0avgdata 3996maxresident)k
0inputs+0outputs (0major+97minor)pagefaults 0swaps
```

- Suggested parameters: $S = 20000$ and $M = 1000$; vary $N$ from a small value up to 10000.
- Plot the results using online Excel, with $N$ on the $x$-axis and maximum resident set size on the $y$-axis.
- You are encouraged to automatically extract necessary values from the execution log.
- Compare results across languages by collaborating with your team members to put them in one Excel sheet.


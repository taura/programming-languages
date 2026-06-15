# <font color="green">Visualize Memory Management</font>

- Examine the previous experiment more closely by visualizing which memory addresses are used.
- Programs are the same as the previous problem, except:
  - They use each language's mechanism for obtaining the address of an allocated object.
  - They also measure the time taken by each allocation.
  - They are output at the end of the program.

## Work

- Compile (if necessary) and run each program.
- Suggested parameters: $S = 200000$, $M = 50$, and $N = 500$.
- The program should print the address returned and the time elapsed for each allocation.
- Plot the addresses as a scatter plot in online Excel; observe how the addresses are distributed and reused or not.
- Plot the cumulative distribution of allocation times.


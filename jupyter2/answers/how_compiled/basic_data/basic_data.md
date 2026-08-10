# <font color="green">Basic Data Types</font>

- Investigate how basic data types such as integers and floating-point numbers are represented in your language.
- To this end, define a function `add_nums` (or `AddNums` in Go) that takes a few integer parameters and returns their sum plus 123. Compile it to assembly and examine the output.
- **Calling conventions** (also known as the Application Binary Interface, or ABI) determine where parameters are placed at the start of a function and where the return value is placed when the function returns.

## Problems

Make a note of the following:

1. Where are the parameters when the function starts?
2. Where is the return value when the function returns?
3. Add slightly different versions of the function and observe how the generated assembly changes. For example:
   - Change the operator `+` to something else (`-`, `*`, `/`, etc.)
   - Change the number of parameters (what happens when it becomes large?)
   - Change the constant (`123`) (what happens when it becomes very large?)
   - Change the parameter type (floating-point numbers or 32-bit integers)


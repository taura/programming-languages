# <font color="green">A Function That Takes a Function</font>

* Write a function `app1` that takes a function $g$ accepting a floating-point number and applies $g$ to `1.0` (i.e., $\texttt{{app1}}(g) = g(1.0)$).
* Write a function `app` that takes a function $f$ and a value $a$ and returns $f(a)$, for any type of $a$ and any return type of $f$ (i.e., $\texttt{{app}}(f, a) = f(a)$).
* This is another warm-up exercise to build familiarity with the syntax for function types, although some languages can infer them without explicit annotations.
* As with the previous problem, this is nearly trivial in Julia and OCaml, which do not require type annotations on function parameters or return values.
* Boilerplate source files `{{go,jl,ml,rs}}/{base}.{{go,jl,ml,rs}}` containing test code are generated and shown below.
* Edit the source files by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.


# <font color="green">A Generic Optimizer for Any → Float Functions</font>

* Extend the previous problem `parametric/optimize_float` so that a single function definition can work for any function $f$ taking a parameter of an arbitrary type and returning a floating-point number ($T \to \mathbb{{R}}$).
* The crux is how to parameterize the input type of $f$.
* To that end, define a type `domain` parameterized by a type parameter $T$, whose `next` method returns a value of type $T$.
  * Depending on the language, `domain` may be an *abstract* type (interface, trait, etc.).
* Then define a generic `optimize` function that takes a function $f : T \to \mathbb{{R}}$ and a domain $D$ of type $T$, and finds an approximation of $\min_{{x \in D}} f(x)$ by evaluating $f(x)$ for each $x$ returned by $D\texttt{{.next()}}$ until the sentinel value is returned.
* Make the range type from the previous problem conform to `domain`, so that the generic optimizer can accept it.
* Define a type representing a 2D range and a constructor $\texttt{{arange2d}}(x_0, x_1, m, y_0, y_1, n)$, and make it conform to `domain` as well.
  * $\texttt{{arange2d}}(x_0, x_1, m, y_0, y_1, n)$ should generate $mn$ points $(x_0 + i\,\Delta x,\ y_0 + j\,\Delta y)$ for all combinations of $0 \leq i < m$ and $0 \leq j < n$, where $\Delta x = (x_1 - x_0)/(m-1)$ and $\Delta y = (y_1 - y_0)/(n-1)$.
  * To represent a 2D point, use:
    * a 2-element float array in Go (expression: `[2]float64{{x, y}}`, type: `[2]float64`)
    * a 2-float tuple in Julia (expression: `(x, y)`)
    * a 2-float tuple in OCaml (expression: `(x, y)`, type: `(float * float)`)
    * a 2-float tuple in Rust (expression: `(x, y)`, type: `(f64, f64)`)
* You may be amazed by the fact that in some languages, the float-only version you implemented in the previous problem and the generic version you define here is identical
* Boilerplate source files `{{go,jl,ml,rs}}/{base}.{{go,jl,ml,rs}}` containing test code are generated and shown below.
* Edit the source files by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.


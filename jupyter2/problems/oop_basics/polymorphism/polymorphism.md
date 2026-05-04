# <font color="green">Polymorphism</font>

- In the previous problem (`oop_basics/class`) you defined a class representing location-free ellipses.
- In this problem you define a class representing location-free rectangles, also exposing an `area` method.
- Notice that two different classes can define methods with the same name but different implementations.
- We then examine how the language supports *polymorphism* and *dynamic dispatch*:
  - **Polymorphism:** allows a single variable, function parameter, or collection to hold values of multiple types at runtime.
  - **Dynamic dispatch:** selects the appropriate method implementation based on the runtime type of the object.

## Docs

**Interfaces and traits**

|      |        |                                                                             |
| :--- | :----- | :-------------------------------------------------------------------------- |
| Go   | interface | [Interfaces](https://go.dev/doc/effective_go#interfaces_and_types)          |
| Rust | trait | [Traits](https://doc.rust-lang.org/book/ch10-02-traits.html)                |

## <font color="green">Problem</font>

- In addition to the `free_ellipse` class from `oop_basics/class`, define `free_rect` (or `FreeRect`) representing a rectangle, and its `area` method.
- As before, define a function `mk_free_rect` that takes two floating-point numbers $w$ and $h$ (in that order) and returns a rectangle with width $w$ and height $h$. Assume one side is parallel to the x-axis and the other to the y-axis.
- Pass a *rectangle* (not an ellipse) to the `smaller` function defined in the previous problem and observe what happens. Before running it, predict which of the following will occur:
  1. A compile-time error (the program cannot be started).
  2. A runtime error (the program starts but does not finish successfully).
  3. The program runs without error.
- In Julia and OCaml, parameter types are optional. Try two versions of `smaller`:
  - A version with no type annotation on the parameters.
  - A version that explicitly annotates the parameter type as `ellipse` (or `Ellipse`).
- If your language does not allow `smaller` to accept a `rect` just by defining them in isolation, modify the program so that it accepts *both* `ellipse` and `rect`, using the appropriate language mechanism (interface, trait, abstract class, etc.).
- <font color="green">Q: Discuss what you predicted and observed with the other team members and explain.</font> Discussion items include but are not limited to:
  - In the languages you worked on, is anything specific necessary for `smaller` to take both ellipses and rectangles as arguments? If so, what is it?
  - Do you think they are type safe (i.e., type errors are detected at compile time)?
  - Compare them with the languages other team members worked on.
- Boilerplate source files `{go,jl,ml,rs}/{base}.{go,jl,ml,rs}` containing the test code are generated and shown below.
- Edit the source files either by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.


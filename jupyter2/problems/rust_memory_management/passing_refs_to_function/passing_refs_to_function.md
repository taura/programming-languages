# <font color="green">A borrowing pointer has to "know" the lifetime of its referent</font>

* In order to check the validity of dereferencing borrowing pointers at compile time, each borrowing pointer (`&T`) has to have information about the lifetime of the data it points to (its _referent_)
* For some simple reference expressions (e.g., `let b = &a`), which owning pointer it is derived from is readily available to the compiler (i.e., `b` obviously points to the data structure owned by `a`), so the compiler can know its referent lifetime
* It is not the case for general expressions involving function calls or data structures, such as `let r = f(&a, &b, &c)` or `let r = &a.p.q.r` (how do we know what kind of lifetime `r` has after this assignment?)
* Rust compiler needs extra information to track this kind of information
* First, superficially, each reference type (`&T`) has its lifetime parameter that indicates its referent lifetime
* Its syntax is `&'a T`, meaning "this is a pointer to a data structure of type `T`; the lifetime of that data is `'a`"
* Any reference type that appears in function parameters or return type must have a lifetime parameter (like `&'a T`) explicitly, and they must be declared after function name (like `f<'a,'b,'c>(a : &'a T, b : &'b T, c : &'c : T)`)
* If you are confused by what lifetime parameters such as `'a` actually represents, imagine it refers to a set of program points whose dereference is valid and it is determined by which owner pointer it was derived from


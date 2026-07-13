# <font color="green">A borrowing pointer cannot be dereferenced after the owner pointer is gone</font>

* With borrowing pointers pointing to the same data structure pointed to by an owning pointer, the crux is how to prevent a program from dereferencing borrowing pointers after the data structure it points has been reclaimed
* As a data structure is reclaimed when its owner pointer is gone, it is equivalent to preventing a program from dereferencing borrowing pointers after its owner pointer is gone
* Rust compiler tries to reject code that violates it at compile-time
* Informally, it keeps track of the owner pointer each borrowing pointer is derived from

* Observe the compiler does the job


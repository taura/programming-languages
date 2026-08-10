# <font color="green">Passing an owner pointer is a move, too</font>

* Just as an assignment of an owner pointer is a move, passing an argument of an owner pointer is a move, too, invalidating the use of the variable `a`, after calling `f(a)`

* Observe the compiler does the job


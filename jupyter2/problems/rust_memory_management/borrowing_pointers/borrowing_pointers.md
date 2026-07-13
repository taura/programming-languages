# <font color="green">A borrowing pointer can coexist with an owner pointer</font>

* Given the restriction that there can be only one owner pointer to a data structure, the only way you can reference the same object through a different variable is _borrowing_

* You can make a borrowing pointer (reference) to a data structure by `&`

* Observe in the following that both `a.x` and `b.x` are valid at the same time


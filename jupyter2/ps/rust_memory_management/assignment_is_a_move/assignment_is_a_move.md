# <font color="green">An assignment of an owner pointer is a move</font>

* Rust guarantees that there is one and only one single owner pointer to each live data

* To this end, an assignment of an owner pointer is a move, which makes the right-hand side unusable after the assignment

* Observe the compiler does the job

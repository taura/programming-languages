# <font color="green">Binary Search Tree</font>

* Define a data type, `bstree` (or `BSTree`), that represents a binary search tree
* A binary search tree is a data structure having the following property
	1. it is a binary tree (either _empty_ or a _node_ having left and right child; each child may be empty)
	1. each node has a _value_
	1. when a node $n$ has a left child $l$, $l$'s value $<$ $n$'s value
	1. when a node $n$ has a right child $r$, $n$'s value $<=$ $r$'s value
* In addition, each node also maintains the number of nodes in left child and right child
* A node therefore has five fields (value, the number of nodes in left child, left child, the number of nodes in right child, right child)
* While values held in a binary tree can be any value that can be compared with $<$, this problem assumes they are _non-negative integers_
* Define a function `insert`, that takes a non-negative number $x$ and a binary search tree $t$, and returns a new binary search tree with $x$ inserted into $t$
* Then define a function, `nth`, that takes a non-negative integer $n$ and a binary search tree $t$ and returns the $n$-th smallest value in $t$ ($n$ is zero-origin; that is, the smallest value is 0-th value)
* If $n \ge$ (the number of nodes in $t$), then return -1
* Hint: due to property 3 and 4, if you perform an in-order traversal of a binary search tree (i.e., traverse left; visit itself; traverse right), you will find values in the tree in ascending order

* Boilerplate source files `{go,jl,ml,rs}/bstree.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.

# <font color="green">Binary Tree</font>

* Define a data type representing a _binary tree_
  * A binary tree is either _empty_ or a _node_ having a left child and a right child (both can be empty)
* Write a function, `mk_maximally_balanced_bintree` (or `mkMaximallyBalancedBintree`), which takes an integer $n$ and returns a binary tree that has $n$ nodes and is _maximally balanced_
  * A binary tree $t$ is maximally balanced when:
    * $t$ is empty, or
    * $t$ is non-empty and satisfies the following two conditions
      1. $t$'s left child has exactly the same as or just one more nodes than $t$'s right child
      1. each child is also maximally balanced
* Write a function, `count_nodes` (or `countNodes`), which takes a binary tree and returns the number of nodes in it (an empty tree has zero nodes) when it is maximally balanced; it should return -1 if it is not maximally balanced

* Note: how to represent an empty tree?  The most natural choice for each language is:
  * Go : `nil`
  * Julia : `nothing`
  * OCaml : use `type` with alternatives to define `bintree`
  * Rust : use `enum` with alternatives to define `bstree`, or use `None` in `Option` type
* Note: in Go and Rust, you cannot have a field of type $T$ in the definition of type $T$; therefore you need to think about the type of left child and right child
  * Go : pointer to `BSTree` (`*BSTree`), which may be `nil` to accommodate the possibility of empty child
  * Rust : pointer to type $T$ is `Box<T>`; if you define `BSTree` with `enum` to accommodate empty tree, then left child and right child can be represented by `Box<BSTree>`; if `BSTree` does not accommodate empty tree, then they have to be `Option<Box<BSTree>>`

* Boilerplate source files `{go,jl,ml,rs}/bintree.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.

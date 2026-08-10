# <font color="green">2-3 Tree</font>

* Let's consider how to implement a 2-3 tree, a simplified version of a B-tree commonly used for indexing data stored in databases.

## 2-3 Tree Definition

* A 2-3 tree is a tree structure similar to the binary search tree discussed earlier (`recursive_type/bstree`).
* See the [Wikipedia article](https://en.wikipedia.org/wiki/2%E2%80%933_tree) for an illustration.
* In a nutshell:
  - Only leaf nodes hold values.
  - Each internal node has either 2 or 3 children, and all leaves are at the same depth (except in the empty and singleton cases); in other words, all children of a node always have the same height.
  - When a node has children $u_0$, $u_1$, and possibly $u_2$, the following holds: any value in $u_0 \le$ any value in $u_1 \le$ any value in $u_2$. This is a property analogous to that of a binary search tree.
  - Internal nodes maintain value(s) that separate their children. Specifically, a node with two children has a separator value $s_0$ such that any value in $u_0 < s_0 \le$ any value in $u_1$; a node with three children has two separator values $s_0$ and $s_1$ such that any value in $u_0 < s_0 \le$ any value in $u_1 < s_1 \le$ any value in $u_2$.
  - Due to this ordering property and the balance property mentioned above, the tree guarantees $O(\log n)$ performance for search.
* The main question is how to insert a value into, or remove a value from, a tree while maintaining the equal-height property in $O(\log n)$ time.
* Below, we refer to a node with two children as a 2-node and a node with three children as a 3-node.

## In This Problem ...

* Define a data type representing a 2-3 tree, called `tttree` (or `TTTree`)
* Define four functions explained below `tttree_add, tttree_lookup, tttree_remove,` and `tttree_check` (or `TTTreeAdd, TTTreeLookup, TTTreeRemove`, and `TTTreeCheck`)
* There are implicit conditions imposed by test code; specifically
  * In Go, use `nil` to represent an empty tree
  * In Julia, use `nothing` to represent an empty tree
  * In OCaml, use variant to define 2-3 tree and `Empty` to represent an empty tree
  * In Rust, use `enum` to define 2-3 tree and `Empty` (`TTTree::Empty`) to represent an empty tree
* Check the test code before you proceed


## Adding a Value

Let's consider adding an element $x$ to a 2-3 tree $t$.
* (a) If $t$ is empty, create a singleton tree containing $x$.
* (b) If $t$ is a singleton tree containing $y$, create a 2-node with two leaf children $x$ and $y$.
* (c) Otherwise $t$ should have a 2- or 3-node as its root; choose the appropriate child $u$ by comparing $x$ and the separator value(s), then add $x$ to $u$.

However, simply replacing $u$ with the result of adding $x$ to $u$ may break the equal-height property. Let's consider how to handle this, starting with the simple case of depth 2 (i.e., a 2- or 3-node whose children are leaves).
* (*c2) If $t$ is a 2-node (i.e., has two leaf children $x_0$ and $x_1$), turn it into a 3-node with three leaves $x_0$, $x_1$, and $x$ in the appropriate order.
* (*c3) If $t$ is a 3-node (i.e., has three leaf children $x_0$, $x_1$, and $x_2$), simply adding $x$ would produce a 4-node, which is not allowed; we therefore split it into two 2-nodes.

With this in mind, let's consider the general case where a subtree may be split during insertion.
* (c) As before, first choose the appropriate child $u$ and add $x$ to it.
* (c-i) If $u$ is not split, simply replace $u$ with the result of adding $x$ to $u$.
* (c-ii) If $u$ is split:
  * If $t$ is a 2-node, create a 3-node by replacing $u$ with the two resulting nodes.
  * If $t$ is a 3-node, split it into two 2-nodes; this split is then handled by the parent.

* Define a function `tttree_add` that takes a non-negative integer $x$ and a 2-3 tree $t$, and inserts $x$ into $t$.
* You may assume $t$ does not already contain $x$ (no duplicates).
* It should not update $t$ in place; instead, it returns a new tree containing $x$.

## Removing a Value

Now let's consider removing a value $x$ from $t$.
* (a) If $t$ is empty, it remains empty.
* (b) If $t$ is a singleton, it becomes empty if $x$ matches its value, or remains unchanged otherwise.
* (c) Otherwise $t$'s root should be a 2- or 3-node; choose the appropriate child $u$ and remove $x$ from $u$.

Again, simply replacing $u$ with the result of removing $x$ from $u$ may break the equal-height property. As before, let's start with the simple case of depth 2 (i.e., a 2- or 3-node whose children are leaves).
* (*c3) If $t$ is a 3-node (i.e., has three leaf children $x_0$, $x_1$, and $x_2$) and one of the three values is removed, turn it into a 2-node.
* (*c2) If $t$ is a 2-node (i.e., has two leaf children $x_0$ and $x_1$) and one value is removed, the result would be a 1-node, which is not allowed; return it with a special flag indicating it is an invalid 1-node.

With this in mind, let's consider the general case where a 2-node may become a 1-node during removal.
* (c) As before, first choose the appropriate child $u$ and remove $x$ from it.
  * (i) If $u$ does not become a 1-node, simply replace $u$ with the result of removing $x$ from $u$.
  * (ii) If $u$ becomes a 1-node:
    * If $t$ is a 3-node, merge the 1-node with a neighboring sibling (if the 1-node is the middle child, either sibling may be used). If the sibling is a 3-node, split it into two 2-nodes ($t$ remains a 3-node); if the sibling is a 2-node, merge them into a 3-node ($t$ becomes a 2-node).
    * If $t$ is a 2-node, merge the 1-node with the other sibling. If the sibling is a 3-node, split it into two 2-nodes ($t$ remains a 2-node); if the sibling is a 2-node, merge them into a 3-node, and $t$ becomes a 1-node, which is then handled by the parent.

* Define a function `tttree_remove` that takes a non-negative integer $x$ and a 2-3 tree $t$, and removes $x$ from $t$ if it is present.
* You may assume each value appears at most once in $t$.
* It should not update $t$ in place; instead, it returns a new tree without $x$.
* If $x$ is not in $t$, return $t$ unchanged.

## Looking Up a Value

* Looking up a value is straightforward.
* Define a function `tttree_lookup` that takes a non-negative integer $x$ and a 2-3 tree $t$, and checks whether $x$ is in $t$.
* It should return `true` if $x$ is in $t$, and `false` otherwise.

## Checking a Tree

* Define a function `tttree_check` that takes a 2-3 tree $t$ and returns its depth, while verifying that all children of every internal node have the same height.
  * The depth of an empty tree is 0.
  * The depth of a singleton tree or a tree consisting of a root + 2 or 3 leaves is 1.
  * The depth of a 2- or 3-node is the depth of its children (which must all be equal) plus 1.

## Note

* The generalization of a 2-3 tree is the B-tree, widely used for indexing in databases.
* Each internal node of a B-tree has between $m$ and $2m-1$ children; a 2-3 tree corresponds to the case $m = 2$.

## Boilerplate and Test Code

* Boilerplate source files `{go,jl,ml,rs}/tttree.{go,jl,ml,rs}` containing the test code are generated and shown below.
* The test code does the following:
   - Randomly shuffles $0, 1, 2, \ldots, n-1$; call the result $X$.
   - Inserts all elements of $X$ into an empty tree (`tttree_add`).
   - Checks that each element of $X$ is found in the tree (`tttree_lookup`).
   - Randomly shuffles $X$ again; call the result $Y$.
   - Removes all elements of $Y$ from the resulting tree (`tttree_remove`).
   - Checks that the resulting tree is empty.
* Edit the source files either by opening them in a text editor (e.g., VSCode), or by editing the cells below and executing them.



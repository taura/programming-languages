""" md
#* Programming Language (2) --- Recursion
"""

""" md w

Enter your name and student ID.

 * Name:
 * Student ID:

"""

""" md
# Roadmap

* In this notebook, you will learn to solve problems with _recursion_, the core idea of _functional programming_
* It can be practiced in any language that supports recursive functions (virtually any programming language), including Go, Julia, OCaml, and Rust
* You are encouraged to work in at least <font color=blue>TWO</font> languages
* You will learn the following topics and solve a few coding problems
  * **recursion** : solving problems straightforwardly with recursion
  * **tail_recursion** : avoiding stack overflow with _tail_ recursion

# Recursion

* A recursive function is a function that calls itself
* In typical languages, nothing special is needed to make a function recursive; just define a function that calls itself. OCaml requires an extra keyword `rec` to define a recursive function (i.e., `let rec f x = ...` instead of `let f x = ...`)
* However, most programming language implementations are prone to stack overflow when recursive calls are nested too deeply
* _Tail recursion_ may avoid this, but there is no guarantee

# Tail Recursion

* A _tail call_ is a function call that has nothing left to do after it returns
* A _tail recursive call_ is a tail call that is also a recursive call
* See if the language you choose allows _tail recursive_ calls to go arbitrarily deep


# Docs

* Slide deck [Functional Programming](https://taura.github.io/programming-languages/slides/01-functional.pdf)
* [Go](https://www.tutorialspoint.com/go/go_functions.htm) Functions
* [Julia](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/functions) Functions
* [OCaml](https://ocaml.org/docs/tour-of-ocaml#recursive-functions) Recursive functions
* [Rust](https://www.tutorialspoint.com/rust/rust_functions.htm) Functions

# AI tutor

* Execute the following to enable it
* For AI use policy in this course, see [home page](https://taura.github.io/programming-languages/index.html#ai_policy)

"""

""" code w kernel=python """
import heytutor
""" """

""" md
# Show status
"""

""" code """
TOPICS = ["recursion", "tail_recursion"]
heytutor.show_status(topics=TOPICS)
""" """

""" md
# Generate a problem

* `gen_problem` function generates a problem based on your preference
* Uncommenting one of the following preferences and execute the cell below
* It will create a directory in `problems/{topic}/{problem}` and put a notebook and four subdirectories, one for each language (`go, jl, ml,` and `rs`)
* Click on the link to the notebook just created and work on it

* You may be able to guess what each preference means by its name, but to clarify
  * `next_topic`
    * get a problem from the "next" topic, which is the topic next to the last one (in the above list) from which at least one problem has been fetched
    * useful when you start from basic topics toward advanced ones, have done a problem on a topic, and want to go to the next topic
  * `last_topic`
    * get a problem from the "last" topic, which is the last topic (in the above list) from which at least one problem has been fetched
    * useful when you started from the most basic topic, have done a problem on a topic, and repeat the same topic
  * `prev_topic`
    * get a problem from the "previous" topic, which is the topic previous to the first topic from which at least one problem has been fetched
    * useful when you started from advanced topics, found a topic too advanced for now, and want to work on a slightly more basic problem
  * `first_topic`
    * get a problem from the "first" topic, which is the first topic from which at least one problem has been fetched
    * useful when you started from advanced topics, have done a problem on the topic, and repeat the same topic
  * `random` : get a random problem that has not been fetched
  * `match:REGEX` : get a problem matching REGEXP.  A problem P from a topic T is represented as T/P, so for example, `match:function/.*` matches any problem of topic "function", whereas `match:.*/xyz` matches any problem named `xyz`, from any topic

"""

""" code w """
PREFERENCE = "next_topic"
#PREFERENCE = "prev_topic"
#PREFERENCE = "last_topic"
#PREFERENCE = "first_topic"
#PREFERENCE = "random"
#PREFERENCE = "match:recursion/.*"
#PREFERENCE = "match:.*/gcd"

heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

* Your goal in this notebook is to solve at least <font color=blue>TWO</font> problems from each topic <font color=blue>(recursion and tail\_recursion)</font>

"""

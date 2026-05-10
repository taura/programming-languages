""" md
#* Programming Language (3) --- Type definition
"""

""" md w

Enter your name and student ID.

 * Name:
 * Student ID:

"""

""" md
# Roadmap

* In this notebook, you will learn how to define a new data type
* You are encouraged to work in at least <font color=blue>TWO</font> languages
* You will learn the following topics and solve a few coding problems
  * **tyepdef** : defining a new data type
  * **recursive_type** : defining a recursive data type

# Docs

* [Go](https://www.tutorialspoint.com/go/go_data_types.htm) Data Types (see "Structure Types")
* [Julia](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/custom-types) Custom structures
* [OCaml](https://ocaml.org/docs/tour-of-ocaml#variant-types) Variant Types
* [Rust](https://www.tutorialspoint.com/rust/rust_structure.htm) Structures and [Rust](https://www.tutorialspoint.com/rust/rust_enums.htm) Enums

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
TOPICS = ["typedef", "recursive_type"]
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
#PREFERENCE = "match:recursive_type/.*"
#PREFERENCE = "match:.*/gcd"

heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

* Your goal in this notebook is to solve at least <font color=blue>TWO</font> problems from each topic <font color=blue>(typedef and recursive\_type)</font>

"""

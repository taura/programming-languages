""" md
# Programming Languages (4) --- Parametric Polymorphism (aka Generic Functions and Types)
"""

""" md w 

Enter your name and student ID.

 * Name:
 * Student ID:

"""

""" md

# Roadmap

* In this notebook, you will learn *parametric polymorphism* (also known as generics), a form of polymorphism widely supported in modern programming languages.
* You should work on the <font color=blue>TWO</font> languages you are assigned to.

# Docs


 |     |                                         |
 |-----|-----------------------------------------|
 |Go   |[Generics](https://www.tutorialspoint.com/go/go_generics.htm)|
 |Julia|[Parametric Types](https://docs.julialang.org/en/v1/manual/types/#Parametric-Types)|
 |Julia|[Parametric Methods](https://docs.julialang.org/en/v1/manual/methods/#Parametric-Methods)|
 |OCaml|[Records and variants](https://ocaml.org/manual/coreexamples.html#s:tut-recvariants)|
 |Rust |[Generic Types](https://www.tutorialspoint.com/rust/rust_generic_types.htm)|


# AI Tutor

* Execute the following cell to enable it.
* For the AI use policy in this course, see the [home page](https://taura.github.io/programming-languages/index.html#ai_policy).

"""

""" code w kernel=python """
import heytutor
""" """

""" md
# Show Status
"""

""" code """
TOPICS = ["parametric"]
heytutor.show_status(topics=TOPICS)
""" """

""" md
# Generate a Problem

* The `gen_problem` function generates a problem based on your preference.
* Uncomment one of the preferences below and execute the cell.
* The goal is to solve the final problem `generic_optimize` in this topic. You may want to use `prev_prob`, which steps backward from the last problem, or `next_prob`, which steps forward from the first.

"""

""" code w """
PREFERENCE = "next_prob"        # want to start from the first problem and move forward
#PREFERENCE = "prev_prob"       # want to start from the last problem, and move backward if difficult

#PREFERENCE = "next_topic"
#PREFERENCE = "prev_topic"
#PREFERENCE = "last_topic"
#PREFERENCE = "first_topic"
#PREFERENCE = "random"
#PREFERENCE = "match:oop_basics/.*"
#PREFERENCE = "match:.*/class"

heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

# Goal

* Your goal in this notebook is to solve the final problem `generic_optimize` in this topic.
* The other problems are warm-up exercises to help you reach it.

"""


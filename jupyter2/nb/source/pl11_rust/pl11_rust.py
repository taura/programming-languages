""" md
#* Programming Languages (11) --- Rust Memory Management
"""
""" md w
Enter your name and student ID.
 * Name:
 * Student ID:
"""
""" md

# Objective

* Learn memory management of Rust
* Ownership and borrowing

# Roadmap

1. Simple benchmark --- compare memory usage and performance of a simple program that continuously allocates memory
1. Visualization --- visualize addresses returned by allocations to witness the same memory address is reused
1. Adjusting GC parameters --- play with GC-related parameters to observe that GC can trade memory for performance
1. Allocation intensive programs --- do the above for a slightly more realistic program

"""

""" md

# AI Tutor

* Run the cell below to enable it.
* For the AI use policy in this course, see the [home page](https://taura.github.io/programming-languages/index.html#ai_policy).
"""

""" code w kernel=python """
import heytutor
""" """

""" md

# Show Status

"""
""" code """
TOPICS = ["rust_memory_management"]
heytutor.show_status(topics=TOPICS)
""" """

""" md

# Generate a Problem

* The `gen_problem` function generates a problem based on your preference.
* Uncomment one of the options below and run the cell.
* The goal is to solve the final problem, `generic_optimize`, in this topic. You may want to use `prev_prob` to step backward from the last problem, or `next_prob` to step forward from the first.
"""

""" code w """
PREFERENCE = "next_prob"        # start from the first problem and move forward
#PREFERENCE = "prev_prob"       # start from the last problem and move backward if too difficult
#PREFERENCE = "next_topic"
#PREFERENCE = "prev_topic"
#PREFERENCE = "last_topic"
#PREFERENCE = "first_topic"
#PREFERENCE = "random"
#PREFERENCE = "match:memory_management/.*"
#PREFERENCE = "match:.*/bst"
heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

# Goal

* This notebooks is mainly for self-learning and exploration
"""


""" md
#* Programming Languages (6) --- Build Systems, Libraries, and Multiple Files
"""
""" md w
Enter your name and student ID.
 * Name:
 * Student ID:
"""
""" md

# Objective

* Learn what is necessary to develop programs beyond single-file, small-scale exercises.

# Roadmap

1. Build system --- compile and run a simple program using a build system
1. Command-line arguments --- write a program that accepts command-line arguments
1. Libraries --- use third-party libraries, installing them as needed
1. Multiple source files --- write a program that spans multiple source files

* The two main goals are:
  * to become comfortable searching for useful libraries and incorporating them into your programs
  * to become comfortable splitting your program into multiple files in a way that is easy to understand and maintain
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
TOPICS = ["build_system"]
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
#PREFERENCE = "match:build_system/.*"
#PREFERENCE = "match:.*/multiple_files"
heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

# Goal

* Your goal in this notebook is to solve the final problem, `multiple_files`, in this topic.
* The other problems are warm-up exercises to help you get there.
"""


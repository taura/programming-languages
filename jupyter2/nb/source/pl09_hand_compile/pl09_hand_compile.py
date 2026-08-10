""" md
#* Programming Languages (9) --- Hand-compiling C programs
"""
""" md w
Enter your name and student ID.
 * Name:
 * Student ID:
"""
""" md

# Objective

* Learn how expressions and statements in C are mapped to assembly code, by translating (compiling) simple C functions into ARM64 assembly _by hand_.
* Even if you are not building a compiler, this knowledge helps you understand how programming languages work, write efficient programs, and diagnose programs in unsafe languages such as C/C++.
* We use the 64-bit ARM instruction set (_arm64_ / _aarch64_) as the target.
  * [ARM64 assembly cheat sheet](https://taura.github.io/programming-languages/html/arm64_assembly_cheat_sheet.html)
  * [reference](https://developer.arm.com/documentation/ddi0602/latest/)
  * If you are new to C, study a [C primer](https://taura.github.io/programming-languages/html/c_language_primer.html) first.
"""

""" md

# How to let the C compiler generate assembly code

* `gcc`/`g++` is a compiler for C/C++.
* The `-S` option emits assembly code and stops after that.
* For example, to get the assembly code for `abc.c`, 
```
gcc -O3 -S abc.c
cat abc.s
```

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
TOPICS = ["hand_compile"]
heytutor.show_status(topics=TOPICS)
""" """

""" md

# Generate a Problem

* The `gen_problem` function generates a problem based on your preference.
* Uncomment one of the options below and run the cell.
"""

""" code w """
PREFERENCE = "next_prob"        # start from the first problem and move forward
#PREFERENCE = "prev_prob"       # start from the last problem and move backward if too difficult
#PREFERENCE = "first_topic"
#PREFERENCE = "last_topic"
#PREFERENCE = "random"
#PREFERENCE = "match:hand_compile/sum_array"
heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

# Goal

* Your goal in this notebook is to solve the following mandatory problems:
   * sum_array
   * expsum
* Other problems are optional, but you are encouraged to solve all of them from the beginning to the end, especially if you are new to assembly code. You can use `prev_prob` and `next_prob` to step backward and forward, respectively.
"""

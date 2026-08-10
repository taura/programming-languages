""" md
#* Programming Languages (10) --- Building a minC (minimum C) compiler
"""
""" md w
Enter your name and student ID.
 * Name:
 * Student ID:
"""

""" md

<a name="intro"> </a>
# Introduction

* This is the launcher for **Option A** of the term report: you build a compiler for _minC_, a minimum subset of C, that emits 64-bit ARM (_arm64_) assembly.
* Pick **one** implementation language (Go, Julia, OCaml, or Rust) and fetch its problem with `gen_problem` below. The fetched problem contains everything you need: the problem statement (`minc.md`), the grammar (`minc_grammar.txt`), the skeleton compiler (`minc/`), a pristine copy of it (`orig/`), and the tests (`test/`).
* Your actual work will be done mostly in a terminal and a text editor inside the fetched problem directory.
"""

""" md

# AI Tutor

* Run the cell below to enable it.
"""

""" code w """
import heytutor
""" """

""" md

# Show status

* In this topic (`minc`) there is only one problem (`minc`).

"""

""" code w kernel=python """
TOPICS = ["minc"]
heytutor.show_status(topics=TOPICS)
""" """

""" md

# Generate your problem

* Run the cell below to fetch the problem
"""

""" code w kernel=python """
PREFERENCE = "match:minc/minc"
heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md
# How to submit

* Submit your work through Jupyter, and submit the brief term report for "Term Report Option A (pl10_minc; build a compiler)" through UTOL.
"""

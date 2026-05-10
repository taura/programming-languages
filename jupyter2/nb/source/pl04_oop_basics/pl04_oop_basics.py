""" md
#* Programming Languages (4) --- Object-Oriented Programming Basics
"""

""" md w 

Enter your name and student ID.

 * Name:
 * Student ID:

"""

""" md

# Roadmap

* In this notebook, you will learn the basics of object-oriented programming, a cornerstone of all modern programming languages
* You should work on the <font color=blue>TWO</font> languages you are assigned to
* You should work on _all_ problems in the topic `oop_basics`

# Docs


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
TOPICS = ["oop_basics"]
heytutor.show_status(topics=TOPICS)
""" """

""" md
# Generate a problem

* `gen_problem` function generates a problem based on your preference
* Un-commenting one of the following preferences and execute the cell below
* In this topic, you are highly encouraged to work on all problems in the order they are listed.
* To that end, simply stick with the `next_prob` option below

"""

""" code w """
PREFERENCE = "next_prob"
#PREFERENCE = "prev_prob"
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

* Your goal in this notebook is to solve _all_ problems in this topic and discuss the results with your team member(s)

"""


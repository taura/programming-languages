""" md 

""" include {out_dir}/{concept}/{problem}/{base}.md """

"""

""" md

# AI tutor

## Prepare

* Your personal AI tutor is provided for questions and feedback
* Execute the following cell before you use it
"""

""" code w """
import heytutor
""" """

""" md
## Examples

* A general question
```
%%hey
What is a borrowing pointer in Rust?
```

* A hint on this specific problem
```
%%hey problem_file={base}.md
Give me a hint on this problem.

{{problem}}
```

* Builtin variables usable in `%%hey` cells
  * `{{file:FILENAME}}` is the content of FILE
  * `{{bash[-1]}}` is the output of the last `%%bash_` cell, `{{bash[-2]}}` the second last, etc.
  * `{{problem}}` is the content of the file you specify by `%%hey problem_file=foo.md`
  * `{{answer}}` is the content of the file you specify by `%%hey answer_file=foo.s`
"""

""" md
# Baseline code
"""

""" code w """
import heytutor
""" """

""" code w """
%%writefile_ rs/{base}.rs
""" include {out_dir}/{concept}/{problem}/rs/{base}.rs """
""" """

""" md
# Compile
"""
""" codex
%%bash_
. ~/.cargo/env
rustc rs/{base}.rs -o rs/{base}
"""

""" md
* Note: when you run `rustc` or other Rust commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`. ~/.cargo/env`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
# Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md answer_file=rs/{base}.rs

Problem:
{{problem}}

My Answer (between /** begin my answer */ and /** end my answer */):
{{answer}}

Give me a feedback to my answer.
"""


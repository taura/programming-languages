""" md

""" include {out_dir}/{concept}/{problem}/{base}.md """

"""

""" md

# AI Tutor

## Prepare

* Your personal AI tutor is provided for questions and feedback.
* Execute the following cell before you use it.
"""

""" code w """
import heytutor
""" """

""" md
## Examples

* A general question
```
%%hey
What does the `ldr` instruction do in ARM64?
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

# Observe: compile example functions

* Before writing your own assembly, it helps to see what the compiler generates for related example functions.
* Running the first cell below writes `explore.c` (some small example functions related to this problem).
* The second cell compiles it with `gcc -O3 -S` and prints the generated assembly.
* Feel free to edit `explore.c` (change the code, add functions, change constants) and re-run the two cells to see how the assembly changes.
"""

""" codex w
%%writefile_ explore.c
""" include {in_dir}/{concept}/{problem}/explore.c """
"""

""" codex w
%%bash_
gcc -O3 -S explore.c
cat explore.s
"""

""" md

# Your Answer (assembly)

* Running the cell below writes the skeleton assembly file `{base}.s`.
* Fill in your instructions after the line `// ------- write your answer here -------`, then run the cell again to save it.
"""

""" codex w points=1
%%writefile_ {base}.s
""" include {in_dir}/{concept}/{problem}/{base}.s """
"""

""" md

# Checker

* The following C program calls your `{base}` function and checks the result against a reference computed in C.
"""

""" codex w
%%writefile_ check_{base}.c
""" include {in_dir}/{concept}/{problem}/check_{base}.c """
"""

""" md

# Compile

* Compile your assembly together with the checker.
* If you get an error, fix `{base}.s` above and recompile.
"""

""" codex w points=1
%%bash_
gcc -o check_{base} -O3 check_{base}.c {base}.s -lm
"""

""" md

# Run

* If you see `OK`s and no errors, you are done.
"""

""" codex w
%%bash_
""" include {in_dir}/{concept}/{problem}/run.sh """
"""

""" md

# If things do not go well

* If your program compiles but does not produce the correct answer, run it within a debugger (gdb).
* Compile with `-O0 -g` first:
```
gcc -o check_{base} -O0 -g check_{base}.c {base}.s -lm
```
* Then, in a terminal (SSH or Jupyter terminal):
```
gdb check_{base}
(gdb) break {base}
(gdb) run ...        # give the same arguments as above
```
* Step through one instruction at a time with `step`, and inspect registers with `print $x0` or `info registers`.

# Ask Questions or Get Feedback

* You are encouraged to ask for feedback once you think you are done, to know if there is a better answer.
"""

""" codex w
%%hey problem_file={base}.md answer_file={base}.s

Problem:
{{problem}}

My Answer:
{{answer}}

Give me a feedback to my answer.
"""

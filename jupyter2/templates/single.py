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
## How to Use It

* You can talk to AI by executing a Python code cell starting with the magic keyword `%%hey problem_file=... [answer_file=]`
* Write any text below the `%%hey ...` and execute it
* `{{problem}}` is automatically replaced by the contents of the file specified with `problem_file=`
* `{{answer}}` is automatically replaced by the contents of the file specified with `answer_file=`
* For example,
* A general question
```
%%hey problem_file=...
How to write a function in Go?
```
* A hint on this specific problem
```
%%hey problem_file=...
I am working on Rust. Give me a hint on this problem.
```
* Help when you struggle
```
%%hey problem_file=... answer_file=...
I get this error when I compile it. What's wrong?"

My program:
{{answer}}

Error message:
  <paste the compile error message> 

```
* You are encouraged to ask a feedback once you think you are done with the problem, to know if there is a better answer.  You can do so by something like:
```
%%hey problem_file=... answer_file=...
My Answer:
{{answer}}

Give me a feedback to my answer.
```
"""

""" md
# Go
"""

""" md
## Baseline code
"""
""" code w """
%%writefile_ go/{base}.go
""" include {out_dir}/{concept}/{problem}/go/{base}.go """
""" """

""" md
## Compile
"""

""" codex
%%bash_
export PATH=${{PATH}}:~/go/bin
go build -o go/{base} go/{base}.go
"""

""" md
* Note: when you run `go` or other Go commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`export PATH=${{PATH}}:~/go/bin`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Run
"""
""" codex
%%bash_
go/{base}
"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md answer_file=go/{base}.go

Problem:
{{problem}}
My Answer (between /** begin my answer */ and /** end my answer */):
{{answer}}

Give me a feedback to my answer.
"""

""" md
# Julia
"""

""" md
## Baseline code
"""
""" code w """
%%writefile_ jl/{base}.jl
""" include {out_dir}/{concept}/{problem}/jl/{base}.jl """
""" """

""" md
## Compile
"""
""" md
* Julia code is compiled "just in time" (compiled upon executed), so does not need a specific action for compilation before you run
"""

""" md
## Run
"""
""" codex
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin
julia jl/{base}.jl
"""

""" md
* Note: when you run `julia` or other Julia commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`export PATH=${{PATH}}:~/.juliaup/bin`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Interactive execution

* `julia` command  also serves is an interactive command for Julia programs

* You can run a source code and continue interaction

```
$ julia -i jl/{base}.jl
```

* For trial and error, you may also consider creating a Julia notebook

"""


""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md answer_file=jl/{base}.jl

Problem:
{{problem}}

My Answer (between ### begin my answer and ### end my answer):
{{answer}}

Give me a feedback to my answer.
"""

""" md
# OCaml
"""

""" md
## Baseline code
"""
""" code w """
%%writefile_ ml/{base}.ml
""" include {out_dir}/{concept}/{problem}/ml/{base}.ml """
""" """

""" md
## Compile
"""
""" codex
%%bash_
eval $(opam env)
ocamlc ml/{base}.ml -o ml/{base}
"""

""" md
* Note: when you run `ocamlc` or other OCaml commands (see below) in a terminal (SSH or Jupyter terminal), you need to execute the first line (`eval $(opam env)`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Run
"""
""" codex
%%bash_
ml/{base}
"""

""" md
## Interactive execution

* `ocaml` command is an interactive command for OCaml programs

* In terminal (Jupyter or SSH), you can directly run a source code

```
$ eval $(opam env)   # once in your session or put it in ~/.bash_profile
$ ocaml ml/{base}.ml
```

* You can run a source code and continue interaction

```
$ eval $(opam env)   # once in your session or put it in ~/.bash_profile
$ ocaml -init ml/{base}.ml
```

* For trial and error, you may also consider creating an OCaml notebook

"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md answer_file=ml/{base}.ml

Problem:
{{problem}}

My Answer (between (** begin my answer *) and (** end my answer *)):
{{answer}}

Give me a feedback to my answer.
"""

""" md
# Rust
"""

""" md
## Baseline code
"""
""" code w """
%%writefile_ rs/{base}.rs
""" include {out_dir}/{concept}/{problem}/rs/{base}.rs """
""" """

""" md
## Compile
"""
""" codex
%%bash_
. ~/.cargo/env
rustc {base}.rs -o rs/{base}
"""

""" md
* Note: when you run `rustc` or other Rust commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`. ~/.cargo/env`)
* You may consider adding that line in your `~/.bash_profile`
"""


""" md
## Run
"""
""" codex
%%bash_
rs/{base}
"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md answer_file=rs/{base}.rs

Problem:
{{problem}}

My Answer (between /** begin my answer */ and /** end my answer */):
{{answer}}

Give me a feedback to my answer.
"""


""" md 

""" include {out_dir}/{concept}/{problem}/{base}.md """

"""

""" md

# AI tutor
"""

""" code w """
import heytutor
""" """

""" md
## Basics

```
%%hey [problem_file=...] [answer_file=...]
```

### Builtin variables

* `{{file:FILENAME}}` is the content of FILE
* `{{files:PATTERN}}` is the content of files matching PATTERN (e.g., `{{files:go/{base}/*/*.go}}`)
* `{{bash[-1]}}` is the output of the last `%%bash_` cell, `{{bash[-2]}}` that of the second last `%%bash_` cell, etc.
* `{{problem}}` is the content of the file you specified by `%%hey problem_file=foo.md`
* `{{answer}}` is the content of the file you specified by `%%hey answer_file=go/foo.go`

"""

""" md
# Go
"""

""" md
## AI tutor
"""

""" code w """
import heytutor
""" """

""" md
## Set up a module
"""

""" codex w
%%bash_

export PATH=${{PATH}}:~/.local/go/bin:~/go/bin
mkdir -p go/{base}
cd go/{base}
go mod init {base}
"""

""" md
* Note: when you run `go` or other Go commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`export PATH=${{PATH}}:~/go/bin`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Writing code

* Write it from scratch below
* No boilerplate provided
* Add `%%writefile_` cells if there are multiple files and you want to write code in Jupyter
* If you edit the file outside Jupyter, <font color=red>be careful not to overwrite it with an empty file</font>
"""

""" codex w 
%%writefile_ go/{base}/{base}.go
/* go/{base}/{base}.go */
"""

""" codex w 
%%bash_

cat go/{base}/{base}.go
"""

""" md
## Build
"""
""" codex w
%%bash_

export PATH=${{PATH}}:~/.local/go/bin:~/go/bin
cd go/{base}
go build
"""

""" md
## Run
"""
""" codex w
%%bash_

""" include {in_dir}/{concept}/{problem}/go/test_{base}.sh """

"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Code: go/{base}/{base}.go
{{file:go/{base}/{base}.go}}

Module descriptor: go/{base}/go.mod
{{file:go/{base}/go.mod}}

Give me a feedback to my answer.
"""

""" md
# Julia
"""

""" md
## AI tutor
"""

""" code w """
import heytutor
""" """

""" md
## Set up a module

* Unnecessary, but make a directory for organization consistent with other languages

"""

""" codex w
%%bash_

mkdir -p jl/{base}
"""

""" md
## Writing code

* Write it from scratch below
* No boilerplate provided
* Add `%%writefile_` cells if there are multiple files and you want to write code in Jupyter
* If you edit the file outside Jupyter, <font color=red>be careful not to overwrite it with an empty file</font>
"""

""" codex w 
%%writefile_ jl/{base}/{base}.jl
## jl/{base}/{base}.jl
"""

""" codex w 
%%bash_

cat jl/{base}/{base}.jl
"""

""" md
## Build

* Unnecessary
"""

""" md
## Run
"""

""" codex w
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin

""" include {in_dir}/{concept}/{problem}/jl/test_{base}.sh """
"""

""" md
* Note: when you run `julia` or other Julia commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`export PATH=${{PATH}}:~/.juliaup/bin`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Ask Questions or Get Feedback

* Consider including `{{bash[-1]}}` --- the last output by `%%bash_` --- to get feedback on errors

"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Code: jl/{base}/{base}.jl
{{file:jl/{base}/{base}.jl}}

Give me a feedback to my answer.
"""

""" md
# OCaml
"""

""" md
## AI tutor
"""

""" code w """
import heytutor
""" """

""" md
## Set up a module
"""

""" codex w
%%bash_

eval $(opam env)
mkdir -p ml
cd ml
dune init proj {base}
"""

""" md
* Note: when you run `ocamlc` or other OCaml commands (see below) in a terminal (SSH or Jupyter terminal), you need to execute the first line (`eval $(opam env)`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Writing code

* Write it from scratch below
* No boilerplate provided
* Add `%%writefile_` cells if there are multiple files and you want to write code in Jupyter
* `dune init proj {base}` command above should have created the following file
* <font color=red>Be careful not to overwrite it with an empty file</font>
"""

""" codex w 
%%bash_

cat ml/{base}/bin/main.ml
"""

""" codex w 
%%writefile_ ml/{base}/bin/main.ml
(* ml/{base}/bin/main.ml *)
"""

""" md
## Build
"""
""" codex w
%%bash_

eval $(opam env)
cd ml/{base}
dune build
"""

""" md
## Run
"""
""" codex w
%%bash_

""" include {in_dir}/{concept}/{problem}/ml/test_{base}.sh """
"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Code: ml/{base}/bin/main.ml
{{file:ml/{base}/bin/main.ml}}

Module descriptor: ml/{base}/bin/dune
{{file:ml/{base}/bin/dune}}

Give me a feedback to my answer.
"""


""" md
# Rust
"""

""" md
## AI tutor
"""

""" code w """
import heytutor
""" """

""" md
## Set up a module
"""

""" codex w
%%bash_

. ~/.cargo/env
mkdir -p rs
cd rs
cargo new {base}
"""

""" md
* Note: when you run `rustc` or other Rust commands in a terminal (SSH or Jupyter terminal), you need to execute the first line (`. ~/.cargo/env`)
* You may consider adding that line in your `~/.bash_profile`
"""

""" md
## Writing code

* Write it from scratch below
* No boilerplate provided
* Add `%%writefile_` cells if there are multiple files and you want to write code in Jupyter
* `cargo new {base}` command above should have created the following file
* <font color=red>Be careful not to overwrite it with an empty file</font>
"""

""" codex w 
%%bash_

cat rs/{base}/src/main.rs
"""

""" codex w 
%%writefile_ rs/{base}/src/main.rs
/* rs/{base}/src/main.rs */
"""

""" md
## Build
"""

""" codex w
%%bash_

. ~/.cargo/env
cd rs/{base}
cargo build
"""

""" md
## Run
"""

""" codex w
%%bash_

""" include {in_dir}/{concept}/{problem}/rs/test_{base}.sh """

"""

""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Code: rs/{base}/src/main.rs
{{file:rs/{base}/src/main.rs}}

Module descriptor: rs/{base}/Cargo.toml
{{file:rs/{base}/Cargo.toml}}

Give me a feedback to my answer.
"""


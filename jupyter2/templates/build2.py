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
# C/C++ for comparison
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

mkdir -p cc/{base}
"""

""" md
## Writing code

* Write it from scratch below
* No boilerplate provided
* Add `%%writefile_` cells if there are multiple files and you want to write code in Jupyter
* If you edit the file outside Jupyter, <font color=red>be careful not to overwrite it with an empty file</font>
"""

""" codex w 
%%writefile_ cc/{base}/{base}.cc


""" include {in_dir}/{concept}/{problem}/cc/{base}/{base}.cc """

"""

""" codex w 
%%bash_

cat cc/{base}/{base}.cc
"""

""" md
## Build
"""
""" codex w
%%bash_

cd cc/{base}
g++ -o {base} -Wall -Wextra -O3 {base}.cc
"""

""" md
## Run
"""
""" codex w
%%bash_

lang=cc
exe=cc/{base}/{base}

""" include {in_dir}/{concept}/{problem}/test_{base}.sh """

"""

""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

...
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

""" include {in_dir}/{concept}/{problem}/go/{base}/{base}.go """

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

lang=go
exe=go/{base}/{base}

""" include {in_dir}/{concept}/{problem}/test_{base}.sh """

"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

...
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

""" include {in_dir}/{concept}/{problem}/jl/{base}/{base}.jl """

"""

""" codex w 
%%bash_

cat jl/{base}/{base}.jl
"""

""" md
## Build

* Unnecessary, but we make the Julia file executable for consistency with other languages
"""

""" codex w 
%%bash_

chmod +x jl/{base}/{base}.jl
"""


""" md
## Run
"""

""" codex w
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin

lang=jl
exe=jl/{base}/{base}.jl

""" include {in_dir}/{concept}/{problem}/test_{base}.sh """

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

...
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

""" include {in_dir}/{concept}/{problem}/ml/{base}/bin/main.ml """

"""

""" md
## Build
"""
""" codex w
%%bash_

eval $(opam env)
cd ml/{base}
dune build --release
"""

""" md
## Run
"""
""" codex w
%%bash_

lang=ml
exe=ml/{base}/_build/default/bin/main.exe

""" include {in_dir}/{concept}/{problem}/test_{base}.sh """

"""

""" md
## Ask Questions or Get Feedback
"""
""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

...
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

""" include {in_dir}/{concept}/{problem}/rs/{base}/src/main.rs """

"""

""" md
## Build
"""

""" codex w
%%bash_

. ~/.cargo/env
cd rs/{base}
cargo build --release
"""

""" md
## Run
"""

""" codex w
%%bash_

lang=rs
exe=rs/{base}/target/release/{base}

""" include {in_dir}/{concept}/{problem}/test_{base}.sh """

"""

""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

...
"""

""" md

# Summarize your observations in this experiment

* Summarize your observations in this experiment below

"""

""" codex w points=1
%%writefile_ note.md
"""

""" md

# Ask Questions or Get Feedback

"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

My thoughts: note.md
{{file:note.md}}

Give me feedback on my thoughts.
"""

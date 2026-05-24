""" md 
""" include {out_dir}/{concept}/{problem}/{base}.md """
"""

""" md

# AI Tutor

## Basics

* Execute

"""

""" code w """
import heytutor
""" """

""" md
and execute a code cell with
```
%%hey [problem_file=...] [answer_file=...]
... arbitrary texts ...
```

## Built-in Variables

The following variables are available in `%%hey` cells and are replaced with the respective strings:

* `{{file:FILENAME}}` = the content of `FILENAME`
* `{{files:PATTERN}}` = the content of files matching `PATTERN` (e.g., `{{files:go/{base}/*/*.go}}`)
* `{{bash[-1]}}` = the output of the last `%%bash_` cell; `{{bash[-2]}}` that of the second-to-last `%%bash_` cell, etc.
* `{{problem}}` = the content of the file specified by `%%hey problem_file=foo.md`
* `{{answer}}` = the content of the file specified by `%%hey answer_file=go/foo.go`
"""

""" md

# Go

"""

""" md

## AI Tutor

"""

""" code w """
import heytutor
""" """

""" md

## Source Code

"""

""" codex w
%%writefile_ go/{base}.go
""" include {out_dir}/{concept}/{problem}/go/{base}.go """
"""

""" md

## Generate Assembly Code

"""

""" codex w
%%bash_
export PATH=${{PATH}}:~/.local/go/bin:~/go/bin
go build -o go/{base}.o go/{base}.go
go tool objdump -gnu go/{base}.o > go/{base}.s
cat go/{base}.s
"""

""" md

## Visualize Assembly Code (Control Flow Graph)

* You can visualize the control flow graph of the assembly code.

"""

""" code w """
import vis_asm
vis_asm.vis_asm_file("go/{base}.s")
""" """

""" md

## Write Your Observation about Go

"""

""" codex w points=1
%%writefile_ go/note.md
"""

""" md

## Ask Questions or Get Feedback

"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Source: go/{base}.go
{{file:go/{base}.go}}

Assembly: go/{base}.s
{{file:go/{base}.s}}

My answer: go/note.md
{{file:go/note.md}}

Give me feedback on my answer about Go.
"""

""" md

# Julia

"""

""" md

## AI Tutor

"""

""" code w """
import heytutor
""" """

""" md

## Source Code

"""

""" codex w
%%writefile_ jl/{base}.jl
""" include {out_dir}/{concept}/{problem}/jl/{base}.jl """
"""

""" md

## Generate Assembly Code

"""

""" codex w
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin
julia -O3 jl/{base}.jl | sed 's/\x1b\[[0-9;]*m//g' > jl/{base}.s
cat jl/{base}.s
"""

""" md

## Visualize Assembly Code (Control Flow Graph)

* You can visualize the control flow graph of the assembly code by specifying the name of the function you want to visualize.

"""

""" code w """
import vis_asm
vis_asm.vis_asm_file("jl/{base}.s")
""" """

""" md

## Write Your Observation about Julia

"""

""" codex w points=1
%%writefile_ jl/note.md
"""

""" md

## Ask Questions or Get Feedback

"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Source: jl/{base}.jl
{{file:jl/{base}.jl}}

Assembly: jl/{base}.s
{{file:jl/{base}.s}}

My answer: jl/note.md
{{file:jl/note.md}}

Give me feedback on my answer about Julia.
"""

""" md

# OCaml

"""

""" md

## AI Tutor

"""

""" code w """
import heytutor
""" """

""" md

## Source Code

"""

""" codex w
%%writefile_ ml/{base}.ml
""" include {out_dir}/{concept}/{problem}/ml/{base}.ml """
"""

""" md

## Generate Assembly Code

"""

""" codex w
%%bash_
eval $(opam env)
ocamlopt -O3 -S ml/{base}.ml
cat -n ml/{base}.s
"""

""" code w """
import vis_asm
vis_asm.vis_asm_file("ml/{base}.s")
""" """

""" md

## Write Your Observation about OCaml

"""

""" codex w points=1
%%writefile_ ml/note.md
"""

""" md

## Ask Questions or Get Feedback

"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Source: ml/{base}.ml
{{file:ml/{base}.ml}}

Assembly: ml/{base}.s
{{file:ml/{base}.s}}

My answer: ml/note.md
{{file:ml/note.md}}

Give me feedback on my answer about OCaml.
"""

""" md

# Rust

"""

""" md

## AI Tutor

"""

""" code w """
import heytutor
""" """

""" md

## Source Code

"""

""" codex w
%%writefile_ rs/{base}.rs
""" include {out_dir}/{concept}/{problem}/rs/{base}.rs """
"""

""" md

## Generate Assembly Code

"""

""" codex w
%%bash_
. ~/.cargo/env
rustc -C opt-level=3 --emit asm --crate-type lib rs/{base}.rs -o rs/{base}.s
cat -n rs/{base}.s
"""

""" code w """
import vis_asm
vis_asm.vis_asm_file("rs/{base}.s")
""" """

""" md

## Write Your Observation about Rust

"""

""" codex w points=1
%%writefile_ rs/note.md
"""

""" md

## Ask Questions or Get Feedback

"""

""" codex w
%%hey problem_file={base}.md

Problem:
{{problem}}

Source: rs/{base}.rs
{{file:rs/{base}.rs}}

Assembly: rs/{base}.s
{{file:rs/{base}.s}}

My answer: rs/note.md
{{file:rs/note.md}}

Give me feedback on my answer about Rust.
"""

""" md

# Compare

"""

""" md

## Write Your Observation Comparing These Languages

* Discuss with your team members and write your observations about the similarities and differences between these languages.

"""

""" codex w
%%writefile_ comparison.md
"""

""" md

## Ask Questions or Get Feedback

"""

""" codex w points=1
%%hey problem_file={base}.md

Problem:
{{problem}}

My answer: comparison.md
{{file:comparison.md}}

Give me feedback on my answer comparing the four languages.
"""



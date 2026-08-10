""" md 
""" include {out_dir}/{concept}/{problem}/{base}.md """
"""

""" md
# AI Tutor
"""

""" code w """
import heytutor
""" """

""" md
# The grammar

* Take a look at the grammar to understand the scope of the language you are implementing. It is in `minc_grammar.txt`, found in your language's `minc/` directory (a copy also sits in `orig/`).
"""

""" md
# Explain

* Read the lexer, AST, and parser, and explain below how they work.
* Also outline how to add the `while` statement to the lexer, AST, and parser.

"""

""" codex w
%%writefile_ explain.md
"""

""" codex w
%%hey

Problem:
{{file:minc.md}}

My explanation:
{{file:explain.md}}


Give me feedback on my explanation for the "Read the lexer, AST, and parser, and **explain in your own words** how they work and how they correspond to the grammar" part of the problem.

"""


""" md
# Go

## Build
"""

""" code w """
import heytutor
""" """

""" codex w
%%bash_
export PATH=${{PATH}}:~/.local/go/bin:~/go/bin
cd go/minc
go build
"""

""" md
## Run (the code generator is an unfinished stub at first)
"""

""" codex w
%%bash_
cd go/minc
echo 'long f(long x) {{ return x + 1; }}' | ./minc
"""

""" md
## Test

* Consider adding to the `make` command line:
  * `-k` to keep going instead of stopping at the first failure
"""

""" codex w points=1
%%bash_
cd test
make -B minc=../go/minc/minc
"""


""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey

Problem:
{{file:minc.md}}

My code (I edited go/minc; go/orig is the original I was given):
{{files:go/minc/*.go}}

Original code:
{{files:go/orig/*.go}}

Give me feedback on my code.
"""

""" md
# Julia

## Build

* Just make the driver executable.
"""

""" code w """
import heytutor
""" """

""" codex w
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin
cd jl/minc
chmod +x minc.jl
"""

""" md
## Run (the code generator is an unfinished stub at first)
"""

""" codex w
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin
cd jl/minc
echo 'long f(long x) {{ return x + 1; }}' | ./minc.jl
"""

""" md
## Test

* Consider adding to the `make` command line:
  * `-k` to keep going instead of stopping at the first failure
"""

""" codex w points=1
%%bash_
export PATH=${{PATH}}:~/.juliaup/bin
cd test
make -B minc=../jl/minc/minc.jl
"""

""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey

Problem:
{{file:minc.md}}

My code (I edited jl/minc; jl/orig is the original I was given):
{{files:jl/minc/*.jl}}

Original code:
{{files:jl/orig/*.jl}}

Give me feedback on my code.
"""

""" md
# OCaml

## Build
"""

""" code w """
import heytutor
""" """

""" codex w
%%bash_
eval $(opam env)
cd ml/minc
dune build
"""

""" md
## Run (the code generator is an unfinished stub at first)
"""

""" codex w
%%bash_
cd ml/minc
echo 'long f(long x) {{ return x + 1; }}' | _build/default/bin/main.exe
"""

""" md
## Test

* Consider adding to the `make` command line:
  * `-k` to keep going instead of stopping at the first failure
"""

""" codex w points=1
%%bash_
cd test
make -B minc=../ml/minc/_build/default/bin/main.exe
"""

""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey

Problem:
{{file:minc.md}}

My code (I edited ml/minc; ml/orig is the original I was given):
{{files:ml/minc/lib/*.ml ml/minc/bin/main.ml}}

Original code:
{{files:ml/orig/lib/*.ml ml/orig/bin/main.ml}}

Give me feedback on my code.
"""

""" md
# Rust

## Build
"""

""" code w """
import heytutor
""" """

""" codex w
%%bash_
. ~/.cargo/env
cd rs/minc
cargo build
"""

""" md
## Run (the code generator is an unfinished stub at first)
"""

""" codex w
%%bash_
cd rs/minc
echo 'long f(long x) {{ return x + 1; }}' | ./target/debug/minc
"""

""" md
## Test

* Consider adding to the `make` command line:
  * `-k` to keep going instead of stopping at the first failure
"""

""" codex w points=1
%%bash_
cd test
make -B minc=../rs/minc/target/debug/minc
"""

""" md
## Ask Questions or Get Feedback
"""

""" codex w
%%hey

Problem:
{{file:minc.md}}

My code (I edited rs/minc; rs/orig is the original I was given):
{{files:rs/minc/src/*.rs}}

Original code:
{{files:rs/orig/src/*.rs}}

Give me feedback on my code.
"""

""" md
# Extra work

* If you have done extra work, describe it here.
* If you have a separate file (e.g., a PDF) describing your work, please upload it here and say so in the cell below (e.g., details are in extra.pdf).
* All your code must be in this directory; depending on the nature of your work, you may modify the code in `minc/` or make a new directory (e.g., `mingo`) for your work.
"""

""" codex w points=1
%%writefile_ extra.md
"""


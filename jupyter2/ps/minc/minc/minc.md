# minC compiler --- problem specification

* You build a compiler for **minC**, a minimum subset of the C language. 
* The compiler reads a minC source file and emits 64-bit ARM (_arm64_ / _aarch64_) assembly.

# The language

* The syntax is defined by the context-free grammar in `minc_grammar.txt`.  Read it first --- it is the single source of truth for what minC programs must support.
* A program is a sequence of function definitions. The only type is `long`.
* Statements: empty `;`, `break;`, `continue;`, `return e;`, blocks `{ ... }`, `if`/`else`, `while`, and expression statements.
* Expressions: integer literals, variables, function calls, the unary operators `+ - ! ~`, the binary operators `* / % + - < > <= >= == !=`, and assignment `=`, with the usual C precedence and associativity.

# What you are given

* In your chosen language (`go`, `jl`, `ml`, or `rs`),
  * the `minc` directory holds a skeleton which you are going to modify to finish the work
  * the `orig` directory holds an identical copy of `minc` to get a diff between your code and the original skeleton
* The skeleton contains the following files
  * **lexer** --- splits the source text into tokens;
  * **AST** --- the data types for the syntax tree;
  * **parser** --- a hand-written LL(1) parser that builds the AST from tokens;
  * **code generator** --- turns the AST into ARM64 assembly.
* The lexer, AST, and parser are given in working form **except** that the `while` statement has been removed from them (it appears in `minc_grammar.txt`). 
* The code generator is essentially empty: its entry function is a stub that reports "not implemented".

# Your tasks

1. **Read** the lexer, AST, and parser, and **explain in your own words** how they work and how they correspond to the grammar.
2. **Add the `while` statement** to the lexer, AST, and parser, following the grammar in `minc_grammar.txt`.
3. **Complete the code generator** so that the compiler translates every construct of minC into correct ARM64 assembly.

# AI usage policy

1. As always, OK to ask general questions or feedback to AI tutor
2. Do NOT ask AI (AI tutor or not) to generate a significant part of the work, until you finish the mandatory test below
3. Do NOT use coding agent (e.g., claude code) or auto completion (e.g., github copilot), until you finish the mandatory test below
4. You are allowed to use AI more freely for extra work (see below)

# Building and running

* Build your compiler, then run it on a minC program. The compiler reads its input from a file or stdin and writes assembly to a file or stdout: `minc [infile [outfile]]`.
* For your language:
  * **Go** --- `cd minc && go build`, then run with `./minc`
  * **Julia** --- `cd minc && chmod +x minc.jl`, then run with `./minc.jl`
  * **OCaml** --- `cd minc && dune build`, then run with `_build/default/bin/main.exe`
  * **Rust** --- `cd minc && cargo build`, then run with `./target/debug/minc` (consider using `cargo build --release` and running `./target/release/minc` in later stages of development)
* You may first need to put the toolchain on your `PATH`: `export PATH=~/go/bin:$PATH` (Go), `export PATH=~/.juliaup/bin:$PATH` (Julia), `eval $(opam env)` (OCaml), or `. ~/.cargo/env` (Rust).
* Example: `echo 'long f(long x) { return x + 1; }' | ./minc`

# Test

* `test/` contains test programs `src/f00.c, f01.c, ...`, each defining a function `f`, plus a `main.c` driver and a `Makefile`.
* For each test the `Makefile` compiles `src/fXX.c` to assembly with your compiler, links it with `main.c`, and compares its output against the executable produced by `gcc` from the same source.
* The baseline goal is to **pass all the tests** (`make -B -k` in `test/`).
* In addition, you may want to work on extra

# Extra work for good grades

* To get a good grade ("A"), you are likely to need to do something beyond passing the mandatory tests above
* Which extra work you do is up to you, but here are a few possibilities
* Extend minC
  * More constructs (e.g., for statement) or expressions (e.g., conditional expressions)
  * Pointers (e.g., long\*, long\*\*, etc.)
  * Type checking
  * Floating point numbers
  * Type definitions and structs
* A better code generator; study compiler optimizations in textbooks and implement some, including but not limited to
  * Intermediate language
  * Function call inlininig
  * Loop unrolling
  * Better register usage
* Or you can implement a whole new language, including syntax, lexer, parser, and code generator

# AI usage policy for extra work

* For extra work after passing the mandatory tests, you can ask the AI tutor to generate a significant amount of code and tests
* However, you still need to explain how they work and you should declare which part has been done by AI

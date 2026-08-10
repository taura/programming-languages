#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
//#import themes.university: *
//#import themes.aqua: *
//#import themes.dewdrop: *
//#import themes.simple: *
//#import themes.stargazer: *
//#import themes.default: *
//#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Implementing a Compiler],
    author: [Kenjiro Taura],
    date: [],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 24pt)
#set quote(block: true)
#let ao(x) = text(fill: blue, x)
#let ak(x) = text(fill: red, x)
#let og(x) = text(fill: orange, x)
#let blink(x, y) = link(x, text(blue, y))

#let sm(x) = text(size: 16pt, x)

#let commentout(x) = ""

#let cimg(x, ..opts) = align(center, image(x, ..opts))

/* include image sequence xxx_L1.svg, xxx_L2.svg, ... */
#let images(prefix, rng, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+1, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

#show raw.where(block: true):  x => text(size: 14pt, pad(left: 0.7em, x))
#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

//#show raw.where(block: true):  x => text(size: 20pt, pad(left: 0.7em, x))
//#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

#title-slide()

#outline(depth: 1)

= The MinC ("Minimum C") language

== MinC ("Minimum C") spec overview

- all expressions have type `long` (64 bit integer)
  - no other integers, floating point numbers, pointers, or structs
  - everything is long $=>$ _type checks are unnecessary_

- no global variables or `typedef`
  - $=>$ a program = list of _function definitions_

- supported complex statements are `if, while`, and compound statement (`{ ... }`) only

- function calls follow the C convention $=>$ MinC code can call or be called by functions compiled by other compilers (e.g., gcc)

= Overview of Inside a Compiler 

== Data structures

#grid(columns: (auto,auto), gutter: 1em, align: top,
[
- *Abstract Syntax Tree (AST):* data structure representing the program
#uncover(2)[- *Intermediate Representation (IR):* common representation portable across multiple source/target languages]
],
[
#align(center)[#images("svg/L/inside_compiler", range(1, 3), width: 100%)]
])

== Typical compilation steps

+ *lexing and parsing:* source code (string) $->$ AST
+ IR generation: AST $->$ IR ($ast$)
+ optimization: IR $->$ IR ($ast$)
+ *code generation:* IR $->$ assembly

($ast$) : optional steps

== Abstract Syntax Tree (AST)

- a data structure that naturally represents a program

#grid(columns: (auto,auto), gutter: 3em, align: top,
  [
- expression,
- statement,
- function definition,
- the whole program,
- ...
],
  [#image("svg/ast_while.svg", width: 60%)]
)

- also called *parse tree*

== Components of the baseline code

- `{go,jl,ml,rs}/minc/`

#table(columns: 2, 
    [`lex.??`], [lexer or tokenizer (string $->$ stream of tokens)],
    [`ast.??`], [abstract syntax tree (AST) definition],
    [`parse.??`], [parser (stream of tokens $->$ AST)],
    [*`codegen.??`*], [AST $->$ assembly],
    [`main.??` or `minc.??`], [main driver]
)

== Your work

+ read given, understand, and explain how they work
+ {`lex,ast,parse`} all lack code for `while` statement
    - $=>$ add necessary definitions for `while` statement
+ implement `codegen`, which is almost empty

= Lexer and parser : source code $->$ AST

== Lexer and parser

#[
#let b(x) = box(stroke: black, inset: 0.2em, text(16pt, x))

- *lexer:* string $->$ sequence of _*tokens*_ ($approx$ words)
  - also called _*lexical analyzer*_, or _*tokenizer*_
  - `while (x < 10) y++;` $=>$
  #table(columns: (auto,auto,auto,auto,auto,auto,auto,auto,auto), stroke: none,
   [#b[while]],   [#b[(]],    [#b[x]],    [#b[<]],     [#b[10]],    [#b[)]],    [#b[y]],    [#b[++]],       [#b[;]],
   [#b[`WHILE`]], [#b[`LP`]], [#b[`ID`]], [#b[`CMP`]], [#b[`INT`]], [#b[`RP`]], [#b[`ID`]], [#b[`PLSPLS`]], [#b[`SEMICOLON`]])

#pagebreak()

- *parser:* sequence of tokens $->$ AST

#table(columns: (auto,auto,auto,auto,auto,auto,auto,auto,auto,auto), stroke: none,
   [#b[while]],   [#b[(]],    [#b[x]],    [#b[<]],     [#b[10]],    [#b[)]],    [#b[y]],    [#b[++]],       [#b[;]], [],
   [#b[`WHILE`]], [#b[`LP`]], [#b[`ID`]], [#b[`CMP`]], [#b[`INT`]], [#b[`RP`]], [#b[`ID`]], [#b[`PLSPLS`]], [#b[`SEMICOLON`]], [$=>$]) 
 #align(center, image("svg/ast_while.svg", width: 30%))
]

== Specifying a grammar

- a grammar for _*tokens*_
  - specifies which character sequence constitutes a valid token
  - typically uses _*Regular Expressions (RE)*_
- a grammar for _*the entire program*_
  - specifies which token sequence constitutes a valid input
  - typically uses (a subset of) _*Context Free Grammar (CFG)*_
- note: there is an approach that uses a single grammar for both 

== Regular expression

- a regular expression is any expression that can be formed by:
#align(center)[
#table(columns: (auto, auto), stroke: none, align: left,
[#og[$epsilon$]], [(empty string)],
[#ao[$c$]], [(a character)],
[$E med E$], [(concatenation)],
[$E$ #og[|] $E$], [(alternation)],
[$E$#og[\*]], [(zero or more repetition)],
[#og[(]$E$#og[)]], [(paren)]
)]

where $E$ is a regular expression
- #og[|], #og[\*], #og[(] and #og[)] are literals

== Regular expression

- expressions for convenience
#align(center)[
#table(columns: (auto, auto, auto, auto), stroke: none, align: left,
[$E$#og[+]], [$equiv$], [$E$ $E$#og[\*]], [(one or more repetition)],
[$E$#og[?]], [$equiv$], [$epsilon med #og[|] med E$], [(optional)]
)]


== Regular expression examples

- to build complex expressions, use symbols to represent regular expressions used in other regular expressions. e.g.,
#text(size: 20pt)[
#align(center)[
#table(columns: (auto,auto,auto,auto), stroke: none, align: left, gutter: 0.25em,
[nz], [=], [#ao[1] #og[|] #ao[2] #og[|] #ao[3] #og[|] #ao[4] #og[|] #ao[5] #og[|] #ao[6] #og[|] #ao[7] #og[|] #ao[8] #og[|] #ao[9]],[#sm[1, 2, ..., 9]],
[digit], [=], [#ao[0] #og[|] nz],[#sm[0, 1, 2, ..., 9]],
[non\_neg], [=], [#ao[0] #og[|] nz digit#og[\*]],[#sm[0, 12, 34]],
[int], [=], [#ao[-]#og[?] non\_neg],[#sm[0, -0, 12, -34]],
[fraction], [=], [int #og[(] #ao[.] digit#og[\*] #og[)]#og[?]],[#sm[-12.34]],
[float], [=], [fraction #og[(] #ao[e] int #og[)]],[#sm[-12.34e-5]],
[alpha], [=], [#ao[A] #og[|] #ao[B] #og[|] ... #ao[Z] #og[|] #ao[a] #og[|] #ao[b] #og[|] ... #ao[z]], [#sm[A, B, ..., Z, a, b, ..., z]],
[alpha\_], [=], [alpha #og[|] #ao[\_]], [#sm[A, B, ..., Z, a, b, ..., z, \_]],
[id], [=], [alpha\_ #og[(] alpha\_ | digit #og[)]#ao[\*] ], [#sm[a, abc, a0\_b1]],
)]
]

== Regular expression semantics (just for formality ...)

- a regular expression $E$ represents _a set of strings_, written $[|E|]$

#align(center)[
#table(columns: (auto,auto,auto), stroke: none, align: left, gutter: 0.25em,
[$[|#og[$epsilon$]|]$],   [=], [ { "" } ],
[$[|#ao[$c$]|]$],         [=], [ { #ao[$c$] } ],
[$[|E_0 med E_1|]$],     [=], [{ $e_0 + e_1$ | $e_0 in [|E_0|], e_1 in [|E_1|]$ }],
[$[|E_0$ #og[|] $E_1|]$], [=], [$[|E_0|] union [|E_1|]$ ],
[$[|E#og[\*]|]$],         [=], [{ "" } $union { e_0 + e_1$ | $e_0 in [|E|], e_1 in [|E#og[\*]|]$ }],
[$[|#og[(]E#og[)]|]$],     [=], [$[|E|]$]
)]

- note: "+" represents string concatenation

== Context Free Grammar (CFG)

- specified by a collection of _*production rules*_
- a production rule looks like

$ L -> R_0 med R_1 med ... $

where
- $L$ : a symbol *(_non-terminal_)*
- $R_i$ is either
  - a symbol defined by a production rule(s), or
  - #ao[a token name] (a *_terminal_* symbol)

== An example : expressions

#align(center)[
#table(columns: (auto,auto,auto,auto),
                stroke: none, align: left, gutter: 0.25em,
[expr], [$->$], [#ao[int]], [#sm[12, 345, ...]],
[expr], [$->$], [#ao[id]], [#sm[f, x, i, is\_prime, ...]],
[expr], [$->$], [#ao[unop] expr], [#sm[-x, ~exp, !a\_greater\_than\_b]],
[expr], [$->$], [expr #ao[binop] expr], [#sm[x + y, a \* x + b \* y + 1, a & b, ...]],
[expr], [$->$], [#ao[(] expr #ao[)]], [#sm[3 \* (a + 1)]],
[expr], [$->$], [funcall], [],
)]

- #ao[blue symbols (int, id, unop, binop, (, ))] are terminals (tokens)
- above rules overlook the fact that some operators (i.e., `+` and `-`) can be used as a unary operator and a binary operator

== An example : function call

#align(center)[
#table(columns: (auto,auto,auto,auto),
                stroke: none, align: left, gutter: 0.25em,
[funcall], [$->$], [#ao[id] #ao[(] comma\_exprs #ao[)]], [#sm[f(x, 2 \* y, 1)]],
[comma\_exprs], [$->$], [], [],
[comma\_exprs], [$->$], [expr], [],
[comma\_exprs], [$->$], [expr comma\_expr\_star], [],
[comma\_expr\_star], [$->$], [], [],
[comma\_expr\_star], [$->$], [#ao[,] expr comma\_expr\_star], [],
)]

== An example : statements

#align(center)[
#table(columns: (auto,auto,auto,auto),
                stroke: none, align: left, gutter: 0.25em,
[stmt], [$->$], [#ao[;]], [],
[stmt], [$->$], [#ao[continue ;]], [],
[stmt], [$->$], [#ao[break ;]], [],
[stmt], [$->$], [#ao[return ;]], [],
[stmt], [$->$], [#ao[{] decl\* stmt\* #ao[}]], [],
[stmt], [$->$], [#ao[if] #ao[(] expr #ao[)] stmt #og[(] #ao[else] stmt #og[)?]], [],
[stmt], [$->$], [#ao[while] #ao[(] expr #ao[)] stmt], [],
[stmt], [$->$], [expr #ao[;]], [],
)]



== Notes

- as you have seen,
  - the same symbol $L$ can appear multiple times in the lefthand side (i.e., _alternation_)
  - $R_i$ can be $L$ or any symbol defined earlier or later (i.e., definitions can be _recursive_)

== A few shorthands

- we often use shorthands (#og[|, ?, \*, +]) that have similar meanings with those for RE
- they can be mechanically eliminated
- the above example using the shorthands:

#align(center)[
#table(columns: (auto,auto,auto), stroke: none, align: left, gutter: 0.25em,
[expr], [$->$], [#ao[int] #og[|] #ao[id] #og[|] #ao[unop] expr #og[|] expr #ao[binop] expr #og[|] funcall],
[funcall], [$->$], [#ao[id] #ao[(] comma\_exprs #ao[)]],
[comma\_exprs], [$->$], [ #og[|] expr #og[(] #ao[,] expr #og[)]#og[\*]]
)]


== CFG semantics (for formality)

- each symbol $L$ represents a set of token sequences ($[|L|]$)
- $[|L|]$ is the set of token sequences that can result by, starting from $L$, repeatedly replacing a non-terminal symbol to the righthand side of its production rule, until it becomes a sequence of tokens (terminals)

#align(center)[
#table(columns: (auto,auto,auto,auto),
                stroke: none, align: left, gutter: 0.25em,
[expr], [$->$], [funcall], [],
[], [$->$], [#ao[id] #ao[(] comma\_exprs #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] expr comma_expr_star #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] #ao[id] comma_expr_star #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] #ao[id] #ao[,] expr comma_expr_star #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] #ao[id] #ao[,] expr #ao[+] expr comma_expr_star #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] #ao[id] #ao[,] #ao[id] #ao[+] expr comma_expr_star #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] #ao[id] #ao[,] #ao[id] #ao[+] #ao[int] comma_expr_star #ao[)]], [],
[], [$->$], [#ao[id] #ao[(] #ao[id] #ao[,] #ao[id] #ao[+] #ao[int] #ao[)]], [],
)]

#align(center)[
    $therefore$ #ao[id ( id , id + int )] $in [| "expr" |]$
]

#align(center)[e.g., f (x, y + 1) $in [| "expr" |]$]

== An alternative semantics

- $[| . |]$ is the minimal set of token sequences satisfying:

+ $[| med t med |] = { med t med }$ ($t$ : terminal)
+ $L -> R_0 med ... med R_(n-1)$ implies
$  & r_0 in [| R_0 |], ..., r_(n-1) in [| R_(n-1) |] \
=> & r_0 + ... + r_(n-1) in [|L|] $
- "+" represents concatenation of token sequences

== CFG is more expressive than RE

- as you might have noticed, RE is a special case of CFG
- all the constructs of RE can be straightforwardly expressed with CFG, where a token = a character
- e.g., a CFG equivalent to RE "int = #ao[0] #og[|] nz digit#og[\*]"
#align(center)[
#grid(columns: (auto, auto), gutter: 1em, align: top,
[$
"int" &-> 0 \
"int" &-> "nz" "digits" \
"digits" &-> \
"digits" &-> "digit" "digits" \
$],
[
$
"digit" &-> 0 \
"digit" &-> "nz" \
"nz" &-> 1 | ... | 9
$
])
]

== In general ...

- below, $"CFG"(e, L)$ is a function that converts regular expression $e$ to an equivalent CFG s.t., $[|L|] = [|e|]$
#text(18pt)[
$ 
"CFG"(#og[$epsilon$], L) &= { L -> } \
"CFG"(#ao[$c$], L)       &= { L -> #ao[$c$] } \
"CFG"(E_0 med E_1, L)    &= {L -> R_0 med R_1} union "CFG"(E_0, R_0) union "CFG"(E_1, R_1) \
"CFG"(E_0 #og[|] E_1, L) &= { L -> R_0 | R_1 } union "CFG"(E_0, R_0) union "CFG"(E_1, R_1) \
"CFG"(E#og[\*], L)       &= { L -> | R med L } union "CFG"(E, R) \
"CFG"(#og[(]E#og[)], L)]    &= "CFG"(E, L)
$]

- $R, R_0$ and $R_1$ are unique symbols that do not appear elsewhere

== A CFG that cannot be expressed by RE

- intuitively, RE _can repeat ($E\*$) but cannot recurse_
    - $approx$ has loops but not recursion
    - $approx$ has tail-recursion but not general recursion
- e.g., both "$A &-> #og[|] med #ao[$a$] med A$" and "$A &-> #og[|] med A med #ao[$a$]$" _can_ be expressed by an RE (both are equivalent to $#ao[$a$]#og[\*]$), but
$ A -> #og[|] med #ao[$a$] med A med #ao[$b$] $
_cannot_ ($[|A|] = {epsilon, a b, a a b b, a a a b b b, ...} = {a^n b^n med | med n >= 0}$)
- #blink("https://en.wikipedia.org/wiki/Pumping_lemma_for_regular_languages")[the proof] is interesting but omitted

== If RE $subset$ CFG, why use both (not just CFG)?

- parsing _general_ CFG is expensive ($O("length"^3)$)
- the primary reason is handling _alternatives_ may require _backtrack_
$ A &-> B_0 med B_1 med ... med | med C_0 med C_1 med ... med | med D_0 med D_1 med ... med $
- practical parsers take either of the following two approaches
  + allow only alternatives that can be determined with a _*limited lookahead (LL(1), LALR(1), etc.)*_
  + allow backtrack with programmer-supplied _cut points_ (_Parsing Expression Grammar; PEG_)

== CFG with a limited lookahead (LL(1), LALR(1), etc.)

- recall the syntax of statement

#align(center)[
#table(columns: (auto,auto,auto,auto),
                stroke: none, align: left, gutter: 0.25em,
[stmt], [$->$], [#ao[;] #og[|] #ao[continue ;] #og[|] #ao[break ;] #og[|] #ao[return ;] #og[|] #ao[{] decl\* stmt\* #ao[}]], [],
[], [], [#og[|] #ao[if] #ao[(] expr #ao[)] stmt #og[(] #ao[else] stmt #og[)?] #og[|] #ao[while] #ao[(] expr #ao[)] stmt ], [],
[], [], [#og[|] expr #ao[;]], [],
)]

- upon parsing a statement, which branch we should take can be determined just by its _first_ token
- _it is essential to have a separate tokenizer for this type of grammar_ (looking ahead a token $!=$ looking ahead a character)

== How to write a CFG parser in practice

+ use parser-generator tool
    - yacc/bison (C/C++)
    - Menhir (OCaml)
    - ANTLR4
    - JavaCC
    - ...
+ _*manually write LL(1) parser*_ 

- This course chooses the latter for lack of a parser generator common across the four languages
- The experience helps you write a robust parser in other occasions

== How to write LL(1) parser?

- For each symbol *$A$* (terminal or non-terminal), define a function,

#align(center)[*parse\_$A$(tokens)*,]

which takes a stream of tokens and consumes a prefix of it constituting $A$

- _*tokens*_ supports the following interface
    - *peek(tokens)* : the "current" (the first unconsumed) token
    - *advance(tokens)* : consume the current token

#pagebreak()

+ If $A$ is a terminal (a token) $=>$ just consume it or raise an error
 ```
parse_A(tokens) {
  if (peek(tokens) != A) parse_error();
  advance(tokens);
}
```
+ If $A$ is a non-terminal and its definition is $A -> B" "C" "D$ (without alternatives), call corresponding *parse\_??* functions in turn
 ```
parse_A(tokens) {
  parse_B(tokens);
  parse_C(tokens);
  parse_D(tokens);
}
```

== Example: if statement

- if_stmt $->$ IF LPAREN expr RPAREN stmt #og[(] ELSE stmt #og[)]#og[?]

```
parse_if(tokens) {
  parse_IF(tokens);      // consume IF token
  parse_LPAREN(tokens);  // consume '(' token
  cond = parse_expr(tokens); // consume expression
  parse_RPAREN(tokens);  // consume ')' token
  then_s = parse_stmt(tokens);
  if (peek(tokens) == ELSE) {
    parse_ELSE(tokens);
    else_s = parse_stmt(tokens);
  } else {
    else_s = none
  }
  return if_stmt(cond, then_s, else_s)
}
```

== Handle alternatives

#grid(columns: (0.53fr, 0.47fr), gutter: 0.25em, align: top, [
3. If $A$ has alternatives, e.g., 
    - $A -> B" "C$
    - $A -> D" "E$
we choose the appropriate branch by _*"peeking the current token"*_
```
parse_A(tokens) {
  if (peek(tokens) in FIRST(B C)) {
    parse_B(tokens);
    parse_C(tokens);
  } else if (peek(tokens) in FIRST(D E)) {
    parse_D(tokens);
    parse_E(tokens);
  } else { parser_error(); } }
```],[

- `FIRST(`・`)` is the set of tokens that could start '・'
- The code assumes `FIRST(B C)` and `FIRST(D E)` do not overlap (LL(1))
- You can compute `FIRST(・)` by an algorithm, but for simple cases manual inspection suffices
])

== Limitation of LL(1)

- It has trouble with "left recursion"
- e.g.,
    - $A -> $
    - $A -> A" "b$
- writing parse\_$A$ following the above formula would result in infinite recursion
- in practice, we get rid of left recursion by manual inspection
- e.g., the above is equivalent to $b$\*, which is
    - $A -> $
    - $A -> b" "A$

#commentout[
== Parsing Expression Grammar (PEG)

- PEG allows unlimited lookahead (uses backtrack)
- in an alternative, it always tries branches in the written order (the order _does_ matter!)
    - 1st branch,
    - if failed, 2nd branch,
    - if failed, 3rd branch, ...
- the programmer may insert a *_cut point_*
  - if a parser succeeds thus far, it tries no other branches

== Lexer/parser generators

- based on the grammar, either:
  - write them by hand, or
  - use a *lexer/parser generators*

- *lexer generator* generates a lexer from the definition of _tokens_ (variables, numbers, ...)

- *parser generator* generates a parser from the definition of higher-level constructs (expressions, statements, ...)

- some grammar frameworks (PEG) specify them in a single framework

== Lexer/parser generators

- many programming languages have lexer/parser generators:
  - lex/yacc (#blink("https://en.wikipedia.org/wiki/Flex_(lexical_analyser_generator)")[flex]/#blink("https://www.gnu.org/software/bison/?ref=geekmonkey.org")[bison]): C/C++
  - #blink("https://www.antlr.org/")[ANTLR:] C, C++, Java, Python, JavaScript, Go, ...
  - #blink("https://dev.realworldocaml.org/parsing-with-ocamllex-and-menhir.html")[ocamllex/menhir:] OCaml
  - #blink("https://tatsu.readthedocs.io/en/stable/")[tatsu:] Python
  - etc.

== In this exercise ...

- we use #blink("https://tatsu.readthedocs.io/en/stable/")[tatsu], a parser generator tool based on PEG, to generate a Python program that converts C source into XML,
- which is then read by the respective XML library you have used before for your language
- see #blink("https://tatsu.readthedocs.io/en/stable/syntax.html")[grammar syntax] in tatsu
  - thanks to PEG, no need for separate definitions of tokens
- the MinC grammar in tatsu is given in `minc_grammar.y`
]



= Code generation

== Code generation (cogen) --- basic structure

- takes an AST and returns machine code (a list of instructions)
- generate machine code for an AST $approx$ generate machine code of its components and properly arrange them
- program $->$ function definition $->$ statement $->$ expression

#pagebreak()

- code generator has lots of:
  - case analysis based on the type of the tree; use:
    - pattern matching (match à la OCaml and Rust), or
    - polymorphism (OCaml objects, Julia function, Go interface, Rust trait)
  - recursive calls to child trees

== Compiling an entire file

- $approx$ concatenate compilation of individual function definitions

#grid(
  columns: (35fr,65fr), gutter: 1em, align: top,
  [#image("svg/L/translate_L1.svg", width: 100%)],
  [Pseudo code:
```ocaml
gen_program (Program([d0, d1, ...])) ... =
    ...
    header
  + (gen_def d0 ...)
  + (gen_def d1 ...)
  + ...
  + trailer
```
note: `+` is a list concatenation
  ]
)

== Compiling a function definition

- $approx$ prologue (grow the stack, etc.) + code for the body (statement) + epilogue (shrink the stack, `ret`, etc.)

#grid(columns: (35fr, 65fr), gutter: 1em, align: top,
  [#image("svg/L/translate_L2.svg", width: 100%)],
  [Pseudo code:
```ocaml
gen_def (DefFun(f, params, ret_type, body)) =
    (gen_prologue f ...)
  + (gen_stmt body ...)
  + (gen_epilogue f ...)
```])

== Compiling a statement (while statement)

- $approx$ jump to the condition expression; body; the condition expression; compare and conditional branch

#grid(columns: (35fr, 65fr), gutter: 1em, align: top,
[#image("svg/L/translate_L3.svg", width: 90%)],
[```ocaml
gen_while_stmt (StmtWhile(cond, body)) ... =
   cond_op,cond_insns = gen_expr cond ... ;
   body_insns = gen_stmt body ... ;
     ... 
   [ jmp Lc; Ls ]
 + body_insns
 + [ Lc ]
 + cond_insns
 + [ cmp cond_op,0; jne Ls ]
```
])
- (`gen_expr `_expr_ ...) returns a pair: (instructions to evaluate _expr_, the location of the result)

== Compiling an expression (arithmetic)

- $approx$ instructions to evaluate the arguments + an appropriate arithmetic instruction
- "`gen_expr` $E$` ...`" returns a pair:
(instructions evaluation $E$, the location holding the value of $E$)

#grid(columns: (35fr, 65fr), gutter: 1em, align: top,
[#image("svg/L/translate_L4.svg", width: 100%)],
[```ocaml
gen_add_expr ExprOp("+", [e0; e1]) ... =
  insns1,op1 = gen_expr e1 ... ;
  insns0,op0 = gen_expr e0 ... ;
  m = (* a slot on the stack for e1 *);
  (  insns1
   + [ str op1,m ]
   + insns0
   + [ mov x0,op0;
       ldr x1,m;
       add x0,x0,x1 ],
   x0)
```])

== Compiling an expression (comparison)

- $A$ `<` $B$ is an expression that evaluates to:
  - 1 if $A$ `<` $B$
  - 0 if $A$ `>=` $B$
- this can be done by cmp + conditional set (cset)

== Compiling an expression (comparison)

- $approx$ compile the arguments; compare; conditional set

#grid(columns: (35fr, 65fr), gutter: 1em, align: top,
[#image("svg/L/translate_L5.svg", width: 100%)],
[```ocaml
gen_cmp_expr (ExprOp("<", [e0; e1])) ... =
  insns1,op1 = gen_expr e1 ... ;
  insns0,op0 = gen_expr e0 ... ;
  m1 = (* a slot on the stack for e1 *);
    ...
  (insns1
   + [ str op1,m1 ]
   + insns0
   + [ mov x0,op0;
       ldr x1,m1;
       cmp x0,x1;
       cset x0,lt ],
   x0)
```])

== Compiling an expression (function call)

- $approx$ instructions for all arguments; put them to positions specified by ABI; a `bl` instruction

#grid(columns: (30fr, 70fr), gutter: 1em, align: top,
[#image("svg/L/translate_L6.svg", width: 100%)],
[```ocaml
gen_call_expr (ExprCall(f, [e0;e1;...])) ... =
  [(i0,op0);(i1,op1);..],[m0;m1;...]
    = gen_exprs [e0;e1;...] ...;
  (  (i0 + [str op0,m0])
   + (i1 + [str op1,m1])
   + ...
   + [ldr x0,m0;
      ldr x1,m1;
      ...;
      bl f],
   x0)
```])

== A few left-out details

- how to determine locations to save values of _subexpressions_ and _variables_?
- that is, how to determine XX below:

#align(center)[#image("svg/L/translate_L4.svg", width: 40%)]

== Determining where to save subexpressions

#grid(columns: (auto, auto), gutter: 1em, align: top,
[
- "`gen_expr` $E$" receives a value (`v`) pointing to the lowest end of free space in the current stack frame
- "`gen_expr` $E$ $v$` ...`" generates instructions that evaluate `E` using (destroying) only addresses at or above SP+$v$
],
[#align(center)[#image("svg/stack_v.svg", width: 100%) a stack frame]]
)

== Determining where to save subexpressions

- when evaluating $A$ `+` $B$,
  + evaluate $B$, using SP+$v$ and higher; save the result at SP+$v$
  + evaluate $A$, using $v + 8$ and higher addresses

#grid(columns: (25fr, 15fr, 65fr), gutter: 1em, align: top,
[#image("svg/L/translate_L4.svg", width: 100%)],
[#image("svg/stack_v.svg", width: 120%)],
[```ocaml
gen_add_expr ExprOp("+",[e0;e1]) v ... =
  insns1,op1 = gen_expr e1  v    ... ;
  insns0,op0 = gen_expr e0 (v+8) ... ;
  (  insns1
   + [ str op1,[sp,v] ]
   + insns0
   + [ mov x0,op0;
       ldr x1,[sp,v];
       add x0,x0,x1],
   x0)
```])

== Locations to hold variables
#grid(columns: 2, align: top, gutter: 1em,
[
```c
  if (...) {
    long a, b, c;
    ...
  }
```
],
[we obviously need to store `a, b, c` somewhere, but where?])

- the problem is almost identical to saving values of subexpressions
- $->$ `gen_stmt` also takes $v$ pointing to the free space
- (`gen_stmt` $S med v med ...$) generates instructions to execute $S$, using only addresses at or above $"SP"+v$
- $=>$
  - $a |-> ("SP"+v)$
  - $b |-> ("SP"+v+8)$
  - $c |-> ("SP"+v+16)$

== Environment: records where variables are held

- variable locations must be known when generating code for expressions referencing them
  - e.g., to compile `x + 1`, we need to know where `x` is stored
- $=>$ make a data structure that holds a mapping: _*variable*_ #og[$|->$] _*location*_ *(_environment_)* and pass it to `gen_stmt` and `gen_expr`
  - generating code for variables look up the environment
  - a compound statement (`{ ... }`) adds new mappings to the environment

== gen\_expr receives an environment

```ocaml
gen_expr (ExprId(x)) env v =
  m = env_lookup x env;
  ([ ldr x0,m ], x0)
```

`env_lookup x env` searches environment `env` for `x` and returns its location

== gen\_stmt receives an environment too

```ocaml
gen_stmt (StmtCompound(decls, stmts)) env v =
  env', v' = env_extend decls env v;
  gen_stmts stmts env' v' ...
```

- `env_extend decls env v` :
  - assigns locations ($v, v+8, v+16, ...$) to variables declared in `decls`
  - registers them in env
  - returns the new environment `env'` and the new free space `v'`

== Implementing environment

- an environment is a list of (_variable name_, _location_) pairs (_association list_)
- `v = env_lookup x env`
  - returns the location paired with `x` in environment `env`
- `env' = env_add x v env`
  - returns a new environment `env'` which has a new mapping \ `x` $|->$ `v`  
    in addition to `env`
- `(env', v') = env_extend decls v env`
  - can be easily built on `env_add` (left for you)

= Intermediate Representation (IR)

== Intermediate Representation (IR)

- a common representation of programs used by a compiler
- roughly $approx$ an assembly with unlimited variables
- purposes
  + achieve portability
    - hopefully independent from the source language (C, C++, Rust, Go, Julia, etc.)
    - hopefully independent from the target language (x86, ARM, PowerPC, etc.)
  + formulate optimizations as IR $->$ IR transformations
- *note:* in the exercise you could design your IR, but it is not necessary (it is possible to directly go from AST $->$ asm)

== Optimizations performed on IR level (a brief)

- *constant folding and propagation* --- compute values at compile time where possible
- *hoisting* --- lift instructions in a loop outside of it
- *function call inlining* --- replace a call to a function with its body
- *register allocation* --- assign registers to variables to reduce memory access


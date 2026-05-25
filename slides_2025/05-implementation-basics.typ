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
    title: [How Programming Languages Work (Basics)],
    author: [Kenjiro Taura],
    date: [2024/05/26],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 28pt)
#set quote(block: true)
#let ao(x) = text(blue)[#x]
#let aka(x) = text(red)[#x]
#let small(x) = text(size: 20pt)[#x]
#let blink(x, y) = link(x, text(blue, y))

#let commentout(x) = ""

#let cimg(x, ..opts) = align(center, image(x, ..opts))

/* include image sequence xxx_L1.svg, xxx_L2.svg, ... */
#let images(prefix, rng, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+1, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

//#show raw.where(block: true):  x => text(size: 16pt, pad(left: 0.7em, x))
//#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

//#show raw.where(block: true):  x => text(size: 20pt, pad(left: 0.7em, x))
//#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

#title-slide()

#outline(depth: 1)

= Introduction

== Why do you want to make a language, today?

- new hardware
  - GPUs, AI chips, Quantum, ...
  - new instructions (e.g., SIMD, matrix, ...)

- new general purpose languages
  - Scala, Julia, Go, Rust, Zig, Mojo, etc.

#pagebreak()

- special purpose (domain specific) languages
  - statistics (R, MatLab, etc.)
  - data processing (SQL, NoSQL, SPARQL, etc.)
  - deep learning (PyTorch, Triton, Halide, etc.)
  - constraint solving, proof assistance (Coq, Lean, etc.)
  - macro  
    (Visual Basic (MS Office),  
    Emacs Lisp (Emacs), Javascript (web browser), etc.)

== Taxonomy : interaction mode
- *interactive / read-eval-print-loop (REPL)*
  - type code directly or load source code in a file interactively
  - Julia
- *batch compile*
  - convert source into an executable file
  - and run it (typically the "main" function)
  - Go, Rust
- some language implementations provide both
  - OCaml

== Taxonomy : execution strategy
- *interpreter* executes source code directly with its input
  - interpreter (_source-code_, _input_) $->$ _output_
- *compiler* first converts source code into _*a machine (assembly) code*_ that is directly executed by the CPU
  - compiler (_source-code_) $->$ _machine-code_;
  - _machine-code_ (_input_) $->$ _output_
- *translator* or *transpiler* are like compiler, but convert into another language, not machine (assembly) code (e.g., C, JavaScript, etc.)

== A (minor) note: machine code vs. assembly code

- in many contexts, they are used almost interchangeably
- machine (assembly) _languages_ are almost interchangeable, too
- if asked a difference,
  - _*machine*_ code is _the_ real encoding of instructions interpretable by a CPU
  - _*assembly*_ code refers to a _textual (human-readable) representation_ of machine code

== Taxonomy : when compilation happens
- *ahead-of-time (AOT)* compiler converts all the program parts into assembly before execution
- *just-in-time (JIT)* compiler converts program parts incrementally as they get executed (e.g., a function at a time)

= CPU and machine code : an overview

== High-level (programming) languages vs. assembly languages

- assembly _is_ just another programming language
- it has many features present in programming languages
#table(columns: (auto,auto), inset: 10pt,
    [*high-level language*],[*assembly language*],
    [variables],          [_registers_ and _memory_],
    [structs and arrays], [lots of registers and memory],
    [expressions],        [arithmetic instructions],
    [if / loop],          [compare, conditional branch instructions],
    [functions],          [branch and link instructions],
)
// - compilation is nothing like a magic; it's more like translating English to French

== What a CPU looks like
- has a small number (typically < 100) of _*registers*_
  - each register can hold a small amount of (e.g., 64-bit) data
- $=>$ majority of data are stored in the _*main memory*_
  - a few GB to $>$1000 GB

#cimg("svg/cpu.svg")

== Terminology note : CPU $in.rev$ core $in.rev$ virtual core

- a _*CPU*_ has multiple (typically, 2 to $>$100) _*cores*_
- a core has multiple (typically, 1 to a few) _*virtual cores*_ or _*hardware threads*_
- each virtual core has its own registers and is capable of fetching and executing instructions
- a single instruction sequence is executed by a single OS-level _*thread*_, which is on a single virtual core at any given time
- this course is only concerned about single-thread execution

== Main memory

- $approx$ a large array indexed by integers, called _*addresses*_
- in machine code level, _*an address is just an integer*_

#cimg("svg/cpu.svg")

== Main memory

- each address stores 8 bits (a single _*byte*_) of data
- a larger word is stored in consecutive addresses. e.g.,
  - 32 bit (4 byte) word occupies 4 consecutive addresses
  - 64 bit (8 byte) word occupies 8 consecutive addresses

#cimg("svg/cpu.svg")

== What a virtual core does
- a virtual core is a machine that does the following:

```text
repeat:
  instruction = memory[program counter]
  execute instruction
```
- _*program counter*_ (or _*instruction pointer*_) is the register that specifies the address to fetch the next instruction from

== What an istruction does

#grid(columns: (auto, auto),
[
+ perform some computation on specified register(s) or a memory address
+ change the program counter,
  - typically to the address of the instruction immediately following it
  - except branch / jump instructions
],
[
#cimg("svg/cpu.svg")
])

== Exercise objectives
- `pl07_how_compiled`
- learn how a _*compiler*_ does the job
- by inspecting assembly code generated from functions of the source language

= A glance at ARM64 machine (assembly) code

== A glance at ARM64 machine (assembly) code

#grid(columns: (auto,auto), align: top, gutter: 10pt,
[
Rust (`add123.rs`)
#text(size: 20pt)[    
```rust
#[no_mangle]
pub fn add123(x:i64, y:i64) -> i64 {
    y + 123
}
```]
#v(2em)
#text(size: 20pt)[    
```bash
$ rustc -O --emit asm --crate-type lib add123.rs -o add123.s
```]
],[
assembly (`add123.s`)
#text(size: 20pt)[    
```asm
        .text
        .file   "pl06.1ebfa1..."
        .section .text.add123,...
        .globl  add123
        .p2align        2
        .type   add123,@function
add123:
        .cfi_startproc
        add     x0, x1, #123
        ret
.Lfunc_end0:
        .size   add123, .Lfunc_...
        .cfi_endproc
```]])

== Insignificant lines

#grid(columns: (55fr,45fr), gutter: 0.5em,
[
- indented lines starting with a dot (e.g., ```asm .file```, ```asm .section```, ```asm .text```, etc.) are _*directives*_ (not instructions) and largely not important
- unindented lines ending in a colon (e.g., ```asm add123:```) are _*labels*_ used to human-readably specify jump targets
],
alternatives[#text(size: 20pt)[    
```asm
        .text
        .file   "pl06.1ebfa1..."
        .section .text.add123,...
        .globl  add123
        .p2align        2
        .type   add123,@function
add123:
        .cfi_startproc
        add     x0, x1, #123
        ret
.Lfunc_end0:
        .size   add123, .Lfunc_end0-add123
        .cfi_endproc
```]][
#text(size: 20pt)[    
```asm




add123:

        add     x0, x1, #123
        ret
.Lfunc_end0:


```]])

== How to read assembly

#grid(columns: (55fr,45fr),
[
- focus on lines that are _instructions_
- look for a label _similar to_ the function name --- where its instructions start
  - the label may not be exactly the same as the function name (_name mangling_)
],
[#text(size: 20pt)[
```asm






add123:

        add     x0, x1, #123
        ret
.Lfunc_end0:


```]]
)

== How to read instructions

- ex.
#text(size: 20pt)[    
```asm
        add     x0, x1, #123
```]
performs ```c   x0 = x1 + 123 ```
- ```asm add``` is an _*instruction name*_ or _mnemonic_
- takes a few _*operands*_ (```asm x0```, ```asm x1```, and ```asm #123```)
  - ```asm x0```, ```asm x1``` : register
  - ```asm #123``` : constant (_*immediate value*_ or _*literal*_)

== ARM64 registers

- integer registers $times 32$
  - 64 bit : ```asm x0, x1, ..., x31```
  - 32 bit : ```asm w0, w1, ..., w31```
    - the lower 32 bits of ```asm x0, x1, ..., x31```
- floating point registers $times 32$
  - 64 bit (double precision) : ```asm d0, d1, ..., d31```
  - 32 bit (single precision): ```asm s0, s1, ..., s31```
    - the lower 32 bits of ```asm d0, d1, ..., d31```
== Implicit registers

- *_condition code register_ (CC)* --- holds the result of the last compare instruction
- *_program counter register_ (PC)* --- holds the address of the next instruction

== SIMD registers

- pack a few floating point numbers / integers in a register
- a SIMD instruction can perform an operation on all values on SIMD register(s)
- important for performance
- not necessary for a minimum working compiler
- you may still witness some in the generated code, so you just want to know that they exist

= ARM64 instructios

== ARM64 instruction categories

- arithmetic / move
- load / store
- compare and conditional branches
- unconditional branch
- branch-and-link and return

== Sources

- when you encouter unfamiliar instructions, see #blink("https://developer.arm.com/documentation/ddi0602/2025-03/?lang=en")[Arm A-profile A64 Instruction Set Architecture]
- #blink("https://taura.github.io/programming-languages/html/arm64_assembly_cheat_sheet.html")[Cheat sheet]
- Google or ask `heytutor` about details
    - e.g., "what is this instruction?"

== Arithmetic / move

#align(center, text(size: 20pt,
table(columns: (auto, auto), align: left,
[assembly], [pseudo C], 
[```asm sub x0, x1, x2```], [```c x0 = x1 - x2```],
[```asm add x0, x1, x2```], [```c x0 = x1 + x2```],
[```asm mov x0, x1```],     [```c x0 = x1```],
[``` ... ```],     [``` ... ```],
)))

- typically takes three operands
- the result is written to the first operand

== Load / store

#align(center, text(size: 20pt, 
table(columns: (auto, auto, auto), align: left,
[], [assembly], [pseudo C], 
[basic load],  [```asm ldr x0,[x1]```],   [```c x0``` = ```c *(long*)x1```],
[basic store], [```asm str x0,[x1]```],   [```c *(long*)x1``` = ```c x0```],
[offset],      [```asm ldr x0,[x1,#8]```],      [```c x0 = *(long*)(x1+8)```], 
[scaled offset], [```asm ldr x0,[x1,x2,lsl #3]```], [```c x0 = *(long*)(x1 + (x2<<3))```],
[pre-increment], [```asm ldr x0,[x1,#8]!```],    [```c x1 += 8; x0 = *(long*)x1```],
[post-increment], [```asm ldr x0,[x1],#8```],    [```c x0 = *(long*)x1; x1 += 8```],
[negative/unaligned offset], [```asm ldur x0,[x1,#-8]```], [```c x0 = *(long*)(x1 - 8)```],
[load pair], [```asm ldp x0,x1,[x2]```],         [```c x0 = *(long*)x2;``` \ ```c x1 = *(long*)(x2 + 8)```]
)))

- there are similar variations for store

== Compare and conditional branches

#align(center, text(size: 20pt, 
table(columns: (auto, auto), align: left,
[```asm cmp x0,x1```], [CC $=$ ```c x0 - x1```], 
[```asm b.eq``` _label_], [if CC $= 0$, goto _label_], 
[```asm b.lt``` _label_], [if CC $< 0$ (signed), goto _label_], 
[```asm b.le``` _label_], [if CC $<= 0$ (signed), goto _label_],
[```asm b.lo``` _label_], [if CC $< 0$ (unsigned), goto _label_], 
[ ... ], [ ... ]
)))

- notes:
  - CC = _condition code register_
  - CC does not hold the value of `x0 - x1` itself
  - but holds whether it is $>0$, $=0$, $<0$, etc. as a bit sequence

== Other jump variants

#align(center, text(size: 20pt, 
table(columns: (auto, auto, auto), align: left,
[```asm b``` _label_], [goto _label_], [],
[```asm bl``` _label_], [goto _label_; `x30 = ` the next address of the `bl`], [($ast$)], 
[```asm ret```], [goto the address in `x30`], [($dagger$)]
)))

- ($ast$) used for calling a function; set `x30` to the address to return after the function
- ($dagger$) used for returning from a function; jump to the "return address", presumably set by the `bl` instruction that called it

== How function calls work --- overview

#grid(columns: (5fr, 5fr),
[
- memory may be required to execute a function, to remember local variables
  - _*activation frame*_ or _*stack frame*_ of a function call
- since life time of a function call is nested inside that of the caller, they are typically LIFO data structure (i.e., stack)
],
[#images("svg/plain/stack_overview", range(1,7), width: 110%)]
)

== Note about the stack data structure

#grid(columns: (auto, auto),
[
- a register, typically called _*stack pointer*_ or _*SP*_, points to the end of the used part of the stack
- the entire stack is typically a single contiguous region, but it doesn't have to
- if it is, allocating an activation frame from the stack just entails bumping a stack pointer
],
[
#image("svg/plain/stack_overview_L1.svg")
])

== Looking into a function call

- rules must exist for function calls to work
  + where are arguments
  + where to jump after finished _*(return address)*_
  + where to use if the function wants to use memory
  + which registers must be preserved across a call
  + where to pass the return value

- they are variously called
  - _calling convention_, _register usage convention_, or
  - *_Application Binary Interface (ABI)_*

== Applicatoin Binary Interface (ABI) of ARM64

Omitting details you should learn through experiments (and which may be language-dependent), 
- upon entry:
  - arguments: `x0, x1, ...` (integers), `d0, d1, ...` (floats)
  - return address: `x30`
  - `sp` points to the end of the stack, below which the callee can use for its purpose

#pagebreak()

- upon return:
  - return value: `x0` (integer), `d0` (float)
  - `x19` - `x28` must hold the same values as those upon entry _*(callee-save registers)*_
  - the following registers must also be preserved
    - `x29` (_frame pointer_),
    - `x30` (_link register_ or _return address register_),
    - `sp` (_stack pointer_)
- `x0` - `x15` can be destroyed by the callee _*(caller-save registers)*_

== A function call in action

#grid(columns: (auto, auto), align: top,
[
#only(1)[- say `f` is calling `g`]
#only(1)[- `f` puts arguments at right places and executes ```asm bl g``` instruction]
#only(2)[
- `x30` now holds the _*return address*_ (address of the instruction immediately following `bl g`)
- if `g` calls another function, it first extends the stack and saves `x30` and `x29` (typically by ```asm stp x29,x30,[sp,#-??]```)
]
#only(3)[- it then sets up _*frame pointer*_ (`x29`), typically to the same as `sp` (more on this later)]
#only(4)[- if it uses some callee-save registers, it saves them on stack]
#only(5)[- `g` is now really ready to execute ...]
#only(6)[- ... before it returns,]
#only(6)[- it restores callee-save registers, if any]
#only(7)[- it then restores `x29` and `x30` and shrinks the stack (typically by ```asm ldp x29,x30,[sp],??```)]
#only(8)[- it finally executes `ret`, which jumps to the address in `x30`, which should hold the return address just restored]
#only(9)[- execution of `f` continues, from the instruction immediately following the `bl`]
],
[#images("svg/L/stack", range(1,10), width: 110%)]
)

== Note: stack pointer (SP) and frame pointer (FP)

#grid(columns: (auto, auto), align: top,
[
- they are usually the same
- more generally,
  - SP may change while executing a function (e.g., when dynamically allocating memory from stack with `alloca`)
  - FP is fixed and always points to where the caller's FP is stored
],
[
#image("svg/L/stack_L4.svg", width: 110%)
])

== Things to learn in the exercise

+ *calling convention / ABI:* how a function call works
+ *control flow:* how conditionals and loops are implemented
+ *data representation:* how various data types (ints, floats, structs, pointers, arrays) are represented



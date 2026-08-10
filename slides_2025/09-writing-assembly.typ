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
    title: [Writing Assembly (or Hand-Compilation)],
    author: [Kenjiro Taura],
    date: [],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 28pt)
#set quote(block: true)
#let ao(x) = text(fill: blue, x)
#let aka(x) = text(fill: red, x)
#let ore(x) = text(fill: orange, x)
#let small(x) = text(size: 20pt)[#x]
#let blink(x, y) = link(x, text(blue, y))

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

// #outline(depth: 1)

== From high-level programming languages to machine code

- there are _no structured control flows_ (for, while, if, etc.); everything must be done by (conditional) jump instructions ($approx$ "goto" statement)
- an instruction can perform _only a single operation_, so nested expressions (e.g., `a * x + b * y + c * z`) must be broken down into a series of instructions

#pagebreak()

- a register $approx$ a variable, but
  - you have _only a fixed number of them_, so some values may have to be spilled on memory (esp. at function calls)
  - function parameters and return values are on predetermined registers (_calling convention_ or _Application Binary Interface_)

== Code generation by hand — introspecting "human compiler"

- ex: how to convert the following (which finds $sqrt(c)$ by the Newton method) into machine language?

```c
double sq(double c, long n) {
  double x = c;
  for (long i = 0; i < n; i++) {
    x = x / 2 + c / (x + x);
  }
  return x;
}
```

== Step 1 --- make all controls "goto"s

#grid(
  columns: (48fr, 4fr, 48fr),
  [
    ```c
    double sq(double c, long n) {
      double x = c;
      for (long i = 0; i < n; i++) {
        x = x / 2 + c / (x + x);
      }
      return x;
    }
    ```
  ],
  $=>$,
  [```c
    double sq(double c, long n) {
      double x = c;
      long i = 0;
      if (i >= n) goto Lend;
    Lstart:
      x = x / 2 + c / (2 * x);
      i++;
      if (i < n) goto Lstart;
    Lend:
      return x;
    }
    ```
  ]
)

== Step 2 --- flatten all nested expressions to "C = A op B"

#grid(
  columns: (47fr, 6fr, 47fr),
  [
    ```c
    double sq(double c, long n) {
      double x = c;
      long i = 0;
      if (i >= n) goto Lend;
    Lstart:
      x = x / 2 + c / (2 * x);
      i++;
      if (i < n) goto Lstart;
    Lend:
      return x;
    }
    ```
  ],
  $=>$,
  [```c
    double sq3(double c, long n) {
      double x = c;
      long i = 0;
      if (!(i < n)) goto Lend;
    Lstart:
      double t0 = 2;
      double t1 = x / t0;
      double t2 = t0 * x;
      double t3 = c / t2;
      x = t1 + t3;
      i = i + 1;
      if (i < n) goto Lstart;
    Lend:
      return x;
    }
    ```
  ]
)

== Step 3 --- assign "machine variables" (registers or memory) to variables

```c
double sq3(double c, long n) { /* c : d0, n : x0 */      
  double x = c;       /* x : d1 */
  long i = 0;         /* i : x1 */
  if (!(i < n)) goto Lend;
Lstart:
  double t0 = 2;      /* t0 : d2 */
  double t1 = x / t0; /* t1 : d3 */
  double t2 = t0 * x; /* t2 : d4 */
  double t3 = c / t2; /* t3 : d5 */
  x = t1 + t3;
  i = i + 1;
  if (i < n) goto Lstart;
Lend:
  return x;
}
```

== Step 4 --- convert them to machine instructions

#grid(
  columns: (50fr, 2fr, 48fr),
  [
```asm
double sq3(double c, long n) {
  /* c : d0, n : x0 */      
  # double x = c;       /*x:d1*/
  fmov d1,d0
  # long i = 0;         /*i:x1*/
  mov x1,0
.Lstart:
  # if (!(i < n)) goto Lend;
  cmp x0,x1            /*n - i*/
  ble .Lend
  # double t0 = 2;      /*t0:d2*/
  fmov d2,1.0e2
  # double t1 = x / t0; /*t1:d3*/
  fdiv d3,d1,d2
```],
    "",
[```asm
  # double t2 = t0 * x; /*t2:d4*/
  fmul d4,d2,d1
  # double t3 = c/t2;   /*t3:d5*/
  fdiv d5,d0,d4
  # x = t1 + t3;
  fadd d1,d3,d5
  # i = i + 1;
  add x1,x1,1
  # if (i < n) goto Lstart;
  cmp x0,x1           /* n - i */
  bl .Lstart
.Lend:
  # return x;
  fmov d0,d1
  ret
```])

== Things are more complex in general...

- we've liberally assigned registers to intermediate results, but:
#grid(columns: (auto,auto),
[```c
  double x = c;       /* x : d1 */
  long i = 0;         /* i : x1 */
  if (!(i < n)) goto Lend;
Lstart:
  double t0 = 2;      /* t0 : d2 */
  double t1 = x / t0; /* t1 : d3 */
  double t2 = t0 * x; /* t2 : d4 */
  double t3 = c / t2; /* t3 : d5 */
```],
[
- registers are finite (may run out)
- some registers are destroyed (i.e., values on them are lost) across a function call
])

$->$ you must use memory ("stack" region) as well

== A simplest general strategy for code generation

- in general:
  - there may be too many intermediate results to hold on registers
  - values used after a function call must be saved on memory (or callee-save registers)  
    $=>$ _always_ using memory (stack) is the simplest strategy
- a register is used only "temporarily" to apply an instruction

// #image("svg/L/stack_L1.svg", width: 50%)

== A code generation based on the simple strategy

- use the following code (integral) as an example

```c
double integ(long n) {
  double x = 0;
  double dx = 1 / (double)n;
  double s = 0;
  for (long i = 0; i < n; i++) {
    s += f(x);
    x += dx;
  }
  return s * dx;
}
```

== converting to "goto"s and "C = A op B"s

#grid(columns: (auto,auto,auto), gutter: 1em, 
[```c
double integ(long n) {
  double x = 0;
  double dx = 1 / (double)n;
  double s = 0;
  for (long i = 0; i < n; i++) {
    s += f(x);
    x += dx;
  }
  return s * dx;
}
```],
$=>$,
[
```c
double integ(long n) {     
  double x = 0;            
  double t0 = 1;           
  double t1 = (double)n;   
  double dx = t0 / t1;     
  double s = 0;            
  long i = 0;              
  if (!(i < n)) goto Lend;
Lstart:
  double t2 = f(x);        
  s += t2;
  x += dx;
  i += 1;
  if (i < n) goto Lstart;
Lend:
  double t3 = s * dx;      
  return t3;
}
```])


== allocate memory slot for intermediate values

```c
double integ(long n) {     /*  n : sp+16 */
  double x = 0;            /*  x : sp+24 */
  double t0 = 1;           /* t0 : sp+32 */
  double t1 = (double)n;   /* t1 : sp+40 */
  double dx = t0 / t1;     /* dx : sp+48 */
  double s = 0;            /*  s : sp+56 */
  long i = 0;              /*  i : sp+64 */
  if (!(i < n)) goto Lend;
Lstart:
  double t2 = f(x);        /* t2 : sp+72 */
  s += t2;
  x += dx;
  i += 1;
  if (i < n) goto Lstart;
Lend:
  double t3 = s * dx;      /* t3 : sp+80 */
  return t3;
}
```

== Generate instructions

#grid(columns: (auto,auto), gutter: 1em, align: top,
[
```asm
double integ(long n) { /*    n: sp+16*/
  stp x29,x30,[sp,-96]!
  mov x29,sp
  str x0,[sp,16]
  /* double x = 0;           x: sp+24*/
  movi d0,#0
  str d0,[sp+24]
  /* double t0 = 1;         t0: sp+32*/
  fmov d0,1.0e+0
  str d0,[sp,32]
  /* double t1 = (double)n; t1: sp+40*/
  ldr x0,[sp,16]
  scvtf d0,x0
  str d0,[sp,40]
  /* double dx = t0 / t1;   dx: sp+48*/
  ldr d0,[sp,32]
```
],
[
```asm
  ldr d1,[sp,40]
  fdiv d0,d0,d1
  str d0,[sp,48]
  /* double s = 0;           s: sp+56*/
  movi d0,#0
  str d0,[sp,56]
  /* long i = 0;             i: sp+64*/
  mov x0,#0
  str x0,[sp,64]
  /* if (!(i < n)) goto Lend; */
  ldr x0,[sp,64]
  ldr x1,[sp,16]
  cmp x0,x1   // i - n
  bge Lend
```])

#grid(columns: (auto,auto), gutter: 1em, align: top,
[
```asm
Lstart:
  /* double t2 = f(x);    t2: sp+72*/
  ldr d0,[sp,24]
  bl f
  str d0,[sp,72]
  /* s += t2; */
  ldr d0,[sp,56]
  ldr d1,[sp,72]
  add d0,d0,d1
  str d0,[sp,56]
  /* x += dx; */
  ldr d0,[sp,24]
  ldr d1,[sp,48]
  add d0,d0,d1
  str d0,[sp,24]
  /* i += 1; */
  ldr d0,[sp,64]
```],
[
```asm
  add d0,d0,1
  str d0,[sp,64]
  /* if (i < n) goto Lstart; */
  ldr x0,[sp,64]
  ldr x1,[sp,16]
  cmp x0,x1   // i - n
  bl Lstart
Lend:
  /* double t3 = s * dx;    t3: sp+80*/
  ldr d0,[sp,56]
  ldr d1,[sp,48]
  mul d0,d0,d1
  str d0,[sp,80]
  /* return t3; */
  ldr d0,[sp,80]
  ret
}
```])



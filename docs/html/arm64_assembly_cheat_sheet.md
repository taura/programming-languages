
# AArch64 (ARM64) Assembly Cheat Sheet

* [Authorative source](https://developer.arm.com/documentation/ddi0602/2025-03/?lang=en)

## Registers

### General Purpose (x0–x30)

* C convention

| Name     | Purpose                            |   |
|----------|------------------------------------|---|
| x0-x7    | Arguments / return values          |   |
| x8       | Indirect result location / syscall |   |
| x9-x15   | Temporary (caller-saved)           |   |
| x16-x17  | Intra-procedure call scratch       |(X)|
| x18      | Platform register (TLS)            |(X)|
| x19-x28  | Callee-saved                       |   |
| x29      | Frame pointer                      |(X)|
| x30      | Link register (return address)     |   |
| sp       | Stack pointer                      |(X)|
| zr       | Zero register                      |   |

* Each xN has a 32-bit alias: wN
* Registers with (X) have specific purposes and should not be used for general computation
* "Temporary (caller-saved)" are destroyed across a function call
  * flip side: your function can use (destroy) them without saving them
* "Callee-saved" are preserved across a function call 
  * flip side: if your function use one, you must save it before using it and restore it before return

---

## Stack & Calling Convention of C (AAPCS64)

- Arguments: x0-x7
- Return: x0
- Stack grows down, 16-byte aligned
- Callee-saved: x19-x28, x29 (fp), x30 (lr), x31 (sp)
- Function call: `bl func`
- Return: `ret`

---

## Arithmetic and Logic

```asm
add x0, x1, x2        // x0 = x1 + x2
sub x0, x1, #4        // x0 = x1 - 4
mul x0, x1, x2        // x0 = x1 * x2
and x0, x1, x2        // bitwise AND
orr x0, x1, x2        // bitwise OR
eor x0, x1, x2        // bitwise XOR
```

---

## Load and Store

* single-word load/stores

```asm
ldr x0, [x1]          // load 64-bit from the address in x1 and put it to x0
ldr w0, [x1]          // load 32-bit
ldrb w0, [x1]         // load byte
str x0, [x1]          // store 64-bit value in x0 to the address in x1
str w0, [x1]          // store 32-bit
strb w0, [x1]         // store byte
```

* offset and increment
```asm
ldr x0, [x1, #16]     // load from the address in x1 + 16
ldr x0, [x1], #16     // load from the address in x1; x1 += 16 (post-increment)
ldr x0, [x1, #16]!    // x1 += 16; load from the address in x1 (pre-increment)
```

* two-word load/stores

```asm
ldp x0, x1, [sp, #16]   // = ldr x0,[sp,#16]; ldr x1,[sp,#24]
stp x0, x1, [sp, #-16]! // = sp -= 16; stp x0,[sp]; stp x1,[sp,#8]
```

---

## Branch and Compare

```asm
cmp x0, x1            // compare x0 and x1 and put the result into the condition flags register
b.eq label            // branch if equal
b.ne label            // not equal
b.gt, b.lt, b.ge, b.le
b label               // unconditional
bl func               // branch and link
ret                   // return
```

* conditional branch instructions look at the flags set in the condition flags register
* in other words, they refer to the result of the _last_ compare instruction
* `bl func` puts the address of the instruction immediately following `bl func` instruction (i.e., the address of `bl func` + 4) to `x30` register
* `ret` jumps to the address in `x30` register

---

## Function Prologue/Epilogue

* Any function that calls another function 

```asm
// Prologue (grows stack and saves x29 and x30; set x29 (fp))
stp x29, x30, [sp, #-16]! 
mov x29, sp

// Epilogue (restores x29 and x30; shrink stack; jump to x30)
ldp x29, x30, [sp], #16 
ret
```

---

## Floating-Point Registers

- sN = 32-bit float, dN = 64-bit float

```asm
fadd s0, s1, s2       // float add
fmul d0, d1, d2       // double mul
scvtf s0, w0          // int to float
fcvtzs w0, s0         // float to int
ldr s0, [x0]          // load float
str d0, [x0]          // store double
```


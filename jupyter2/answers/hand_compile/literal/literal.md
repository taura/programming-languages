# <font color="green">Literal (immediate) values</font>

## Problem

* Write two functions __in assembly__:
```
long imm() { return 1234567; }
double fimm() { return 1.234; }
```
  * `imm` returns the `long` value `1234567`. Since this does not fit in a single 16-bit immediate, you will need a `mov`/`movz` followed by one or more `movk`s.
  * `fimm` returns the `double` value `1.234`. Since this is not a "simple" number, build its 64-bit representation on an integer register first, then move it into a floating-point register with `fmov`.
* Fill in the skeleton `literal.s` (after each `// ------- write your answer here -------`) with instructions.
* The checker `check_literal.c` verifies both return values. If you see `OK`s and no errors, you are done.

## Hints

* Using literal (immediate) values in arbitrary expressions (e.g., `x + 1234567` or `x * 3.141592`) is trivial in any high-level language, but not in machine code.
* Machine languages restrict using such values directly in instructions, because the number of bits per instruction is limited (32 bits in ARM64); there is no room to encode an arbitrary 32-bit, let alone 64-bit, number.
* In ARM64:
  * a `mov`/`movz` (move-and-zero) instruction can set one of the four 16-bit words of an integer register to a specified 16-bit value, and zeros the remaining three words;
  * a `movk` (move-and-keep) instruction can set one of the four 16-bit words to a specified 16-bit value, and leaves the remaining three words unchanged;
  * by combining a `mov` with up to three `movk`s, you can set an arbitrary 64-bit value into a register;
  * `fmov` can set a floating-point register to certain "simple" numbers --- numbers whose exponent and mantissa fit in a few bits; in a quick investigation, `fmov` can take numbers of the form $\pm 1.xxxx \times 2^{(yyy-3)}$ (3-bit exponent, 4-bit mantissa, positive and negative);
  * each non-simple number is first built as its bit representation on an integer register with `mov`/`movk`, and then moved to a floating-point register with `fmov`.
* The *Observe* cells below contain `imm` and `fimm` (returning `1234567` and `1.234`). Compile them and look at how the constants are loaded. Try changing the immediate values --- e.g. a small int (`5`), a "simple" floating-point value (`1.5`), and a "non-simple" one (`1.234`) --- and compare the generated code.

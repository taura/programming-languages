#!/bin/bash
#prefix=00-roadmap
#prefix=01-functional
#prefix=0x-ocaml
#prefix=02-oop
#prefix=03-parametric
#prefix=04-build-system-libraries
#prefix=05-implementation-basics
#prefix=06-memory-management
#prefix=07-gc-basics
prefix=08-rust
#prefix=09-writing-assembly
#prefix=10-compiler
src=${prefix}.typ
#dst=~/0main/${prefix}.pdf
dst=../docs/slides/${prefix}.pdf
#typst watch --open evince ${src} ${dst}
typst watch --open evince ${src} ${dst}

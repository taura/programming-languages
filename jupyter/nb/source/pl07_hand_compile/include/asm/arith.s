	.arch armv8-a
	.file	"arith.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add
	.type	add, %function
add:
.LFB0:
	.cfi_startproc
	add	x2, x2, x2, lsl 1
	add	x0, x0, x1, lsl 1
	add	x0, x0, x2
	ret
	.cfi_endproc
.LFE0:
	.size	add, .-add
	.align	2
	.p2align 4,,11
	.global	sub
	.type	sub, %function
sub:
.LFB1:
	.cfi_startproc
	sub	x0, x0, x1
	sub	x0, x0, x2
	ret
	.cfi_endproc
.LFE1:
	.size	sub, .-sub
	.align	2
	.p2align 4,,11
	.global	mul
	.type	mul, %function
mul:
.LFB2:
	.cfi_startproc
	mul	x0, x0, x1
	mul	x0, x0, x2
	ret
	.cfi_endproc
.LFE2:
	.size	mul, .-mul
	.align	2
	.p2align 4,,11
	.global	div
	.type	div, %function
div:
.LFB3:
	.cfi_startproc
	sdiv	x0, x0, x1
	sdiv	x0, x0, x2
	ret
	.cfi_endproc
.LFE3:
	.size	div, .-div
	.align	2
	.p2align 4,,11
	.global	fadd
	.type	fadd, %function
fadd:
.LFB4:
	.cfi_startproc
	fmov	d4, 2.0e+0
	fmov	d3, 3.0e+0
	fmadd	d0, d1, d4, d0
	fmadd	d0, d2, d3, d0
	ret
	.cfi_endproc
.LFE4:
	.size	fadd, .-fadd
	.align	2
	.p2align 4,,11
	.global	fsub
	.type	fsub, %function
fsub:
.LFB5:
	.cfi_startproc
	fsub	d0, d0, d1
	fsub	d0, d0, d2
	ret
	.cfi_endproc
.LFE5:
	.size	fsub, .-fsub
	.align	2
	.p2align 4,,11
	.global	fmul
	.type	fmul, %function
fmul:
.LFB6:
	.cfi_startproc
	fmul	d0, d0, d1
	fmul	d0, d0, d2
	ret
	.cfi_endproc
.LFE6:
	.size	fmul, .-fmul
	.align	2
	.p2align 4,,11
	.global	fdiv
	.type	fdiv, %function
fdiv:
.LFB7:
	.cfi_startproc
	fdiv	d0, d0, d1
	fdiv	d0, d0, d2
	ret
	.cfi_endproc
.LFE7:
	.size	fdiv, .-fdiv
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

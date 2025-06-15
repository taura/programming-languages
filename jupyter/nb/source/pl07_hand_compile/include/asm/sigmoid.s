	.arch armv8-a
	.file	"sigmoid.c"
	.text
	.align	2
	.p2align 4,,11
	.global	sigmoid
	.type	sigmoid, %function
sigmoid:
.LFB0:
	.cfi_startproc
	fneg	d0, d0
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	bl	exp
	fmov	d1, 1.0e+0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	fadd	d0, d0, d1
	fdiv	d0, d1, d0
	ret
	.cfi_endproc
.LFE0:
	.size	sigmoid, .-sigmoid
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

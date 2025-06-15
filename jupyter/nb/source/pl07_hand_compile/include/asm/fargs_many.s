	.arch armv8-a
	.file	"fargs_many.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add_many
	.type	add_many, %function
add_many:
.LFB0:
	.cfi_startproc
	movi	d16, #0
	ldp	d23, d22, [sp]
	ldp	d21, d20, [sp, 16]
	fadd	d0, d0, d16
	ldp	d19, d18, [sp, 32]
	ldp	d17, d16, [sp, 48]
	fadd	d0, d0, d1
	fadd	d0, d0, d2
	ldp	d2, d1, [sp, 64]
	fadd	d0, d0, d3
	fadd	d0, d0, d4
	fadd	d0, d0, d5
	fadd	d0, d0, d6
	fadd	d0, d0, d7
	fadd	d0, d0, d23
	fadd	d0, d0, d22
	fadd	d0, d0, d21
	fadd	d0, d0, d20
	fadd	d0, d0, d19
	fadd	d0, d0, d18
	fadd	d0, d0, d17
	fadd	d0, d0, d16
	fadd	d0, d0, d2
	fadd	d0, d0, d1
	ret
	.cfi_endproc
.LFE0:
	.size	add_many, .-add_many
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

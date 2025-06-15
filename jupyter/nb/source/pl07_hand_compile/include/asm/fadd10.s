	.arch armv8-a
	.file	"fadd10.c"
	.text
	.align	2
	.p2align 4,,11
	.global	fadd10
	.type	fadd10, %function
fadd10:
.LFB0:
	.cfi_startproc
	fadd	d1, d0, d1
	ldp	d16, d0, [sp]
	fadd	d1, d1, d2
	fadd	d1, d1, d3
	fadd	d1, d1, d4
	fadd	d1, d1, d5
	fadd	d1, d1, d6
	fadd	d1, d1, d7
	fadd	d1, d1, d16
	fadd	d0, d1, d0
	ret
	.cfi_endproc
.LFE0:
	.size	fadd10, .-fadd10
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"fadd.c"
	.text
	.align	2
	.p2align 4,,11
	.global	fadd
	.type	fadd, %function
fadd:
.LFB0:
	.cfi_startproc
	fadd	d0, d0, d1
	fadd	d0, d0, d1
	ret
	.cfi_endproc
.LFE0:
	.size	fadd, .-fadd
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

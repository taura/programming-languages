	.arch armv8-a
	.file	"mul.c"
	.text
	.align	2
	.p2align 4,,11
	.global	mul
	.type	mul, %function
mul:
.LFB0:
	.cfi_startproc
	mul	x0, x0, x1
	ret
	.cfi_endproc
.LFE0:
	.size	mul, .-mul
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

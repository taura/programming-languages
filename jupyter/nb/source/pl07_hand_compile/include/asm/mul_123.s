	.arch armv8-a
	.file	"mul_123.c"
	.text
	.align	2
	.p2align 4,,11
	.global	mul_123
	.type	mul_123, %function
mul_123:
.LFB0:
	.cfi_startproc
	lsl	x1, x0, 5
	sub	x1, x1, x0
	lsl	x1, x1, 2
	sub	x0, x1, x0
	ret
	.cfi_endproc
.LFE0:
	.size	mul_123, .-mul_123
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

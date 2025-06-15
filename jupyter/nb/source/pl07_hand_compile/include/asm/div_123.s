	.arch armv8-a
	.file	"div_123.c"
	.text
	.align	2
	.p2align 4,,11
	.global	div_123
	.type	div_123, %function
div_123:
.LFB0:
	.cfi_startproc
	mov	x1, 123
	sdiv	x0, x1, x0
	ret
	.cfi_endproc
.LFE0:
	.size	div_123, .-div_123
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

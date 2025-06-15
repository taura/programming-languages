	.arch armv8-a
	.file	"sub_123.c"
	.text
	.align	2
	.p2align 4,,11
	.global	sub_123
	.type	sub_123, %function
sub_123:
.LFB0:
	.cfi_startproc
	mov	x1, 123
	sub	x0, x1, x0
	ret
	.cfi_endproc
.LFE0:
	.size	sub_123, .-sub_123
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

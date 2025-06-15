	.arch armv8-a
	.file	"l2_norm_long.c"
	.text
	.align	2
	.p2align 4,,11
	.global	l2_norm_long
	.type	l2_norm_long, %function
l2_norm_long:
.LFB0:
	.cfi_startproc
	ldp	x1, x2, [x0]
	ldr	x0, [x0, 16]
	mul	x2, x2, x2
	madd	x1, x1, x1, x2
	madd	x0, x0, x0, x1
	ret
	.cfi_endproc
.LFE0:
	.size	l2_norm_long, .-l2_norm_long
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

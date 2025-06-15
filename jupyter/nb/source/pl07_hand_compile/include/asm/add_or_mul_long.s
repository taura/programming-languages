	.arch armv8-a
	.file	"add_or_mul_long.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add_or_mul_long
	.type	add_or_mul_long, %function
add_or_mul_long:
.LFB0:
	.cfi_startproc
	add	x3, x1, x2
	cmp	x0, x1
	mul	x1, x1, x2
	csel	x0, x1, x3, ge
	ret
	.cfi_endproc
.LFE0:
	.size	add_or_mul_long, .-add_or_mul_long
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

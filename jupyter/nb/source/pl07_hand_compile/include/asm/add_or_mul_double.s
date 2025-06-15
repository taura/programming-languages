	.arch armv8-a
	.file	"add_or_mul_double.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add_or_mul_double
	.type	add_or_mul_double, %function
add_or_mul_double:
.LFB0:
	.cfi_startproc
	fcmpe	d0, d1
	bmi	.L5
	fmul	d0, d1, d2
	ret
	.p2align 2,,3
.L5:
	fadd	d0, d1, d2
	ret
	.cfi_endproc
.LFE0:
	.size	add_or_mul_double, .-add_or_mul_double
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

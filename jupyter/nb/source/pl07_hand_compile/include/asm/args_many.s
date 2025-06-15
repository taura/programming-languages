	.arch armv8-a
	.file	"args_many.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add_many
	.type	add_many, %function
add_many:
.LFB0:
	.cfi_startproc
	add	x0, x0, x1
	add	x0, x0, x2
	add	x0, x0, x3
	add	x0, x0, x4
	ldp	x4, x3, [sp]
	add	x0, x0, x5
	ldp	x2, x1, [sp, 16]
	add	x0, x0, x6
	add	x0, x0, x7
	add	x0, x0, x4
	add	x0, x0, x3
	ldp	x4, x3, [sp, 32]
	add	x0, x0, x2
	add	x0, x0, x1
	ldp	x2, x1, [sp, 48]
	add	x0, x0, x4
	add	x0, x0, x3
	ldp	x4, x3, [sp, 64]
	add	x0, x0, x2
	add	x0, x0, x1
	ldp	x2, x1, [sp, 80]
	add	x0, x0, x4
	add	x0, x0, x3
	add	x0, x0, x2
	add	x0, x0, x1
	ret
	.cfi_endproc
.LFE0:
	.size	add_many, .-add_many
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

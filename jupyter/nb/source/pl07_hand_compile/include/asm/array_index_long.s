	.arch armv8-a
	.file	"array_index_long.c"
	.text
	.align	2
	.p2align 4,,11
	.global	array_index_long
	.type	array_index_long, %function
array_index_long:
.LFB0:
	.cfi_startproc
	ldr	x1, [x0]
	ldr	x0, [x0, 80]
	add	x0, x1, x0
	ret
	.cfi_endproc
.LFE0:
	.size	array_index_long, .-array_index_long
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"array_index_int.c"
	.text
	.align	2
	.p2align 4,,11
	.global	array_index_int
	.type	array_index_int, %function
array_index_int:
.LFB0:
	.cfi_startproc
	ldr	w1, [x0]
	ldr	w0, [x0, 40]
	add	w0, w1, w0
	ret
	.cfi_endproc
.LFE0:
	.size	array_index_int, .-array_index_int
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

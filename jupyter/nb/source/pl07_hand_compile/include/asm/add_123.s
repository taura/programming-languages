	.arch armv8-a
	.file	"add_123.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add_123
	.type	add_123, %function
add_123:
.LFB0:
	.cfi_startproc
	add	x0, x0, 123
	ret
	.cfi_endproc
.LFE0:
	.size	add_123, .-add_123
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

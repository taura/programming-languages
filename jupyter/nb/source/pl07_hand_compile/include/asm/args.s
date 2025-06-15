	.arch armv8-a
	.file	"args.c"
	.text
	.align	2
	.p2align 4,,11
	.global	add6
	.type	add6, %function
add6:
.LFB0:
	.cfi_startproc
	add	x0, x0, x1
	add	x0, x0, x2
	add	x0, x0, x3
	add	x0, x0, x4
	add	x0, x0, x5
	ret
	.cfi_endproc
.LFE0:
	.size	add6, .-add6
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

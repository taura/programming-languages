	.arch armv8-a
	.file	"ret_struct.c"
	.text
	.align	2
	.p2align 4,,11
	.global	mk_point
	.type	mk_point, %function
mk_point:
.LFB0:
	.cfi_startproc
	stp	x0, x1, [x8]
	str	x2, [x8, 16]
	ret
	.cfi_endproc
.LFE0:
	.size	mk_point, .-mk_point
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"ptr_ptr.c"
	.text
	.align	2
	.p2align 4,,11
	.global	left_right
	.type	left_right, %function
left_right:
.LFB0:
	.cfi_startproc
	ldr	x0, [x0]
	ldr	x0, [x0, 8]
	ret
	.cfi_endproc
.LFE0:
	.size	left_right, .-left_right
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

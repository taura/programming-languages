	.arch armv8-a
	.file	"ptr_deref.c"
	.text
	.align	2
	.p2align 4,,11
	.global	long_ptr_deref
	.type	long_ptr_deref, %function
long_ptr_deref:
.LFB0:
	.cfi_startproc
	ldr	x0, [x0]
	ret
	.cfi_endproc
.LFE0:
	.size	long_ptr_deref, .-long_ptr_deref
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

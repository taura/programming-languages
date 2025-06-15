	.arch armv8-a
	.file	"struct_field.c"
	.text
	.align	2
	.p2align 4,,11
	.global	struct_field
	.type	struct_field, %function
struct_field:
.LFB0:
	.cfi_startproc
	ldp	x1, x3, [x0]
	ldr	x2, [x0, 16]
	add	x0, x1, x3
	add	x0, x0, x2
	ret
	.cfi_endproc
.LFE0:
	.size	struct_field, .-struct_field
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

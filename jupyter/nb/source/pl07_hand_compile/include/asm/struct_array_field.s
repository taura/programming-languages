	.arch armv8-a
	.file	"struct_array_field.c"
	.text
	.align	2
	.p2align 4,,11
	.global	struct_array_field
	.type	struct_array_field, %function
struct_array_field:
.LFB0:
	.cfi_startproc
	add	x1, x0, 240
	ldr	x0, [x0, 240]
	ldp	x2, x1, [x1, 8]
	add	x0, x0, x2
	add	x0, x0, x1
	ret
	.cfi_endproc
.LFE0:
	.size	struct_array_field, .-struct_array_field
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"struct_array_field_assign.c"
	.text
	.align	2
	.p2align 4,,11
	.global	struct_array_field
	.type	struct_array_field, %function
struct_array_field:
.LFB0:
	.cfi_startproc
	adrp	x2, .LC0
	mov	x1, 50
	ldr	q0, [x2, #:lo12:.LC0]
	str	q0, [x0, 240]!
	str	x1, [x0, 16]
	ret
	.cfi_endproc
.LFE0:
	.size	struct_array_field, .-struct_array_field
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LC0:
	.xword	30
	.xword	40
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

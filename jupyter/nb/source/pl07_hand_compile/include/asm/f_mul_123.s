	.arch armv8-a
	.file	"f_mul_123.c"
	.text
	.align	2
	.p2align 4,,11
	.global	f_mul_123
	.type	f_mul_123, %function
f_mul_123:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x0, 10
	mov	x29, sp
	str	x19, [sp, 16]
	.cfi_offset 19, -16
	bl	f
	mov	x19, x0
	mov	x0, 100
	bl	f
	mul	x0, x19, x0
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	f_mul_123, .-f_mul_123
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

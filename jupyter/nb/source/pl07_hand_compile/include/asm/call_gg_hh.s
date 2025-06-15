	.arch armv8-a
	.file	"call_gg_hh.c"
	.text
	.align	2
	.p2align 4,,11
	.global	ff
	.type	ff, %function
ff:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x0, 1
	mov	x29, sp
	str	x19, [sp, 16]
	.cfi_offset 19, -16
	bl	gg
	mov	x19, x0
	mov	x0, 2
	bl	hh
	add	x0, x19, x0
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	ff, .-ff
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

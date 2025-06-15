	.arch armv8-a
	.file	"many_vars.c"
	.text
	.align	2
	.p2align 4,,11
	.global	ff
	.type	ff, %function
ff:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -96]!
	.cfi_def_cfa_offset 96
	.cfi_offset 29, -96
	.cfi_offset 30, -88
	mov	x0, 0
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	.cfi_offset 19, -80
	.cfi_offset 20, -72
	.cfi_offset 21, -64
	.cfi_offset 22, -56
	.cfi_offset 23, -48
	.cfi_offset 24, -40
	.cfi_offset 25, -32
	.cfi_offset 26, -24
	.cfi_offset 27, -16
	.cfi_offset 28, -8
	bl	gg
	mov	x19, x0
	mov	x0, 1
	bl	gg
	mov	x20, x0
	mov	x0, 2
	bl	gg
	mov	x21, x0
	mov	x0, 3
	bl	gg
	mov	x22, x0
	mov	x0, 4
	bl	gg
	mov	x23, x0
	mov	x0, 5
	bl	gg
	mov	x24, x0
	mov	x0, 6
	bl	gg
	mov	x25, x0
	mov	x0, 7
	bl	gg
	mov	x26, x0
	mov	x0, 8
	bl	gg
	mov	x28, x0
	mov	x0, 9
	bl	gg
	mov	x27, x0
	mov	x0, 10
	bl	gg
	cmp	x0, 0
	blt	.L1
	mov	x19, x20
	beq	.L1
	mov	x19, x21
	cmp	x0, 1
	beq	.L1
	mov	x19, x22
	cmp	x0, 2
	beq	.L1
	mov	x19, x23
	cmp	x0, 3
	beq	.L1
	mov	x19, x24
	cmp	x0, 4
	beq	.L1
	mov	x19, x25
	cmp	x0, 5
	beq	.L1
	mov	x19, x26
	cmp	x0, 6
	beq	.L1
	cmp	x0, 7
	csel	x19, x28, x27, eq
.L1:
	ldp	x21, x22, [sp, 32]
	mov	x0, x19
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 96
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 27
	.cfi_restore 28
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	ff, .-ff
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

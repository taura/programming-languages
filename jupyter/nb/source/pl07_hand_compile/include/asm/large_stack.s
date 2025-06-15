	.arch armv8-a
	.file	"large_stack.c"
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
	adrp	x1, :got:__stack_chk_guard
	ldr	x1, [x1, :got_lo12:__stack_chk_guard]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	sub	sp, sp, #816
	.cfi_def_cfa_offset 848
	.cfi_offset 19, -16
	.cfi_offset 20, -8
	add	x20, sp, 8
	ldr	x2, [x1]
	str	x2, [sp, 808]
	mov	x2, 0
	mov	x0, x20
	bl	gg
	mov	x19, x0
	mov	x0, x20
	bl	hh
	adrp	x1, :got:__stack_chk_guard
	ldr	x1, [x1, :got_lo12:__stack_chk_guard]
	add	x0, x19, x0
	ldr	x3, [sp, 808]
	ldr	x2, [x1]
	subs	x3, x3, x2
	mov	x2, 0
	bne	.L5
	add	sp, sp, 816
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
.L5:
	.cfi_restore_state
	bl	__stack_chk_fail
	.cfi_endproc
.LFE0:
	.size	ff, .-ff
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"get_struct.c"
	.text
	.align	2
	.p2align 4,,11
	.global	get_point
	.type	get_point, %function
get_point:
.LFB0:
	.cfi_startproc
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	mov	x2, 3
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, :got_lo12:__stack_chk_guard]
	mov	x1, 2
	stp	x29, x30, [sp, 32]
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	add	x29, sp, 32
	mov	x8, sp
	ldr	x3, [x0]
	str	x3, [sp, 24]
	mov	x3, 0
	mov	x0, 1
	bl	mk_point
	ldp	x0, x1, [sp]
	ldr	x2, [sp, 16]
	add	x0, x0, x1
	adrp	x1, :got:__stack_chk_guard
	ldr	x1, [x1, :got_lo12:__stack_chk_guard]
	add	x0, x0, x2
	ldr	x3, [sp, 24]
	ldr	x2, [x1]
	subs	x3, x3, x2
	mov	x2, 0
	bne	.L5
	ldp	x29, x30, [sp, 32]
	add	sp, sp, 48
	.cfi_remember_state
	.cfi_restore 29
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	ret
.L5:
	.cfi_restore_state
	bl	__stack_chk_fail
	.cfi_endproc
.LFE0:
	.size	get_point, .-get_point
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"check_l2_norm_long.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"check_l2_norm_long.c"
	.align	3
.LC1:
	.string	"l2 == x[0] * x[0] + x[1] * x[1] + x[2] * x[2]"
	.align	3
.LC2:
	.string	"OK"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,11
	.global	main
	.type	main, %function
main:
.LFB39:
	.cfi_startproc
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	mov	w2, 10
	adrp	x3, :got:__stack_chk_guard
	ldr	x3, [x3, :got_lo12:__stack_chk_guard]
	stp	x29, x30, [sp, 32]
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 32
	str	x19, [sp, 48]
	.cfi_offset 19, -16
	mov	x19, x1
	mov	x1, 0
	ldr	x4, [x3]
	str	x4, [sp, 24]
	mov	x4, 0
	ldr	x0, [x19, 8]
	bl	strtol
	mov	x3, x0
	ldr	x0, [x19, 16]
	mov	w2, 10
	mov	x1, 0
	str	x3, [sp]
	bl	strtol
	mov	x3, x0
	ldr	x0, [x19, 24]
	mov	x1, 0
	mov	w2, 10
	str	x3, [sp, 8]
	bl	strtol
	mov	x1, x0
	mov	x0, sp
	str	x1, [sp, 16]
	bl	l2_norm_long
	ldp	x2, x3, [sp]
	ldr	x1, [sp, 16]
	mul	x3, x3, x3
	madd	x2, x2, x2, x3
	madd	x1, x1, x1, x2
	cmp	x1, x0
	bne	.L6
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	puts
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, :got_lo12:__stack_chk_guard]
	ldr	x2, [sp, 24]
	ldr	x1, [x0]
	subs	x2, x2, x1
	mov	x1, 0
	bne	.L7
	ldp	x29, x30, [sp, 32]
	mov	w0, 0
	ldr	x19, [sp, 48]
	add	sp, sp, 64
	.cfi_remember_state
	.cfi_restore 29
	.cfi_restore 30
	.cfi_restore 19
	.cfi_def_cfa_offset 0
	ret
.L6:
	.cfi_restore_state
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
	add	x3, x3, :lo12:.LANCHOR0
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	mov	w2, 9
	bl	__assert_fail
.L7:
	bl	__stack_chk_fail
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	__PRETTY_FUNCTION__.0, %object
	.size	__PRETTY_FUNCTION__.0, 5
__PRETTY_FUNCTION__.0:
	.string	"main"
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

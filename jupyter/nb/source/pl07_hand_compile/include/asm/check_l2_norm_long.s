	.arch armv8-a
	.file	"check_l2_norm_long.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"check_l2_norm_long.c"
	.align	3
.LC1:
	.string	"argc == 4"
	.align	3
.LC2:
	.string	"l2 == x[0] * x[0] + x[1] * x[1] + x[2] * x[2]"
	.align	3
.LC3:
	.string	"OK %ld\n"
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
	adrp	x2, :got:__stack_chk_guard
	ldr	x2, [x2, :got_lo12:__stack_chk_guard]
	stp	x29, x30, [sp, 32]
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 32
	str	x19, [sp, 48]
	.cfi_offset 19, -16
	mov	x19, x1
	ldr	x1, [x2]
	str	x1, [sp, 24]
	mov	x1, 0
	cmp	w0, 4
	bne	.L7
	ldr	x0, [x19, 8]
	mov	w2, 10
	mov	x1, 0
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
	ldp	x1, x3, [sp]
	ldr	x2, [sp, 16]
	mul	x3, x3, x3
	madd	x1, x1, x1, x3
	madd	x2, x2, x2, x1
	cmp	x2, x0
	bne	.L8
	adrp	x1, .LC3
	mov	w0, 2
	add	x1, x1, :lo12:.LC3
	bl	__printf_chk
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, :got_lo12:__stack_chk_guard]
	ldr	x2, [sp, 24]
	ldr	x1, [x0]
	subs	x2, x2, x1
	mov	x1, 0
	bne	.L9
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
.L7:
	.cfi_restore_state
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
	add	x3, x3, :lo12:.LANCHOR0
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	mov	w2, 7
	bl	__assert_fail
.L9:
	bl	__stack_chk_fail
.L8:
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC2
	add	x3, x3, :lo12:.LANCHOR0
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC2
	mov	w2, 10
	bl	__assert_fail
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

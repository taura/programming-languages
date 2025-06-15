	.arch armv8-a
	.file	"check_max_array.c"
	.text
	.align	2
	.p2align 4,,11
	.global	max_array_c
	.type	max_array_c, %function
max_array_c:
.LFB39:
	.cfi_startproc
	movi	d0, #0
	cmp	x1, 0
	ble	.L1
	add	x1, x0, x1, lsl 3
	.p2align 3,,7
.L5:
	ldr	d1, [x0]
	fcmpe	d0, d1
	bmi	.L7
.L3:
	add	x0, x0, 8
	cmp	x1, x0
	bne	.L5
.L1:
	ret
	.p2align 2,,3
.L7:
	fmov	d0, d1
	b	.L3
	.cfi_endproc
.LFE39:
	.size	max_array_c, .-max_array_c
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"check_max_array.c"
	.align	3
.LC1:
	.string	"sa == max_array_c(a, n)"
	.align	3
.LC2:
	.string	"OK"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,11
	.global	main
	.type	main, %function
main:
.LFB40:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -48
	.cfi_offset 20, -40
	sxtw	x20, w0
	sub	w19, w20, #1
	stp	x21, x22, [sp, 32]
	.cfi_offset 21, -32
	.cfi_offset 22, -24
	mov	x22, x1
	sbfiz	x0, x19, 3, 32
	str	x23, [sp, 48]
	.cfi_offset 23, -16
	sxtw	x23, w19
	bl	malloc
	cmp	w19, 0
	ble	.L11
	mov	x21, x0
	add	x22, x22, 8
	sub	x20, x20, #1
	mov	x19, 0
	.p2align 3,,7
.L12:
	ldr	x0, [x22, x19, lsl 3]
	mov	x1, 0
	bl	strtod
	str	d0, [x21, x19, lsl 3]
	add	x19, x19, 1
	cmp	x19, x20
	bne	.L12
	mov	x1, x23
	mov	x0, x21
	bl	max_array
	movi	d2, #0
	mov	x1, 0
	.p2align 3,,7
.L17:
	ldr	d1, [x21, x1, lsl 3]
	fcmpe	d1, d2
	bgt	.L19
.L15:
	add	x1, x1, 1
	cmp	x1, x20
	bne	.L17
.L14:
	fcmp	d0, d2
	bne	.L24
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	puts
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
	ldp	x29, x30, [sp], 64
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 23
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
	.p2align 2,,3
.L19:
	.cfi_restore_state
	fmov	d2, d1
	b	.L15
.L11:
	mov	x1, x23
	bl	max_array
	movi	d2, #0
	b	.L14
.L24:
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
	add	x3, x3, :lo12:.LANCHOR0
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	mov	w2, 21
	bl	__assert_fail
	.cfi_endproc
.LFE40:
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

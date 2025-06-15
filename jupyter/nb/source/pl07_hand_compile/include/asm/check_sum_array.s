	.arch armv8-a
	.file	"check_sum_array.c"
	.text
	.align	2
	.p2align 4,,11
	.global	sum_array_c
	.type	sum_array_c, %function
sum_array_c:
.LFB39:
	.cfi_startproc
	mov	x4, x0
	cmp	x1, 0
	ble	.L7
	sub	x0, x1, #1
	cmp	x0, 1
	bls	.L8
	lsr	x3, x1, 1
	mov	x2, x4
	movi	v0.4s, 0
	add	x3, x4, x3, lsl 4
	.p2align 3,,7
.L4:
	ldr	q1, [x2], 16
	add	v0.2d, v0.2d, v1.2d
	cmp	x2, x3
	bne	.L4
	addp	d0, v0.2d
	and	x2, x1, -2
	fmov	x0, d0
	tbz	x1, 0, .L1
.L3:
	ldr	x5, [x4, x2, lsl 3]
	add	x3, x2, 1
	lsl	x2, x2, 3
	add	x0, x0, x5
	cmp	x1, x3
	ble	.L1
	add	x4, x4, x2
	ldr	x1, [x4, 8]
	add	x0, x0, x1
.L1:
	ret
	.p2align 2,,3
.L7:
	mov	x0, 0
	ret
.L8:
	mov	x2, 0
	mov	x0, 0
	b	.L3
	.cfi_endproc
.LFE39:
	.size	sum_array_c, .-sum_array_c
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"check_sum_array.c"
	.align	3
.LC1:
	.string	"sa == sum_array_c(a, n)"
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
	stp	x21, x22, [sp, 32]
	.cfi_offset 21, -32
	.cfi_offset 22, -24
	sxtw	x21, w0
	stp	x23, x24, [sp, 48]
	.cfi_offset 23, -16
	.cfi_offset 24, -8
	sub	w23, w21, #1
	mov	x24, x1
	sxtw	x22, w23
	sbfiz	x0, x23, 3, 32
	bl	malloc
	cmp	w23, 0
	ble	.L12
	add	x24, x24, 8
	sub	x21, x21, #1
	stp	x19, x20, [sp, 16]
	.cfi_offset 20, -40
	.cfi_offset 19, -48
	mov	x20, x0
	mov	x19, 0
	.p2align 3,,7
.L13:
	ldr	x0, [x24, x19, lsl 3]
	mov	w2, 10
	mov	x1, 0
	bl	strtol
	str	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	cmp	x19, x21
	bne	.L13
	mov	x1, x22
	mov	x0, x20
	bl	sum_array
	sub	x1, x22, #1
	cmp	x1, 1
	bls	.L20
	lsr	x2, x22, 1
	mov	x1, x20
	movi	v0.4s, 0
	add	x2, x20, x2, lsl 4
	.p2align 3,,7
.L17:
	ldr	q1, [x1], 16
	add	v0.2d, v0.2d, v1.2d
	cmp	x1, x2
	bne	.L17
	addp	d0, v0.2d
	and	x2, x22, -2
	fmov	x1, d0
	tbz	x23, 0, .L29
.L16:
	lsl	x3, x2, 3
	add	x2, x2, 1
	ldr	x4, [x20, x3]
	add	x1, x1, x4
	cmp	x22, x2
	ble	.L29
	add	x20, x20, x3
	ldr	x2, [x20, 8]
	ldp	x19, x20, [sp, 16]
	.cfi_restore 20
	.cfi_restore 19
	add	x1, x1, x2
.L15:
	cmp	x0, x1
	bne	.L30
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	puts
	ldp	x21, x22, [sp, 32]
	mov	w0, 0
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 21
	.cfi_restore 22
	.cfi_def_cfa_offset 0
	ret
.L29:
	.cfi_def_cfa_offset 64
	.cfi_offset 19, -48
	.cfi_offset 20, -40
	.cfi_offset 21, -32
	.cfi_offset 22, -24
	.cfi_offset 23, -16
	.cfi_offset 24, -8
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	ldp	x19, x20, [sp, 16]
	.cfi_restore 20
	.cfi_restore 19
	b	.L15
.L12:
	mov	x1, x22
	bl	sum_array
	mov	x1, 0
	b	.L15
.L20:
	.cfi_offset 19, -48
	.cfi_offset 20, -40
	mov	x1, 0
	mov	x2, 0
	b	.L16
.L30:
	.cfi_restore 19
	.cfi_restore 20
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
	add	x3, x3, :lo12:.LANCHOR0
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	mov	w2, 21
	stp	x19, x20, [sp, 16]
	.cfi_offset 20, -40
	.cfi_offset 19, -48
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

	.arch armv8-a
	.file	"check_mul_3_add_5.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"check_mul_3_add_5.c"
	.align	3
.LC1:
	.string	"argc == 2"
	.align	3
.LC2:
	.string	"OK %ld %ld\n"
	.align	3
.LC3:
	.string	"NG %ld %ld\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,11
	.global	main
	.type	main, %function
main:
.LFB39:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -16
	.cfi_offset 20, -8
	cmp	w0, 2
	bne	.L7
	mov	w20, w0
	mov	w2, 10
	ldr	x0, [x1, 8]
	mov	x1, 0
	bl	strtol
	mov	x19, x0
	bl	mul_3_add_5
	mov	x2, x0
	add	x19, x19, x19, lsl 1
	mov	w0, w20
	add	x3, x19, 5
	cmp	x2, x3
	beq	.L8
	adrp	x1, .LC3
	add	x1, x1, :lo12:.LC3
	bl	__printf_chk
.L4:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
.L8:
	.cfi_restore_state
	mov	x3, x2
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	bl	__printf_chk
	b	.L4
.L7:
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
	add	x3, x3, :lo12:.LANCHOR0
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	mov	w2, 7
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

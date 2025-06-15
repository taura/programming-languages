	.arch armv8-a
	.file	"sum_array.c"
	.text
	.align	2
	.p2align 4,,11
	.global	sum_array
	.type	sum_array, %function
sum_array:
.LFB0:
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
.LFE0:
	.size	sum_array, .-sum_array
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

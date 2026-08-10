	.text
	.global	f
f:
	stp	x29, x30, [sp, #-16]!
	mov	x29, sp
	mov	x0, #123
	b	.Lret_f
	mov	x0, #0
.Lret_f:
	mov	sp, x29
	ldp	x29, x30, [sp], #16
	ret


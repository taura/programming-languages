	.arch armv8-a
	.file	"max_array.c"
	.text
	.align	2
	.p2align 4,,11
	.global	max_array
	.type	max_array, %function
max_array:
.LFB0:
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
.LFE0:
	.size	max_array, .-max_array
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

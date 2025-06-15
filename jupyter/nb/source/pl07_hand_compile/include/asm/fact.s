	.arch armv8-a
	.file	"fact.c"
	.text
	.align	2
	.p2align 4,,11
	.global	fact
	.type	fact, %function
fact:
.LFB0:
	.cfi_startproc
	cmp	x0, 0
	ble	.L4
	add	x2, x0, 1
	mov	x0, 1
	mov	x1, x0
	.p2align 3,,7
.L3:
	mul	x0, x0, x1
	add	x1, x1, 1
	cmp	x1, x2
	bne	.L3
	ret
	.p2align 2,,3
.L4:
	mov	x0, 1
	ret
	.cfi_endproc
.LFE0:
	.size	fact, .-fact
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"ax_b.c"
	.text
	.align	2
	.p2align 4,,11
	.global	ax_b
	.type	ax_b, %function
ax_b:
.LFB0:
	.cfi_startproc
	cmp	x0, 0
	ble	.L2
	mov	x1, 0
	.p2align 3,,7
.L3:
	add	x1, x1, 1
	fmadd	d0, d1, d0, d2
	cmp	x0, x1
	bne	.L3
.L2:
	ret
	.cfi_endproc
.LFE0:
	.size	ax_b, .-ax_b
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

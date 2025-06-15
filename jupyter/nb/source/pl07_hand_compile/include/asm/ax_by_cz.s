	.arch armv8-a
	.file	"ax_by_cz.c"
	.text
	.align	2
	.p2align 4,,11
	.global	ax_by_cz
	.type	ax_by_cz, %function
ax_by_cz:
.LFB0:
	.cfi_startproc
	mul	x2, x2, x3
	madd	x0, x0, x1, x2
	madd	x0, x4, x5, x0
	ret
	.cfi_endproc
.LFE0:
	.size	ax_by_cz, .-ax_by_cz
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

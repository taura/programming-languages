	.arch armv8-a
	.file	"fmul.c"
	.text
	.align	2
	.p2align 4,,11
	.global	fmul
	.type	fmul, %function
fmul:
.LFB0:
	.cfi_startproc
	fmul	d2, d2, d3
	fmadd	d0, d0, d1, d2
	ret
	.cfi_endproc
.LFE0:
	.size	fmul, .-fmul
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

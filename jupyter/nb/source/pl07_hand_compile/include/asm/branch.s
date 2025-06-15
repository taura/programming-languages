	.arch armv8-a
	.file	"branch.c"
	.text
	.align	2
	.p2align 4,,11
	.global	g
	.type	g, %function
g:
.LFB0:
	.cfi_startproc
	cmp	x1, 5
	ble	.L3
	sub	x1, x1, #5
	sdiv	x0, x0, x1
	ret
	.p2align 2,,3
.L3:
	mov	x0, 0
	ret
	.cfi_endproc
.LFE0:
	.size	g, .-g
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

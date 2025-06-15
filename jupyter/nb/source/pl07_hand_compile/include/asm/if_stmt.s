	.arch armv8-a
	.file	"if_stmt.c"
	.text
	.align	2
	.p2align 4,,11
	.global	g
	.type	g, %function
g:
.LFB0:
	.cfi_startproc
	cmp	x0, 0
	bgt	.L7
	add	x0, x0, 123
	ret
	.p2align 2,,3
.L7:
	mov	x0, 456
	b	f
	.cfi_endproc
.LFE0:
	.size	g, .-g
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

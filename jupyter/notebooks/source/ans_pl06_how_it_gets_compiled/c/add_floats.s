	.file	"add_floats.c"
	.text
	.p2align 4
	.globl	add_floats
	.type	add_floats, @function
add_floats:
.LFB0:
	.cfi_startproc
	endbr64
	addsd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE0:
	.size	add_floats, .-add_floats
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

	.file	"get_struct_elem.c"
	.text
	.p2align 4
	.globl	get_point_y
	.type	get_point_y, @function
get_point_y:
.LFB0:
	.cfi_startproc
	endbr64
	movapd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE0:
	.size	get_point_y, .-get_point_y
	.p2align 4
	.globl	get_pointp_y
	.type	get_pointp_y, @function
get_pointp_y:
.LFB1:
	.cfi_startproc
	endbr64
	movsd	8(%rdi), %xmm0
	ret
	.cfi_endproc
.LFE1:
	.size	get_pointp_y, .-get_pointp_y
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

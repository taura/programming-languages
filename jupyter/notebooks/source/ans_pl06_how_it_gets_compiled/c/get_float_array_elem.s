	.file	"get_float_array_elem.c"
	.text
	.p2align 4
	.globl	get_float_array_elem_const
	.type	get_float_array_elem_const, @function
get_float_array_elem_const:
.LFB0:
	.cfi_startproc
	endbr64
	movsd	16(%rdi), %xmm0
	ret
	.cfi_endproc
.LFE0:
	.size	get_float_array_elem_const, .-get_float_array_elem_const
	.p2align 4
	.globl	get_float_array_elem_i
	.type	get_float_array_elem_i, @function
get_float_array_elem_i:
.LFB1:
	.cfi_startproc
	endbr64
	movsd	(%rdi,%rsi,8), %xmm0
	ret
	.cfi_endproc
.LFE1:
	.size	get_float_array_elem_i, .-get_float_array_elem_i
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

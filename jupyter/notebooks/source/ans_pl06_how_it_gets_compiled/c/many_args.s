	.file	"many_args.c"
	.text
	.p2align 4
	.globl	many_args
	.type	many_args, @function
many_args:
.LFB0:
	.cfi_startproc
	endbr64
	addq	%rsi, %rdi
	addq	%rdx, %rdi
	addq	%rcx, %rdi
	addq	%r8, %rdi
	leaq	(%rdi,%r9), %rax
	addq	8(%rsp), %rax
	addq	16(%rsp), %rax
	addq	24(%rsp), %rax
	addq	32(%rsp), %rax
	addq	40(%rsp), %rax
	addq	48(%rsp), %rax
	ret
	.cfi_endproc
.LFE0:
	.size	many_args, .-many_args
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

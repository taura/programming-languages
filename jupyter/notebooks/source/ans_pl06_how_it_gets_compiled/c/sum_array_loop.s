	.file	"sum_array_loop.c"
	.text
	.p2align 4
	.globl	sum_array_loop
	.type	sum_array_loop, @function
sum_array_loop:
.LFB0:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	jle	.L7
	cmpq	$1, %rsi
	je	.L8
	movq	%rsi, %rdx
	movq	%rdi, %rax
	pxor	%xmm0, %xmm0
	shrq	%rdx
	salq	$4, %rdx
	addq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L4:
	addsd	(%rax), %xmm0
	addq	$16, %rax
	addsd	-8(%rax), %xmm0
	cmpq	%rax, %rdx
	jne	.L4
	movq	%rsi, %rax
	andq	$-2, %rax
	andl	$1, %esi
	je	.L1
.L3:
	cltq
	addsd	(%rdi,%rax,8), %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	pxor	%xmm0, %xmm0
.L1:
	ret
.L8:
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	jmp	.L3
	.cfi_endproc
.LFE0:
	.size	sum_array_loop, .-sum_array_loop
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

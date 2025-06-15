	.arch armv8-a
	.file	"empty.c"
	.text
	.align	2
	.p2align 4,,11
	.global	aaa
	.type	aaa, %function
aaa:
.LFB0:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE0:
	.size	aaa, .-aaa
	.align	2
	.p2align 4,,11
	.global	bbb
	.type	bbb, %function
bbb:
.LFB5:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE5:
	.size	bbb, .-bbb
	.align	2
	.p2align 4,,11
	.global	ccc
	.type	ccc, %function
ccc:
.LFB7:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE7:
	.size	ccc, .-ccc
	.align	2
	.p2align 4,,11
	.global	ddd
	.type	ddd, %function
ddd:
.LFB9:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE9:
	.size	ddd, .-ddd
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

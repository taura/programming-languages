	.arch armv8-a
	.file	"normal_dist.c"
	.text
	.align	2
	.p2align 4,,11
	.global	normal_dist
	.type	normal_dist, %function
normal_dist:
.LFB0:
	.cfi_startproc
	fnmul	d0, d0, d0
	fmov	d1, 5.0e-1
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	fmul	d0, d0, d1
	bl	exp
	adrp	x0, .LC0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ldr	d1, [x0, #:lo12:.LC0]
	fdiv	d0, d0, d1
	ret
	.cfi_endproc
.LFE0:
	.size	normal_dist, .-normal_dist
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LC0:
	.word	536225541
	.word	1074007443
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

	.arch armv8-a
	.file	"args_mixed_many.c"
	.text
	.align	2
	.p2align 4,,11
	.global	gg
	.type	gg, %function
gg:
.LFB0:
	.cfi_startproc
	stp	d8, d9, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 72, -16
	.cfi_offset 73, -8
	movi	d8, #0
	ldr	d16, [x0]
	ldr	d18, [x1]
	ldr	d17, [x2]
	fadd	d16, d16, d8
	ldr	d9, [x3]
	ldr	d8, [x4]
	ldr	d29, [x6]
	ldr	d28, [x7]
	fadd	d16, d16, d0
	ldr	d0, [x5]
	ldr	x0, [sp, 16]
	ldr	d26, [sp, 24]
	fadd	d16, d16, d18
	ldr	d25, [sp, 40]
	ldr	d27, [x0]
	ldr	x1, [sp, 32]
	fadd	d16, d16, d1
	ldr	d23, [sp, 56]
	ldr	x0, [sp, 48]
	ldr	d30, [x1]
	fadd	d16, d16, d17
	ldr	d22, [sp, 72]
	ldr	d24, [x0]
	ldr	x0, [sp, 64]
	fadd	d16, d16, d2
	ldr	d21, [sp, 88]
	ldr	x5, [sp, 80]
	ldr	d31, [x0]
	fadd	d16, d16, d9
	ldr	d20, [sp, 104]
	ldr	x4, [sp, 96]
	ldr	x3, [sp, 112]
	fadd	d16, d16, d3
	ldr	d18, [sp, 120]
	ldr	x2, [sp, 128]
	fadd	d16, d16, d8
	ldr	d17, [sp, 136]
	ldr	d3, [sp, 152]
	ldr	x1, [sp, 144]
	fadd	d16, d16, d4
	ldr	d9, [x5]
	ldr	d8, [x4]
	ldr	d19, [x3]
	ldr	d4, [x1]
	fadd	d16, d16, d0
	ldr	d1, [sp, 168]
	ldr	x0, [sp, 160]
	fadd	d16, d16, d5
	ldr	d5, [x2]
	ldr	d2, [x0]
	fadd	d16, d16, d29
	fadd	d16, d16, d6
	fadd	d16, d16, d28
	fadd	d0, d16, d7
	fadd	d0, d0, d27
	fadd	d0, d0, d26
	fadd	d0, d0, d30
	fadd	d0, d0, d25
	fadd	d0, d0, d24
	fadd	d0, d0, d23
	fadd	d0, d0, d31
	fadd	d0, d0, d22
	fadd	d0, d0, d9
	fadd	d0, d0, d21
	fadd	d0, d0, d8
	ldp	d8, d9, [sp], 16
	.cfi_restore 73
	.cfi_restore 72
	.cfi_def_cfa_offset 0
	fadd	d0, d0, d20
	fadd	d0, d0, d19
	fadd	d0, d0, d18
	fadd	d0, d0, d5
	fadd	d0, d0, d17
	fadd	d0, d0, d4
	fadd	d0, d0, d3
	fadd	d0, d0, d2
	fadd	d0, d0, d1
	ret
	.cfi_endproc
.LFE0:
	.size	gg, .-gg
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

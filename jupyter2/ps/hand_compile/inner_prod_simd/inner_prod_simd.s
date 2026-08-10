	.arch armv8-a
	.file	"inner_prod_simd.c"
	.text
	.align	2
	.p2align 4,,11
	.global	inner_prod_simd
	.type	inner_prod_simd, %function
inner_prod_simd:
.LFB0:
	.cfi_startproc
	// ------- write your answer here -------
	// hint: accumulate two products at a time in a v-register, e.g.
	//   ld1  {v1.2d}, [x0], #16     // p[i], p[i+1]; advance x0
	//   ld1  {v2.2d}, [x1], #16     // q[i], q[i+1]; advance x1
	//   fmla v0.2d, v1.2d, v2.2d    // v0 += p*q, lane-wise (fused multiply-add)
	// then reduce the two lanes at the end with:  faddp d0, v0.2d
	// don't forget the tail element when n is odd.
	.cfi_endproc
.LFE0:
	.size	inner_prod_simd, .-inner_prod_simd
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits

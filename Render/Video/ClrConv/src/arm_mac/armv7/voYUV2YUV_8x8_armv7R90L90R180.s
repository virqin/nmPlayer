	@AREA	|.text|, CODE, READONLY
	#include "voYYDef_CC.h"
	.text
	
	.align 2
	.globl	_cc_yuv2yuv_8x8_L90_armv7
	.globl	_cc_yuv2yuv_8x8_R90_armv7
	.globl	_cc_yuv2yuv_8x8_R180_armv7		

	
  .macro Transpose_L90
		ldr		r4, [sp, #36]
		ldr		r5, [sp, #40]
		vld1.64	{d4}, [r0], r3
		vld1.64	{d5}, [r0], r3		
		vld1.64	{d6}, [r0], r3
		vld1.64	{d7}, [r0], r3
		vld1.64	{d8}, [r0], r3
		vld1.64	{d9}, [r0], r3
		vld1.64	{d12}, [r0], r3
		vld1.64	{d13}, [r0]		

		vld1.32	{d30[0]}, [r1], r4
		vld1.32	{d30[1]}, [r2], r5						
		vld1.32	{d31[0]}, [r1], r4
		vld1.32	{d31[1]}, [r2], r5				
		vld1.32	{d10[0]}, [r1], r4
		vld1.32	{d10[1]}, [r2], r5
		vld1.32	{d11[0]}, [r1]
		vld1.32	{d11[1]}, [r2]
		  
		ldr		r7, [sp, #44]	@ r7 = dsty		
		ldr		r2, [sp, #48]	@ r2 = dstu		
		ldr		r0, [sp, #52]	@ r0 = dstv		
	@	Transpose
@START L90	
@y	
		vtrn.8 d4, d5
		vtrn.8 d6, d7
		vtrn.8 d8, d9
		vtrn.8 d12, d13
		
		vtrn.16 d4, d6
		vtrn.16 d5, d7
		vtrn.16 d8, d12
		vtrn.16 d9, d13
		
		vtrn.32 d4, d8
		vtrn.32 d5, d9
		vtrn.32 d6, d12
		vtrn.32 d7, d13	
		@d13, d12, d9, d8, d7, d6, d5, d4
		
@uv		
		vtrn.8 d30, d31
		vtrn.8 d10, d11
		
		vtrn.16 d30, d10
		vtrn.16 d31, d11
		@u = d11[0] d10[0] d31[0] d30[0]
		@v = d11[1] d10[1] d31[1] d30[1]				
@END L90		
		

@ STRAT TO STORE
		vst1.64	{d13}, [r7]!
		vst1.64	{d12}, [r7]!
		vst1.64	{d9}, [r7]!
		vst1.64	{d8}, [r7]!
		vst1.64	{d7}, [r7]!
		vst1.64	{d6}, [r7]!
		vst1.64	{d5}, [r7]!												
		vst1.64	{d4}, [r7]!		
		
		@q2, q3, q4, q6, q15, q5	
		vst1.32	{d11[0]}, [r2]!
		vst1.32	{d11[1]}, [r0]!						
		vst1.32	{d10[0]}, [r2]!
		vst1.32	{d10[1]}, [r0]!				
		vst1.32	{d31[0]}, [r2]!
		vst1.32	{d31[1]}, [r0]!
		vst1.32	{d30[0]}, [r2]!
		vst1.32	{d30[1]}, [r0]!
  .endmacro

	
  .macro  Transpose_R90
		ldr		r4, [sp, #36]
		ldr		r5, [sp, #40]
		vld1.64	{d4}, [r0], r3
		vld1.64	{d5}, [r0], r3		
		vld1.64	{d6}, [r0], r3
		vld1.64	{d7}, [r0], r3
		vld1.64	{d8}, [r0], r3
		vld1.64	{d9}, [r0], r3
		vld1.64	{d12}, [r0], r3
		vld1.64	{d13}, [r0]		

		vld1.32	{d30[0]}, [r1], r4
		vld1.32	{d30[1]}, [r2], r5						
		vld1.32	{d31[0]}, [r1], r4
		vld1.32	{d31[1]}, [r2], r5				
		vld1.32	{d10[0]}, [r1], r4
		vld1.32	{d10[1]}, [r2], r5
		vld1.32	{d11[0]}, [r1]
		vld1.32	{d11[1]}, [r2]
		  
		ldr		r7, [sp, #44]	@ r7 = dsty		
		ldr		r2, [sp, #48]	@ r2 = dstu		
		ldr		r0, [sp, #52]	@ r0 = dstv		
	@	Transpose
@START L90	
@y	
		vtrn.8 d4, d5
		vtrn.8 d6, d7
		vtrn.8 d8, d9
		vtrn.8 d12, d13
		
		vtrn.16 d4, d6
		vtrn.16 d5, d7
		vtrn.16 d8, d12
		vtrn.16 d9, d13
		
		vtrn.32 d4, d8
		vtrn.32 d5, d9
		vtrn.32 d6, d12
		vtrn.32 d7, d13	
		@d13, d12, d9, d8, d7, d6, d5, d4
		
@uv		
		vtrn.8 d30, d31
		vtrn.8 d10, d11
		
		vtrn.16 d30, d10
		vtrn.16 d31, d11
		@u = d11[0] d10[0] d31[0] d30[0]
		@v = d11[1] d10[1] d31[1] d30[1]				
@END L90

@START R90
		vrev64.8 q2, q2
		vrev64.8 q3, q3
		vrev64.8 q4, q4
		vrev64.8 q6, q6
		@d4, d5, d6, d7, d8, d9, d12, d13
		
		vrev32.8 q15, q15
		vrev32.8 q5, q5
		@u = d30[0] d31[0] d10[0] d11[0]
		@v = d30[1] d31[1] d10[1] d11[1]		
@END R90

@ STRAT TO STORE
		
		vst1.64	{q2}, [r7]!
		vst1.64	{q3}, [r7]!
		vst1.64	{q4}, [r7]!
		vst1.64	{q6}, [r7]!
		@q2, q3, q4, q6, q15, q5	
		vst1.32	{d30[0]}, [r2]!
		vst1.32	{d30[1]}, [r0]!						
		vst1.32	{d31[0]}, [r2]!
		vst1.32	{d31[1]}, [r0]!				
		vst1.32	{d10[0]}, [r2]!
		vst1.32	{d10[1]}, [r0]!
		vst1.32	{d11[0]}, [r2]!
		vst1.32	{d11[1]}, [r0]!
  .endmacro
  
  .macro  Transpose_R180
		ldr		r4, [sp, #36]
		ldr		r5, [sp, #40]
		vld1.64	{d4}, [r0], r3
		vld1.64	{d5}, [r0], r3		
		vld1.64	{d6}, [r0], r3
		vld1.64	{d7}, [r0], r3
		vld1.64	{d8}, [r0], r3
		vld1.64	{d9}, [r0], r3
		vld1.64	{d12}, [r0], r3
		vld1.64	{d13}, [r0]		

		vld1.32	{d30[0]}, [r1], r4
		vld1.32	{d30[1]}, [r2], r5						
		vld1.32	{d31[0]}, [r1], r4
		vld1.32	{d31[1]}, [r2], r5				
		vld1.32	{d10[0]}, [r1], r4
		vld1.32	{d10[1]}, [r2], r5
		vld1.32	{d11[0]}, [r1]
		vld1.32	{d11[1]}, [r2]
		  
		ldr		r7, [sp, #44]	@ r7 = dsty		
		ldr		r2, [sp, #48]	@ r2 = dstu		
		ldr		r0, [sp, #52]	@ r0 = dstv
				
	@	Transpose
@START 	R180
		vrev64.8 q6, q6
		.if $0>2		
		vrev64.8 q4, q4	
		.if $0>4		
		vrev64.8 q3, q3	
		.if $0>6				
		vrev64.8 q2, q2
		@d13, d12, d9, d8, d7, d6, d5, d4
		.endif
		.endif
		.endif
		
		vrev32.8 q5, q5				
		.if $0>4		
		vrev32.8 q15, q15
		.endif		
		@u = d11[0] d10[0] d31[0] d30[0]
		@v = d11[1] d10[1] d31[1] d30[1]
@END R180
@ STRAT TO STORE

		vst1.64	{d13}, [r7]!
		vst1.64	{d12}, [r7]!
		vst1.64	{d9}, [r7]!
		vst1.64	{d8}, [r7]!		
		vst1.64	{d7}, [r7]!
		vst1.64	{d6}, [r7]!						
		vst1.64	{d5}, [r7]!												
		vst1.64	{d4}, [r7]!

		@q2, q3, q4, q6, q15, q5	

		vst1.32	{d11[0]}, [r2]!
		vst1.32	{d11[1]}, [r0]!
		vst1.32	{d10[0]}, [r2]!
		vst1.32	{d10[1]}, [r0]!	
		vst1.32	{d31[0]}, [r2]!
		vst1.32	{d31[1]}, [r0]!								
		vst1.32	{d30[0]}, [r2]!
		vst1.32	{d30[1]}, [r0]!		
  .endmacro
  
  
@		r0 = y
@		r1 = u
@		r2 = v
@		r3 = in_stride
@		r4 = uin_stride		ldr		r4, [sp, #36]
@		r5 = vin_stride		ldr		r5, [sp, #40]
@		r6 = dsty		ldr		r6, [sp, #44]
@		r7 = dstu		ldr		r7, [sp, #48]
@		r8 = dstv		ldr		r8, [sp, #52]  
@cc_yuv2yuv_8x8_R90_armv7(y, u, v, 
@in_stride, uin_stride, vin_stride, dsty, dstu, dstv)@

_cc_yuv2yuv_8x8_R90_armv7:
		stmdb	sp!, {r4-r11, lr}		@save regs used
		
		Transpose_R90
		
		ldmia	sp!, {r4-r11, pc}		@ restore and return
		
_cc_yuv2yuv_8x8_L90_armv7:
		stmdb	sp!, {r4-r11, lr}		@save regs used
		
		Transpose_L90
		
		ldmia	sp!, {r4-r11, pc}		@ restore and return
		
_cc_yuv2yuv_8x8_R180_armv7:
		stmdb	sp!, {r4-r11, lr}		@save regs used
		
		Transpose_R180 8
		
		ldmia	sp!, {r4-r11, pc}		@ restore and return								
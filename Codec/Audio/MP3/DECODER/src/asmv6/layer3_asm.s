	AREA	|.rdata|, DATA, READONLY, ALIGN = 4
|csa_table|
	DCD 0x36e12a00	
	DCD 0xdf128041	
	DCD 0x15f3aa41	
	DCD 0xa8315641	
	DCD 0x386e7600	
	DCD 0xe1cf24a1	
	DCD 0x1a3d9aa1	
	DCD 0xa960aea1	
	DCD 0x3cc6b740	
	DCD 0xebf19fa1	
	DCD 0x28b856e1	
	DCD 0xaf2ae861	
	DCD 0x3eeea040	
	DCD 0xf45b88c1	
	DCD 0x334a2901	
	DCD 0xb56ce881	
	DCD 0x3fb69040	
	DCD 0xf9f27f19	
	DCD 0x39a90f59	
	DCD 0xba3beed9	
	DCD 0x3ff23f40	
	DCD 0xfd60d1e5	
	DCD 0x3d531125	
	DCD 0xbd6e92a5	
	DCD 0x3ffe5940	
	DCD 0xff175ee4	
	DCD 0x3f15b824	
	DCD 0xbf1905a4	
	DCD 0x3fffe340	
	DCD 0xffc3612f	
	DCD 0x3fc3446f	
	DCD 0xbfc37def	

	EXPORT	|voMP3Decidct9|
	AREA	|.text|, CODE, READONLY

|voMP3Decidct9|	PROC
	stmdb   sp!, {r4 - r11, lr}
	sub     sp, sp, #12
|$M2844|
	mov		r14, r0
	ldr		r0, [r14, #0]
	ldr     r1, [r14, #4]                      
	ldr     r2, [r14, #8]   
	ldr     r3, [r14, #12]   
	ldr     r4, [r14, #16]   
	ldr     r5, [r14, #20]   
	ldr     r6, [r14, #24]   
	ldr     r7, [r14, #28]   
	ldr     r8, [r14, #32]   
	sub     r9, r0, r6					; a1 = x0 - x6;       
    sub     r10, r1, r5                 ; a2 = x1 - x5;  
    str		r14, [r13, #4]
	add     r11, r1, r5                 ; a3 = x1 + x5; 
    sub     r12, r2, r4                 ; a4 = x2 - x4;
    add     r5, r2, r4                  ; a5 = x2 + x4;
	str		r9, [r13, #8]  
    add     r14, r2, r8                 ; a6 = x2 + x8;  
    add     r4, r1, r7                  ; a7 = x1 + x7;  
    sub     r2, r14, r5                 ; a8 = a6 - a5; 
    add     r1, r0, r6, asr #1          ; a12 = x0 + (x6 >> 1);	 
    sub     r10, r10, r7                ; a10 = a2 - x7; 
    sub     r6, r11, r4                 ; a9 = a3 - a7;  
    ldr     r0, |$L2848|                ; c9_0
	sub     r12, r12, r8                ; a11 = a4 - x8;  
    smmul	r3, r0, r3					; m1 =  MUL_32(c9_0, x3);
	ldr		r7, |$L2848| + 4			; c9_1
	smmul	r10, r0, r10				; m3 =  MUL_32(c9_0, a10);
	smmul	r2, r7, r2					; m7 =  MUL_32(c9_1, a8);
	ldr		r8, |$L2848| + 8			; c9_2
	smmul 	r7, r5, r7					; m5 =  MUL_32(c9_1, a5);
	smmul	r14, r8, r14				; m6 =  MUL_32(c9_2, a6);
	ldr		r9, |$L2848| + 12			; c9_3
	smmul	r5, r8, r5					; m8 =  MUL_32(c9_2, a5);
	add		r7, r7, r14					; m5 + m6;
	smmul	r11, r9, r11				; m11 = MUL_32(c9_3, a3);
	mov		r7, r7, lsl #1				; a16 = ( m5 + m6 ) << 1;
	ldr		r14, |$L2848| + 16			; c9_4
	smmul	r9, r6, r9					; m9 =  MUL_32(c9_3, a9);
	sub		r2, r2, r5					; m7 - m8;
	smmul	r4, r14, r4			    	; m10 = MUL_32(c9_4, a7);
	mov		r2, r2, lsl #1				; a17 = ( m7 - m8 ) << 1;
	smmul	r14, r6, r14				; m12 = MUL_32(c9_4, a9);
	add		r9, r9, r4					; (m9 + m10);
	sub		r8, r1, r3, lsl #1			; a14 = a12  -  (  m1 << 1);
	add		r3,	r1, r3, lsl #1			; a13 = a12  +  (  m1 << 1);		
	sub		r11, r11, r14				; (m11 - m12);
	mov		r9, r9, lsl #1				; a19 = ( m9 + m10) << 1;
	mov		r11, r11, lsl #1			; a20 = (m11 - m12) << 1;
	add		r4,	r3, r7					; a22 = a13 + a16;
	add		r14, r8, r7     			; a23 = a14 + a16;
	add		r7, r7, r2					; a18 = a16 + a17;
	add		r5,	r8, r2					; a24 = a14 + a17;
	add		r2, r3, r2					; a25 = a13 + a17;
	ldr		r1, [r13, #8] 
	sub		r8, r8, r7					; a26 = a14 - a18;
	sub		r3, r3, r7					; a27 = a13 - a18;
	add		r7, r1, r12, asr #1			; a15 = a1   +  ( a11 >> 1);
	ldr		r0, [r13, #4] 
	sub		r12, r1, r12                ; x4 = a1 - a11;			x[4] = x4;
	add		r1, r4, r9					; x0 = a22 + a19;			x[0] = x0;
	add		r6, r7, r10, lsl #1			; x1 = a15 + (m3 << 1);		x[1] = x1;
	str     r1, [r0, #0]   
	str		r6, [r0, #4]
	add		r1, r5, r11					; x2 = a24 + a20;			x[2] = x2;
	sub		r6, r11, r9 				; a21 = a20 - a19;
	str		r1, [r0, #8]				
	add		r3, r3, r6					; x5 = a27 + a21;			x[5] = x5;
	sub		r6, r8,	r6					; x3 = a26 - a21;			x[3] = x3;
	sub		r2, r2, r11					; x6 = a25 - a20;			x[6] = x6;
	str		r6, [r0, #12]
	str		r12, [r0, #16]
	str		r3, [r0, #20]
	sub		r7, r7, r10, lsl #1			; x7 = a15 - (m3 << 1);	x[7] = x7;
	str		r2, [r0, #24]	
	sub		r6, r14, r9					; x8 = a23 - a19;			x[8] = x8;
	str		r7, [r0, #28]
	str		r6, [r0, #32]

	add     sp, sp, #12
	ldmia   sp!, {r4 - r11, pc}
|$L2848|
	DCD     0x6ed9eba1
    DCD     0x620dbe8b
    DCD     0x163a1a7e
    DCD     0x5246dd49
    DCD     0x7e0e2e32
|$M2845|
	ENDP  ; |voMP3Decidct9|



	EXPORT	|AliasReduce|
	AREA	|.text|, CODE, READONLY

|AliasReduce| PROC
	stmdb     sp!, {r4 - r11, lr}
|$M2693|
	mov		  r11, r1
	add		  r10, r0, #72
    cmp		  r1, #0      
	ble       |$L1604|

	ldr		  r12, 	|$L2697|

	;#define INT_AA(j) \
    ;        tmp0 = ptr[-1-j];\
    ;        tmp1 = ptr[   j];\
    ;        tmp2= MUL_32(tmp0 + tmp1, csa[0+4*j]);\
    ;        ptr[-1-j] = 4*(tmp2 - MUL_32(tmp1, csa[2+4*j]));\
    ;        ptr[   j] = 4*(tmp2 + MUL_32(tmp0, csa[3+4*j]));

|$L2691|
    ;  INT_AA(0)
    ;  INT_AA(1)	
	ldrd	  r0, [r10, #-8]
	ldrd	  r2, [r10, #0]			
	ldr  	  r4, [r12, #0]
	add		  r8, r2, r1
	ldrd	  r6, [r12, #8]	

	smmul	  r5, r8, r4
	add		  r8, r0, r3
	ldr		  r4, [r12, #16]	
	smmls	  r9, r6, r2, r5
	smmla	  r2, r7, r1, r5
	smmul	  r14, r8, r4
	ldrd	  r6, [r12, #24]
	mov		  r1, r9, lsl #2
	smmls	  r8, r6, r3, r14
	mov		  r2, r2, lsl #2
	smmla	  r3, r7, r0, r14				
	mov		  r0, r8, lsl #2
	mov		  r3, r3, lsl #2	
	
	strd	  r0, [r10, #-8]
	strd	  r2, [r10, #0]		
	
	;  INT_AA(2)
    ;  INT_AA(3)	
	ldrd	  r0, [r10, #-16]
	ldrd	  r2, [r10, #8]			
	ldr	      r4, [r12, #32]
	add		  r8, r2, r1
	ldrd	  r6, [r12, #40]	

	smmul	  r5, r8, r4
	add		  r8, r0, r3
	ldr		  r4, [r12, #48]	
	smmls	  r9, r6, r2, r5
	smmla	  r2, r7, r1, r5
	smmul	  r14, r8, r4
	ldrd	  r6, [r12, #56]
	mov		  r1, r9, lsl #2
	smmls	  r8, r6, r3, r14
	mov		  r2, r2, lsl #2
	smmla	  r3, r7, r0, r14				
	mov		  r0, r8, lsl #2
	mov		  r3, r3, lsl #2
	
	strd	  r0, [r10, #-16]
	strd	  r2, [r10, #8]		
	
	;  INT_AA(4)
    ;  INT_AA(5)	
	ldrd	  r0, [r10, #-24]
	ldrd	  r2, [r10, #16]			
	ldr 	  r4, [r12, #64]
	add		  r8, r2, r1
	ldrd	  r6, [r12, #72]	

	smmul	  r5, r8, r4
	add		  r8, r0, r3
	ldr		  r4, [r12, #80]	
	smmls	  r9, r6, r2, r5
	smmla	  r2, r7, r1, r5
	smmul	  r14, r8, r4
	ldrd	  r6, [r12, #88]
	mov		  r1, r9, lsl #2
	smmls	  r8, r6, r3, r14
	mov		  r2, r2, lsl #2
	smmla	  r3, r7, r0, r14				
	mov		  r0, r8, lsl #2
	mov		  r3, r3, lsl #2
	
	strd	  r0, [r10, #-24]
	strd	  r2, [r10, #16]		
	
	sub		  r11, r11, #1	
	;  INT_AA(6)
    ;  INT_AA(7)	
	ldrd	  r0, [r10, #-32]
	ldrd	  r2, [r10, #24]			
	ldr 	  r4, [r12, #96]
	add		  r8, r2, r1
	ldrd	  r6, [r12, #104]	

	smmul	  r5, r8, r4
	add		  r8, r0, r3
	ldr		  r4, [r12, #112]	
	smmls	  r9, r6, r2, r5
	smmla	  r2, r7, r1, r5
	ldrd	  r6, [r12, #120]
	smmul	  r14, r8, r4
	mov		  r1, r9, lsl #2
	smmls	  r8, r6, r3, r14
	mov		  r2, r2, lsl #2
	smmla	  r3, r7, r0, r14				
	mov		  r0, r8, lsl #2
	mov		  r3, r3, lsl #2

	strd	  r0, [r10, #-32]
	strd	  r2, [r10, #24]		

	cmp       r11, #0
	add       r10, r10, #0x48
	bhi       |$L2691|
|$L1604|

	ldmia     sp!, {r4 - r11, pc}
|$L2697|
	DCD		  |csa_table|

|$M2694|
	ENDP  ; |AliasReduce|

	END

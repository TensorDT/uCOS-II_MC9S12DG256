   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
  73                     ; 53 _NEAR void  OSTimeDly (INT32U ticks)
  73                     ; 54 {
  74                     	switch	.text
  75  0000               _OSTimeDly:
  77  0000 3b            	pshd	
  78  0001 34            	pshx	
  79  0002 3b            	pshd	
  80       00000002      OFST:	set	2
  83                     ; 57     OS_CPU_SR  cpu_sr = 0u;
  85                     ; 62     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
  87  0003 f60000        	ldab	_OSIntNesting
  88  0006 2605          	bne	L01
  89                     ; 63         return;
  91                     ; 65     if (OSLockNesting > 0u) {                    /* See if called with scheduler locked                */
  93  0008 f60000        	ldab	_OSLockNesting
  94  000b 2703          	beq	L33
  95                     ; 66         return;
  96  000d               L01:
  99  000d 1b86          	leas	6,s
 100  000f 3d            	rts	
 101  0010               L33:
 102                     ; 68     if (ticks > 0u) {                            /* 0 means no delay!                                  */
 104  0010 ec82          	ldd	OFST+0,s
 105  0012 2604          	bne	LC001
 106  0014 ec84          	ldd	OFST+2,s
 107  0016 27f5          	beq	L01
 108  0018               LC001:
 109                     ; 69         OS_ENTER_CRITICAL();
 111  0018 160000        	jsr	_OS_CPU_SR_Save
 113  001b 6b81          	stab	OFST-1,s
 114                     ; 70         y            =  OSTCBCur->OSTCBY;        /* Delay current task                                 */
 116  001d fd0000        	ldy	_OSTCBCur
 117  0020 e6e826        	ldab	38,y
 118  0023 6b80          	stab	OFST-2,s
 119                     ; 71         OSRdyTbl[y] &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
 121  0025 b796          	exg	b,y
 122  0027 fe0000        	ldx	_OSTCBCur
 123  002a e6e027        	ldab	39,x
 124  002d 51            	comb	
 125  002e e4ea0000      	andb	_OSRdyTbl,y
 126  0032 6bea0000      	stab	_OSRdyTbl,y
 127                     ; 73         if (OSRdyTbl[y] == 0u) {
 130  0036 260c          	bne	L73
 131                     ; 74             OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
 133  0038 b756          	tfr	x,y
 134  003a e6e828        	ldab	40,y
 135  003d 51            	comb	
 136  003e f40000        	andb	_OSRdyGrp
 137  0041 7b0000        	stab	_OSRdyGrp
 138  0044               L73:
 139                     ; 76         OSTCBCur->OSTCBDly = ticks;              /* Load ticks in TCB                                  */
 141  0044 b756          	tfr	x,y
 142  0046 ec84          	ldd	OFST+2,s
 143  0048 6ce820        	std	32,y
 144  004b ec82          	ldd	OFST+0,s
 145  004d 6ce81e        	std	30,y
 146                     ; 78         OS_EXIT_CRITICAL();
 149  0050 e681          	ldab	OFST-1,s
 150  0052 87            	clra	
 151  0053 160000        	jsr	_OS_CPU_SR_Restore
 153                     ; 79         OS_Sched();                              /* Find next task to run!                             */
 155  0056 160000        	jsr	_OS_Sched
 157                     ; 81 }
 159  0059 20b2          	bra	L01
 200                     ; 237 _NEAR INT32U  OSTimeGet (void)
 200                     ; 238 {
 201                     	switch	.text
 202  005b               _OSTimeGet:
 204  005b 1b9b          	leas	-5,s
 205       00000005      OFST:	set	5
 208                     ; 241     OS_CPU_SR  cpu_sr = 0u;
 210                     ; 246     OS_ENTER_CRITICAL();
 212  005d 160000        	jsr	_OS_CPU_SR_Save
 214  0060 6b80          	stab	OFST-5,s
 215                     ; 247     ticks = OSTime;
 217  0062 fc0002        	ldd	_OSTime+2
 218  0065 6c83          	std	OFST-2,s
 219  0067 fc0000        	ldd	_OSTime
 220  006a 6c81          	std	OFST-4,s
 221                     ; 248     OS_EXIT_CRITICAL();
 223  006c e680          	ldab	OFST-5,s
 224  006e 87            	clra	
 225  006f 160000        	jsr	_OS_CPU_SR_Restore
 227                     ; 249     return (ticks);
 229  0072 ec83          	ldd	OFST-2,s
 230  0074 ee81          	ldx	OFST-4,s
 233  0076 1b85          	leas	5,s
 234  0078 3d            	rts	
 275                     ; 267 _NEAR void  OSTimeSet (INT32U ticks)
 275                     ; 268 {
 276                     	switch	.text
 277  0079               _OSTimeSet:
 279  0079 3b            	pshd	
 280  007a 34            	pshx	
 281  007b 37            	pshb	
 282       00000001      OFST:	set	1
 285                     ; 270     OS_CPU_SR  cpu_sr = 0u;
 287                     ; 275     OS_ENTER_CRITICAL();
 289  007c 160000        	jsr	_OS_CPU_SR_Save
 291  007f 6b80          	stab	OFST-1,s
 292                     ; 276     OSTime = ticks;
 294  0081 1805830002    	movw	OFST+2,s,_OSTime+2
 295  0086 1805810000    	movw	OFST+0,s,_OSTime
 296                     ; 277     OS_EXIT_CRITICAL();
 298  008b 87            	clra	
 299  008c 160000        	jsr	_OS_CPU_SR_Restore
 301                     ; 278 }
 304  008f 1b85          	leas	5,s
 305  0091 3d            	rts	
 317                     	xref	_OS_Sched
 318                     	xdef	_OSTimeSet
 319                     	xdef	_OSTimeGet
 320                     	xdef	_OSTimeDly
 321                     	xref	_OSTime
 322                     	xref	_OSTCBCur
 323                     	xref	_OSRdyTbl
 324                     	xref	_OSRdyGrp
 325                     	xref	_OSLockNesting
 326                     	xref	_OSIntNesting
 327                     	xref	_OS_CPU_SR_Restore
 328                     	xref	_OS_CPU_SR_Save
 348                     	end

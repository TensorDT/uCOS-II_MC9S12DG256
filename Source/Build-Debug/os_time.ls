   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4040                     ; 53 _NEAR void  OSTimeDly (INT32U ticks)
4040                     ; 54 {
4041                     	switch	.text
4042  0000               _OSTimeDly:
4044  0000 3b            	pshd	
4045  0001 34            	pshx	
4046  0002 3b            	pshd	
4047       00000002      OFST:	set	2
4050                     ; 57     OS_CPU_SR  cpu_sr = 0u;
4052                     ; 62     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
4054  0003 f60000        	ldab	_OSIntNesting
4055  0006 2605          	bne	L01
4056                     ; 63         return;
4058                     ; 65     if (OSLockNesting > 0u) {                    /* See if called with scheduler locked                */
4060  0008 f60000        	ldab	_OSLockNesting
4061  000b 2703          	beq	L3762
4062                     ; 66         return;
4063  000d               L01:
4066  000d 1b86          	leas	6,s
4067  000f 3d            	rts	
4068  0010               L3762:
4069                     ; 68     if (ticks > 0u) {                            /* 0 means no delay!                                  */
4071  0010 ec82          	ldd	OFST+0,s
4072  0012 2604          	bne	LC001
4073  0014 ec84          	ldd	OFST+2,s
4074  0016 27f5          	beq	L01
4075  0018               LC001:
4076                     ; 69         OS_ENTER_CRITICAL();
4078  0018 160000        	jsr	_OS_CPU_SR_Save
4080  001b 6b81          	stab	OFST-1,s
4081                     ; 70         y            =  OSTCBCur->OSTCBY;        /* Delay current task                                 */
4083  001d fd0000        	ldy	_OSTCBCur
4084  0020 e6e826        	ldab	38,y
4085  0023 6b80          	stab	OFST-2,s
4086                     ; 71         OSRdyTbl[y] &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
4088  0025 b796          	exg	b,y
4089  0027 fe0000        	ldx	_OSTCBCur
4090  002a e6e027        	ldab	39,x
4091  002d 51            	comb	
4092  002e e4ea0000      	andb	_OSRdyTbl,y
4093  0032 6bea0000      	stab	_OSRdyTbl,y
4094                     ; 73         if (OSRdyTbl[y] == 0u) {
4097  0036 260c          	bne	L7762
4098                     ; 74             OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
4100  0038 b756          	tfr	x,y
4101  003a e6e828        	ldab	40,y
4102  003d 51            	comb	
4103  003e f40000        	andb	_OSRdyGrp
4104  0041 7b0000        	stab	_OSRdyGrp
4105  0044               L7762:
4106                     ; 76         OSTCBCur->OSTCBDly = ticks;              /* Load ticks in TCB                                  */
4108  0044 b756          	tfr	x,y
4109  0046 ec84          	ldd	OFST+2,s
4110  0048 6ce820        	std	32,y
4111  004b ec82          	ldd	OFST+0,s
4112  004d 6ce81e        	std	30,y
4113                     ; 78         OS_EXIT_CRITICAL();
4116  0050 e681          	ldab	OFST-1,s
4117  0052 87            	clra	
4118  0053 160000        	jsr	_OS_CPU_SR_Restore
4120                     ; 79         OS_Sched();                              /* Find next task to run!                             */
4122  0056 160000        	jsr	_OS_Sched
4124                     ; 81 }
4126  0059 20b2          	bra	L01
4167                     ; 237 _NEAR INT32U  OSTimeGet (void)
4167                     ; 238 {
4168                     	switch	.text
4169  005b               _OSTimeGet:
4171  005b 1b9b          	leas	-5,s
4172       00000005      OFST:	set	5
4175                     ; 241     OS_CPU_SR  cpu_sr = 0u;
4177                     ; 246     OS_ENTER_CRITICAL();
4179  005d 160000        	jsr	_OS_CPU_SR_Save
4181  0060 6b80          	stab	OFST-5,s
4182                     ; 247     ticks = OSTime;
4184  0062 fc0002        	ldd	_OSTime+2
4185  0065 6c83          	std	OFST-2,s
4186  0067 fc0000        	ldd	_OSTime
4187  006a 6c81          	std	OFST-4,s
4188                     ; 248     OS_EXIT_CRITICAL();
4190  006c e680          	ldab	OFST-5,s
4191  006e 87            	clra	
4192  006f 160000        	jsr	_OS_CPU_SR_Restore
4194                     ; 249     return (ticks);
4196  0072 ec83          	ldd	OFST-2,s
4197  0074 ee81          	ldx	OFST-4,s
4200  0076 1b85          	leas	5,s
4201  0078 3d            	rts	
4242                     ; 267 _NEAR void  OSTimeSet (INT32U ticks)
4242                     ; 268 {
4243                     	switch	.text
4244  0079               _OSTimeSet:
4246  0079 3b            	pshd	
4247  007a 34            	pshx	
4248  007b 37            	pshb	
4249       00000001      OFST:	set	1
4252                     ; 270     OS_CPU_SR  cpu_sr = 0u;
4254                     ; 275     OS_ENTER_CRITICAL();
4256  007c 160000        	jsr	_OS_CPU_SR_Save
4258  007f 6b80          	stab	OFST-1,s
4259                     ; 276     OSTime = ticks;
4261  0081 1805830002    	movw	OFST+2,s,_OSTime+2
4262  0086 1805810000    	movw	OFST+0,s,_OSTime
4263                     ; 277     OS_EXIT_CRITICAL();
4265  008b 87            	clra	
4266  008c 160000        	jsr	_OS_CPU_SR_Restore
4268                     ; 278 }
4271  008f 1b85          	leas	5,s
4272  0091 3d            	rts	
4284                     	xref	_OS_Sched
4285                     	xdef	_OSTimeSet
4286                     	xdef	_OSTimeGet
4287                     	xdef	_OSTimeDly
4288                     	xref	_OSTime
4289                     	xref	_OSTCBCur
4290                     	xref	_OSRdyTbl
4291                     	xref	_OSRdyGrp
4292                     	xref	_OSLockNesting
4293                     	xref	_OSIntNesting
4294                     	xref	_OS_CPU_SR_Restore
4295                     	xref	_OS_CPU_SR_Save
4315                     	end

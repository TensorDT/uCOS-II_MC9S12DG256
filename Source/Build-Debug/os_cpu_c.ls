   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
3982                     	switch	.data
3983  0000               L5462_CntrTick:
3984  0000 0000          	dc.w	0
4015                     ; 84 _NEAR void  OSInitHookBegin (void)
4015                     ; 85 {
4016                     	switch	.text
4017  0000               _OSInitHookBegin:
4021                     ; 87     OSTmrCtr = 0;
4023  0000 87            	clra	
4024  0001 c7            	clrb	
4025  0002 7c0000        	std	L3462_OSTmrCtr
4026                     ; 89 }
4029  0005 3d            	rts	
4051                     ; 105 _NEAR void  OSInitHookEnd (void)
4051                     ; 106 {
4052                     	switch	.text
4053  0006               _OSInitHookEnd:
4057                     ; 107 }
4060  0006 3d            	rts	
4474                     ; 123 _NEAR void  OSTaskCreateHook (OS_TCB *ptcb)
4474                     ; 124 {
4475                     	switch	.text
4476  0007               _OSTaskCreateHook:
4480                     ; 128     (void)ptcb;                                                         /* Prevent compiler warning                                 */
4482                     ; 130 }
4485  0007 3d            	rts	
4521                     ; 145 _NEAR void  OSTaskDelHook (OS_TCB *ptcb)
4521                     ; 146 {
4522                     	switch	.text
4523  0008               _OSTaskDelHook:
4527                     ; 150     (void)ptcb;                                                         /* Prevent compiler warning                                 */
4529                     ; 152 }
4532  0008 3d            	rts	
4554                     ; 168 _NEAR void  OSTaskIdleHook (void)
4554                     ; 169 {
4555                     	switch	.text
4556  0009               _OSTaskIdleHook:
4560                     ; 173 }
4563  0009 3d            	rts	
4599                     ; 190 _NEAR void  OSTaskReturnHook (OS_TCB *ptcb)
4599                     ; 191 {
4600                     	switch	.text
4601  000a               _OSTaskReturnHook:
4605                     ; 195     (void)ptcb;                                                         /* Prevent compiler warning                                 */
4607                     ; 197 }
4610  000a 3d            	rts	
4632                     ; 213 _NEAR void  OSTaskStatHook (void)
4632                     ; 214 {
4633                     	switch	.text
4634  000b               _OSTaskStatHook:
4638                     ; 218 }
4641  000b 3d            	rts	
4840                     ; 307 _NEAR OS_STK *OSTaskStkInit (
4840                     ; 308     void (*task)(void *pd),       // task start address
4840                     ; 309     void *p_arg,                  // task argument pointer
4840                     ; 310     OS_STK *ptos,                 // task top of stack pointer
4840                     ; 311     INT16U opt)                   // options
4840                     ; 312 {
4841                     	switch	.text
4842  000c               _OSTaskStkInit:
4844  000c 3b            	pshd	
4845  000d 1b98          	leas	-8,s
4846       00000008      OFST:	set	8
4849                     ; 318     (void)&opt;                                  // 'opt' is not used, prevent warning
4851                     ; 320     bstk    = (INT8U *)ptos;                     // Load stack pointer
4853  000f ed8e          	ldy	OFST+6,s
4854                     ; 325     addrTemp_UN.addr = (INT32U)OSTaskAbort;
4856  0011 ce0000        	ldx	#0
4857  0014 cc004d        	ldd	#_OSTaskAbort
4858  0017 6e82          	stx	OFST-6,s
4859                     ; 326     *--bstk = addrTemp_UN.addr32_ST.byte0;       // address low byte  (simulated calling fn)
4861  0019 03            	dey	
4862  001a 6b7f          	stab	1,y-
4863                     ; 327     *--bstk = addrTemp_UN.addr32_ST.byte1;       // address high byte (simulated calling fn)
4865  001c 6a7f          	staa	1,y-
4866                     ; 329     *--bstk = addrTemp_UN.addr32_ST.byte2;       // address page      (simulated calling fn)
4868  001e 180a837f      	movb	OFST-5,s,1,y-
4869                     ; 333     addrTemp_UN.addr = (INT32U)task;
4871  0022 ec88          	ldd	OFST+0,s
4872  0024 6c84          	std	OFST-4,s
4873  0026 6e82          	stx	OFST-6,s
4874                     ; 334     *--bstk = addrTemp_UN.addr32_ST.byte0;       // address low byte  (task)
4876  0028 6b7f          	stab	1,y-
4877                     ; 335     *--bstk = addrTemp_UN.addr32_ST.byte1;       // address high byte (task)
4879  002a 6a7f          	staa	1,y-
4880                     ; 337     *--bstk = (INT8U)0x22;                       // Y Register low byte  (simulated)
4882  002c c622          	ldab	#34
4883  002e 6b7f          	stab	1,y-
4884                     ; 338     *--bstk = (INT8U)0x22;                       // Y Register high byte (simulated)
4886  0030 6b7f          	stab	1,y-
4887                     ; 340     *--bstk = (INT8U)0x11;                       // X Register low byte  (simulated)
4889  0032 c611          	ldab	#17
4890  0034 6b7f          	stab	1,y-
4891                     ; 341     *--bstk = (INT8U)0x11;                       // X Register high byte (simulated)
4893  0036 6b7f          	stab	1,y-
4894                     ; 343     valueTemp_UN.value = (INT16U)p_arg;
4896  0038 ec8c          	ldd	OFST+4,s
4897  003a 6c86          	std	OFST-2,s
4898                     ; 344     *--bstk = valueTemp_UN.value16_ST.byte1;     // A register / D register high task arg
4900  003c 6a7f          	staa	1,y-
4901                     ; 345     *--bstk = valueTemp_UN.value16_ST.byte0;     // B register / D register low  task arg
4903  003e 6b7f          	stab	1,y-
4904                     ; 347     *--bstk = 0xC0;                              // CCR Register (Disable STOP instruction and XIRQ)
4906  0040 c6c0          	ldab	#192
4907  0042 6b7f          	stab	1,y-
4908                     ; 350     *--bstk = addrTemp_UN.addr32_ST.byte2;       // address page (task)
4910  0044 180a8340      	movb	OFST-5,s,0,y
4911                     ; 352     return ((OS_STK *)bstk);                     // Return pointer to new top-of-stack
4913  0048 b764          	tfr	y,d
4916  004a 1b8a          	leas	10,s
4917  004c 3d            	rts	
4940                     ; 373 _NEAR void  OSTaskAbort (void)
4940                     ; 374 {
4941                     	switch	.text
4942  004d               _OSTaskAbort:
4946                     ; 375     OSTaskDel(OS_PRIO_SELF);
4948  004d cc00ff        	ldd	#255
4949  0050 160000        	jsr	_OSTaskDel
4951                     ; 376 }
4954  0053 3d            	rts	
4976                     ; 395 _NEAR void  OSTaskSwHook (void)
4976                     ; 396 {
4977                     	switch	.text
4978  0054               _OSTaskSwHook:
4982                     ; 400 }
4985  0054 3d            	rts	
5021                     ; 415 _NEAR void  OSTCBInitHook (OS_TCB *ptcb)
5021                     ; 416 {
5022                     	switch	.text
5023  0055               _OSTCBInitHook:
5027                     ; 420     (void)ptcb;                                                         /* Prevent compiler warning                                 */
5029                     ; 422 }
5032  0055 3d            	rts	
5056                     ; 438 _NEAR void  OSTimeTickHook (void)
5056                     ; 439 {
5057                     	switch	.text
5058  0056               _OSTimeTickHook:
5062                     ; 445     OSTmrCtr++;
5064  0056 fd0000        	ldy	L3462_OSTmrCtr
5065  0059 02            	iny	
5066  005a 7d0000        	sty	L3462_OSTmrCtr
5067                     ; 451 }
5070  005d 3d            	rts	
5095                     ; 456 _NEAR void  OSTickISRHandler (void)
5095                     ; 457 {
5096                     	switch	.text
5097  005e               _OSTickISRHandler:
5101                     ; 460     TFLG1 |= TFLG1_C7F;
5103  005e 4c4e80        	bset	_TFLG1,128
5104                     ; 464     TC7   += TMR_TICKS_PER_TMR_INT;
5106  0061 dc5e          	ldd	_TC7
5107  0063 c35ff0        	addd	#24560
5108  0066 5c5e          	std	_TC7
5109                     ; 471     ++CntrTick;  // For debugging...
5111  0068 fd0000        	ldy	L5462_CntrTick
5112  006b 02            	iny	
5113  006c 7d0000        	sty	L5462_CntrTick
5114                     ; 473     return;
5117  006f 3d            	rts	
5145                     	switch	.bss
5146  0000               L3462_OSTmrCtr:
5147  0000 0000          	ds.b	2
5148                     	xdef	_OSTaskAbort
5149                     	xdef	_OSTimeTickHook
5150                     	xdef	_OSTCBInitHook
5151                     	xdef	_OSTaskSwHook
5152                     	xdef	_OSTaskStkInit
5153                     	xdef	_OSTaskStatHook
5154                     	xdef	_OSTaskReturnHook
5155                     	xdef	_OSTaskIdleHook
5156                     	xdef	_OSTaskDelHook
5157                     	xdef	_OSTaskCreateHook
5158                     	xdef	_OSInitHookEnd
5159                     	xdef	_OSInitHookBegin
5160                     	xref	_OSTmrSignal
5161                     	xref	_OSTaskDel
5162                     	xdef	_OSTickISRHandler
5183                     	end

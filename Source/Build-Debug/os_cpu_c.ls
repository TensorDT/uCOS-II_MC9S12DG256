   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
  44                     ; 82 _NEAR void  OSInitHookBegin (void)
  44                     ; 83 {
  45                     	switch	.text
  46  0000               _OSInitHookBegin:
  50                     ; 85     OSTmrCtr = 0;
  52  0000 87            	clra	
  53  0001 c7            	clrb	
  54  0002 7c0000        	std	L3_OSTmrCtr
  55                     ; 87 }
  58  0005 3d            	rts	
  80                     ; 103 _NEAR void  OSInitHookEnd (void)
  80                     ; 104 {
  81                     	switch	.text
  82  0006               _OSInitHookEnd:
  86                     ; 105 }
  89  0006 3d            	rts	
 503                     ; 121 _NEAR void  OSTaskCreateHook (OS_TCB *ptcb)
 503                     ; 122 {
 504                     	switch	.text
 505  0007               _OSTaskCreateHook:
 509                     ; 126     (void)ptcb;                                                         /* Prevent compiler warning                                 */
 511                     ; 128 }
 514  0007 3d            	rts	
 550                     ; 143 _NEAR void  OSTaskDelHook (OS_TCB *ptcb)
 550                     ; 144 {
 551                     	switch	.text
 552  0008               _OSTaskDelHook:
 556                     ; 148     (void)ptcb;                                                         /* Prevent compiler warning                                 */
 558                     ; 150 }
 561  0008 3d            	rts	
 583                     ; 166 _NEAR void  OSTaskIdleHook (void)
 583                     ; 167 {
 584                     	switch	.text
 585  0009               _OSTaskIdleHook:
 589                     ; 171 }
 592  0009 3d            	rts	
 628                     ; 188 _NEAR void  OSTaskReturnHook (OS_TCB *ptcb)
 628                     ; 189 {
 629                     	switch	.text
 630  000a               _OSTaskReturnHook:
 634                     ; 193     (void)ptcb;                                                         /* Prevent compiler warning                                 */
 636                     ; 195 }
 639  000a 3d            	rts	
 661                     ; 211 _NEAR void  OSTaskStatHook (void)
 661                     ; 212 {
 662                     	switch	.text
 663  000b               _OSTaskStatHook:
 667                     ; 216 }
 670  000b 3d            	rts	
 869                     ; 305 _NEAR OS_STK *OSTaskStkInit (
 869                     ; 306     void (*task)(void *pd),       // task start address
 869                     ; 307     void *p_arg,                  // task argument pointer
 869                     ; 308     OS_STK *ptos,                 // task top of stack pointer
 869                     ; 309     INT16U opt)                   // options
 869                     ; 310 {
 870                     	switch	.text
 871  000c               _OSTaskStkInit:
 873  000c 3b            	pshd	
 874  000d 1b98          	leas	-8,s
 875       00000008      OFST:	set	8
 878                     ; 316     (void)&opt;                                  // 'opt' is not used, prevent warning
 880                     ; 318     bstk    = (INT8U *)ptos;                     // Load stack pointer
 882  000f ed8e          	ldy	OFST+6,s
 883                     ; 323     addrTemp_UN.addr = (INT32U)OSTaskAbort;
 885  0011 ce0000        	ldx	#0
 886  0014 cc004d        	ldd	#_OSTaskAbort
 887  0017 6e82          	stx	OFST-6,s
 888                     ; 324     *--bstk = addrTemp_UN.addr32_ST.byte0;       // address low byte  (simulated calling fn)
 890  0019 03            	dey	
 891  001a 6b7f          	stab	1,y-
 892                     ; 325     *--bstk = addrTemp_UN.addr32_ST.byte1;       // address high byte (simulated calling fn)
 894  001c 6a7f          	staa	1,y-
 895                     ; 327     *--bstk = addrTemp_UN.addr32_ST.byte2;       // address page      (simulated calling fn)
 897  001e 180a837f      	movb	OFST-5,s,1,y-
 898                     ; 331     addrTemp_UN.addr = (INT32U)task;
 900  0022 ec88          	ldd	OFST+0,s
 901  0024 6c84          	std	OFST-4,s
 902  0026 6e82          	stx	OFST-6,s
 903                     ; 332     *--bstk = addrTemp_UN.addr32_ST.byte0;       // address low byte  (task)
 905  0028 6b7f          	stab	1,y-
 906                     ; 333     *--bstk = addrTemp_UN.addr32_ST.byte1;       // address high byte (task)
 908  002a 6a7f          	staa	1,y-
 909                     ; 335     *--bstk = (INT8U)0x22;                       // Y Register low byte  (simulated)
 911  002c c622          	ldab	#34
 912  002e 6b7f          	stab	1,y-
 913                     ; 336     *--bstk = (INT8U)0x22;                       // Y Register high byte (simulated)
 915  0030 6b7f          	stab	1,y-
 916                     ; 338     *--bstk = (INT8U)0x11;                       // X Register low byte  (simulated)
 918  0032 c611          	ldab	#17
 919  0034 6b7f          	stab	1,y-
 920                     ; 339     *--bstk = (INT8U)0x11;                       // X Register high byte (simulated)
 922  0036 6b7f          	stab	1,y-
 923                     ; 341     valueTemp_UN.value = (INT16U)p_arg;
 925  0038 ec8c          	ldd	OFST+4,s
 926  003a 6c86          	std	OFST-2,s
 927                     ; 342     *--bstk = valueTemp_UN.value16_ST.byte1;     // A register / D register high task arg
 929  003c 6a7f          	staa	1,y-
 930                     ; 343     *--bstk = valueTemp_UN.value16_ST.byte0;     // B register / D register low  task arg
 932  003e 6b7f          	stab	1,y-
 933                     ; 345     *--bstk = 0xC0;                              // CCR Register (Disable STOP instruction and XIRQ)
 935  0040 c6c0          	ldab	#192
 936  0042 6b7f          	stab	1,y-
 937                     ; 348     *--bstk = addrTemp_UN.addr32_ST.byte2;       // address page (task)
 939  0044 180a8340      	movb	OFST-5,s,0,y
 940                     ; 350     return ((OS_STK *)bstk);                     // Return pointer to new top-of-stack
 942  0048 b764          	tfr	y,d
 945  004a 1b8a          	leas	10,s
 946  004c 3d            	rts	
 969                     ; 371 _NEAR void  OSTaskAbort (void)
 969                     ; 372 {
 970                     	switch	.text
 971  004d               _OSTaskAbort:
 975                     ; 373     OSTaskDel(OS_PRIO_SELF);
 977  004d cc00ff        	ldd	#255
 978  0050 160000        	jsr	_OSTaskDel
 980                     ; 374 }
 983  0053 3d            	rts	
1005                     ; 393 _NEAR void  OSTaskSwHook (void)
1005                     ; 394 {
1006                     	switch	.text
1007  0054               _OSTaskSwHook:
1011                     ; 398 }
1014  0054 3d            	rts	
1050                     ; 413 _NEAR void  OSTCBInitHook (OS_TCB *ptcb)
1050                     ; 414 {
1051                     	switch	.text
1052  0055               _OSTCBInitHook:
1056                     ; 418     (void)ptcb;                                                         /* Prevent compiler warning                                 */
1058                     ; 420 }
1061  0055 3d            	rts	
1085                     ; 436 _NEAR void  OSTimeTickHook (void)
1085                     ; 437 {
1086                     	switch	.text
1087  0056               _OSTimeTickHook:
1091                     ; 443     OSTmrCtr++;
1093  0056 fd0000        	ldy	L3_OSTmrCtr
1094  0059 02            	iny	
1095  005a 7d0000        	sty	L3_OSTmrCtr
1096                     ; 444     if (OSTmrCtr >= (OS_TICKS_PER_SEC / OS_TMR_CFG_TICKS_PER_SEC)) {
1098  005d ce0000        	ldx	#0
1099  0060 8df000        	cpy	#-4096
1100  0063 b754          	tfr	x,d
1101  0065 c200          	sbcb	#0
1102  0067 8200          	sbca	#0
1103  0069 2508          	blo	L735
1104                     ; 445         OSTmrCtr = 0;
1106  006b 87            	clra	
1107  006c c7            	clrb	
1108  006d 7c0000        	std	L3_OSTmrCtr
1109                     ; 446         OSTmrSignal();
1111  0070 160000        	jsr	_OSTmrSignal
1113  0073               L735:
1114                     ; 449 }
1117  0073 3d            	rts	
1139                     ; 454 _NEAR void  OSTickISRHandler (void)
1139                     ; 455 {
1140                     	switch	.text
1141  0074               _OSTickISRHandler:
1145                     ; 457 }
1148  0074 3d            	rts	
1169                     	switch	.bss
1170  0000               L3_OSTmrCtr:
1171  0000 0000          	ds.b	2
1172                     	xdef	_OSTaskAbort
1173                     	xdef	_OSTimeTickHook
1174                     	xdef	_OSTCBInitHook
1175                     	xdef	_OSTaskSwHook
1176                     	xdef	_OSTaskStkInit
1177                     	xdef	_OSTaskStatHook
1178                     	xdef	_OSTaskReturnHook
1179                     	xdef	_OSTaskIdleHook
1180                     	xdef	_OSTaskDelHook
1181                     	xdef	_OSTaskCreateHook
1182                     	xdef	_OSInitHookEnd
1183                     	xdef	_OSInitHookBegin
1184                     	xref	_OSTmrSignal
1185                     	xref	_OSTaskDel
1186                     	xdef	_OSTickISRHandler
1207                     	end

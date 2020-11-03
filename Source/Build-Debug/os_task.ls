   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 537                     ; 60 _NEAR INT8U  OSTaskChangePrio (INT8U  oldprio,
 537                     ; 61                               INT8U  newprio)
 537                     ; 62 {
 538                     	switch	.text
 539  0000               _OSTaskChangePrio:
 541  0000 3b            	pshd	
 542  0001 1b92          	leas	-14,s
 543       0000000e      OFST:	set	14
 546                     ; 78     OS_CPU_SR  cpu_sr = 0u;                                 /* Storage for CPU status register         */
 548                     ; 83     if (oldprio >= OS_LOWEST_PRIO) {
 550  0003 c13f          	cmpb	#63
 551  0005 2503          	blo	L113
 552                     ; 84         if (oldprio != OS_PRIO_SELF) {
 554  0007 52            	incb	
 555                     ; 85             return (OS_ERR_PRIO_INVALID);
 558  0008 2607          	bne	LC001
 559  000a               L113:
 560                     ; 88     if (newprio >= OS_LOWEST_PRIO) {
 562  000a e6f013        	ldab	OFST+5,s
 563  000d c13f          	cmpb	#63
 564  000f 2506          	blo	L513
 565                     ; 89         return (OS_ERR_PRIO_INVALID);
 567  0011               LC001:
 568  0011 c62a          	ldab	#42
 570  0013               L61:
 572  0013 1bf010        	leas	16,s
 573  0016 3d            	rts	
 574  0017               L513:
 575                     ; 92     OS_ENTER_CRITICAL();
 577  0017 160000        	jsr	_OS_CPU_SR_Save
 579  001a 6b8c          	stab	OFST-2,s
 580                     ; 93     if (OSTCBPrioTbl[newprio] != (OS_TCB *)0) {             /* New priority must not already exist     */
 582  001c e6f013        	ldab	OFST+5,s
 583  001f 87            	clra	
 584  0020 59            	lsld	
 585  0021 b746          	tfr	d,y
 586  0023 ecea0000      	ldd	_OSTCBPrioTbl,y
 587  0027 270a          	beq	L713
 588                     ; 94         OS_EXIT_CRITICAL();
 590  0029 e68c          	ldab	OFST-2,s
 591  002b 87            	clra	
 592  002c 160000        	jsr	_OS_CPU_SR_Restore
 594                     ; 95         return (OS_ERR_PRIO_EXIST);
 596  002f c628          	ldab	#40
 598  0031 20e0          	bra	L61
 599  0033               L713:
 600                     ; 97     if (oldprio == OS_PRIO_SELF) {                          /* See if changing self                    */
 602  0033 e68f          	ldab	OFST+1,s
 603  0035 c1ff          	cmpb	#255
 604  0037 2608          	bne	L123
 605                     ; 98         oldprio = OSTCBCur->OSTCBPrio;                      /* Yes, get priority                       */
 607  0039 fd0000        	ldy	_OSTCBCur
 608  003c e6e824        	ldab	36,y
 609  003f 6b8f          	stab	OFST+1,s
 610  0041               L123:
 611                     ; 100     ptcb = OSTCBPrioTbl[oldprio];
 613  0041 87            	clra	
 614  0042 59            	lsld	
 615  0043 b746          	tfr	d,y
 616  0045 ecea0000      	ldd	_OSTCBPrioTbl,y
 617  0049 6c82          	std	OFST-12,s
 618                     ; 101     if (ptcb == (OS_TCB *)0) {                              /* Does task to change exist?              */
 620  004b 2609          	bne	L323
 621                     ; 102         OS_EXIT_CRITICAL();                                 /* No, can't change its priority!          */
 623  004d e68c          	ldab	OFST-2,s
 624  004f 160000        	jsr	_OS_CPU_SR_Restore
 626                     ; 103         return (OS_ERR_PRIO);
 628  0052 c629          	ldab	#41
 630  0054 20bd          	bra	L61
 631  0056               L323:
 632                     ; 105     if (ptcb == OS_TCB_RESERVED) {                          /* Is task assigned to Mutex               */
 634  0056 042409        	dbne	d,L523
 635                     ; 106         OS_EXIT_CRITICAL();                                 /* No, can't change its priority!          */
 637  0059 e68c          	ldab	OFST-2,s
 638  005b 160000        	jsr	_OS_CPU_SR_Restore
 640                     ; 107         return (OS_ERR_TASK_NOT_EXIST);
 642  005e c643          	ldab	#67
 644  0060 20b1          	bra	L61
 645  0062               L523:
 646                     ; 110     y_new                 = (INT8U)(newprio >> 3u);         /* Yes, compute new TCB fields             */
 648  0062 e6f013        	ldab	OFST+5,s
 649  0065 54            	lsrb	
 650  0066 54            	lsrb	
 651  0067 54            	lsrb	
 652  0068 6b87          	stab	OFST-7,s
 653                     ; 111     x_new                 = (INT8U)(newprio & 0x07u);
 655  006a e6f013        	ldab	OFST+5,s
 656  006d c407          	andb	#7
 657  006f 6b8d          	stab	OFST-1,s
 658                     ; 116     bity_new              = (OS_PRIO)(1uL << y_new);
 660  0071 c601          	ldab	#1
 661  0073 a687          	ldaa	OFST-7,s
 662  0075 2704          	beq	L6
 663  0077               L01:
 664  0077 58            	lslb	
 665  0078 0430fc        	dbne	a,L01
 666  007b               L6:
 667  007b 6b88          	stab	OFST-6,s
 668                     ; 117     bitx_new              = (OS_PRIO)(1uL << x_new);
 670  007d c601          	ldab	#1
 671  007f a68d          	ldaa	OFST-1,s
 672  0081 2704          	beq	L21
 673  0083               L41:
 674  0083 58            	lslb	
 675  0084 0430fc        	dbne	a,L41
 676  0087               L21:
 677  0087 6b89          	stab	OFST-5,s
 678                     ; 119     OSTCBPrioTbl[oldprio] = (OS_TCB *)0;                    /* Remove TCB from old priority            */
 680  0089 e68f          	ldab	OFST+1,s
 681  008b 87            	clra	
 682  008c 59            	lsld	
 683  008d b746          	tfr	d,y
 684  008f 87            	clra	
 685  0090 c7            	clrb	
 686  0091 6cea0000      	std	_OSTCBPrioTbl,y
 687                     ; 120     OSTCBPrioTbl[newprio] =  ptcb;                          /* Place pointer to TCB @ new priority     */
 689  0095 e6f013        	ldab	OFST+5,s
 690  0098 59            	lsld	
 691  0099 b746          	tfr	d,y
 692  009b ec82          	ldd	OFST-12,s
 693  009d 6cea0000      	std	_OSTCBPrioTbl,y
 694                     ; 121     y_old                 =  ptcb->OSTCBY;
 696  00a1 b746          	tfr	d,y
 697  00a3 e6e826        	ldab	38,y
 698  00a6 6b84          	stab	OFST-10,s
 699                     ; 122     bity_old              =  ptcb->OSTCBBitY;
 701  00a8 e6e828        	ldab	40,y
 702  00ab 6b8b          	stab	OFST-3,s
 703                     ; 123     bitx_old              =  ptcb->OSTCBBitX;
 705  00ad e6e827        	ldab	39,y
 706  00b0 6b8a          	stab	OFST-4,s
 707                     ; 124     if ((OSRdyTbl[y_old] &   bitx_old) != 0u) {             /* If task is ready make it not            */
 709  00b2 e684          	ldab	OFST-10,s
 710  00b4 b796          	exg	b,y
 711  00b6 e6ea0000      	ldab	_OSRdyTbl,y
 712  00ba e48a          	andb	OFST-4,s
 713  00bc 272c          	beq	L723
 714                     ; 125          OSRdyTbl[y_old] &= (OS_PRIO)~bitx_old;
 716  00be e68a          	ldab	OFST-4,s
 717  00c0 51            	comb	
 718  00c1 e4ea0000      	andb	_OSRdyTbl,y
 719  00c5 6bea0000      	stab	_OSRdyTbl,y
 720                     ; 126          if (OSRdyTbl[y_old] == 0u) {
 722  00c9 2609          	bne	L133
 723                     ; 127              OSRdyGrp &= (OS_PRIO)~bity_old;
 725  00cb e68b          	ldab	OFST-3,s
 726  00cd 51            	comb	
 727  00ce f40000        	andb	_OSRdyGrp
 728  00d1 7b0000        	stab	_OSRdyGrp
 729  00d4               L133:
 730                     ; 129          OSRdyGrp        |= bity_new;                       /* Make new priority ready to run          */
 732  00d4 e688          	ldab	OFST-6,s
 733  00d6 fa0000        	orab	_OSRdyGrp
 734  00d9 7b0000        	stab	_OSRdyGrp
 735                     ; 130          OSRdyTbl[y_new] |= bitx_new;
 737  00dc e687          	ldab	OFST-7,s
 738  00de b796          	exg	b,y
 739  00e0 e689          	ldab	OFST-5,s
 740  00e2 eaea0000      	orab	_OSRdyTbl,y
 741  00e6 6bea0000      	stab	_OSRdyTbl,y
 743  00ea               L723:
 744                     ; 135     pevent = ptcb->OSTCBEventPtr;
 746  00ea ed82          	ldy	OFST-12,s
 747  00ec ede812        	ldy	18,y
 748  00ef 6d80          	sty	OFST-14,s
 749                     ; 136     if (pevent != (OS_EVENT *)0) {
 751  00f1 2730          	beq	L333
 752                     ; 137         pevent->OSEventTbl[y_old] &= (OS_PRIO)~bitx_old;    /* Remove old task prio from wait list     */
 754  00f3 e684          	ldab	OFST-10,s
 755  00f5 19ed          	leay	b,y
 756  00f7 e68a          	ldab	OFST-4,s
 757  00f9 51            	comb	
 758  00fa e446          	andb	6,y
 759  00fc 6b46          	stab	6,y
 760                     ; 138         if (pevent->OSEventTbl[y_old] == 0u) {
 762  00fe ed80          	ldy	OFST-14,s
 763  0100 e684          	ldab	OFST-10,s
 764  0102 19ed          	leay	b,y
 765  0104 e646          	ldab	6,y
 766  0106 2609          	bne	L533
 767                     ; 139             pevent->OSEventGrp    &= (OS_PRIO)~bity_old;
 769  0108 ed80          	ldy	OFST-14,s
 770  010a e68b          	ldab	OFST-3,s
 771  010c 51            	comb	
 772  010d e445          	andb	5,y
 773  010f 6b45          	stab	5,y
 774  0111               L533:
 775                     ; 141         pevent->OSEventGrp        |= bity_new;              /* Add    new task prio to   wait list     */
 777  0111 ed80          	ldy	OFST-14,s
 778  0113 e688          	ldab	OFST-6,s
 779  0115 ea45          	orab	5,y
 780  0117 6b45          	stab	5,y
 781                     ; 142         pevent->OSEventTbl[y_new] |= bitx_new;
 783  0119 e687          	ldab	OFST-7,s
 784  011b 19ed          	leay	b,y
 785  011d e689          	ldab	OFST-5,s
 786  011f ea46          	orab	6,y
 787  0121 6b46          	stab	6,y
 788  0123               L333:
 789                     ; 145     if (ptcb->OSTCBEventMultiPtr != (OS_EVENT **)0) {
 791  0123 ed82          	ldy	OFST-12,s
 792  0125 ece814        	ldd	20,y
 793  0128 273e          	beq	L733
 794                     ; 146         pevents =  ptcb->OSTCBEventMultiPtr;
 796  012a 6c85          	std	OFST-9,s
 797                     ; 147         pevent  = *pevents;
 799  012c ecf30005      	ldd	[OFST-9,s]
 801  0130 202e          	bra	L543
 802  0132               L143:
 803                     ; 149             pevent->OSEventTbl[y_old] &= (OS_PRIO)~bitx_old;   /* Remove old task prio from wait lists */
 805  0132 e684          	ldab	OFST-10,s
 806  0134 19ed          	leay	b,y
 807  0136 e68a          	ldab	OFST-4,s
 808  0138 51            	comb	
 809  0139 e446          	andb	6,y
 810  013b 6b46          	stab	6,y
 811                     ; 150             if (pevent->OSEventTbl[y_old] == 0u) {
 813  013d 2609          	bne	L153
 814                     ; 151                 pevent->OSEventGrp    &= (OS_PRIO)~bity_old;
 816  013f ed80          	ldy	OFST-14,s
 817  0141 e68b          	ldab	OFST-3,s
 818  0143 51            	comb	
 819  0144 e445          	andb	5,y
 820  0146 6b45          	stab	5,y
 821  0148               L153:
 822                     ; 153             pevent->OSEventGrp        |= bity_new;          /* Add    new task prio to   wait lists    */
 824  0148 ed80          	ldy	OFST-14,s
 825  014a e688          	ldab	OFST-6,s
 826  014c ea45          	orab	5,y
 827  014e 6b45          	stab	5,y
 828                     ; 154             pevent->OSEventTbl[y_new] |= bitx_new;
 830  0150 e687          	ldab	OFST-7,s
 831  0152 19ed          	leay	b,y
 832  0154 e689          	ldab	OFST-5,s
 833  0156 ea46          	orab	6,y
 834  0158 6b46          	stab	6,y
 835                     ; 155             pevents++;
 837  015a ed85          	ldy	OFST-9,s
 838                     ; 156             pevent                     = *pevents;
 840  015c ec61          	ldd	2,+y
 841  015e 6d85          	sty	OFST-9,s
 842  0160               L543:
 843  0160 6c80          	std	OFST-14,s
 844                     ; 148         while (pevent != (OS_EVENT *)0) {
 846  0162 ed80          	ldy	OFST-14,s
 847  0164 26cc          	bne	L143
 848  0166 ed82          	ldy	OFST-12,s
 849  0168               L733:
 850                     ; 162     ptcb->OSTCBPrio = newprio;                              /* Set new task priority                   */
 852  0168 e6f013        	ldab	OFST+5,s
 853  016b 6be824        	stab	36,y
 854                     ; 163     ptcb->OSTCBY    = y_new;
 856  016e e687          	ldab	OFST-7,s
 857  0170 6be826        	stab	38,y
 858                     ; 164     ptcb->OSTCBX    = x_new;
 860  0173 e68d          	ldab	OFST-1,s
 861  0175 6be825        	stab	37,y
 862                     ; 165     ptcb->OSTCBBitY = bity_new;
 864  0178 e688          	ldab	OFST-6,s
 865  017a 6be828        	stab	40,y
 866                     ; 166     ptcb->OSTCBBitX = bitx_new;
 868  017d e689          	ldab	OFST-5,s
 869  017f 6be827        	stab	39,y
 870                     ; 167     OS_EXIT_CRITICAL();
 872  0182 e68c          	ldab	OFST-2,s
 873  0184 87            	clra	
 874  0185 160000        	jsr	_OS_CPU_SR_Restore
 876                     ; 168     if (OSRunning == OS_TRUE) {
 878  0188 f60000        	ldab	_OSRunning
 879  018b 042103        	dbne	b,L353
 880                     ; 169         OS_Sched();                                         /* Find new highest priority task          */
 882  018e 160000        	jsr	_OS_Sched
 884  0191               L353:
 885                     ; 171     return (OS_ERR_NONE);
 887  0191 c7            	clrb	
 889  0192 060013        	bra	L61
 983                     ; 219 _NEAR INT8U  OSTaskCreate (void   (*task)(void *p_arg),
 983                     ; 220                           void    *p_arg,
 983                     ; 221                           OS_STK  *ptos,
 983                     ; 222                           INT8U    prio)
 983                     ; 223 {
 984                     	switch	.text
 985  0195               _OSTaskCreate:
 987  0195 3b            	pshd	
 988  0196 1b9c          	leas	-4,s
 989       00000004      OFST:	set	4
 992                     ; 227     OS_CPU_SR   cpu_sr = 0u;
 994                     ; 240     if (prio > OS_LOWEST_PRIO) {             /* Make sure priority is within allowable range           */
 996  0198 e68d          	ldab	OFST+9,s
 997  019a c13f          	cmpb	#63
 998  019c 2304          	bls	L514
 999                     ; 241         return (OS_ERR_PRIO_INVALID);
1001  019e c62a          	ldab	#42
1003  01a0 2010          	bra	L22
1004  01a2               L514:
1005                     ; 244     OS_ENTER_CRITICAL();
1007  01a2 160000        	jsr	_OS_CPU_SR_Save
1009  01a5 6b80          	stab	OFST-4,s
1010                     ; 245     if (OSIntNesting > 0u) {                 /* Make sure we don't create the task from within an ISR  */
1012  01a7 b60000        	ldaa	_OSIntNesting
1013  01aa 2709          	beq	L714
1014                     ; 246         OS_EXIT_CRITICAL();
1016  01ac 87            	clra	
1017  01ad 160000        	jsr	_OS_CPU_SR_Restore
1019                     ; 247         return (OS_ERR_TASK_CREATE_ISR);
1021  01b0 c63c          	ldab	#60
1023  01b2               L22:
1025  01b2 1b86          	leas	6,s
1026  01b4 3d            	rts	
1027  01b5               L714:
1028                     ; 249     if (OSTCBPrioTbl[prio] == (OS_TCB *)0) { /* Make sure task doesn't already exist at this priority  */
1030  01b5 e68d          	ldab	OFST+9,s
1031  01b7 59            	lsld	
1032  01b8 b746          	tfr	d,y
1033  01ba ecea0000      	ldd	_OSTCBPrioTbl,y
1034  01be 265b          	bne	L124
1035                     ; 250         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;/* Reserve the priority to prevent others from doing ...  */
1037  01c0 cc0001        	ldd	#1
1038  01c3 6cea0000      	std	_OSTCBPrioTbl,y
1039                     ; 252         OS_EXIT_CRITICAL();
1041  01c7 e680          	ldab	OFST-4,s
1042  01c9 160000        	jsr	_OS_CPU_SR_Restore
1044                     ; 253         psp = OSTaskStkInit(task, p_arg, ptos, 0u);             /* Initialize the task's stack         */
1046  01cc 87            	clra	
1047  01cd c7            	clrb	
1048  01ce 3b            	pshd	
1049  01cf ec8c          	ldd	OFST+8,s
1050  01d1 3b            	pshd	
1051  01d2 ec8c          	ldd	OFST+8,s
1052  01d4 3b            	pshd	
1053  01d5 ec8a          	ldd	OFST+6,s
1054  01d7 160000        	jsr	_OSTaskStkInit
1056  01da 1b86          	leas	6,s
1057  01dc 6c82          	std	OFST-2,s
1058                     ; 254         err = OS_TCBInit(prio, psp, (OS_STK *)0, 0u, 0u, (void *)0, 0u);
1060  01de 87            	clra	
1061  01df c7            	clrb	
1062  01e0 3b            	pshd	
1063  01e1 3b            	pshd	
1064  01e2 3b            	pshd	
1065  01e3 3b            	pshd	
1066  01e4 3b            	pshd	
1067  01e5 3b            	pshd	
1068  01e6 ec8e          	ldd	OFST+10,s
1069  01e8 3b            	pshd	
1070  01e9 e6f01b        	ldab	OFST+23,s
1071  01ec 87            	clra	
1072  01ed 160000        	jsr	_OS_TCBInit
1074  01f0 1b8e          	leas	14,s
1075  01f2 6b81          	stab	OFST-3,s
1076                     ; 255         if (err == OS_ERR_NONE) {
1078  01f4 260b          	bne	L324
1079                     ; 257             if (OSRunning == OS_TRUE) {      /* Find highest priority task if multitasking has started */
1082  01f6 f60000        	ldab	_OSRunning
1083  01f9 04211b        	dbne	b,L724
1084                     ; 258                 OS_Sched();
1086  01fc 160000        	jsr	_OS_Sched
1088  01ff 2016          	bra	L724
1089  0201               L324:
1090                     ; 262             OS_ENTER_CRITICAL();
1093  0201 160000        	jsr	_OS_CPU_SR_Save
1095  0204 6b80          	stab	OFST-4,s
1096                     ; 263             OSTCBPrioTbl[prio] = (OS_TCB *)0;/* Make this priority available to others                 */
1098  0206 e68d          	ldab	OFST+9,s
1099  0208 87            	clra	
1100  0209 59            	lsld	
1101  020a b746          	tfr	d,y
1102  020c 87            	clra	
1103  020d c7            	clrb	
1104  020e 6cea0000      	std	_OSTCBPrioTbl,y
1105                     ; 264             OS_EXIT_CRITICAL();
1107  0212 e680          	ldab	OFST-4,s
1108  0214 160000        	jsr	_OS_CPU_SR_Restore
1110  0217               L724:
1111                     ; 266         return (err);
1113  0217 e681          	ldab	OFST-3,s
1115  0219 2008          	bra	L42
1116  021b               L124:
1117                     ; 268     OS_EXIT_CRITICAL();
1119  021b e680          	ldab	OFST-4,s
1120  021d 87            	clra	
1121  021e 160000        	jsr	_OS_CPU_SR_Restore
1123                     ; 269     return (OS_ERR_PRIO_EXIST);
1125  0221 c628          	ldab	#40
1127  0223               L42:
1129  0223 1b86          	leas	6,s
1130  0225 3d            	rts	
1266                     ; 347 _NEAR INT8U  OSTaskCreateExt (void   (*task)(void *p_arg),
1266                     ; 348                              void    *p_arg,
1266                     ; 349                              OS_STK  *ptos,
1266                     ; 350                              INT8U    prio,
1266                     ; 351                              INT16U   id,
1266                     ; 352                              OS_STK  *pbos,
1266                     ; 353                              INT32U   stk_size,
1266                     ; 354                              void    *pext,
1266                     ; 355                              INT16U   opt)
1266                     ; 356 {
1267                     	switch	.text
1268  0226               _OSTaskCreateExt:
1270  0226 3b            	pshd	
1271  0227 1b9c          	leas	-4,s
1272       00000004      OFST:	set	4
1275                     ; 360     OS_CPU_SR   cpu_sr = 0u;
1277                     ; 373     if (prio > OS_LOWEST_PRIO) {             /* Make sure priority is within allowable range           */
1279  0229 e68d          	ldab	OFST+9,s
1280  022b c13f          	cmpb	#63
1281  022d 2304          	bls	L705
1282                     ; 374         return (OS_ERR_PRIO_INVALID);
1284  022f c62a          	ldab	#42
1286  0231 2010          	bra	L03
1287  0233               L705:
1288                     ; 377     OS_ENTER_CRITICAL();
1290  0233 160000        	jsr	_OS_CPU_SR_Save
1292  0236 6b80          	stab	OFST-4,s
1293                     ; 378     if (OSIntNesting > 0u) {                 /* Make sure we don't create the task from within an ISR  */
1295  0238 b60000        	ldaa	_OSIntNesting
1296  023b 2709          	beq	L115
1297                     ; 379         OS_EXIT_CRITICAL();
1299  023d 87            	clra	
1300  023e 160000        	jsr	_OS_CPU_SR_Restore
1302                     ; 380         return (OS_ERR_TASK_CREATE_ISR);
1304  0241 c63c          	ldab	#60
1306  0243               L03:
1308  0243 1b86          	leas	6,s
1309  0245 3d            	rts	
1310  0246               L115:
1311                     ; 382     if (OSTCBPrioTbl[prio] == (OS_TCB *)0) { /* Make sure task doesn't already exist at this priority  */
1313  0246 e68d          	ldab	OFST+9,s
1314  0248 59            	lsld	
1315  0249 b746          	tfr	d,y
1316  024b ecea0000      	ldd	_OSTCBPrioTbl,y
1317  024f 18260080      	bne	L315
1318                     ; 383         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;/* Reserve the priority to prevent others from doing ...  */
1320  0253 cc0001        	ldd	#1
1321  0256 6cea0000      	std	_OSTCBPrioTbl,y
1322                     ; 385         OS_EXIT_CRITICAL();
1324  025a e680          	ldab	OFST-4,s
1325  025c 160000        	jsr	_OS_CPU_SR_Restore
1327                     ; 388         OS_TaskStkClr(pbos, stk_size, opt);                    /* Clear the task stack (if needed)     */
1329  025f ecf018        	ldd	OFST+20,s
1330  0262 3b            	pshd	
1331  0263 ecf016        	ldd	OFST+18,s
1332  0266 3b            	pshd	
1333  0267 ecf016        	ldd	OFST+18,s
1334  026a 3b            	pshd	
1335  026b ecf016        	ldd	OFST+18,s
1336  026e 1607a3        	jsr	_OS_TaskStkClr
1338  0271 1b86          	leas	6,s
1339                     ; 391         psp = OSTaskStkInit(task, p_arg, ptos, opt);           /* Initialize the task's stack          */
1341  0273 ecf018        	ldd	OFST+20,s
1342  0276 3b            	pshd	
1343  0277 ec8c          	ldd	OFST+8,s
1344  0279 3b            	pshd	
1345  027a ec8c          	ldd	OFST+8,s
1346  027c 3b            	pshd	
1347  027d ec8a          	ldd	OFST+6,s
1348  027f 160000        	jsr	_OSTaskStkInit
1350  0282 1b86          	leas	6,s
1351  0284 6c82          	std	OFST-2,s
1352                     ; 392         err = OS_TCBInit(prio, psp, pbos, id, stk_size, pext, opt);
1354  0286 ecf018        	ldd	OFST+20,s
1355  0289 3b            	pshd	
1356  028a ecf018        	ldd	OFST+20,s
1357  028d 3b            	pshd	
1358  028e ecf018        	ldd	OFST+20,s
1359  0291 3b            	pshd	
1360  0292 ecf018        	ldd	OFST+20,s
1361  0295 3b            	pshd	
1362  0296 ecf016        	ldd	OFST+18,s
1363  0299 3b            	pshd	
1364  029a ecf01a        	ldd	OFST+22,s
1365  029d 3b            	pshd	
1366  029e ec8e          	ldd	OFST+10,s
1367  02a0 3b            	pshd	
1368  02a1 e6f01b        	ldab	OFST+23,s
1369  02a4 87            	clra	
1370  02a5 160000        	jsr	_OS_TCBInit
1372  02a8 1b8e          	leas	14,s
1373  02aa 6b81          	stab	OFST-3,s
1374                     ; 393         if (err == OS_ERR_NONE) {
1376  02ac 260b          	bne	L515
1377                     ; 395             if (OSRunning == OS_TRUE) {                        /* Find HPT if multitasking has started */
1380  02ae f60000        	ldab	_OSRunning
1381  02b1 04211b        	dbne	b,L125
1382                     ; 396                 OS_Sched();
1384  02b4 160000        	jsr	_OS_Sched
1386  02b7 2016          	bra	L125
1387  02b9               L515:
1388                     ; 399             OS_ENTER_CRITICAL();
1390  02b9 160000        	jsr	_OS_CPU_SR_Save
1392  02bc 6b80          	stab	OFST-4,s
1393                     ; 400             OSTCBPrioTbl[prio] = (OS_TCB *)0;                  /* Make this priority avail. to others  */
1395  02be e68d          	ldab	OFST+9,s
1396  02c0 87            	clra	
1397  02c1 59            	lsld	
1398  02c2 b746          	tfr	d,y
1399  02c4 87            	clra	
1400  02c5 c7            	clrb	
1401  02c6 6cea0000      	std	_OSTCBPrioTbl,y
1402                     ; 401             OS_EXIT_CRITICAL();
1404  02ca e680          	ldab	OFST-4,s
1405  02cc 160000        	jsr	_OS_CPU_SR_Restore
1407  02cf               L125:
1408                     ; 403         return (err);
1410  02cf e681          	ldab	OFST-3,s
1412  02d1 2008          	bra	L23
1413  02d3               L315:
1414                     ; 405     OS_EXIT_CRITICAL();
1416  02d3 e680          	ldab	OFST-4,s
1417  02d5 87            	clra	
1418  02d6 160000        	jsr	_OS_CPU_SR_Restore
1420                     ; 406     return (OS_ERR_PRIO_EXIST);
1422  02d9 c628          	ldab	#40
1424  02db               L23:
1426  02db 1b86          	leas	6,s
1427  02dd 3d            	rts	
1507                     ; 450 _NEAR INT8U  OSTaskDel (INT8U prio)
1507                     ; 451 {
1508                     	switch	.text
1509  02de               _OSTaskDel:
1511  02de 3b            	pshd	
1512  02df 1b9b          	leas	-5,s
1513       00000005      OFST:	set	5
1516                     ; 457     OS_CPU_SR     cpu_sr = 0u;
1518                     ; 469     if (OSIntNesting > 0u) {                            /* See if trying to delete from ISR            */
1520  02e1 f60000        	ldab	_OSIntNesting
1521  02e4 2704          	beq	L555
1522                     ; 470         return (OS_ERR_TASK_DEL_ISR);
1524  02e6 c640          	ldab	#64
1526  02e8 2008          	bra	L63
1527  02ea               L555:
1528                     ; 472     if (prio == OS_TASK_IDLE_PRIO) {                    /* Not allowed to delete idle task             */
1530  02ea e686          	ldab	OFST+1,s
1531  02ec c13f          	cmpb	#63
1532  02ee 2605          	bne	L755
1533                     ; 473         return (OS_ERR_TASK_DEL_IDLE);
1535  02f0 c63e          	ldab	#62
1537  02f2               L63:
1539  02f2 1b87          	leas	7,s
1540  02f4 3d            	rts	
1541  02f5               L755:
1542                     ; 476     if (prio >= OS_LOWEST_PRIO) {                       /* Task priority valid ?                       */
1544  02f5 2507          	blo	L165
1545                     ; 477         if (prio != OS_PRIO_SELF) {
1547  02f7 048104        	ibeq	b,L165
1548                     ; 478             return (OS_ERR_PRIO_INVALID);
1550  02fa c62a          	ldab	#42
1552  02fc 20f4          	bra	L63
1553  02fe               L165:
1554                     ; 483     OS_ENTER_CRITICAL();
1556  02fe 160000        	jsr	_OS_CPU_SR_Save
1558  0301 6b82          	stab	OFST-3,s
1559                     ; 484     if (prio == OS_PRIO_SELF) {                         /* See if requesting to delete self            */
1561  0303 e686          	ldab	OFST+1,s
1562  0305 c1ff          	cmpb	#255
1563  0307 2608          	bne	L565
1564                     ; 485         prio = OSTCBCur->OSTCBPrio;                     /* Set priority to delete to current           */
1566  0309 fd0000        	ldy	_OSTCBCur
1567  030c e6e824        	ldab	36,y
1568  030f 6b86          	stab	OFST+1,s
1569  0311               L565:
1570                     ; 487     ptcb = OSTCBPrioTbl[prio];
1572  0311 87            	clra	
1573  0312 59            	lsld	
1574  0313 b746          	tfr	d,y
1575  0315 ecea0000      	ldd	_OSTCBPrioTbl,y
1576  0319 6c80          	std	OFST-5,s
1577                     ; 488     if (ptcb == (OS_TCB *)0) {                          /* Task to delete must exist                   */
1579  031b 2609          	bne	L765
1580                     ; 489         OS_EXIT_CRITICAL();
1582  031d e682          	ldab	OFST-3,s
1583  031f 160000        	jsr	_OS_CPU_SR_Restore
1585                     ; 490         return (OS_ERR_TASK_NOT_EXIST);
1587  0322 c643          	ldab	#67
1589  0324 20cc          	bra	L63
1590  0326               L765:
1591                     ; 492     if (ptcb == OS_TCB_RESERVED) {                      /* Must not be assigned to Mutex               */
1593  0326 8c0001        	cpd	#1
1594  0329 260a          	bne	L175
1595                     ; 493         OS_EXIT_CRITICAL();
1597  032b e682          	ldab	OFST-3,s
1598  032d 87            	clra	
1599  032e 160000        	jsr	_OS_CPU_SR_Restore
1601                     ; 494         return (OS_ERR_TASK_DEL);
1603  0331 c63d          	ldab	#61
1605  0333 20bd          	bra	L63
1606  0335               L175:
1607                     ; 497     OSRdyTbl[ptcb->OSTCBY] &= (OS_PRIO)~ptcb->OSTCBBitX;
1609  0335 b746          	tfr	d,y
1610  0337 e6e826        	ldab	38,y
1611  033a b796          	exg	b,y
1612  033c ee80          	ldx	OFST-5,s
1613  033e e6e027        	ldab	39,x
1614  0341 51            	comb	
1615  0342 e4ea0000      	andb	_OSRdyTbl,y
1616  0346 6bea0000      	stab	_OSRdyTbl,y
1617                     ; 499     if (OSRdyTbl[ptcb->OSTCBY] == 0u) {                 /* Make task not ready                         */
1620  034a 260c          	bne	L375
1621                     ; 500         OSRdyGrp           &= (OS_PRIO)~ptcb->OSTCBBitY;
1623  034c b756          	tfr	x,y
1624  034e e6e828        	ldab	40,y
1625  0351 51            	comb	
1626  0352 f40000        	andb	_OSRdyGrp
1627  0355 7b0000        	stab	_OSRdyGrp
1628  0358               L375:
1629                     ; 504     if (ptcb->OSTCBEventPtr != (OS_EVENT *)0) {
1631  0358 b756          	tfr	x,y
1632  035a ece812        	ldd	18,y
1633  035d 270a          	beq	L575
1634                     ; 505         OS_EventTaskRemove(ptcb, ptcb->OSTCBEventPtr);  /* Remove this task from any event   wait list */
1636  035f 3b            	pshd	
1637  0360 b754          	tfr	x,d
1638  0362 160000        	jsr	_OS_EventTaskRemove
1640  0365 1b82          	leas	2,s
1641  0367 ed80          	ldy	OFST-5,s
1642  0369               L575:
1643                     ; 508     if (ptcb->OSTCBEventMultiPtr != (OS_EVENT **)0) {   /* Remove this task from any events' wait lists*/
1645  0369 ece814        	ldd	20,y
1646  036c 270a          	beq	L775
1647                     ; 509         OS_EventTaskRemoveMulti(ptcb, ptcb->OSTCBEventMultiPtr);
1649  036e 3b            	pshd	
1650  036f ec82          	ldd	OFST-3,s
1651  0371 160000        	jsr	_OS_EventTaskRemoveMulti
1653  0374 1b82          	leas	2,s
1654  0376 ed80          	ldy	OFST-5,s
1655  0378               L775:
1656                     ; 515     pnode = ptcb->OSTCBFlagNode;
1658  0378 ece81a        	ldd	26,y
1659  037b 6c83          	std	OFST-2,s
1660                     ; 516     if (pnode != (OS_FLAG_NODE *)0) {                   /* If task is waiting on event flag            */
1662  037d 2705          	beq	L106
1663                     ; 517         OS_FlagUnlink(pnode);                           /* Remove from wait list                       */
1665  037f 160000        	jsr	_OS_FlagUnlink
1667  0382 ed80          	ldy	OFST-5,s
1668  0384               L106:
1669                     ; 521     ptcb->OSTCBDly      = 0u;                           /* Prevent OSTimeTick() from updating          */
1671  0384 87            	clra	
1672  0385 c7            	clrb	
1673  0386 6ce820        	std	32,y
1674  0389 6ce81e        	std	30,y
1675                     ; 522     ptcb->OSTCBStat     = OS_STAT_RDY;                  /* Prevent task from being resumed             */
1677                     ; 523     ptcb->OSTCBStatPend = OS_STAT_PEND_OK;
1679  038c 6ce822        	std	34,y
1680                     ; 524     if (OSLockNesting < 255u) {                         /* Make sure we don't context switch           */
1682  038f f60000        	ldab	_OSLockNesting
1683  0392 c1ff          	cmpb	#255
1684  0394 2403          	bhs	L306
1685                     ; 525         OSLockNesting++;
1687  0396 720000        	inc	_OSLockNesting
1688  0399               L306:
1689                     ; 527     OS_EXIT_CRITICAL();                                 /* Enabling INT. ignores next instruc.         */
1691  0399 e682          	ldab	OFST-3,s
1692  039b 87            	clra	
1693  039c 160000        	jsr	_OS_CPU_SR_Restore
1695                     ; 528     OS_Dummy();                                         /* ... Dummy ensures that INTs will be         */
1697  039f 160000        	jsr	_OS_Dummy
1699                     ; 529     OS_ENTER_CRITICAL();                                /* ... disabled HERE!                          */
1701  03a2 160000        	jsr	_OS_CPU_SR_Save
1703  03a5 6b82          	stab	OFST-3,s
1704                     ; 530     if (OSLockNesting > 0u) {                           /* Remove context switch lock                  */
1706  03a7 f70000        	tst	_OSLockNesting
1707  03aa 2703          	beq	L506
1708                     ; 531         OSLockNesting--;
1710  03ac 730000        	dec	_OSLockNesting
1711  03af               L506:
1712                     ; 533     OSTaskDelHook(ptcb);                                /* Call user defined hook                      */
1714  03af ec80          	ldd	OFST-5,s
1715  03b1 160000        	jsr	_OSTaskDelHook
1717                     ; 541     OSTaskCtr--;                                        /* One less task being managed                 */
1719  03b4 730000        	dec	_OSTaskCtr
1720                     ; 542     OSTCBPrioTbl[prio] = (OS_TCB *)0;                   /* Clear old priority entry                    */
1722  03b7 e686          	ldab	OFST+1,s
1723  03b9 87            	clra	
1724  03ba 59            	lsld	
1725  03bb b746          	tfr	d,y
1726  03bd 87            	clra	
1727  03be c7            	clrb	
1728  03bf 6cea0000      	std	_OSTCBPrioTbl,y
1729                     ; 543     if (ptcb->OSTCBPrev == (OS_TCB *)0) {               /* Remove from TCB chain                       */
1731  03c3 ed80          	ldy	OFST-5,s
1732  03c5 eee810        	ldx	16,y
1733  03c8 260e          	bne	L706
1734                     ; 544         ptcb->OSTCBNext->OSTCBPrev = (OS_TCB *)0;
1736  03ca ed4e          	ldy	14,y
1737  03cc 6ce810        	std	16,y
1738                     ; 545         OSTCBList                  = ptcb->OSTCBNext;
1740  03cf ed80          	ldy	OFST-5,s
1741  03d1 18054e0000    	movw	14,y,_OSTCBList
1743  03d6 2012          	bra	L116
1744  03d8               L706:
1745                     ; 547         ptcb->OSTCBPrev->OSTCBNext = ptcb->OSTCBNext;
1747  03d8 18024e0e      	movw	14,y,14,x
1748                     ; 548         ptcb->OSTCBNext->OSTCBPrev = ptcb->OSTCBPrev;
1750  03dc ee4e          	ldx	14,y
1751  03de 1ae010        	leax	16,x
1752  03e1 19e810        	leay	16,y
1753  03e4 18024000      	movw	0,y,0,x
1754  03e8 ed80          	ldy	OFST-5,s
1755  03ea               L116:
1756                     ; 550     ptcb->OSTCBNext     = OSTCBFreeList;                /* Return TCB to free TCB list                 */
1758  03ea 18014e0000    	movw	_OSTCBFreeList,14,y
1759                     ; 551     OSTCBFreeList       = ptcb;
1761  03ef 7d0000        	sty	_OSTCBFreeList
1762                     ; 553     ptcb->OSTCBTaskName = (INT8U *)(void *)"?";
1764  03f2 cc0000        	ldd	#L316
1765  03f5 6ce83c        	std	60,y
1766                     ; 555     OS_EXIT_CRITICAL();
1768  03f8 e682          	ldab	OFST-3,s
1769  03fa 87            	clra	
1770  03fb 160000        	jsr	_OS_CPU_SR_Restore
1772                     ; 556     if (OSRunning == OS_TRUE) {
1774  03fe f60000        	ldab	_OSRunning
1775  0401 042103        	dbne	b,L516
1776                     ; 557         OS_Sched();                                     /* Find new highest priority task              */
1778  0404 160000        	jsr	_OS_Sched
1780  0407               L516:
1781                     ; 559     return (OS_ERR_NONE);
1783  0407 c7            	clrb	
1786  0408 1b87          	leas	7,s
1787  040a 3d            	rts	
1848                     ; 613 _NEAR INT8U  OSTaskDelReq (INT8U prio)
1848                     ; 614 {
1849                     	switch	.text
1850  040b               _OSTaskDelReq:
1852  040b 3b            	pshd	
1853  040c 1b9c          	leas	-4,s
1854       00000004      OFST:	set	4
1857                     ; 618     OS_CPU_SR  cpu_sr = 0u;
1859                     ; 630     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to delete idle task     */
1861  040e c13f          	cmpb	#63
1862  0410 2604          	bne	L546
1863                     ; 631         return (OS_ERR_TASK_DEL_IDLE);
1865  0412 c63e          	ldab	#62
1867  0414 200c          	bra	L24
1868  0416               L546:
1869                     ; 634     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
1871  0416 e685          	ldab	OFST+1,s
1872  0418 c13f          	cmpb	#63
1873  041a 2509          	blo	L746
1874                     ; 635         if (prio != OS_PRIO_SELF) {
1876  041c c1ff          	cmpb	#255
1877  041e 2705          	beq	L746
1878                     ; 636             return (OS_ERR_PRIO_INVALID);
1880  0420 c62a          	ldab	#42
1882  0422               L24:
1884  0422 1b86          	leas	6,s
1885  0424 3d            	rts	
1886  0425               L746:
1887                     ; 640     if (prio == OS_PRIO_SELF) {                                 /* See if a task is requesting to ...  */
1889  0425 04a117        	ibne	b,L356
1890                     ; 641         OS_ENTER_CRITICAL();                                    /* ... this task to delete itself      */
1892  0428 160000        	jsr	_OS_CPU_SR_Save
1894  042b 6b80          	stab	OFST-4,s
1895                     ; 642         stat = OSTCBCur->OSTCBDelReq;                           /* Return request status to caller     */
1897  042d fd0000        	ldy	_OSTCBCur
1898  0430 e6e829        	ldab	41,y
1899  0433 6b83          	stab	OFST-1,s
1900                     ; 643         OS_EXIT_CRITICAL();
1902  0435 e680          	ldab	OFST-4,s
1903  0437 87            	clra	
1904  0438 160000        	jsr	_OS_CPU_SR_Restore
1906                     ; 644         return (stat);
1908  043b e683          	ldab	OFST-1,s
1910  043d 20e3          	bra	L24
1911  043f               L356:
1912                     ; 646     OS_ENTER_CRITICAL();
1914  043f 160000        	jsr	_OS_CPU_SR_Save
1916  0442 6b80          	stab	OFST-4,s
1917                     ; 647     ptcb = OSTCBPrioTbl[prio];
1919  0444 e685          	ldab	OFST+1,s
1920  0446 87            	clra	
1921  0447 59            	lsld	
1922  0448 b746          	tfr	d,y
1923  044a ecea0000      	ldd	_OSTCBPrioTbl,y
1924  044e 6c81          	std	OFST-3,s
1925                     ; 648     if (ptcb == (OS_TCB *)0) {                                  /* Task to delete must exist           */
1927  0450 2609          	bne	L556
1928                     ; 649         OS_EXIT_CRITICAL();
1930  0452 e680          	ldab	OFST-4,s
1931  0454 160000        	jsr	_OS_CPU_SR_Restore
1933                     ; 650         return (OS_ERR_TASK_NOT_EXIST);                         /* Task must already be deleted        */
1935  0457 c643          	ldab	#67
1937  0459 20c7          	bra	L24
1938  045b               L556:
1939                     ; 652     if (ptcb == OS_TCB_RESERVED) {                              /* Must NOT be assigned to a Mutex     */
1941  045b 042409        	dbne	d,L756
1942                     ; 653         OS_EXIT_CRITICAL();
1944  045e e680          	ldab	OFST-4,s
1945  0460 160000        	jsr	_OS_CPU_SR_Restore
1947                     ; 654         return (OS_ERR_TASK_DEL);
1949  0463 c63d          	ldab	#61
1951  0465 20bb          	bra	L24
1952  0467               L756:
1953                     ; 656     ptcb->OSTCBDelReq = OS_ERR_TASK_DEL_REQ;                    /* Set flag indicating task to be DEL. */
1955  0467 c63f          	ldab	#63
1956  0469 ee81          	ldx	OFST-3,s
1957  046b 6be029        	stab	41,x
1958                     ; 657     OS_EXIT_CRITICAL();
1960  046e e680          	ldab	OFST-4,s
1961  0470 87            	clra	
1962  0471 160000        	jsr	_OS_CPU_SR_Restore
1964                     ; 658     return (OS_ERR_NONE);
1966  0474 c7            	clrb	
1968  0475 20ab          	bra	L24
2052                     ; 688 _NEAR INT8U  OSTaskNameGet (INT8U    prio,
2052                     ; 689                            INT8U  **pname,
2052                     ; 690                            INT8U   *perr)
2052                     ; 691 {
2053                     	switch	.text
2054  0477               _OSTaskNameGet:
2056  0477 3b            	pshd	
2057  0478 1b9c          	leas	-4,s
2058       00000004      OFST:	set	4
2061                     ; 695     OS_CPU_SR  cpu_sr = 0u;
2063                     ; 708     if (prio > OS_LOWEST_PRIO) {                         /* Task priority valid ?                      */
2065  047a c13f          	cmpb	#63
2066  047c 2307          	bls	L717
2067                     ; 709         if (prio != OS_PRIO_SELF) {
2069  047e 048104        	ibeq	b,L717
2070                     ; 710             *perr = OS_ERR_PRIO_INVALID;                 /* No                                         */
2072  0481 c62a          	ldab	#42
2073                     ; 711             return (0u);
2076  0483 2006          	bra	LC002
2077  0485               L717:
2078                     ; 714     if (pname == (INT8U **)0) {                          /* Is 'pname' a NULL pointer?                 */
2080  0485 ec88          	ldd	OFST+4,s
2081  0487 260a          	bne	L327
2082                     ; 715         *perr = OS_ERR_PNAME_NULL;                       /* Yes                                        */
2084  0489 c60c          	ldab	#12
2085                     ; 716         return (0u);
2087  048b               LC002:
2088  048b 6bf3000a      	stab	[OFST+6,s]
2089  048f c7            	clrb	
2091  0490               L64:
2093  0490 1b86          	leas	6,s
2094  0492 3d            	rts	
2095  0493               L327:
2096                     ; 719     if (OSIntNesting > 0u) {                              /* See if trying to call from an ISR          */
2098  0493 f60000        	ldab	_OSIntNesting
2099  0496 2704          	beq	L527
2100                     ; 720         *perr = OS_ERR_NAME_GET_ISR;
2102  0498 c611          	ldab	#17
2103                     ; 721         return (0u);
2106  049a 20ef          	bra	LC002
2107  049c               L527:
2108                     ; 723     OS_ENTER_CRITICAL();
2110  049c 160000        	jsr	_OS_CPU_SR_Save
2112  049f 6b80          	stab	OFST-4,s
2113                     ; 724     if (prio == OS_PRIO_SELF) {                          /* See if caller desires it's own name        */
2115  04a1 e685          	ldab	OFST+1,s
2116  04a3 c1ff          	cmpb	#255
2117  04a5 2608          	bne	L727
2118                     ; 725         prio = OSTCBCur->OSTCBPrio;
2120  04a7 fd0000        	ldy	_OSTCBCur
2121  04aa e6e824        	ldab	36,y
2122  04ad 6b85          	stab	OFST+1,s
2123  04af               L727:
2124                     ; 727     ptcb = OSTCBPrioTbl[prio];
2126  04af 87            	clra	
2127  04b0 59            	lsld	
2128  04b1 b746          	tfr	d,y
2129  04b3 ecea0000      	ldd	_OSTCBPrioTbl,y
2130  04b7 6c81          	std	OFST-3,s
2131                     ; 728     if (ptcb == (OS_TCB *)0) {                           /* Does task exist?                           */
2133  04b9 260a          	bne	L137
2134                     ; 729         OS_EXIT_CRITICAL();                              /* No                                         */
2137                     ; 730         *perr = OS_ERR_TASK_NOT_EXIST;
2139  04bb               LC003:
2140  04bb e680          	ldab	OFST-4,s
2141  04bd 87            	clra	
2142  04be 160000        	jsr	_OS_CPU_SR_Restore
2143  04c1 c643          	ldab	#67
2144                     ; 731         return (0u);
2147  04c3 20c6          	bra	LC002
2148  04c5               L137:
2149                     ; 733     if (ptcb == OS_TCB_RESERVED) {                       /* Task assigned to a Mutex?                  */
2151  04c5 8c0001        	cpd	#1
2152                     ; 734         OS_EXIT_CRITICAL();                              /* Yes                                        */
2155                     ; 735         *perr = OS_ERR_TASK_NOT_EXIST;
2157                     ; 736         return (0u);
2160  04c8 27f1          	beq	LC003
2161                     ; 738     *pname = ptcb->OSTCBTaskName;
2163  04ca b746          	tfr	d,y
2164  04cc ece83c        	ldd	60,y
2165  04cf ee88          	ldx	OFST+4,s
2166  04d1 6c00          	std	0,x
2167                     ; 739     len    = OS_StrLen(*pname);
2169  04d3 160000        	jsr	_OS_StrLen
2171  04d6 6b83          	stab	OFST-1,s
2172                     ; 740     OS_EXIT_CRITICAL();
2174  04d8 e680          	ldab	OFST-4,s
2175  04da 87            	clra	
2176  04db 160000        	jsr	_OS_CPU_SR_Restore
2178                     ; 741     *perr  = OS_ERR_NONE;
2180  04de 69f3000a      	clr	[OFST+6,s]
2181                     ; 742     return (len);
2183  04e2 e683          	ldab	OFST-1,s
2185  04e4 20aa          	bra	L64
2260                     ; 770 _NEAR void  OSTaskNameSet (INT8U   prio,
2260                     ; 771                           INT8U  *pname,
2260                     ; 772                           INT8U  *perr)
2260                     ; 773 {
2261                     	switch	.text
2262  04e6               _OSTaskNameSet:
2264  04e6 3b            	pshd	
2265  04e7 1b9d          	leas	-3,s
2266       00000003      OFST:	set	3
2269                     ; 776     OS_CPU_SR  cpu_sr = 0u;
2271                     ; 789     if (prio > OS_LOWEST_PRIO) {                     /* Task priority valid ?                          */
2273  04e9 c13f          	cmpb	#63
2274  04eb 2307          	bls	L177
2275                     ; 790         if (prio != OS_PRIO_SELF) {
2277  04ed 048104        	ibeq	b,L177
2278                     ; 791             *perr = OS_ERR_PRIO_INVALID;             /* No                                             */
2280  04f0 c62a          	ldab	#42
2281                     ; 792             return;
2283  04f2 2006          	bra	LC004
2284  04f4               L177:
2285                     ; 795     if (pname == (INT8U *)0) {                       /* Is 'pname' a NULL pointer?                     */
2287  04f4 ec87          	ldd	OFST+4,s
2288  04f6 2609          	bne	L577
2289                     ; 796         *perr = OS_ERR_PNAME_NULL;                   /* Yes                                            */
2291  04f8 c60c          	ldab	#12
2292  04fa               LC004:
2293  04fa 6bf30009      	stab	[OFST+6,s]
2294                     ; 797         return;
2295  04fe               L25:
2298  04fe 1b85          	leas	5,s
2299  0500 3d            	rts	
2300  0501               L577:
2301                     ; 800     if (OSIntNesting > 0u) {                         /* See if trying to call from an ISR              */
2303  0501 f60000        	ldab	_OSIntNesting
2304  0504 2704          	beq	L777
2305                     ; 801         *perr = OS_ERR_NAME_SET_ISR;
2307  0506 c612          	ldab	#18
2308                     ; 802         return;
2310  0508 20f0          	bra	LC004
2311  050a               L777:
2312                     ; 804     OS_ENTER_CRITICAL();
2314  050a 160000        	jsr	_OS_CPU_SR_Save
2316  050d 6b80          	stab	OFST-3,s
2317                     ; 805     if (prio == OS_PRIO_SELF) {                      /* See if caller desires to set it's own name     */
2319  050f e684          	ldab	OFST+1,s
2320  0511 c1ff          	cmpb	#255
2321  0513 2608          	bne	L1001
2322                     ; 806         prio = OSTCBCur->OSTCBPrio;
2324  0515 fd0000        	ldy	_OSTCBCur
2325  0518 e6e824        	ldab	36,y
2326  051b 6b84          	stab	OFST+1,s
2327  051d               L1001:
2328                     ; 808     ptcb = OSTCBPrioTbl[prio];
2330  051d 87            	clra	
2331  051e 59            	lsld	
2332  051f b746          	tfr	d,y
2333  0521 ecea0000      	ldd	_OSTCBPrioTbl,y
2334  0525 6c81          	std	OFST-2,s
2335                     ; 809     if (ptcb == (OS_TCB *)0) {                       /* Does task exist?                               */
2337  0527 260a          	bne	L3001
2338                     ; 810         OS_EXIT_CRITICAL();                          /* No                                             */
2341                     ; 811         *perr = OS_ERR_TASK_NOT_EXIST;
2343  0529               LC005:
2344  0529 e680          	ldab	OFST-3,s
2345  052b 87            	clra	
2346  052c 160000        	jsr	_OS_CPU_SR_Restore
2347  052f c643          	ldab	#67
2348                     ; 812         return;
2350  0531 20c7          	bra	LC004
2351  0533               L3001:
2352                     ; 814     if (ptcb == OS_TCB_RESERVED) {                   /* Task assigned to a Mutex?                      */
2354  0533 8c0001        	cpd	#1
2355                     ; 815         OS_EXIT_CRITICAL();                          /* Yes                                            */
2358                     ; 816         *perr = OS_ERR_TASK_NOT_EXIST;
2360                     ; 817         return;
2362  0536 27f1          	beq	LC005
2363                     ; 819     ptcb->OSTCBTaskName = pname;
2365  0538 ec87          	ldd	OFST+4,s
2366  053a ee81          	ldx	OFST-2,s
2367  053c 6ce03c        	std	60,x
2368                     ; 821     OS_EXIT_CRITICAL();
2371  053f e680          	ldab	OFST-3,s
2372  0541 87            	clra	
2373  0542 160000        	jsr	_OS_CPU_SR_Restore
2375                     ; 822     *perr               = OS_ERR_NONE;
2377  0545 69f30009      	clr	[OFST+6,s]
2378                     ; 823 }
2380  0549 20b3          	bra	L25
2437                     ; 846 _NEAR INT8U  OSTaskResume (INT8U prio)
2437                     ; 847 {
2438                     	switch	.text
2439  054b               _OSTaskResume:
2441  054b 3b            	pshd	
2442  054c 1b9d          	leas	-3,s
2443       00000003      OFST:	set	3
2446                     ; 850     OS_CPU_SR  cpu_sr = 0u;
2448                     ; 856     if (prio >= OS_LOWEST_PRIO) {                             /* Make sure task priority is valid      */
2450  054e c13f          	cmpb	#63
2451  0550 2504          	blo	L3301
2452                     ; 857         return (OS_ERR_PRIO_INVALID);
2454  0552 c62a          	ldab	#42
2456  0554 201a          	bra	L06
2457  0556               L3301:
2458                     ; 860     OS_ENTER_CRITICAL();
2460  0556 160000        	jsr	_OS_CPU_SR_Save
2462  0559 6b82          	stab	OFST-1,s
2463                     ; 861     ptcb = OSTCBPrioTbl[prio];
2465  055b e684          	ldab	OFST+1,s
2466  055d 87            	clra	
2467  055e 59            	lsld	
2468  055f b746          	tfr	d,y
2469  0561 ecea0000      	ldd	_OSTCBPrioTbl,y
2470  0565 6c80          	std	OFST-3,s
2471                     ; 862     if (ptcb == (OS_TCB *)0) {                                /* Task to suspend must exist            */
2473  0567 260a          	bne	L5301
2474                     ; 863         OS_EXIT_CRITICAL();
2476  0569 e682          	ldab	OFST-1,s
2477  056b 160000        	jsr	_OS_CPU_SR_Restore
2479                     ; 864         return (OS_ERR_TASK_RESUME_PRIO);
2481  056e c646          	ldab	#70
2483  0570               L06:
2485  0570 1b85          	leas	5,s
2486  0572 3d            	rts	
2487  0573               L5301:
2488                     ; 866     if (ptcb == OS_TCB_RESERVED) {                            /* See if assigned to Mutex              */
2490  0573 8c0001        	cpd	#1
2491  0576 260a          	bne	L7301
2492                     ; 867         OS_EXIT_CRITICAL();
2494  0578 e682          	ldab	OFST-1,s
2495  057a 87            	clra	
2496  057b 160000        	jsr	_OS_CPU_SR_Restore
2498                     ; 868         return (OS_ERR_TASK_NOT_EXIST);
2500  057e c643          	ldab	#67
2502  0580 20ee          	bra	L06
2503  0582               L7301:
2504                     ; 870     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) != OS_STAT_RDY) { /* Task must be suspended                */
2506  0582 b746          	tfr	d,y
2507  0584 0fe8220849    	brclr	34,y,8,L1401
2508                     ; 871         ptcb->OSTCBStat &= (INT8U)~(INT8U)OS_STAT_SUSPEND;    /* Remove suspension                     */
2510  0589 0de82208      	bclr	34,y,8
2511                     ; 872         if ((ptcb->OSTCBStat & OS_STAT_PEND_ANY) == OS_STAT_RDY) { /* See if task is now ready         */
2513  058d e6e822        	ldab	34,y
2514  0590 c537          	bitb	#55
2515  0592 2635          	bne	L5401
2516                     ; 873             if (ptcb->OSTCBDly == 0u) {
2518  0594 ece81e        	ldd	30,y
2519  0597 2630          	bne	L5401
2520  0599 ece820        	ldd	32,y
2521  059c 262b          	bne	L5401
2522                     ; 874                 OSRdyGrp               |= ptcb->OSTCBBitY;    /* Yes, Make task ready to run           */
2524  059e e6e828        	ldab	40,y
2525  05a1 fa0000        	orab	_OSRdyGrp
2526  05a4 7b0000        	stab	_OSRdyGrp
2527                     ; 875                 OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
2529  05a7 e6e826        	ldab	38,y
2530  05aa b746          	tfr	d,y
2531  05ac ee80          	ldx	OFST-3,s
2532  05ae e6e027        	ldab	39,x
2533  05b1 eaea0000      	orab	_OSRdyTbl,y
2534  05b5 6bea0000      	stab	_OSRdyTbl,y
2535                     ; 877                 OS_EXIT_CRITICAL();
2538  05b9 e682          	ldab	OFST-1,s
2539  05bb 160000        	jsr	_OS_CPU_SR_Restore
2541                     ; 878                 if (OSRunning == OS_TRUE) {
2543  05be f60000        	ldab	_OSRunning
2544  05c1 04210b        	dbne	b,L3501
2545                     ; 880                     OS_Sched();                               /* Find new highest priority task        */
2548  05c4 160000        	jsr	_OS_Sched
2550  05c7 2006          	bra	L3501
2551  05c9               L5401:
2552                     ; 883                 OS_EXIT_CRITICAL();
2555                     ; 886             OS_EXIT_CRITICAL();
2557  05c9 e682          	ldab	OFST-1,s
2558  05cb 87            	clra	
2559  05cc 160000        	jsr	_OS_CPU_SR_Restore
2561  05cf               L3501:
2562                     ; 888         return (OS_ERR_NONE);
2564  05cf c7            	clrb	
2566  05d0 2008          	bra	L26
2567  05d2               L1401:
2568                     ; 890     OS_EXIT_CRITICAL();
2570  05d2 e682          	ldab	OFST-1,s
2571  05d4 87            	clra	
2572  05d5 160000        	jsr	_OS_CPU_SR_Restore
2574                     ; 891     return (OS_ERR_TASK_NOT_SUSPENDED);
2576  05d8 c644          	ldab	#68
2578  05da               L26:
2580  05da 1b85          	leas	5,s
2581  05dc 3d            	rts	
2692                     ; 916 _NEAR INT8U  OSTaskStkChk (INT8U         prio,
2692                     ; 917                           OS_STK_DATA  *p_stk_data)
2692                     ; 918 {
2693                     	switch	.text
2694  05dd               _OSTaskStkChk:
2696  05dd 3b            	pshd	
2697  05de 1b95          	leas	-11,s
2698       0000000b      OFST:	set	11
2701                     ; 924     OS_CPU_SR  cpu_sr = 0u;
2703                     ; 930     if (prio > OS_LOWEST_PRIO) {                       /* Make sure task priority is valid             */
2705  05e0 c13f          	cmpb	#63
2706  05e2 2307          	bls	L7211
2707                     ; 931         if (prio != OS_PRIO_SELF) {
2709  05e4 048104        	ibeq	b,L7211
2710                     ; 932             return (OS_ERR_PRIO_INVALID);
2712  05e7 c62a          	ldab	#42
2714  05e9 2006          	bra	L07
2715  05eb               L7211:
2716                     ; 935     if (p_stk_data == (OS_STK_DATA *)0) {              /* Validate 'p_stk_data'                        */
2718  05eb ed8f          	ldy	OFST+4,s
2719  05ed 2605          	bne	L3311
2720                     ; 936         return (OS_ERR_PDATA_NULL);
2722  05ef c609          	ldab	#9
2724  05f1               L07:
2726  05f1 1b8d          	leas	13,s
2727  05f3 3d            	rts	
2728  05f4               L3311:
2729                     ; 939     p_stk_data->OSFree = 0u;                           /* Assume failure, set to 0 size                */
2731  05f4 87            	clra	
2732  05f5 c7            	clrb	
2733  05f6 6c42          	std	2,y
2734  05f8 6c40          	std	0,y
2735                     ; 940     p_stk_data->OSUsed = 0u;
2737  05fa 6c46          	std	6,y
2738  05fc 6c44          	std	4,y
2739                     ; 941     OS_ENTER_CRITICAL();
2741  05fe 160000        	jsr	_OS_CPU_SR_Save
2743  0601 6b86          	stab	OFST-5,s
2744                     ; 942     if (prio == OS_PRIO_SELF) {                        /* See if check for SELF                        */
2746  0603 e68c          	ldab	OFST+1,s
2747  0605 c1ff          	cmpb	#255
2748  0607 2608          	bne	L5311
2749                     ; 943         prio = OSTCBCur->OSTCBPrio;
2751  0609 fd0000        	ldy	_OSTCBCur
2752  060c e6e824        	ldab	36,y
2753  060f 6b8c          	stab	OFST+1,s
2754  0611               L5311:
2755                     ; 945     ptcb = OSTCBPrioTbl[prio];
2757  0611 87            	clra	
2758  0612 59            	lsld	
2759  0613 b746          	tfr	d,y
2760  0615 ecea0000      	ldd	_OSTCBPrioTbl,y
2761  0619 6c80          	std	OFST-11,s
2762                     ; 946     if (ptcb == (OS_TCB *)0) {                         /* Make sure task exist                         */
2764  061b 2609          	bne	L7311
2765                     ; 947         OS_EXIT_CRITICAL();
2767  061d e686          	ldab	OFST-5,s
2768  061f 160000        	jsr	_OS_CPU_SR_Restore
2770                     ; 948         return (OS_ERR_TASK_NOT_EXIST);
2772  0622 c643          	ldab	#67
2774  0624 20cb          	bra	L07
2775  0626               L7311:
2776                     ; 950     if (ptcb == OS_TCB_RESERVED) {
2778  0626 8c0001        	cpd	#1
2779  0629 260a          	bne	L1411
2780                     ; 951         OS_EXIT_CRITICAL();
2782  062b e686          	ldab	OFST-5,s
2783  062d 87            	clra	
2784  062e 160000        	jsr	_OS_CPU_SR_Restore
2786                     ; 952         return (OS_ERR_TASK_NOT_EXIST);
2788  0631 c643          	ldab	#67
2790  0633 20bc          	bra	L07
2791  0635               L1411:
2792                     ; 954     if ((ptcb->OSTCBOpt & OS_TASK_OPT_STK_CHK) == 0u) { /* Make sure stack checking option is set      */
2794  0635 b746          	tfr	d,y
2795  0637 0e4b010a      	brset	11,y,1,L3411
2796                     ; 955         OS_EXIT_CRITICAL();
2798  063b e686          	ldab	OFST-5,s
2799  063d 87            	clra	
2800  063e 160000        	jsr	_OS_CPU_SR_Restore
2802                     ; 956         return (OS_ERR_TASK_OPT);
2804  0641 c645          	ldab	#69
2806  0643 20ac          	bra	L07
2807  0645               L3411:
2808                     ; 958     nfree = 0u;
2810  0645 87            	clra	
2811  0646 c7            	clrb	
2812  0647 6c84          	std	OFST-7,s
2813  0649 6c82          	std	OFST-9,s
2814                     ; 959     size  = ptcb->OSTCBStkSize;
2816  064b 18024889      	movw	8,y,OFST-2,s
2817  064f 18024687      	movw	6,y,OFST-4,s
2818                     ; 960     pchk  = ptcb->OSTCBStkBottom;
2820  0653 18024480      	movw	4,y,OFST-11,s
2821                     ; 961     OS_EXIT_CRITICAL();
2823  0657 e686          	ldab	OFST-5,s
2824  0659 160000        	jsr	_OS_CPU_SR_Restore
2827  065c ed80          	ldy	OFST-11,s
2828  065e 200f          	bra	L66
2829  0660               L5411:
2830                     ; 964         nfree++;
2832  0660 ec84          	ldd	OFST-7,s
2833  0662 c30001        	addd	#1
2834  0665 6c84          	std	OFST-7,s
2835  0667 2406          	bcc	L66
2836  0669 6283          	inc	OFST-8,s
2837  066b 2602          	bne	L66
2838  066d 6282          	inc	OFST-9,s
2839  066f               L66:
2840                     ; 963     while (*pchk++ == (OS_STK)0) {                    /* Compute the number of zero entries on the stk */
2842  066f e670          	ldab	1,y+
2843  0671 6d80          	sty	OFST-11,s
2844  0673 0451ea        	tbeq	b,L5411
2845                     ; 971     p_stk_data->OSFree = nfree;                       /* Store   number of free entries on the stk     */
2847  0676 ed8f          	ldy	OFST+4,s
2848  0678 18028442      	movw	OFST-7,s,2,y
2849  067c 18028240      	movw	OFST-9,s,0,y
2850                     ; 972     p_stk_data->OSUsed = size - nfree;                /* Compute number of entries used on the stk     */
2852  0680 ec89          	ldd	OFST-2,s
2853  0682 ee87          	ldx	OFST-4,s
2854  0684 1982          	leay	OFST-9,s
2855  0686 160000        	jsr	c_lsub
2857  0689 ed8f          	ldy	OFST+4,s
2858  068b 6c46          	std	6,y
2859  068d 6e44          	stx	4,y
2860                     ; 973     return (OS_ERR_NONE);
2862  068f c7            	clrb	
2865  0690 1b8d          	leas	13,s
2866  0692 3d            	rts	
2937                     ; 1002 _NEAR INT8U  OSTaskSuspend (INT8U prio)
2937                     ; 1003 {
2938                     	switch	.text
2939  0693               _OSTaskSuspend:
2941  0693 3b            	pshd	
2942  0694 1b9b          	leas	-5,s
2943       00000005      OFST:	set	5
2946                     ; 1008     OS_CPU_SR  cpu_sr = 0u;
2948                     ; 1014     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to suspend idle task    */
2950  0696 c13f          	cmpb	#63
2951  0698 2604          	bne	L3021
2952                     ; 1015         return (OS_ERR_TASK_SUSPEND_IDLE);
2954  069a c647          	ldab	#71
2956  069c 200b          	bra	L47
2957  069e               L3021:
2958                     ; 1017     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
2960  069e e686          	ldab	OFST+1,s
2961  06a0 c13f          	cmpb	#63
2962  06a2 2508          	blo	L5021
2963                     ; 1018         if (prio != OS_PRIO_SELF) {
2965  06a4 048105        	ibeq	b,L5021
2966                     ; 1019             return (OS_ERR_PRIO_INVALID);
2968  06a7 c62a          	ldab	#42
2970  06a9               L47:
2972  06a9 1b87          	leas	7,s
2973  06ab 3d            	rts	
2974  06ac               L5021:
2975                     ; 1023     OS_ENTER_CRITICAL();
2977  06ac 160000        	jsr	_OS_CPU_SR_Save
2979  06af 6b82          	stab	OFST-3,s
2980                     ; 1024     if (prio == OS_PRIO_SELF) {                                 /* See if suspend SELF                 */
2982  06b1 e686          	ldab	OFST+1,s
2983  06b3 c1ff          	cmpb	#255
2984  06b5 260a          	bne	L1121
2985                     ; 1025         prio = OSTCBCur->OSTCBPrio;
2987  06b7 fd0000        	ldy	_OSTCBCur
2988  06ba e6e824        	ldab	36,y
2989  06bd 6b86          	stab	OFST+1,s
2990                     ; 1026         self = OS_TRUE;
2993  06bf 2008          	bra	LC007
2994  06c1               L1121:
2995                     ; 1027     } else if (prio == OSTCBCur->OSTCBPrio) {                   /* See if suspending self              */
2997  06c1 fd0000        	ldy	_OSTCBCur
2998  06c4 e1e824        	cmpb	36,y
2999  06c7 2608          	bne	L5121
3000                     ; 1028         self = OS_TRUE;
3002  06c9               LC007:
3003  06c9 c601          	ldab	#1
3004  06cb 6b83          	stab	OFST-2,s
3006  06cd e686          	ldab	OFST+1,s
3007  06cf 2002          	bra	L3121
3008  06d1               L5121:
3009                     ; 1030         self = OS_FALSE;                                        /* No suspending another task          */
3011  06d1 6983          	clr	OFST-2,s
3012  06d3               L3121:
3013                     ; 1032     ptcb = OSTCBPrioTbl[prio];
3015  06d3 87            	clra	
3016  06d4 59            	lsld	
3017  06d5 b746          	tfr	d,y
3018  06d7 ecea0000      	ldd	_OSTCBPrioTbl,y
3019  06db 6c80          	std	OFST-5,s
3020                     ; 1033     if (ptcb == (OS_TCB *)0) {                                  /* Task to suspend must exist          */
3022  06dd 2609          	bne	L1221
3023                     ; 1034         OS_EXIT_CRITICAL();
3025  06df e682          	ldab	OFST-3,s
3026  06e1 160000        	jsr	_OS_CPU_SR_Restore
3028                     ; 1035         return (OS_ERR_TASK_SUSPEND_PRIO);
3030  06e4 c648          	ldab	#72
3032  06e6 20c1          	bra	L47
3033  06e8               L1221:
3034                     ; 1037     if (ptcb == OS_TCB_RESERVED) {                              /* See if assigned to Mutex            */
3036  06e8 8c0001        	cpd	#1
3037  06eb 260a          	bne	L3221
3038                     ; 1038         OS_EXIT_CRITICAL();
3040  06ed e682          	ldab	OFST-3,s
3041  06ef 87            	clra	
3042  06f0 160000        	jsr	_OS_CPU_SR_Restore
3044                     ; 1039         return (OS_ERR_TASK_NOT_EXIST);
3046  06f3 c643          	ldab	#67
3048  06f5 20b2          	bra	L47
3049  06f7               L3221:
3050                     ; 1041     y            = ptcb->OSTCBY;
3052  06f7 b746          	tfr	d,y
3053  06f9 e6e826        	ldab	38,y
3054  06fc 6b84          	stab	OFST-1,s
3055                     ; 1042     OSRdyTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;                   /* Make task not ready                 */
3057  06fe b796          	exg	b,y
3058  0700 ee80          	ldx	OFST-5,s
3059  0702 e6e027        	ldab	39,x
3060  0705 51            	comb	
3061  0706 e4ea0000      	andb	_OSRdyTbl,y
3062  070a 6bea0000      	stab	_OSRdyTbl,y
3063                     ; 1043     if (OSRdyTbl[y] == 0u) {
3065  070e 260c          	bne	L5221
3066                     ; 1044         OSRdyGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
3068  0710 b756          	tfr	x,y
3069  0712 e6e828        	ldab	40,y
3070  0715 51            	comb	
3071  0716 f40000        	andb	_OSRdyGrp
3072  0719 7b0000        	stab	_OSRdyGrp
3073  071c               L5221:
3074                     ; 1046     ptcb->OSTCBStat |= OS_STAT_SUSPEND;                         /* Status of task is 'SUSPENDED'       */
3076  071c b756          	tfr	x,y
3077  071e 0ce82208      	bset	34,y,8
3078                     ; 1047     OS_EXIT_CRITICAL();
3080  0722 e682          	ldab	OFST-3,s
3081  0724 87            	clra	
3082  0725 160000        	jsr	_OS_CPU_SR_Restore
3084                     ; 1050     if (self == OS_TRUE) {                                      /* Context switch only if SELF         */
3088  0728 e683          	ldab	OFST-2,s
3089  072a 042103        	dbne	b,L7221
3090                     ; 1051         OS_Sched();                                             /* Find new highest priority task      */
3092  072d 160000        	jsr	_OS_Sched
3094  0730               L7221:
3095                     ; 1053     return (OS_ERR_NONE);
3097  0730 c7            	clrb	
3100  0731 1b87          	leas	7,s
3101  0733 3d            	rts	
3168                     ; 1078 _NEAR INT8U  OSTaskQuery (INT8U    prio,
3168                     ; 1079                          OS_TCB  *p_task_data)
3168                     ; 1080 {
3169                     	switch	.text
3170  0734               _OSTaskQuery:
3172  0734 3b            	pshd	
3173  0735 1b9d          	leas	-3,s
3174       00000003      OFST:	set	3
3177                     ; 1083     OS_CPU_SR  cpu_sr = 0u;
3179                     ; 1089     if (prio > OS_LOWEST_PRIO) {                 /* Task priority valid ?                              */
3181  0737 c13f          	cmpb	#63
3182  0739 2307          	bls	L3621
3183                     ; 1090         if (prio != OS_PRIO_SELF) {
3185  073b 048104        	ibeq	b,L3621
3186                     ; 1091             return (OS_ERR_PRIO_INVALID);
3188  073e c62a          	ldab	#42
3190  0740 2006          	bra	L001
3191  0742               L3621:
3192                     ; 1094     if (p_task_data == (OS_TCB *)0) {            /* Validate 'p_task_data'                             */
3194  0742 ec87          	ldd	OFST+4,s
3195  0744 2605          	bne	L7621
3196                     ; 1095         return (OS_ERR_PDATA_NULL);
3198  0746 c609          	ldab	#9
3200  0748               L001:
3202  0748 1b85          	leas	5,s
3203  074a 3d            	rts	
3204  074b               L7621:
3205                     ; 1098     OS_ENTER_CRITICAL();
3207  074b 160000        	jsr	_OS_CPU_SR_Save
3209  074e 6b80          	stab	OFST-3,s
3210                     ; 1099     if (prio == OS_PRIO_SELF) {                  /* See if suspend SELF                                */
3212  0750 e684          	ldab	OFST+1,s
3213  0752 c1ff          	cmpb	#255
3214  0754 2608          	bne	L1721
3215                     ; 1100         prio = OSTCBCur->OSTCBPrio;
3217  0756 fd0000        	ldy	_OSTCBCur
3218  0759 e6e824        	ldab	36,y
3219  075c 6b84          	stab	OFST+1,s
3220  075e               L1721:
3221                     ; 1102     ptcb = OSTCBPrioTbl[prio];
3223  075e 87            	clra	
3224  075f 59            	lsld	
3225  0760 b746          	tfr	d,y
3226  0762 ecea0000      	ldd	_OSTCBPrioTbl,y
3227  0766 6c81          	std	OFST-2,s
3228                     ; 1103     if (ptcb == (OS_TCB *)0) {                   /* Task to query must exist                           */
3230  0768 2609          	bne	L3721
3231                     ; 1104         OS_EXIT_CRITICAL();
3233  076a e680          	ldab	OFST-3,s
3234  076c 160000        	jsr	_OS_CPU_SR_Restore
3236                     ; 1105         return (OS_ERR_PRIO);
3238  076f c629          	ldab	#41
3240  0771 20d5          	bra	L001
3241  0773               L3721:
3242                     ; 1107     if (ptcb == OS_TCB_RESERVED) {               /* Task to query must not be assigned to a Mutex      */
3244  0773 042409        	dbne	d,L5721
3245                     ; 1108         OS_EXIT_CRITICAL();
3247  0776 e680          	ldab	OFST-3,s
3248  0778 160000        	jsr	_OS_CPU_SR_Restore
3250                     ; 1109         return (OS_ERR_TASK_NOT_EXIST);
3252  077b c643          	ldab	#67
3254  077d 20c9          	bra	L001
3255  077f               L5721:
3256                     ; 1112     OS_MemCopy((INT8U *)p_task_data, (INT8U *)ptcb, sizeof(OS_TCB));
3258  077f cc003e        	ldd	#62
3259  0782 3b            	pshd	
3260  0783 ec83          	ldd	OFST+0,s
3261  0785 3b            	pshd	
3262  0786 ec8b          	ldd	OFST+8,s
3263  0788 160000        	jsr	_OS_MemCopy
3265  078b 1b84          	leas	4,s
3266                     ; 1113     OS_EXIT_CRITICAL();
3268  078d e680          	ldab	OFST-3,s
3269  078f 87            	clra	
3270  0790 160000        	jsr	_OS_CPU_SR_Restore
3272                     ; 1114     return (OS_ERR_NONE);
3274  0793 c7            	clrb	
3276  0794 20b2          	bra	L001
3301                     ; 1327 _NEAR void  OS_TaskReturn (void)
3301                     ; 1328 {
3302                     	switch	.text
3303  0796               _OS_TaskReturn:
3307                     ; 1329     OSTaskReturnHook(OSTCBCur);                   /* Call hook to let user decide on what to do        */
3309  0796 fc0000        	ldd	_OSTCBCur
3310  0799 160000        	jsr	_OSTaskReturnHook
3312                     ; 1332     (void)OSTaskDel(OS_PRIO_SELF);                /* Delete task if it accidentally returns!           */
3314  079c cc00ff        	ldd	#255
3315  079f 1602de        	jsr	_OSTaskDel
3317                     ; 1338 }
3320  07a2 3d            	rts	
3368                     ; 1364 _NEAR void  OS_TaskStkClr (OS_STK  *pbos,
3368                     ; 1365                      INT32U   size,
3368                     ; 1366                      INT16U   opt)
3368                     ; 1367 {
3369                     	switch	.text
3370  07a3               _OS_TaskStkClr:
3372  07a3 3b            	pshd	
3373       00000000      OFST:	set	0
3376                     ; 1368     if ((opt & OS_TASK_OPT_STK_CHK) != 0x0000u) {      /* See if stack checking has been enabled       */
3378  07a4 e689          	ldab	OFST+9,s
3379  07a6 c501          	bitb	#1
3380  07a8 2723          	beq	L1331
3381                     ; 1369         if ((opt & OS_TASK_OPT_STK_CLR) != 0x0000u) {  /* See if stack needs to be cleared             */
3383  07aa c502          	bitb	#2
3384  07ac 271f          	beq	L1331
3386  07ae 2015          	bra	L7331
3387  07b0               L5331:
3388                     ; 1372                 size--;
3390  07b0 ec86          	ldd	OFST+6,s
3391  07b2 830001        	subd	#1
3392  07b5 6c86          	std	OFST+6,s
3393  07b7 ec84          	ldd	OFST+4,s
3394  07b9 c200          	sbcb	#0
3395  07bb 8200          	sbca	#0
3396  07bd 6c84          	std	OFST+4,s
3397                     ; 1373                 *pbos++ = (OS_STK)0;                   /* Clear from bottom of stack and up!           */
3399  07bf ed80          	ldy	OFST+0,s
3400  07c1 6970          	clr	1,y+
3401  07c3 6d80          	sty	OFST+0,s
3402  07c5               L7331:
3403                     ; 1371             while (size > 0u) {                        /* Stack grows from HIGH to LOW memory          */
3405  07c5 ec84          	ldd	OFST+4,s
3406  07c7 26e7          	bne	L5331
3407  07c9 ec86          	ldd	OFST+6,s
3408  07cb 26e3          	bne	L5331
3409  07cd               L1331:
3410                     ; 1383 }
3413  07cd 31            	puly	
3414  07ce 3d            	rts	
3426                     	xref	_OSTaskStkInit
3427                     	xref	_OSTaskReturnHook
3428                     	xref	_OSTaskDelHook
3429                     	xref	_OS_TCBInit
3430                     	xdef	_OS_TaskStkClr
3431                     	xdef	_OS_TaskReturn
3432                     	xref	_OS_StrLen
3433                     	xref	_OS_Sched
3434                     	xref	_OS_MemCopy
3435                     	xref	_OS_FlagUnlink
3436                     	xref	_OS_EventTaskRemoveMulti
3437                     	xref	_OS_EventTaskRemove
3438                     	xref	_OS_Dummy
3439                     	xdef	_OSTaskQuery
3440                     	xdef	_OSTaskStkChk
3441                     	xdef	_OSTaskSuspend
3442                     	xdef	_OSTaskResume
3443                     	xdef	_OSTaskNameSet
3444                     	xdef	_OSTaskNameGet
3445                     	xdef	_OSTaskDelReq
3446                     	xdef	_OSTaskDel
3447                     	xdef	_OSTaskCreateExt
3448                     	xdef	_OSTaskCreate
3449                     	xdef	_OSTaskChangePrio
3450                     	xref	_OSTCBPrioTbl
3451                     	xref	_OSTCBList
3452                     	xref	_OSTCBFreeList
3453                     	xref	_OSTCBCur
3454                     	xref	_OSTaskCtr
3455                     	xref	_OSRunning
3456                     	xref	_OSRdyTbl
3457                     	xref	_OSRdyGrp
3458                     	xref	_OSLockNesting
3459                     	xref	_OSIntNesting
3460                     	xref	_OS_CPU_SR_Restore
3461                     	xref	_OS_CPU_SR_Save
3462                     .const:	section	.data
3463  0000               L316:
3464  0000 3f00          	dc.b	"?",0
3485                     	xref	c_lsub
3486                     	end

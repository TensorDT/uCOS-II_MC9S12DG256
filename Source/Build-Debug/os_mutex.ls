   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4109                     ; 93 _NEAR BOOLEAN  OSMutexAccept (OS_EVENT  *pevent,
4109                     ; 94                              INT8U     *perr)
4109                     ; 95 {
4110                     	switch	.text
4111  0000               _OSMutexAccept:
4113  0000 3b            	pshd	
4114       00000002      OFST:	set	2
4117                     ; 98     OS_CPU_SR  cpu_sr = 0u;
4119                     ; 111     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
4121  0001 6cae          	std	2,-s
4122  0003 2604          	bne	L1372
4123                     ; 112         *perr = OS_ERR_PEVENT_NULL;
4125  0005 c604          	ldab	#4
4126                     ; 113         return (OS_FALSE);
4129  0007 200a          	bra	LC001
4130  0009               L1372:
4131                     ; 116     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {  /* Validate event block type                    */
4133  0009 e6f30002      	ldab	[OFST+0,s]
4134  000d c104          	cmpb	#4
4135  000f 270a          	beq	L3372
4136                     ; 117         *perr = OS_ERR_EVENT_TYPE;
4138  0011 c601          	ldab	#1
4139                     ; 118         return (OS_FALSE);
4141  0013               LC001:
4142  0013 6bf30006      	stab	[OFST+4,s]
4143  0017 c7            	clrb	
4145  0018               L6:
4147  0018 1b84          	leas	4,s
4148  001a 3d            	rts	
4149  001b               L3372:
4150                     ; 120     if (OSIntNesting > 0u) {                           /* Make sure it's not called from an ISR        */
4152  001b f60000        	ldab	_OSIntNesting
4153  001e 2704          	beq	L5372
4154                     ; 121         *perr = OS_ERR_PEND_ISR;
4156  0020 c602          	ldab	#2
4157                     ; 122         return (OS_FALSE);
4160  0022 20ef          	bra	LC001
4161  0024               L5372:
4162                     ; 124     OS_ENTER_CRITICAL();                               /* Get value (0 or 1) of Mutex                  */
4164  0024 160000        	jsr	_OS_CPU_SR_Save
4166  0027 6b80          	stab	OFST-2,s
4167                     ; 125     pcp = (INT8U)(pevent->OSEventCnt >> 8u);           /* Get PCP from mutex                           */
4169  0029 ed82          	ldy	OFST+0,s
4170  002b 180a4381      	movb	3,y,OFST-1,s
4171                     ; 126     if ((pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8) == OS_MUTEX_AVAILABLE) {
4173  002f e644          	ldab	4,y
4174  0031 87            	clra	
4175  0032 8c00ff        	cpd	#255
4176  0035 263a          	bne	L7372
4177                     ; 127         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;   /*      Mask off LSByte (Acquire Mutex)         */
4179  0037 6a44          	staa	4,y
4180                     ; 128         pevent->OSEventCnt |= (INT16U)OSTCBCur->OSTCBPrio;  /* Save current task priority in LSByte    */
4182  0039 fe0000        	ldx	_OSTCBCur
4183  003c e6e024        	ldab	36,x
4184  003f ea44          	orab	4,y
4185  0041 aa43          	oraa	3,y
4186  0043 6c43          	std	3,y
4187                     ; 129         pevent->OSEventPtr  = (void *)OSTCBCur;        /*      Link TCB of task owning Mutex           */
4189  0045 6e41          	stx	1,y
4190                     ; 130         if ((pcp != OS_PRIO_MUTEX_CEIL_DIS) &&
4190                     ; 131             (OSTCBCur->OSTCBPrio <= pcp)) {            /*      PCP 'must' have a SMALLER prio ...      */
4192  0047 e681          	ldab	OFST-1,s
4193  0049 048117        	ibeq	b,L1472
4195  004c b756          	tfr	x,y
4196  004e e6e824        	ldab	36,y
4197  0051 e181          	cmpb	OFST-1,s
4198  0053 220e          	bhi	L1472
4199                     ; 132              OS_EXIT_CRITICAL();                       /*      ... than current task!                  */
4201  0055 e680          	ldab	OFST-2,s
4202  0057 87            	clra	
4203  0058 160000        	jsr	_OS_CPU_SR_Restore
4205                     ; 133             *perr = OS_ERR_PCP_LOWER;
4207  005b c678          	ldab	#120
4208  005d 6bf30006      	stab	[OFST+4,s]
4210  0061 200a          	bra	L3472
4211  0063               L1472:
4212                     ; 135              OS_EXIT_CRITICAL();
4214  0063 e680          	ldab	OFST-2,s
4215  0065 87            	clra	
4216  0066 160000        	jsr	_OS_CPU_SR_Restore
4218                     ; 136             *perr = OS_ERR_NONE;
4220  0069 69f30006      	clr	[OFST+4,s]
4221  006d               L3472:
4222                     ; 138         return (OS_TRUE);
4224  006d c601          	ldab	#1
4226  006f 20a7          	bra	L6
4227  0071               L7372:
4228                     ; 140     OS_EXIT_CRITICAL();
4230  0071 e680          	ldab	OFST-2,s
4231  0073 160000        	jsr	_OS_CPU_SR_Restore
4233                     ; 141     *perr = OS_ERR_NONE;
4235  0076 c7            	clrb	
4236  0077 6bf30006      	stab	[OFST+4,s]
4237                     ; 142     return (OS_FALSE);
4241  007b 1b84          	leas	4,s
4242  007d 3d            	rts	
4311                     ; 187 _NEAR OS_EVENT  *OSMutexCreate (INT8U   prio,
4311                     ; 188                                INT8U  *perr)
4311                     ; 189 {
4312                     	switch	.text
4313  007e               _OSMutexCreate:
4315  007e 3b            	pshd	
4316  007f 1b9d          	leas	-3,s
4317       00000003      OFST:	set	3
4320                     ; 192     OS_CPU_SR  cpu_sr = 0u;
4322                     ; 213     if (prio != OS_PRIO_MUTEX_CEIL_DIS) {
4324  0081 c1ff          	cmpb	#255
4325  0083 2708          	beq	L7772
4326                     ; 214         if (prio >= OS_LOWEST_PRIO) {                      /* Validate PCP                             */
4328  0085 c13f          	cmpb	#63
4329  0087 2504          	blo	L7772
4330                     ; 215            *perr = OS_ERR_PRIO_INVALID;
4332  0089 c62a          	ldab	#42
4333                     ; 216             return ((OS_EVENT *)0);
4336  008b 2007          	bra	LC002
4337  008d               L7772:
4338                     ; 220     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4340  008d f60000        	ldab	_OSIntNesting
4341  0090 270b          	beq	L3003
4342                     ; 221         *perr = OS_ERR_CREATE_ISR;                         /* ... can't CREATE mutex from an ISR       */
4344  0092 c610          	ldab	#16
4345                     ; 222         return ((OS_EVENT *)0);
4347  0094               LC002:
4348  0094 6bf30007      	stab	[OFST+4,s]
4349  0098 87            	clra	
4350  0099 c7            	clrb	
4352  009a               L21:
4354  009a 1b85          	leas	5,s
4355  009c 3d            	rts	
4356  009d               L3003:
4357                     ; 224     OS_ENTER_CRITICAL();
4359  009d 160000        	jsr	_OS_CPU_SR_Save
4361  00a0 6b82          	stab	OFST-1,s
4362                     ; 225     if (prio != OS_PRIO_MUTEX_CEIL_DIS) {
4364  00a2 e684          	ldab	OFST+1,s
4365  00a4 c1ff          	cmpb	#255
4366  00a6 2720          	beq	L5003
4367                     ; 226         if (OSTCBPrioTbl[prio] != (OS_TCB *)0) {           /* Mutex priority must not already exist    */
4369  00a8 87            	clra	
4370  00a9 59            	lsld	
4371  00aa b746          	tfr	d,y
4372  00ac ecea0000      	ldd	_OSTCBPrioTbl,y
4373  00b0 270a          	beq	L7003
4374                     ; 227             OS_EXIT_CRITICAL();                            /* Task already exist at priority ...       */
4376  00b2 e682          	ldab	OFST-1,s
4377  00b4 87            	clra	
4378  00b5 160000        	jsr	_OS_CPU_SR_Restore
4380                     ; 228            *perr = OS_ERR_PRIO_EXIST;                      /* ... ceiling priority                     */
4382  00b8 c628          	ldab	#40
4383                     ; 229             return ((OS_EVENT *)0);
4386  00ba 20d8          	bra	LC002
4387  00bc               L7003:
4388                     ; 231         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;              /* Reserve the table entry                  */
4390  00bc e684          	ldab	OFST+1,s
4391  00be 59            	lsld	
4392  00bf b746          	tfr	d,y
4393  00c1 cc0001        	ldd	#1
4394  00c4 6cea0000      	std	_OSTCBPrioTbl,y
4395  00c8               L5003:
4396                     ; 234     pevent = OSEventFreeList;                              /* Get next free event control block        */
4398  00c8 fc0000        	ldd	_OSEventFreeList
4399  00cb 6c80          	std	OFST-3,s
4400                     ; 235     if (pevent == (OS_EVENT *)0) {                         /* See if an ECB was available              */
4402  00cd 261f          	bne	L1103
4403                     ; 236         if (prio != OS_PRIO_MUTEX_CEIL_DIS) {
4405  00cf e684          	ldab	OFST+1,s
4406  00d1 c1ff          	cmpb	#255
4407  00d3 2709          	beq	L3103
4408                     ; 237             OSTCBPrioTbl[prio] = (OS_TCB *)0;              /* No, Release the table entry              */
4410  00d5 59            	lsld	
4411  00d6 b746          	tfr	d,y
4412  00d8 87            	clra	
4413  00d9 c7            	clrb	
4414  00da 6cea0000      	std	_OSTCBPrioTbl,y
4415  00de               L3103:
4416                     ; 239         OS_EXIT_CRITICAL();
4418  00de e682          	ldab	OFST-1,s
4419  00e0 87            	clra	
4420  00e1 160000        	jsr	_OS_CPU_SR_Restore
4422                     ; 240        *perr = OS_ERR_PEVENT_NULL;                         /* No more event control blocks             */
4424  00e4 c604          	ldab	#4
4425  00e6 6bf30007      	stab	[OFST+4,s]
4426                     ; 241         return (pevent);
4428  00ea ec80          	ldd	OFST-3,s
4430  00ec 20ac          	bra	L21
4431  00ee               L1103:
4432                     ; 243     OSEventFreeList     = (OS_EVENT *)OSEventFreeList->OSEventPtr; /* Adjust the free list             */
4434  00ee b746          	tfr	d,y
4435  00f0 1805410000    	movw	1,y,_OSEventFreeList
4436                     ; 244     OS_EXIT_CRITICAL();
4438  00f5 e682          	ldab	OFST-1,s
4439  00f7 87            	clra	
4440  00f8 160000        	jsr	_OS_CPU_SR_Restore
4442                     ; 245     pevent->OSEventType = OS_EVENT_TYPE_MUTEX;
4444  00fb c604          	ldab	#4
4445  00fd ed80          	ldy	OFST-3,s
4446  00ff 6b40          	stab	0,y
4447                     ; 246     pevent->OSEventCnt  = (INT16U)((INT16U)prio << 8u) | OS_MUTEX_AVAILABLE; /* Resource is avail.     */
4449  0101 cc00ff        	ldd	#255
4450  0104 aa84          	oraa	OFST+1,s
4451  0106 6c43          	std	3,y
4452                     ; 247     pevent->OSEventPtr  = (void *)0;                       /* No task owning the mutex                 */
4454  0108 87            	clra	
4455  0109 c7            	clrb	
4456  010a 6c41          	std	1,y
4457                     ; 249     pevent->OSEventName = (INT8U *)(void *)"?";
4459  010c cc0000        	ldd	#L5103
4460  010f 6c4e          	std	14,y
4461                     ; 251     OS_EventWaitListInit(pevent);
4463  0111 b764          	tfr	y,d
4464  0113 160000        	jsr	_OS_EventWaitListInit
4466                     ; 253    *perr = OS_ERR_NONE;
4469  0116 69f30007      	clr	[OFST+4,s]
4470                     ; 254     return (pevent);
4472  011a ec80          	ldd	OFST-3,s
4475  011c 1b85          	leas	5,s
4476  011e 3d            	rts	
4912                     ; 301 _NEAR OS_EVENT  *OSMutexDel (OS_EVENT  *pevent,
4912                     ; 302                             INT8U      opt,
4912                     ; 303                             INT8U     *perr)
4912                     ; 304 {
4913                     	switch	.text
4914  011f               _OSMutexDel:
4916  011f 3b            	pshd	
4917  0120 1b9a          	leas	-6,s
4918       00000006      OFST:	set	6
4921                     ; 311     OS_CPU_SR  cpu_sr = 0u;
4923                     ; 331     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
4925  0122 046404        	tbne	d,L3723
4926                     ; 332         *perr = OS_ERR_PEVENT_NULL;
4928  0125 c604          	ldab	#4
4929                     ; 333         return (pevent);
4932  0127 200a          	bra	L61
4933  0129               L3723:
4934                     ; 339     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
4937  0129 e6f30006      	ldab	[OFST+0,s]
4938  012d c104          	cmpb	#4
4939  012f 270b          	beq	L5723
4940                     ; 340         *perr = OS_ERR_EVENT_TYPE;
4942  0131 c601          	ldab	#1
4943                     ; 342         return (pevent);
4947  0133               L61:
4948  0133 6bf3000c      	stab	[OFST+6,s]
4949  0137 ec86          	ldd	OFST+0,s
4951  0139 1b88          	leas	8,s
4952  013b 3d            	rts	
4953  013c               L5723:
4954                     ; 344     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4956  013c f60000        	ldab	_OSIntNesting
4957  013f 2704          	beq	L7723
4958                     ; 345         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
4960  0141 c60f          	ldab	#15
4961                     ; 347         return (pevent);
4965  0143 20ee          	bra	L61
4966  0145               L7723:
4967                     ; 349     OS_ENTER_CRITICAL();
4969  0145 160000        	jsr	_OS_CPU_SR_Save
4971  0148 6b83          	stab	OFST-3,s
4972                     ; 350     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on mutex        */
4974  014a ed86          	ldy	OFST+0,s
4975  014c e645          	ldab	5,y
4976  014e 2706          	beq	L1033
4977                     ; 351         tasks_waiting = OS_TRUE;                           /* Yes                                      */
4979  0150 c601          	ldab	#1
4980  0152 6b84          	stab	OFST-2,s
4982  0154 2002          	bra	L3033
4983  0156               L1033:
4984                     ; 353         tasks_waiting = OS_FALSE;                          /* No                                       */
4986  0156 6984          	clr	OFST-2,s
4987  0158               L3033:
4988                     ; 355     switch (opt) {
4990  0158 e68b          	ldab	OFST+5,s
4992  015a 270d          	beq	L7103
4993  015c 040154        	dbeq	b,L1203
4994                     ; 413         default:
4994                     ; 414              OS_EXIT_CRITICAL();
4996  015f e683          	ldab	OFST-3,s
4997  0161 87            	clra	
4998  0162 160000        	jsr	_OS_CPU_SR_Restore
5000                     ; 415              *perr         = OS_ERR_INVALID_OPT;
5002  0165 c607          	ldab	#7
5003                     ; 416              pevent_return = pevent;
5005                     ; 417              break;
5007  0167 2040          	bra	LC004
5008  0169               L7103:
5009                     ; 356         case OS_DEL_NO_PEND:                               /* DELETE MUTEX ONLY IF NO TASK WAITING --- */
5009                     ; 357              if (tasks_waiting == OS_FALSE) {
5011  0169 e684          	ldab	OFST-2,s
5012  016b 2634          	bne	L1133
5013                     ; 359                  pevent->OSEventName   = (INT8U *)(void *)"?";
5015  016d cc0000        	ldd	#L5103
5016  0170 6c4e          	std	14,y
5017                     ; 361                  pcp                   = (INT8U)(pevent->OSEventCnt >> 8u);
5019  0172 e643          	ldab	3,y
5020  0174 6b82          	stab	OFST-4,s
5021                     ; 362                  if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
5023  0176 c1ff          	cmpb	#255
5024  0178 270c          	beq	L3133
5025                     ; 363                      OSTCBPrioTbl[pcp] = (OS_TCB *)0;      /* Free up the PCP                          */
5027  017a 87            	clra	
5028  017b 59            	lsld	
5029  017c b746          	tfr	d,y
5030  017e 87            	clra	
5031  017f c7            	clrb	
5032  0180 6cea0000      	std	_OSTCBPrioTbl,y
5033  0184 ed86          	ldy	OFST+0,s
5034  0186               L3133:
5035                     ; 365                  pevent->OSEventType   = OS_EVENT_TYPE_UNUSED;
5037  0186 87            	clra	
5038  0187 6a40          	staa	0,y
5039                     ; 366                  pevent->OSEventPtr    = OSEventFreeList;  /* Return Event Control Block to free list  */
5041  0189 1801410000    	movw	_OSEventFreeList,1,y
5042                     ; 367                  pevent->OSEventCnt    = 0u;
5044  018e c7            	clrb	
5045  018f 6c43          	std	3,y
5046                     ; 368                  OSEventFreeList       = pevent;
5048  0191 7d0000        	sty	_OSEventFreeList
5049                     ; 369                  OS_EXIT_CRITICAL();
5051  0194 e683          	ldab	OFST-3,s
5052  0196 160000        	jsr	_OS_CPU_SR_Restore
5054                     ; 370                  *perr                 = OS_ERR_NONE;
5056  0199 87            	clra	
5057  019a 6af3000c      	staa	[OFST+6,s]
5058                     ; 371                  pevent_return         = (OS_EVENT *)0;    /* Mutex has been deleted                   */
5060  019e c7            	clrb	
5062  019f 200e          	bra	LC003
5063  01a1               L1133:
5064                     ; 373                  OS_EXIT_CRITICAL();
5066  01a1 e683          	ldab	OFST-3,s
5067  01a3 87            	clra	
5068  01a4 160000        	jsr	_OS_CPU_SR_Restore
5070                     ; 374                  *perr                 = OS_ERR_TASK_WAITING;
5072  01a7 c649          	ldab	#73
5073                     ; 375                  pevent_return         = pevent;
5075  01a9               LC004:
5076  01a9 6bf3000c      	stab	[OFST+6,s]
5077  01ad ec86          	ldd	OFST+0,s
5078  01af               LC003:
5079  01af 6c80          	std	OFST-6,s
5080  01b1 2075          	bra	L7033
5081  01b3               L1203:
5082                     ; 379         case OS_DEL_ALWAYS:                                /* ALWAYS DELETE THE MUTEX ---------------- */
5082                     ; 380              pcp  = (INT8U)(pevent->OSEventCnt >> 8u);                       /* Get PCP of mutex       */
5084  01b3 e643          	ldab	3,y
5085  01b5 6b82          	stab	OFST-4,s
5086                     ; 381              if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
5088  01b7 04812e        	ibeq	b,L7233
5089                     ; 382                  prio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8); /* Get owner's orig prio  */
5091  01ba 180a4485      	movb	4,y,OFST-1,s
5092                     ; 383                  ptcb = (OS_TCB *)pevent->OSEventPtr;
5094  01be ed41          	ldy	1,y
5095  01c0 6d80          	sty	OFST-6,s
5096                     ; 384                  if (ptcb != (OS_TCB *)0) {                /* See if any task owns the mutex           */
5098  01c2 2724          	beq	L7233
5099                     ; 385                      if (ptcb->OSTCBPrio == pcp) {         /* See if original prio was changed         */
5101  01c4 e6e824        	ldab	36,y
5102  01c7 e182          	cmpb	OFST-4,s
5103  01c9 261d          	bne	L7233
5104                     ; 387                          OSMutex_RdyAtPrio(ptcb, prio);    /* Yes, Restore the task's original prio    */
5107  01cb e685          	ldab	OFST-1,s
5108  01cd 87            	clra	
5109  01ce 3b            	pshd	
5110  01cf b764          	tfr	y,d
5111  01d1 160541        	jsr	L3462_OSMutex_RdyAtPrio
5113  01d4 1b82          	leas	2,s
5114  01d6 2010          	bra	L7233
5115  01d8               L5233:
5116                     ; 392                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MUTEX, OS_STAT_PEND_ABORT);
5118  01d8 cc0002        	ldd	#2
5119  01db 3b            	pshd	
5120  01dc c610          	ldab	#16
5121  01de 3b            	pshd	
5122  01df c7            	clrb	
5123  01e0 3b            	pshd	
5124  01e1 b764          	tfr	y,d
5125  01e3 160000        	jsr	_OS_EventTaskRdy
5127  01e6 1b86          	leas	6,s
5128  01e8               L7233:
5129                     ; 391              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for mutex        */
5131  01e8 ed86          	ldy	OFST+0,s
5132  01ea e645          	ldab	5,y
5133  01ec 26ea          	bne	L5233
5134                     ; 395              pevent->OSEventName   = (INT8U *)(void *)"?";
5136  01ee cc0000        	ldd	#L5103
5137  01f1 6c4e          	std	14,y
5138                     ; 397              pcp                   = (INT8U)(pevent->OSEventCnt >> 8u);
5140  01f3 e643          	ldab	3,y
5141  01f5 6b82          	stab	OFST-4,s
5142                     ; 398              if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
5144  01f7 c1ff          	cmpb	#255
5145  01f9 270c          	beq	L3333
5146                     ; 399                  OSTCBPrioTbl[pcp] = (OS_TCB *)0;          /* Free up the PCP                          */
5148  01fb 87            	clra	
5149  01fc 59            	lsld	
5150  01fd b746          	tfr	d,y
5151  01ff 87            	clra	
5152  0200 c7            	clrb	
5153  0201 6cea0000      	std	_OSTCBPrioTbl,y
5154  0205 ed86          	ldy	OFST+0,s
5155  0207               L3333:
5156                     ; 401              pevent->OSEventType   = OS_EVENT_TYPE_UNUSED;
5158  0207 87            	clra	
5159  0208 6a40          	staa	0,y
5160                     ; 402              pevent->OSEventPtr    = OSEventFreeList;      /* Return Event Control Block to free list  */
5162  020a 1801410000    	movw	_OSEventFreeList,1,y
5163                     ; 403              pevent->OSEventCnt    = 0u;
5165  020f c7            	clrb	
5166  0210 6c43          	std	3,y
5167                     ; 404              OSEventFreeList       = pevent;               /* Get next free event control block        */
5169  0212 7d0000        	sty	_OSEventFreeList
5170                     ; 405              OS_EXIT_CRITICAL();
5172  0215 e683          	ldab	OFST-3,s
5173  0217 160000        	jsr	_OS_CPU_SR_Restore
5175                     ; 406              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
5177  021a e684          	ldab	OFST-2,s
5178  021c 042103        	dbne	b,L5333
5179                     ; 407                  OS_Sched();                               /* Find highest priority task ready to run  */
5181  021f 160000        	jsr	_OS_Sched
5183  0222               L5333:
5184                     ; 409              *perr         = OS_ERR_NONE;
5186  0222 87            	clra	
5187  0223 6af3000c      	staa	[OFST+6,s]
5188                     ; 410              pevent_return = (OS_EVENT *)0;                /* Mutex has been deleted                   */
5190  0227 c7            	clrb	
5191                     ; 411              break;
5193  0228               L7033:
5194                     ; 422     return (pevent_return);
5199  0228 1b88          	leas	8,s
5200  022a 3d            	rts	
5323                     ; 467 _NEAR void  OSMutexPend (OS_EVENT  *pevent,
5323                     ; 468                         INT32U     timeout,
5323                     ; 469                         INT8U     *perr)
5323                     ; 470 {
5324                     	switch	.text
5325  022b               _OSMutexPend:
5327  022b 3b            	pshd	
5328  022c 1b99          	leas	-7,s
5329       00000007      OFST:	set	7
5332                     ; 478     OS_CPU_SR  cpu_sr = 0u;
5334                     ; 490     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
5336  022e 046404        	tbne	d,L1243
5337                     ; 491         *perr = OS_ERR_PEVENT_NULL;
5339  0231 c604          	ldab	#4
5340                     ; 492         return;
5342  0233 200a          	bra	LC005
5343  0235               L1243:
5344                     ; 498     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
5347  0235 e6f30007      	ldab	[OFST+0,s]
5348  0239 c104          	cmpb	#4
5349  023b 2709          	beq	L3243
5350                     ; 499         *perr = OS_ERR_EVENT_TYPE;
5352  023d c601          	ldab	#1
5353  023f               LC005:
5354  023f 6bf3000f      	stab	[OFST+8,s]
5355                     ; 501         return;
5356  0243               L23:
5360  0243 1b89          	leas	9,s
5361  0245 3d            	rts	
5362  0246               L3243:
5363                     ; 503     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
5365  0246 f60000        	ldab	_OSIntNesting
5366  0249 2704          	beq	L5243
5367                     ; 504         *perr = OS_ERR_PEND_ISR;                           /* ... can't PEND from an ISR               */
5369  024b c602          	ldab	#2
5370                     ; 506         return;
5373  024d 20f0          	bra	LC005
5374  024f               L5243:
5375                     ; 508     if (OSLockNesting > 0u) {                              /* See if called with scheduler locked ...  */
5377  024f f60000        	ldab	_OSLockNesting
5378  0252 2704          	beq	L7243
5379                     ; 509         *perr = OS_ERR_PEND_LOCKED;                        /* ... can't PEND when locked               */
5381  0254 c60d          	ldab	#13
5382                     ; 511         return;
5385  0256 20e7          	bra	LC005
5386  0258               L7243:
5387                     ; 514     OS_ENTER_CRITICAL();
5389  0258 160000        	jsr	_OS_CPU_SR_Save
5391  025b 6b86          	stab	OFST-1,s
5392                     ; 515     pcp = (INT8U)(pevent->OSEventCnt >> 8u);               /* Get PCP from mutex                       */
5394  025d ed87          	ldy	OFST+0,s
5395  025f 180a4385      	movb	3,y,OFST-2,s
5396                     ; 517     if ((INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8) == OS_MUTEX_AVAILABLE) {
5398  0263 e644          	ldab	4,y
5399  0265 04a135        	ibne	b,L1343
5400                     ; 518         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;       /* Yes, Acquire the resource                */
5402  0268 87            	clra	
5403  0269 6a44          	staa	4,y
5404                     ; 519         pevent->OSEventCnt |= (INT16U)OSTCBCur->OSTCBPrio; /*      Save priority of owning task        */
5406  026b fe0000        	ldx	_OSTCBCur
5407  026e e6e024        	ldab	36,x
5408  0271 ea44          	orab	4,y
5409  0273 aa43          	oraa	3,y
5410  0275 6c43          	std	3,y
5411                     ; 520         pevent->OSEventPtr  = (void *)OSTCBCur;            /*      Point to owning task's OS_TCB       */
5413  0277 6e41          	stx	1,y
5414                     ; 521         if ((pcp != OS_PRIO_MUTEX_CEIL_DIS) &&
5414                     ; 522             (OSTCBCur->OSTCBPrio <= pcp)) {                /*      PCP 'must' have a SMALLER prio ...  */
5416  0279 e685          	ldab	OFST-2,s
5417  027b 048113        	ibeq	b,L3343
5419  027e b756          	tfr	x,y
5420  0280 e6e824        	ldab	36,y
5421  0283 e185          	cmpb	OFST-2,s
5422  0285 220a          	bhi	L3343
5423                     ; 523              OS_EXIT_CRITICAL();                           /*      ... than current task!              */
5425  0287 e686          	ldab	OFST-1,s
5426  0289 87            	clra	
5427  028a 160000        	jsr	_OS_CPU_SR_Restore
5429                     ; 524             *perr = OS_ERR_PCP_LOWER;
5431  028d c678          	ldab	#120
5433  028f 20ae          	bra	LC005
5434  0291               L3343:
5435                     ; 526              OS_EXIT_CRITICAL();
5437  0291 e686          	ldab	OFST-1,s
5438  0293 87            	clra	
5439  0294 160000        	jsr	_OS_CPU_SR_Restore
5441                     ; 527             *perr = OS_ERR_NONE;
5443  0297 69f3000f      	clr	[OFST+8,s]
5444                     ; 530         return;
5447  029b 20a6          	bra	L23
5448  029d               L1343:
5449                     ; 532     if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
5451  029d e685          	ldab	OFST-2,s
5452  029f 52            	incb	
5453  02a0 182700f4      	beq	L7343
5454                     ; 533         mprio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8); /*  Get priority of mutex owner   */
5456  02a4 180a4482      	movb	4,y,OFST-5,s
5457                     ; 534         ptcb  = (OS_TCB *)(pevent->OSEventPtr);                   /*     Point to TCB of mutex owner   */
5459  02a8 ed41          	ldy	1,y
5460  02aa 6d80          	sty	OFST-7,s
5461                     ; 535         if (ptcb->OSTCBPrio > pcp) {                              /*     Need to promote prio of owner?*/
5463  02ac e6e824        	ldab	36,y
5464  02af e185          	cmpb	OFST-2,s
5465  02b1 182300e3      	bls	L7343
5466                     ; 536             if (mprio > OSTCBCur->OSTCBPrio) {
5468  02b5 e682          	ldab	OFST-5,s
5469  02b7 fd0000        	ldy	_OSTCBCur
5470  02ba e1e824        	cmpb	36,y
5471  02bd 182300d7      	bls	L7343
5472                     ; 537                 y = ptcb->OSTCBY;
5474  02c1 ed80          	ldy	OFST-7,s
5475  02c3 e6e826        	ldab	38,y
5476  02c6 6b82          	stab	OFST-5,s
5477                     ; 538                 if ((OSRdyTbl[y] & ptcb->OSTCBBitX) != 0u) {      /*     See if mutex owner is ready   */
5479  02c8 b796          	exg	b,y
5480  02ca ee80          	ldx	OFST-7,s
5481  02cc e6e027        	ldab	39,x
5482  02cf e4ea0000      	andb	_OSRdyTbl,y
5483  02d3 2720          	beq	L5443
5484                     ; 539                     OSRdyTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;     /*     Yes, Remove owner from Rdy ...*/
5486  02d5 e6e027        	ldab	39,x
5487  02d8 51            	comb	
5488  02d9 e4ea0000      	andb	_OSRdyTbl,y
5489  02dd 6bea0000      	stab	_OSRdyTbl,y
5490                     ; 540                     if (OSRdyTbl[y] == 0u) {                      /*          ... list at current prio */
5492  02e1 260c          	bne	L7443
5493                     ; 541                         OSRdyGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
5495  02e3 b756          	tfr	x,y
5496  02e5 e6e828        	ldab	40,y
5497  02e8 51            	comb	
5498  02e9 f40000        	andb	_OSRdyGrp
5499  02ec 7b0000        	stab	_OSRdyGrp
5500  02ef               L7443:
5501                     ; 543                     rdy = OS_TRUE;
5503  02ef c601          	ldab	#1
5504  02f1 6b82          	stab	OFST-5,s
5506  02f3 2028          	bra	L1543
5507  02f5               L5443:
5508                     ; 545                     pevent2 = ptcb->OSTCBEventPtr;
5510  02f5 b756          	tfr	x,y
5511  02f7 ece812        	ldd	18,y
5512  02fa 6c83          	std	OFST-4,s
5513                     ; 546                     if (pevent2 != (OS_EVENT *)0) {               /* Remove from event wait list       */
5515  02fc 271d          	beq	L3543
5516                     ; 547                         y = ptcb->OSTCBY;
5518  02fe e6e826        	ldab	38,y
5519  0301 6b82          	stab	OFST-5,s
5520                     ; 548                         pevent2->OSEventTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;
5522  0303 ed83          	ldy	OFST-4,s
5523  0305 19ed          	leay	b,y
5524  0307 e6e027        	ldab	39,x
5525  030a 51            	comb	
5526  030b e446          	andb	6,y
5527  030d 6b46          	stab	6,y
5528                     ; 549                         if (pevent2->OSEventTbl[y] == 0u) {
5530  030f 260a          	bne	L3543
5531                     ; 550                             pevent2->OSEventGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
5533  0311 ed83          	ldy	OFST-4,s
5534  0313 e6e028        	ldab	40,x
5535  0316 51            	comb	
5536  0317 e445          	andb	5,y
5537  0319 6b45          	stab	5,y
5538  031b               L3543:
5539                     ; 553                     rdy = OS_FALSE;                        /* No                                       */
5541  031b 6982          	clr	OFST-5,s
5542  031d               L1543:
5543                     ; 555                 ptcb->OSTCBPrio = pcp;                     /* Change owner task prio to PCP            */
5545  031d e685          	ldab	OFST-2,s
5546  031f ed80          	ldy	OFST-7,s
5547  0321 6be824        	stab	36,y
5548                     ; 560                 ptcb->OSTCBY    = (INT8U)( ptcb->OSTCBPrio >> 3u);
5551  0324 54            	lsrb	
5552  0325 54            	lsrb	
5553  0326 54            	lsrb	
5554  0327 6be826        	stab	38,y
5555                     ; 561                 ptcb->OSTCBX    = (INT8U)( ptcb->OSTCBPrio & 0x07u);
5557  032a e6e824        	ldab	36,y
5558  032d c407          	andb	#7
5559  032f 6be825        	stab	37,y
5560                     ; 566                 ptcb->OSTCBBitY = (OS_PRIO)(1uL << ptcb->OSTCBY);
5562  0332 c601          	ldab	#1
5563  0334 a6e826        	ldaa	38,y
5564  0337 2704          	beq	L22
5565  0339               L42:
5566  0339 58            	lslb	
5567  033a 0430fc        	dbne	a,L42
5568  033d               L22:
5569  033d 6be828        	stab	40,y
5570                     ; 567                 ptcb->OSTCBBitX = (OS_PRIO)(1uL << ptcb->OSTCBX);
5572  0340 c601          	ldab	#1
5573  0342 a6e825        	ldaa	37,y
5574  0345 2704          	beq	L62
5575  0347               L03:
5576  0347 58            	lslb	
5577  0348 0430fc        	dbne	a,L03
5578  034b               L62:
5579  034b 6be827        	stab	39,y
5580                     ; 569                 if (rdy == OS_TRUE) {                      /* If task was ready at owner's priority ...*/
5582  034e e682          	ldab	OFST-5,s
5583  0350 04211d        	dbne	b,L7543
5584                     ; 570                     OSRdyGrp               |= ptcb->OSTCBBitY; /* ... make it ready at new priority.   */
5586  0353 e6e828        	ldab	40,y
5587  0356 fa0000        	orab	_OSRdyGrp
5588  0359 7b0000        	stab	_OSRdyGrp
5589                     ; 571                     OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
5591  035c e6e826        	ldab	38,y
5592  035f b796          	exg	b,y
5593  0361 ee80          	ldx	OFST-7,s
5594  0363 e6e027        	ldab	39,x
5595  0366 eaea0000      	orab	_OSRdyTbl,y
5596  036a 6bea0000      	stab	_OSRdyTbl,y
5598  036e 201c          	bra	L1643
5599  0370               L7543:
5600                     ; 573                     pevent2 = ptcb->OSTCBEventPtr;
5602  0370 ede812        	ldy	18,y
5603  0373 6d83          	sty	OFST-4,s
5604                     ; 574                     if (pevent2 != (OS_EVENT *)0) {        /* Add to event wait list                   */
5606  0375 2715          	beq	L1643
5607                     ; 575                         pevent2->OSEventGrp               |= ptcb->OSTCBBitY;
5609  0377 ee80          	ldx	OFST-7,s
5610  0379 e6e028        	ldab	40,x
5611  037c ea45          	orab	5,y
5612  037e 6b45          	stab	5,y
5613                     ; 576                         pevent2->OSEventTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
5615  0380 e6e026        	ldab	38,x
5616  0383 19ed          	leay	b,y
5617  0385 e6e027        	ldab	39,x
5618  0388 ea46          	orab	6,y
5619  038a 6b46          	stab	6,y
5620  038c               L1643:
5621                     ; 579                 OSTCBPrioTbl[pcp] = ptcb;
5623  038c e685          	ldab	OFST-2,s
5624  038e 87            	clra	
5625  038f 59            	lsld	
5626  0390 b746          	tfr	d,y
5627  0392 ec80          	ldd	OFST-7,s
5628  0394 6cea0000      	std	_OSTCBPrioTbl,y
5629  0398               L7343:
5630                     ; 583     OSTCBCur->OSTCBStat     |= OS_STAT_MUTEX;         /* Mutex not available, pend current task        */
5632  0398 fd0000        	ldy	_OSTCBCur
5633  039b 0ce82210      	bset	34,y,16
5634                     ; 584     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
5636  039f 69e823        	clr	35,y
5637                     ; 585     OSTCBCur->OSTCBDly       = timeout;               /* Store timeout in current task's TCB           */
5639  03a2 ec8d          	ldd	OFST+6,s
5640  03a4 6ce820        	std	32,y
5641  03a7 ec8b          	ldd	OFST+4,s
5642  03a9 6ce81e        	std	30,y
5643                     ; 586     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
5645  03ac ec87          	ldd	OFST+0,s
5646  03ae 160000        	jsr	_OS_EventTaskWait
5648                     ; 587     OS_EXIT_CRITICAL();
5650  03b1 e686          	ldab	OFST-1,s
5651  03b3 87            	clra	
5652  03b4 160000        	jsr	_OS_CPU_SR_Restore
5654                     ; 588     OS_Sched();                                       /* Find next highest priority task ready         */
5656  03b7 160000        	jsr	_OS_Sched
5658                     ; 589     OS_ENTER_CRITICAL();
5660  03ba 160000        	jsr	_OS_CPU_SR_Save
5662  03bd 6b86          	stab	OFST-1,s
5663                     ; 590     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
5665  03bf fd0000        	ldy	_OSTCBCur
5666  03c2 e6e823        	ldab	35,y
5668  03c5 2708          	beq	L7333
5669  03c7 04010f        	dbeq	b,L3433
5670  03ca 040108        	dbeq	b,L1433
5671  03cd 200a          	bra	L3433
5672  03cf               L7333:
5673                     ; 591         case OS_STAT_PEND_OK:
5673                     ; 592              *perr = OS_ERR_NONE;
5675  03cf 69f3000f      	clr	[OFST+8,s]
5676                     ; 593              break;
5678  03d3 2017          	bra	L7643
5679  03d5               L1433:
5680                     ; 595         case OS_STAT_PEND_ABORT:
5680                     ; 596              *perr = OS_ERR_PEND_ABORT;               /* Indicate that we aborted getting mutex        */
5682  03d5 c60e          	ldab	#14
5683                     ; 597              break;
5685  03d7 200c          	bra	LC006
5686  03d9               L3433:
5687                     ; 599         case OS_STAT_PEND_TO:
5687                     ; 600         default:
5687                     ; 601              OS_EventTaskRemove(OSTCBCur, pevent);
5689  03d9 ec87          	ldd	OFST+0,s
5690  03db 3b            	pshd	
5691  03dc b764          	tfr	y,d
5692  03de 160000        	jsr	_OS_EventTaskRemove
5694  03e1 1b82          	leas	2,s
5695                     ; 602              *perr = OS_ERR_TIMEOUT;                  /* Indicate that we didn't get mutex within TO   */
5697  03e3 c60a          	ldab	#10
5698  03e5               LC006:
5699  03e5 6bf3000f      	stab	[OFST+8,s]
5700                     ; 603              break;
5702  03e9 fd0000        	ldy	_OSTCBCur
5703  03ec               L7643:
5704                     ; 605     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
5706  03ec c7            	clrb	
5707  03ed 6be822        	stab	34,y
5708                     ; 606     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
5710  03f0 87            	clra	
5711  03f1 6ae823        	staa	35,y
5712                     ; 607     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
5714  03f4 6ce812        	std	18,y
5715                     ; 609     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
5717  03f7 6ce814        	std	20,y
5718                     ; 610     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
5720  03fa 6ce816        	std	22,y
5721                     ; 612     OS_EXIT_CRITICAL();
5723  03fd e686          	ldab	OFST-1,s
5724  03ff 160000        	jsr	_OS_CPU_SR_Restore
5726                     ; 615 }
5730  0402 1b89          	leas	9,s
5731  0404 3d            	rts	
5796                     ; 642 _NEAR INT8U  OSMutexPost (OS_EVENT *pevent)
5796                     ; 643 {
5797                     	switch	.text
5798  0405               _OSMutexPost:
5800  0405 3b            	pshd	
5801  0406 1b9d          	leas	-3,s
5802       00000003      OFST:	set	3
5805                     ; 647     OS_CPU_SR  cpu_sr = 0u;
5807                     ; 651     if (OSIntNesting > 0u) {                          /* See if called from ISR ...                    */
5809  0408 f60000        	ldab	_OSIntNesting
5810  040b 2704          	beq	L7153
5811                     ; 652         return (OS_ERR_POST_ISR);                     /* ... can't POST mutex from an ISR              */
5813  040d c605          	ldab	#5
5815  040f 2006          	bra	L63
5816  0411               L7153:
5817                     ; 655     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
5819  0411 ec83          	ldd	OFST+0,s
5820  0413 2605          	bne	L1253
5821                     ; 656         return (OS_ERR_PEVENT_NULL);
5823  0415 c604          	ldab	#4
5825  0417               L63:
5827  0417 1b85          	leas	5,s
5828  0419 3d            	rts	
5829  041a               L1253:
5830                     ; 662     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) { /* Validate event block type                     */
5833  041a e6f30003      	ldab	[OFST+0,s]
5834  041e c104          	cmpb	#4
5835  0420 2704          	beq	L3253
5836                     ; 664         return (OS_ERR_EVENT_TYPE);
5839  0422 c601          	ldab	#1
5841  0424 20f1          	bra	L63
5842  0426               L3253:
5843                     ; 666     OS_ENTER_CRITICAL();
5845  0426 160000        	jsr	_OS_CPU_SR_Save
5847  0429 6b82          	stab	OFST-1,s
5848                     ; 667     pcp  = (INT8U)(pevent->OSEventCnt >> 8u);         /* Get priority ceiling priority of mutex        */
5850  042b ed83          	ldy	OFST+0,s
5851  042d 180a4380      	movb	3,y,OFST-3,s
5852                     ; 668     prio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);  /* Get owner's original priority      */
5854  0431 180a4481      	movb	4,y,OFST-2,s
5855                     ; 669     if (OSTCBCur != (OS_TCB *)pevent->OSEventPtr) {   /* See if posting task owns the MUTEX            */
5857  0435 fc0000        	ldd	_OSTCBCur
5858  0438 ac41          	cpd	1,y
5859  043a 270a          	beq	L5253
5860                     ; 670         OS_EXIT_CRITICAL();
5862  043c e682          	ldab	OFST-1,s
5863  043e 87            	clra	
5864  043f 160000        	jsr	_OS_CPU_SR_Restore
5866                     ; 672         return (OS_ERR_NOT_MUTEX_OWNER);
5869  0442 c664          	ldab	#100
5871  0444 20d1          	bra	L63
5872  0446               L5253:
5873                     ; 674     if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
5875  0446 e680          	ldab	OFST-3,s
5876  0448 048124        	ibeq	b,L7253
5877                     ; 675         if (OSTCBCur->OSTCBPrio == pcp) {             /* Did we have to raise current task's priority? */
5879  044b fd0000        	ldy	_OSTCBCur
5880  044e e6e824        	ldab	36,y
5881  0451 e180          	cmpb	OFST-3,s
5882  0453 260b          	bne	L1353
5883                     ; 677             OSMutex_RdyAtPrio(OSTCBCur, prio);        /* Restore the task's original priority          */
5886  0455 e681          	ldab	OFST-2,s
5887  0457 87            	clra	
5888  0458 3b            	pshd	
5889  0459 b764          	tfr	y,d
5890  045b 160541        	jsr	L3462_OSMutex_RdyAtPrio
5892  045e 1b82          	leas	2,s
5893  0460               L1353:
5894                     ; 679         OSTCBPrioTbl[pcp] = OS_TCB_RESERVED;          /* Reserve table entry                           */
5896  0460 e680          	ldab	OFST-3,s
5897  0462 87            	clra	
5898  0463 59            	lsld	
5899  0464 b746          	tfr	d,y
5900  0466 cc0001        	ldd	#1
5901  0469 6cea0000      	std	_OSTCBPrioTbl,y
5902  046d ed83          	ldy	OFST+0,s
5903  046f               L7253:
5904                     ; 681     if (pevent->OSEventGrp != 0u) {                   /* Any task waiting for the mutex?               */
5906  046f e645          	ldab	5,y
5907  0471 274f          	beq	L3353
5908                     ; 683         prio                = OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MUTEX, OS_STAT_PEND_OK);
5910  0473 87            	clra	
5911  0474 c7            	clrb	
5912  0475 3b            	pshd	
5913  0476 c610          	ldab	#16
5914  0478 3b            	pshd	
5915  0479 c7            	clrb	
5916  047a 3b            	pshd	
5917  047b ec89          	ldd	OFST+6,s
5918  047d 160000        	jsr	_OS_EventTaskRdy
5920  0480 1b86          	leas	6,s
5921  0482 6b81          	stab	OFST-2,s
5922                     ; 684         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;  /*      Save priority of mutex's new owner       */
5924  0484 ed83          	ldy	OFST+0,s
5925  0486 87            	clra	
5926  0487 6a44          	staa	4,y
5927                     ; 685         pevent->OSEventCnt |= (INT16U)prio;
5929  0489 ea44          	orab	4,y
5930  048b aa43          	oraa	3,y
5931  048d 6c43          	std	3,y
5932                     ; 686         pevent->OSEventPtr  = OSTCBPrioTbl[prio];     /*      Link to new mutex owner's OS_TCB         */
5934  048f e681          	ldab	OFST-2,s
5935  0491 87            	clra	
5936  0492 59            	lsld	
5937  0493 b746          	tfr	d,y
5938  0495 ecea0000      	ldd	_OSTCBPrioTbl,y
5939  0499 ee83          	ldx	OFST+0,s
5940  049b 6c01          	std	1,x
5941                     ; 687         if ((pcp  != OS_PRIO_MUTEX_CEIL_DIS) &&
5941                     ; 688             (prio <= pcp)) {                          /*      PCP 'must' have a SMALLER prio ...       */
5943  049d e680          	ldab	OFST-3,s
5944  049f 048113        	ibeq	b,L5353
5946  04a2 e681          	ldab	OFST-2,s
5947  04a4 e180          	cmpb	OFST-3,s
5948  04a6 220d          	bhi	L5353
5949                     ; 689             OS_EXIT_CRITICAL();                       /*      ... than current task!                   */
5951  04a8 e682          	ldab	OFST-1,s
5952  04aa 87            	clra	
5953  04ab 160000        	jsr	_OS_CPU_SR_Restore
5955                     ; 690             OS_Sched();                               /*      Find highest priority task ready to run  */
5957  04ae 160000        	jsr	_OS_Sched
5959                     ; 692             return (OS_ERR_PCP_LOWER);
5962  04b1 c678          	ldab	#120
5964  04b3 200a          	bra	L04
5965  04b5               L5353:
5966                     ; 694             OS_EXIT_CRITICAL();
5968  04b5 e682          	ldab	OFST-1,s
5969  04b7 87            	clra	
5970  04b8 160000        	jsr	_OS_CPU_SR_Restore
5972                     ; 695             OS_Sched();                               /*      Find highest priority task ready to run  */
5974  04bb 160000        	jsr	_OS_Sched
5976                     ; 697             return (OS_ERR_NONE);
5979  04be               LC007:
5980  04be c7            	clrb	
5982  04bf               L04:
5984  04bf 1b85          	leas	5,s
5985  04c1 3d            	rts	
5986  04c2               L3353:
5987                     ; 700     pevent->OSEventCnt |= OS_MUTEX_AVAILABLE;         /* No,  Mutex is now available                   */
5989  04c2 0c44ff        	bset	4,y,255
5990                     ; 701     pevent->OSEventPtr  = (void *)0;
5992  04c5 87            	clra	
5993  04c6 6c41          	std	1,y
5994                     ; 702     OS_EXIT_CRITICAL();
5996  04c8 e682          	ldab	OFST-1,s
5997  04ca 160000        	jsr	_OS_CPU_SR_Restore
5999                     ; 704     return (OS_ERR_NONE);
6003  04cd 20ef          	bra	LC007
6133                     ; 727 _NEAR INT8U  OSMutexQuery (OS_EVENT       *pevent,
6133                     ; 728                           OS_MUTEX_DATA  *p_mutex_data)
6133                     ; 729 {
6134                     	switch	.text
6135  04cf               _OSMutexQuery:
6137  04cf 3b            	pshd	
6138  04d0 1b9a          	leas	-6,s
6139       00000006      OFST:	set	6
6142                     ; 734     OS_CPU_SR   cpu_sr = 0u;
6144                     ; 739     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
6146  04d2 f60000        	ldab	_OSIntNesting
6147  04d5 2704          	beq	L3263
6148                     ; 740         return (OS_ERR_QUERY_ISR);                         /* ... can't QUERY mutex from an ISR        */
6150  04d7 c606          	ldab	#6
6152  04d9 2006          	bra	L44
6153  04db               L3263:
6154                     ; 743     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
6156  04db ec86          	ldd	OFST+0,s
6157  04dd 2605          	bne	L5263
6158                     ; 744         return (OS_ERR_PEVENT_NULL);
6160  04df c604          	ldab	#4
6162  04e1               L44:
6164  04e1 1b88          	leas	8,s
6165  04e3 3d            	rts	
6166  04e4               L5263:
6167                     ; 746     if (p_mutex_data == (OS_MUTEX_DATA *)0) {              /* Validate 'p_mutex_data'                  */
6169  04e4 ec8a          	ldd	OFST+4,s
6170  04e6 2604          	bne	L7263
6171                     ; 747         return (OS_ERR_PDATA_NULL);
6173  04e8 c609          	ldab	#9
6175  04ea 20f5          	bra	L44
6176  04ec               L7263:
6177                     ; 750     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
6179  04ec e6f30006      	ldab	[OFST+0,s]
6180  04f0 c104          	cmpb	#4
6181  04f2 2704          	beq	L1363
6182                     ; 751         return (OS_ERR_EVENT_TYPE);
6184  04f4 c601          	ldab	#1
6186  04f6 20e9          	bra	L44
6187  04f8               L1363:
6188                     ; 753     OS_ENTER_CRITICAL();
6190  04f8 160000        	jsr	_OS_CPU_SR_Save
6192  04fb 6b85          	stab	OFST-1,s
6193                     ; 754     p_mutex_data->OSMutexPCP  = (INT8U)(pevent->OSEventCnt >> 8u);
6195  04fd ee86          	ldx	OFST+0,s
6196  04ff ed8a          	ldy	OFST+4,s
6197  0501 180a034b      	movb	3,x,11,y
6198                     ; 755     p_mutex_data->OSOwnerPrio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);
6200  0505 e604          	ldab	4,x
6201  0507 6b4a          	stab	10,y
6202                     ; 756     if (p_mutex_data->OSOwnerPrio == 0xFFu) {
6204  0509 04a106        	ibne	b,L3363
6205                     ; 757         p_mutex_data->OSValue = OS_TRUE;
6207  050c c601          	ldab	#1
6208  050e 6b49          	stab	9,y
6210  0510 2002          	bra	L5363
6211  0512               L3363:
6212                     ; 759         p_mutex_data->OSValue = OS_FALSE;
6214  0512 6949          	clr	9,y
6215  0514               L5363:
6216                     ; 761     p_mutex_data->OSEventGrp  = pevent->OSEventGrp;        /* Copy wait list                           */
6218  0514 180a0548      	movb	5,x,8,y
6219                     ; 762     psrc                      = &pevent->OSEventTbl[0];
6221  0518 ed86          	ldy	OFST+0,s
6222  051a 1946          	leay	6,y
6223  051c 6d81          	sty	OFST-5,s
6224                     ; 763     pdest                     = &p_mutex_data->OSEventTbl[0];
6226  051e 18028a83      	movw	OFST+4,s,OFST-3,s
6227                     ; 764     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
6229  0522 6980          	clr	OFST-6,s
6230  0524 ee81          	ldx	OFST-5,s
6231  0526 ed83          	ldy	OFST-3,s
6232  0528               L7363:
6233                     ; 765         *pdest++ = *psrc++;
6235  0528 180a3070      	movb	1,x+,1,y+
6236                     ; 764     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
6238  052c 6280          	inc	OFST-6,s
6241  052e e680          	ldab	OFST-6,s
6242  0530 c108          	cmpb	#8
6243  0532 25f4          	blo	L7363
6244  0534 6e81          	stx	OFST-5,s
6245  0536 6d83          	sty	OFST-3,s
6246                     ; 767     OS_EXIT_CRITICAL();
6248  0538 e685          	ldab	OFST-1,s
6249  053a 87            	clra	
6250  053b 160000        	jsr	_OS_CPU_SR_Restore
6252                     ; 768     return (OS_ERR_NONE);
6254  053e c7            	clrb	
6256  053f 20a0          	bra	L44
6310                     ; 787 static  void  OSMutex_RdyAtPrio (OS_TCB  *ptcb,
6310                     ; 788                                  INT8U    prio)
6310                     ; 789 {
6311                     	switch	.text
6312  0541               L3462_OSMutex_RdyAtPrio:
6314  0541 3b            	pshd	
6315  0542 37            	pshb	
6316       00000001      OFST:	set	1
6319                     ; 793     y            =  ptcb->OSTCBY;                          /* Remove owner from ready list at 'pcp'    */
6321  0543 b746          	tfr	d,y
6322  0545 e6e826        	ldab	38,y
6323  0548 6b80          	stab	OFST-1,s
6324                     ; 794     OSRdyTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;
6326  054a b796          	exg	b,y
6327  054c ee81          	ldx	OFST+0,s
6328  054e e6e027        	ldab	39,x
6329  0551 51            	comb	
6330  0552 e4ea0000      	andb	_OSRdyTbl,y
6331  0556 6bea0000      	stab	_OSRdyTbl,y
6332                     ; 796     if (OSRdyTbl[y] == 0u) {
6335  055a 260c          	bne	L1763
6336                     ; 797         OSRdyGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
6338  055c b756          	tfr	x,y
6339  055e e6e828        	ldab	40,y
6340  0561 51            	comb	
6341  0562 f40000        	andb	_OSRdyGrp
6342  0565 7b0000        	stab	_OSRdyGrp
6343  0568               L1763:
6344                     ; 799     ptcb->OSTCBPrio         = prio;
6346  0568 e686          	ldab	OFST+5,s
6347  056a b756          	tfr	x,y
6348  056c 6be824        	stab	36,y
6349                     ; 800     OSPrioCur               = prio;                        /* The current task is now at this priority */
6351  056f 7b0000        	stab	_OSPrioCur
6352                     ; 802     ptcb->OSTCBY            = (INT8U)((INT8U)(prio >> 3u) & 0x07u);
6354  0572 c438          	andb	#56
6355  0574 54            	lsrb	
6356  0575 54            	lsrb	
6357  0576 54            	lsrb	
6358  0577 6be826        	stab	38,y
6359                     ; 803     ptcb->OSTCBX            = (INT8U)(prio & 0x07u);
6361  057a e686          	ldab	OFST+5,s
6362  057c c407          	andb	#7
6363  057e 6be825        	stab	37,y
6364                     ; 808     ptcb->OSTCBBitY         = (OS_PRIO)(1uL << ptcb->OSTCBY);
6366  0581 c601          	ldab	#1
6367  0583 a6e826        	ldaa	38,y
6368  0586 2704          	beq	L05
6369  0588               L25:
6370  0588 58            	lslb	
6371  0589 0430fc        	dbne	a,L25
6372  058c               L05:
6373  058c 6be828        	stab	40,y
6374                     ; 809     ptcb->OSTCBBitX         = (OS_PRIO)(1uL << ptcb->OSTCBX);
6376  058f c601          	ldab	#1
6377  0591 a6e825        	ldaa	37,y
6378  0594 2704          	beq	L45
6379  0596               L65:
6380  0596 58            	lslb	
6381  0597 0430fc        	dbne	a,L65
6382  059a               L45:
6383  059a 6be827        	stab	39,y
6384                     ; 810     OSRdyGrp               |= ptcb->OSTCBBitY;             /* Make task ready at original priority     */
6386  059d e6e828        	ldab	40,y
6387  05a0 fa0000        	orab	_OSRdyGrp
6388  05a3 7b0000        	stab	_OSRdyGrp
6389                     ; 811     OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
6391  05a6 e6e826        	ldab	38,y
6392  05a9 87            	clra	
6393  05aa b746          	tfr	d,y
6394  05ac e6e027        	ldab	39,x
6395  05af eaea0000      	orab	_OSRdyTbl,y
6396  05b3 6bea0000      	stab	_OSRdyTbl,y
6397                     ; 812     OSTCBPrioTbl[prio]      = ptcb;
6399  05b7 e686          	ldab	OFST+5,s
6400  05b9 59            	lsld	
6401  05ba b746          	tfr	d,y
6402  05bc 6eea0000      	stx	_OSTCBPrioTbl,y
6403                     ; 814 }
6407  05c0 1b83          	leas	3,s
6408  05c2 3d            	rts	
6420                     	xref	_OS_Sched
6421                     	xref	_OS_EventWaitListInit
6422                     	xref	_OS_EventTaskRemove
6423                     	xref	_OS_EventTaskWait
6424                     	xref	_OS_EventTaskRdy
6425                     	xdef	_OSMutexQuery
6426                     	xdef	_OSMutexPost
6427                     	xdef	_OSMutexPend
6428                     	xdef	_OSMutexDel
6429                     	xdef	_OSMutexCreate
6430                     	xdef	_OSMutexAccept
6431                     	xref	_OSTCBPrioTbl
6432                     	xref	_OSTCBCur
6433                     	xref	_OSRdyTbl
6434                     	xref	_OSRdyGrp
6435                     	xref	_OSPrioCur
6436                     	xref	_OSLockNesting
6437                     	xref	_OSIntNesting
6438                     	xref	_OSEventFreeList
6439                     	xref	_OS_CPU_SR_Restore
6440                     	xref	_OS_CPU_SR_Save
6441                     .const:	section	.data
6442  0000               L5103:
6443  0000 3f00          	dc.b	"?",0
6464                     	end

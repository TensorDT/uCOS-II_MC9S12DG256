   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4200                     ; 70 _NEAR void  *OSQAccept (OS_EVENT  *pevent,
4200                     ; 71                        INT8U     *perr)
4200                     ; 72 {
4201                     	switch	.text
4202  0000               _OSQAccept:
4204  0000 3b            	pshd	
4205  0001 1b9b          	leas	-5,s
4206       00000005      OFST:	set	5
4209                     ; 76     OS_CPU_SR  cpu_sr = 0u;
4211                     ; 89     if (pevent == (OS_EVENT *)0) {               /* Validate 'pevent'                                  */
4213  0003 046404        	tbne	d,L5772
4214                     ; 90         *perr = OS_ERR_PEVENT_NULL;
4216  0006 c604          	ldab	#4
4217                     ; 91         return ((void *)0);
4220  0008 200a          	bra	LC001
4221  000a               L5772:
4222                     ; 94     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {/* Validate event block type                          */
4224  000a e6f30005      	ldab	[OFST+0,s]
4225  000e c102          	cmpb	#2
4226  0010 270b          	beq	L7772
4227                     ; 95         *perr = OS_ERR_EVENT_TYPE;
4229  0012 c601          	ldab	#1
4230                     ; 96         return ((void *)0);
4232  0014               LC001:
4233  0014 6bf30009      	stab	[OFST+4,s]
4234  0018 87            	clra	
4235  0019 c7            	clrb	
4237  001a               L6:
4239  001a 1b87          	leas	7,s
4240  001c 3d            	rts	
4241  001d               L7772:
4242                     ; 98     OS_ENTER_CRITICAL();
4244  001d 160000        	jsr	_OS_CPU_SR_Save
4246  0020 6b84          	stab	OFST-1,s
4247                     ; 99     pq = (OS_Q *)pevent->OSEventPtr;             /* Point at queue control block                       */
4249  0022 ed85          	ldy	OFST+0,s
4250  0024 ed41          	ldy	1,y
4251  0026 6d80          	sty	OFST-5,s
4252                     ; 100     if (pq->OSQEntries > 0u) {                   /* See if any messages in the queue                   */
4254  0028 ec4c          	ldd	12,y
4255  002a 271d          	beq	L1003
4256                     ; 101         pmsg = *pq->OSQOut++;                    /* Yes, extract oldest message from the queue         */
4258  002c ee48          	ldx	8,y
4259  002e 18023182      	movw	2,x+,OFST-3,s
4260  0032 6e48          	stx	8,y
4261                     ; 102         pq->OSQEntries--;                        /* Update the number of entries in the queue          */
4263  0034 ee4c          	ldx	12,y
4264  0036 09            	dex	
4265  0037 6e4c          	stx	12,y
4266                     ; 103         if (pq->OSQOut == pq->OSQEnd) {          /* Wrap OUT pointer if we are at the end of the queue */
4268  0039 ec48          	ldd	8,y
4269  003b ac44          	cpd	4,y
4270  003d 2604          	bne	L3003
4271                     ; 104             pq->OSQOut = pq->OSQStart;
4273  003f 18024248      	movw	2,y,8,y
4274  0043               L3003:
4275                     ; 106         *perr = OS_ERR_NONE;
4277  0043 69f30009      	clr	[OFST+4,s]
4279  0047 2009          	bra	L5003
4280  0049               L1003:
4281                     ; 108         *perr = OS_ERR_Q_EMPTY;
4283  0049 c61f          	ldab	#31
4284  004b 6bf30009      	stab	[OFST+4,s]
4285                     ; 109         pmsg  = (void *)0;                       /* Queue is empty                                     */
4287  004f c7            	clrb	
4288  0050 6c82          	std	OFST-3,s
4289  0052               L5003:
4290                     ; 111     OS_EXIT_CRITICAL();
4292  0052 e684          	ldab	OFST-1,s
4293  0054 87            	clra	
4294  0055 160000        	jsr	_OS_CPU_SR_Restore
4296                     ; 112     return (pmsg);                               /* Return message received (or NULL)                  */
4298  0058 ec82          	ldd	OFST-3,s
4300  005a 20be          	bra	L6
4382                     ; 136 _NEAR OS_EVENT  *OSQCreate (void    **start,
4382                     ; 137                            INT16U    size)
4382                     ; 138 {
4383                     	switch	.text
4384  005c               _OSQCreate:
4386  005c 3b            	pshd	
4387  005d 1b9b          	leas	-5,s
4388       00000005      OFST:	set	5
4391                     ; 142     OS_CPU_SR  cpu_sr = 0u;
4393                     ; 154     if (OSIntNesting > 0u) {                     /* See if called from ISR ...                         */
4395  005f f60000        	ldab	_OSIntNesting
4396  0062 2705          	beq	L7403
4397                     ; 155         return ((OS_EVENT *)0);                  /* ... can't CREATE from an ISR                       */
4399  0064 87            	clra	
4400  0065 c7            	clrb	
4403  0066 1b87          	leas	7,s
4404  0068 3d            	rts	
4405  0069               L7403:
4406                     ; 157     OS_ENTER_CRITICAL();
4408  0069 160000        	jsr	_OS_CPU_SR_Save
4410  006c 6b84          	stab	OFST-1,s
4411                     ; 158     pevent = OSEventFreeList;                    /* Get next free event control block                  */
4413  006e fd0000        	ldy	_OSEventFreeList
4414  0071 6d80          	sty	OFST-5,s
4415                     ; 159     if (OSEventFreeList != (OS_EVENT *)0) {      /* See if pool of free ECB pool was empty             */
4417  0073 2705          	beq	L1503
4418                     ; 160         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
4420  0075 1805410000    	movw	1,y,_OSEventFreeList
4421  007a               L1503:
4422                     ; 162     OS_EXIT_CRITICAL();
4424  007a 87            	clra	
4425  007b 160000        	jsr	_OS_CPU_SR_Restore
4427                     ; 163     if (pevent != (OS_EVENT *)0) {               /* See if we have an event control block              */
4429  007e ec80          	ldd	OFST-5,s
4430  0080 275b          	beq	L3503
4431                     ; 164         OS_ENTER_CRITICAL();
4433  0082 160000        	jsr	_OS_CPU_SR_Save
4435  0085 6b84          	stab	OFST-1,s
4436                     ; 165         pq = OSQFreeList;                        /* Get a free queue control block                     */
4438  0087 fd0000        	ldy	_OSQFreeList
4439  008a 6d82          	sty	OFST-3,s
4440                     ; 166         if (pq != (OS_Q *)0) {                   /* Were we able to get a queue control block ?        */
4442  008c 273f          	beq	L5503
4443                     ; 167             OSQFreeList            = OSQFreeList->OSQPtr; /* Yes, Adjust free list pointer to next free*/
4445  008e 1805400000    	movw	0,y,_OSQFreeList
4446                     ; 168             OS_EXIT_CRITICAL();
4448  0093 87            	clra	
4449  0094 160000        	jsr	_OS_CPU_SR_Restore
4451                     ; 169             pq->OSQStart           = start;               /*      Initialize the queue                 */
4453  0097 ed82          	ldy	OFST-3,s
4454  0099 18028542      	movw	OFST+0,s,2,y
4455                     ; 170             pq->OSQEnd             = &start[size];
4457  009d ec89          	ldd	OFST+4,s
4458  009f 59            	lsld	
4459  00a0 e385          	addd	OFST+0,s
4460  00a2 6c44          	std	4,y
4461                     ; 171             pq->OSQIn              = start;
4463  00a4 ec85          	ldd	OFST+0,s
4464  00a6 6c46          	std	6,y
4465                     ; 172             pq->OSQOut             = start;
4467  00a8 6c48          	std	8,y
4468                     ; 173             pq->OSQSize            = size;
4470  00aa 1802894a      	movw	OFST+4,s,10,y
4471                     ; 174             pq->OSQEntries         = 0u;
4473  00ae 87            	clra	
4474  00af c7            	clrb	
4475  00b0 6c4c          	std	12,y
4476                     ; 175             pevent->OSEventType    = OS_EVENT_TYPE_Q;
4478  00b2 c602          	ldab	#2
4479  00b4 ed80          	ldy	OFST-5,s
4480  00b6 6b40          	stab	0,y
4481                     ; 176             pevent->OSEventCnt     = 0u;
4483  00b8 c7            	clrb	
4484  00b9 6c43          	std	3,y
4485                     ; 177             pevent->OSEventPtr     = pq;
4487  00bb 18028241      	movw	OFST-3,s,1,y
4488                     ; 179             pevent->OSEventName    = (INT8U *)(void *)"?";
4490  00bf cc0000        	ldd	#L7503
4491  00c2 6c4e          	std	14,y
4492                     ; 181             OS_EventWaitListInit(pevent);                 /*      Initialize the wait list             */
4494  00c4 b764          	tfr	y,d
4495  00c6 160000        	jsr	_OS_EventWaitListInit
4497                     ; 183             OS_TRACE_Q_CREATE(pevent, pevent->OSEventName);
4499  00c9 ec80          	ldd	OFST-5,s
4500  00cb 2010          	bra	L3503
4501  00cd               L5503:
4502                     ; 185             pevent->OSEventPtr = (void *)OSEventFreeList; /* No,  Return event control block on error  */
4504  00cd ed80          	ldy	OFST-5,s
4505  00cf 1801410000    	movw	_OSEventFreeList,1,y
4506                     ; 186             OSEventFreeList    = pevent;
4508  00d4 7d0000        	sty	_OSEventFreeList
4509                     ; 187             OS_EXIT_CRITICAL();
4511  00d7 87            	clra	
4512  00d8 160000        	jsr	_OS_CPU_SR_Restore
4514                     ; 188             pevent = (OS_EVENT *)0;
4516  00db 87            	clra	
4517  00dc c7            	clrb	
4518  00dd               L3503:
4519                     ; 191     return (pevent);
4523  00dd 1b87          	leas	7,s
4524  00df 3d            	rts	
4625                     ; 241 _NEAR OS_EVENT  *OSQDel (OS_EVENT  *pevent,
4625                     ; 242                         INT8U      opt,
4625                     ; 243                         INT8U     *perr)
4625                     ; 244 {
4626                     	switch	.text
4627  00e0               _OSQDel:
4629  00e0 3b            	pshd	
4630  00e1 1b9c          	leas	-4,s
4631       00000004      OFST:	set	4
4634                     ; 249     OS_CPU_SR  cpu_sr = 0u;
4636                     ; 269     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
4638  00e3 046404        	tbne	d,L1413
4639                     ; 270         *perr = OS_ERR_PEVENT_NULL;
4641  00e6 c604          	ldab	#4
4642                     ; 271         return (pevent);
4645  00e8 200a          	bra	L41
4646  00ea               L1413:
4647                     ; 277     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {          /* Validate event block type                */
4650  00ea e6f30004      	ldab	[OFST+0,s]
4651  00ee c102          	cmpb	#2
4652  00f0 270b          	beq	L3413
4653                     ; 278         *perr = OS_ERR_EVENT_TYPE;
4655  00f2 c601          	ldab	#1
4656                     ; 280         return (pevent);
4660  00f4               L41:
4661  00f4 6bf3000a      	stab	[OFST+6,s]
4662  00f8 ec84          	ldd	OFST+0,s
4664  00fa 1b86          	leas	6,s
4665  00fc 3d            	rts	
4666  00fd               L3413:
4667                     ; 282     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4669  00fd f60000        	ldab	_OSIntNesting
4670  0100 2704          	beq	L5413
4671                     ; 283         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
4673  0102 c60f          	ldab	#15
4674                     ; 285         return (pevent);
4678  0104 20ee          	bra	L41
4679  0106               L5413:
4680                     ; 287     OS_ENTER_CRITICAL();
4682  0106 160000        	jsr	_OS_CPU_SR_Save
4684  0109 6b82          	stab	OFST-2,s
4685                     ; 288     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on queue        */
4687  010b ed84          	ldy	OFST+0,s
4688  010d e645          	ldab	5,y
4689  010f 2706          	beq	L7413
4690                     ; 289         tasks_waiting = OS_TRUE;                           /* Yes                                      */
4692  0111 c601          	ldab	#1
4693  0113 6b83          	stab	OFST-1,s
4695  0115 2002          	bra	L1513
4696  0117               L7413:
4697                     ; 291         tasks_waiting = OS_FALSE;                          /* No                                       */
4699  0117 6983          	clr	OFST-1,s
4700  0119               L1513:
4701                     ; 293     switch (opt) {
4703  0119 e689          	ldab	OFST+5,s
4705  011b 270d          	beq	L3603
4706  011d 040160        	dbeq	b,L5613
4707                     ; 338         default:
4707                     ; 339              OS_EXIT_CRITICAL();
4709  0120 e682          	ldab	OFST-2,s
4710  0122 87            	clra	
4711  0123 160000        	jsr	_OS_CPU_SR_Restore
4713                     ; 340              *perr                  = OS_ERR_INVALID_OPT;
4715  0126 c607          	ldab	#7
4716                     ; 341              pevent_return          = pevent;
4718                     ; 342              break;
4720  0128 203a          	bra	LC003
4721  012a               L3603:
4722                     ; 294         case OS_DEL_NO_PEND:                               /* Delete queue only if no task waiting     */
4722                     ; 295              if (tasks_waiting == OS_FALSE) {
4724  012a e683          	ldab	OFST-1,s
4725  012c 262e          	bne	L7513
4726                     ; 297                  pevent->OSEventName    = (INT8U *)(void *)"?";
4728  012e cc0000        	ldd	#L7503
4729  0131 6c4e          	std	14,y
4730                     ; 299                  pq                     = (OS_Q *)pevent->OSEventPtr;  /* Return OS_Q to free list     */
4732  0133 ee41          	ldx	1,y
4733  0135 6e80          	stx	OFST-4,s
4734                     ; 300                  pq->OSQPtr             = OSQFreeList;
4736  0137 1801000000    	movw	_OSQFreeList,0,x
4737                     ; 301                  OSQFreeList            = pq;
4739  013c 7e0000        	stx	_OSQFreeList
4740                     ; 302                  pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
4742  013f 87            	clra	
4743  0140 6a40          	staa	0,y
4744                     ; 303                  pevent->OSEventPtr     = OSEventFreeList; /* Return Event Control Block to free list  */
4746  0142 1801410000    	movw	_OSEventFreeList,1,y
4747                     ; 304                  pevent->OSEventCnt     = 0u;
4749  0147 c7            	clrb	
4750  0148 6c43          	std	3,y
4751                     ; 305                  OSEventFreeList        = pevent;          /* Get next free event control block        */
4753  014a 1805840000    	movw	OFST+0,s,_OSEventFreeList
4754                     ; 306                  OS_EXIT_CRITICAL();
4756  014f e682          	ldab	OFST-2,s
4757  0151 160000        	jsr	_OS_CPU_SR_Restore
4759                     ; 307                  *perr                  = OS_ERR_NONE;
4761  0154 87            	clra	
4762  0155 6af3000a      	staa	[OFST+6,s]
4763                     ; 308                  pevent_return          = (OS_EVENT *)0;   /* Queue has been deleted                   */
4765  0159 c7            	clrb	
4767  015a 200e          	bra	LC002
4768  015c               L7513:
4769                     ; 310                  OS_EXIT_CRITICAL();
4771  015c e682          	ldab	OFST-2,s
4772  015e 87            	clra	
4773  015f 160000        	jsr	_OS_CPU_SR_Restore
4775                     ; 311                  *perr                  = OS_ERR_TASK_WAITING;
4777  0162 c649          	ldab	#73
4778                     ; 312                  pevent_return          = pevent;
4780  0164               LC003:
4781  0164 6bf3000a      	stab	[OFST+6,s]
4782  0168 ec84          	ldd	OFST+0,s
4783  016a               LC002:
4784  016a 6c80          	std	OFST-4,s
4785  016c 204a          	bra	L5513
4786  016e               L3613:
4787                     ; 318                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
4789  016e cc0002        	ldd	#2
4790  0171 3b            	pshd	
4791  0172 c604          	ldab	#4
4792  0174 3b            	pshd	
4793  0175 c7            	clrb	
4794  0176 3b            	pshd	
4795  0177 ec8a          	ldd	OFST+6,s
4796  0179 160000        	jsr	_OS_EventTaskRdy
4798  017c 1b86          	leas	6,s
4799  017e ed84          	ldy	OFST+0,s
4800  0180               L5613:
4801                     ; 316         case OS_DEL_ALWAYS:                                /* Always delete the queue                  */
4801                     ; 317              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for queue        */
4803  0180 e645          	ldab	5,y
4804  0182 26ea          	bne	L3613
4805                     ; 321              pevent->OSEventName    = (INT8U *)(void *)"?";
4807  0184 cc0000        	ldd	#L7503
4808  0187 6c4e          	std	14,y
4809                     ; 323              pq                     = (OS_Q *)pevent->OSEventPtr;   /* Return OS_Q to free list        */
4811  0189 ee41          	ldx	1,y
4812  018b 6e80          	stx	OFST-4,s
4813                     ; 324              pq->OSQPtr             = OSQFreeList;
4815  018d 1801000000    	movw	_OSQFreeList,0,x
4816                     ; 325              OSQFreeList            = pq;
4818  0192 7e0000        	stx	_OSQFreeList
4819                     ; 326              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
4821  0195 87            	clra	
4822  0196 6a40          	staa	0,y
4823                     ; 327              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
4825  0198 1801410000    	movw	_OSEventFreeList,1,y
4826                     ; 328              pevent->OSEventCnt     = 0u;
4828  019d c7            	clrb	
4829  019e 6c43          	std	3,y
4830                     ; 329              OSEventFreeList        = pevent;              /* Get next free event control block        */
4832  01a0 1805840000    	movw	OFST+0,s,_OSEventFreeList
4833                     ; 330              OS_EXIT_CRITICAL();
4835  01a5 e682          	ldab	OFST-2,s
4836  01a7 160000        	jsr	_OS_CPU_SR_Restore
4838                     ; 331              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
4840  01aa e683          	ldab	OFST-1,s
4841  01ac 042103        	dbne	b,L1713
4842                     ; 332                  OS_Sched();                               /* Find highest priority task ready to run  */
4844  01af 160000        	jsr	_OS_Sched
4846  01b2               L1713:
4847                     ; 334              *perr                  = OS_ERR_NONE;
4849  01b2 87            	clra	
4850  01b3 6af3000a      	staa	[OFST+6,s]
4851                     ; 335              pevent_return          = (OS_EVENT *)0;       /* Queue has been deleted                   */
4853  01b7 c7            	clrb	
4854                     ; 336              break;
4856  01b8               L5513:
4857                     ; 347     return (pevent_return);
4862  01b8 1b86          	leas	6,s
4863  01ba 3d            	rts	
4920                     ; 372 _NEAR INT8U  OSQFlush (OS_EVENT *pevent)
4920                     ; 373 {
4921                     	switch	.text
4922  01bb               _OSQFlush:
4924  01bb 3b            	pshd	
4925  01bc 1b9d          	leas	-3,s
4926       00000003      OFST:	set	3
4929                     ; 376     OS_CPU_SR  cpu_sr = 0u;
4931                     ; 382     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
4933  01be 046404        	tbne	d,L3223
4934                     ; 383         return (OS_ERR_PEVENT_NULL);
4936  01c1 c604          	ldab	#4
4938  01c3 200a          	bra	L02
4939  01c5               L3223:
4940                     ; 385     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
4942  01c5 e6f30003      	ldab	[OFST+0,s]
4943  01c9 c102          	cmpb	#2
4944  01cb 2705          	beq	L5223
4945                     ; 386         return (OS_ERR_EVENT_TYPE);
4947  01cd c601          	ldab	#1
4949  01cf               L02:
4951  01cf 1b85          	leas	5,s
4952  01d1 3d            	rts	
4953  01d2               L5223:
4954                     ; 389     OS_ENTER_CRITICAL();
4956  01d2 160000        	jsr	_OS_CPU_SR_Save
4958  01d5 6b82          	stab	OFST-1,s
4959                     ; 390     pq             = (OS_Q *)pevent->OSEventPtr;      /* Point to queue storage structure              */
4961  01d7 ed83          	ldy	OFST+0,s
4962  01d9 ed41          	ldy	1,y
4963  01db 6d80          	sty	OFST-3,s
4964                     ; 391     pq->OSQIn      = pq->OSQStart;
4966  01dd ec42          	ldd	2,y
4967  01df 6c46          	std	6,y
4968                     ; 392     pq->OSQOut     = pq->OSQStart;
4970  01e1 6c48          	std	8,y
4971                     ; 393     pq->OSQEntries = 0u;
4973  01e3 87            	clra	
4974  01e4 c7            	clrb	
4975  01e5 6c4c          	std	12,y
4976                     ; 394     OS_EXIT_CRITICAL();
4978  01e7 e682          	ldab	OFST-1,s
4979  01e9 160000        	jsr	_OS_CPU_SR_Restore
4981                     ; 395     return (OS_ERR_NONE);
4983  01ec c7            	clrb	
4985  01ed 20e0          	bra	L02
5076                     ; 436 _NEAR void  *OSQPend (OS_EVENT  *pevent,
5076                     ; 437                 INT32U     timeout,
5076                     ; 438                 INT8U     *perr)
5076                     ; 439 {
5077                     	switch	.text
5078  01ef               _OSQPend:
5080  01ef 3b            	pshd	
5081  01f0 1b9b          	leas	-5,s
5082       00000005      OFST:	set	5
5085                     ; 443     OS_CPU_SR  cpu_sr = 0u;
5087                     ; 455     if (pevent == (OS_EVENT *)0) {               /* Validate 'pevent'                                  */
5089  01f2 046404        	tbne	d,L7723
5090                     ; 456         *perr = OS_ERR_PEVENT_NULL;
5092  01f5 c604          	ldab	#4
5093                     ; 457         return ((void *)0);
5096  01f7 200a          	bra	LC004
5097  01f9               L7723:
5098                     ; 463     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {/* Validate event block type                          */
5101  01f9 e6f30005      	ldab	[OFST+0,s]
5102  01fd c102          	cmpb	#2
5103  01ff 270b          	beq	L1033
5104                     ; 464         *perr = OS_ERR_EVENT_TYPE;
5106  0201 c601          	ldab	#1
5107                     ; 466         return ((void *)0);
5110  0203               LC004:
5111  0203 6bf3000d      	stab	[OFST+8,s]
5112  0207 87            	clra	
5113  0208 c7            	clrb	
5115  0209               L42:
5117  0209 1b87          	leas	7,s
5118  020b 3d            	rts	
5119  020c               L1033:
5120                     ; 468     if (OSIntNesting > 0u) {                     /* See if called from ISR ...                         */
5122  020c f60000        	ldab	_OSIntNesting
5123  020f 2704          	beq	L3033
5124                     ; 469         *perr = OS_ERR_PEND_ISR;                 /* ... can't PEND from an ISR                         */
5126  0211 c602          	ldab	#2
5127                     ; 471         return ((void *)0);
5131  0213 20ee          	bra	LC004
5132  0215               L3033:
5133                     ; 473     if (OSLockNesting > 0u) {                    /* See if called with scheduler locked ...            */
5135  0215 f60000        	ldab	_OSLockNesting
5136  0218 2704          	beq	L5033
5137                     ; 474         *perr = OS_ERR_PEND_LOCKED;              /* ... can't PEND when locked                         */
5139  021a c60d          	ldab	#13
5140                     ; 476         return ((void *)0);
5144  021c 20e5          	bra	LC004
5145  021e               L5033:
5146                     ; 478     OS_ENTER_CRITICAL();
5148  021e 160000        	jsr	_OS_CPU_SR_Save
5150  0221 6b84          	stab	OFST-1,s
5151                     ; 479     pq = (OS_Q *)pevent->OSEventPtr;             /* Point at queue control block                       */
5153  0223 ed85          	ldy	OFST+0,s
5154  0225 ed41          	ldy	1,y
5155  0227 6d80          	sty	OFST-5,s
5156                     ; 480     if (pq->OSQEntries > 0u) {                   /* See if any messages in the queue                   */
5158  0229 ec4c          	ldd	12,y
5159  022b 2725          	beq	L7033
5160                     ; 481         pmsg = *pq->OSQOut++;                    /* Yes, extract oldest message from the queue         */
5162  022d ee48          	ldx	8,y
5163  022f 18023182      	movw	2,x+,OFST-3,s
5164  0233 6e48          	stx	8,y
5165                     ; 482         pq->OSQEntries--;                        /* Update the number of entries in the queue          */
5167  0235 ee4c          	ldx	12,y
5168  0237 09            	dex	
5169  0238 6e4c          	stx	12,y
5170                     ; 483         if (pq->OSQOut == pq->OSQEnd) {          /* Wrap OUT pointer if we are at the end of the queue */
5172  023a ec48          	ldd	8,y
5173  023c ac44          	cpd	4,y
5174  023e 2604          	bne	L1133
5175                     ; 484             pq->OSQOut = pq->OSQStart;
5177  0240 18024248      	movw	2,y,8,y
5178  0244               L1133:
5179                     ; 486         OS_EXIT_CRITICAL();
5181  0244 e684          	ldab	OFST-1,s
5182  0246 87            	clra	
5183  0247 160000        	jsr	_OS_CPU_SR_Restore
5185                     ; 487         *perr = OS_ERR_NONE;
5187  024a 69f3000d      	clr	[OFST+8,s]
5188                     ; 489         return (pmsg);                           /* Return message received                            */
5191  024e ec82          	ldd	OFST-3,s
5193  0250 20b7          	bra	L42
5194  0252               L7033:
5195                     ; 491     OSTCBCur->OSTCBStat     |= OS_STAT_Q;        /* Task will have to pend for a message to be posted  */
5197  0252 fd0000        	ldy	_OSTCBCur
5198  0255 0ce82204      	bset	34,y,4
5199                     ; 492     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
5201  0259 69e823        	clr	35,y
5202                     ; 493     OSTCBCur->OSTCBDly       = timeout;          /* Load timeout into TCB                              */
5204  025c ec8b          	ldd	OFST+6,s
5205  025e 6ce820        	std	32,y
5206  0261 ec89          	ldd	OFST+4,s
5207  0263 6ce81e        	std	30,y
5208                     ; 494     OS_EventTaskWait(pevent);                    /* Suspend task until event or timeout occurs         */
5210  0266 ec85          	ldd	OFST+0,s
5211  0268 160000        	jsr	_OS_EventTaskWait
5213                     ; 495     OS_EXIT_CRITICAL();
5215  026b e684          	ldab	OFST-1,s
5216  026d 87            	clra	
5217  026e 160000        	jsr	_OS_CPU_SR_Restore
5219                     ; 496     OS_Sched();                                  /* Find next highest priority task ready to run       */
5221  0271 160000        	jsr	_OS_Sched
5223                     ; 497     OS_ENTER_CRITICAL();
5225  0274 160000        	jsr	_OS_CPU_SR_Save
5227  0277 6b84          	stab	OFST-1,s
5228                     ; 498     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
5230  0279 fd0000        	ldy	_OSTCBCur
5231  027c e6e823        	ldab	35,y
5233  027f 2708          	beq	L7223
5234  0281 040117        	dbeq	b,L3323
5235  0284 04010d        	dbeq	b,L1323
5236  0287 2012          	bra	L3323
5237  0289               L7223:
5238                     ; 499         case OS_STAT_PEND_OK:                         /* Extract message from TCB (Put there by QPost) */
5238                     ; 500              pmsg =  OSTCBCur->OSTCBMsg;
5240  0289 ece818        	ldd	24,y
5241  028c 6c82          	std	OFST-3,s
5242                     ; 501             *perr =  OS_ERR_NONE;
5244  028e 69f3000d      	clr	[OFST+8,s]
5245                     ; 502              break;
5247  0292 201e          	bra	L5133
5248  0294               L1323:
5249                     ; 504         case OS_STAT_PEND_ABORT:
5249                     ; 505              pmsg = (void *)0;
5251  0294 87            	clra	
5252  0295 6c82          	std	OFST-3,s
5253                     ; 506             *perr =  OS_ERR_PEND_ABORT;               /* Indicate that we aborted                      */
5255  0297 c60e          	ldab	#14
5256                     ; 507              break;
5258  0299 2010          	bra	LC005
5259  029b               L3323:
5260                     ; 509         case OS_STAT_PEND_TO:
5260                     ; 510         default:
5260                     ; 511              OS_EventTaskRemove(OSTCBCur, pevent);
5262  029b ec85          	ldd	OFST+0,s
5263  029d 3b            	pshd	
5264  029e b764          	tfr	y,d
5265  02a0 160000        	jsr	_OS_EventTaskRemove
5267  02a3 1b82          	leas	2,s
5268                     ; 512              pmsg = (void *)0;
5270  02a5 87            	clra	
5271  02a6 c7            	clrb	
5272  02a7 6c82          	std	OFST-3,s
5273                     ; 513             *perr =  OS_ERR_TIMEOUT;                  /* Indicate that we didn't get event within TO   */
5275  02a9 c60a          	ldab	#10
5276  02ab               LC005:
5277  02ab 6bf3000d      	stab	[OFST+8,s]
5278                     ; 514              break;
5280  02af fd0000        	ldy	_OSTCBCur
5281  02b2               L5133:
5282                     ; 516     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
5284  02b2 c7            	clrb	
5285  02b3 6be822        	stab	34,y
5286                     ; 517     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
5288  02b6 87            	clra	
5289  02b7 6ae823        	staa	35,y
5290                     ; 518     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
5292  02ba 6ce812        	std	18,y
5293                     ; 520     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
5295  02bd 6ce814        	std	20,y
5296                     ; 521     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
5298  02c0 6ce816        	std	22,y
5299                     ; 523     OSTCBCur->OSTCBMsg           = (void      *)0;    /* Clear  received message                       */
5301  02c3 6ce818        	std	24,y
5302                     ; 524     OS_EXIT_CRITICAL();
5304  02c6 e684          	ldab	OFST-1,s
5305  02c8 160000        	jsr	_OS_CPU_SR_Restore
5307                     ; 527     return (pmsg);                                    /* Return received message                       */
5310  02cb ec82          	ldd	OFST-3,s
5313  02cd 1b87          	leas	7,s
5314  02cf 3d            	rts	
5385                     ; 564 _NEAR INT8U  OSQPendAbort (OS_EVENT  *pevent,
5385                     ; 565                           INT8U      opt,
5385                     ; 566                           INT8U     *perr)
5385                     ; 567 {
5386                     	switch	.text
5387  02d0               _OSQPendAbort:
5389  02d0 3b            	pshd	
5390       00000002      OFST:	set	2
5393                     ; 570     OS_CPU_SR  cpu_sr = 0u;
5395                     ; 583     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
5397  02d1 6cae          	std	2,-s
5398  02d3 2604          	bne	L5533
5399                     ; 584         *perr = OS_ERR_PEVENT_NULL;
5401  02d5 c604          	ldab	#4
5402                     ; 585         return (0u);
5405  02d7 200a          	bra	LC006
5406  02d9               L5533:
5407                     ; 588     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {          /* Validate event block type                */
5409  02d9 e6f30002      	ldab	[OFST+0,s]
5410  02dd c102          	cmpb	#2
5411  02df 270a          	beq	L7533
5412                     ; 589         *perr = OS_ERR_EVENT_TYPE;
5414  02e1 c601          	ldab	#1
5415                     ; 590         return (0u);
5417  02e3               LC006:
5418  02e3 6bf30008      	stab	[OFST+6,s]
5419  02e7 c7            	clrb	
5421  02e8               L03:
5423  02e8 1b84          	leas	4,s
5424  02ea 3d            	rts	
5425  02eb               L7533:
5426                     ; 592     OS_ENTER_CRITICAL();
5428  02eb 160000        	jsr	_OS_CPU_SR_Save
5430  02ee 6b81          	stab	OFST-1,s
5431                     ; 593     if (pevent->OSEventGrp != 0u) {                        /* See if any task waiting on queue?        */
5433  02f0 ed82          	ldy	OFST+0,s
5434  02f2 e745          	tst	5,y
5435  02f4 274a          	beq	L1633
5436                     ; 594         nbr_tasks = 0u;
5438  02f6 6980          	clr	OFST-2,s
5439                     ; 595         switch (opt) {
5441  02f8 e687          	ldab	OFST+5,s
5443  02fa 271f          	beq	L1233
5444  02fc 040116        	dbeq	b,L1733
5445  02ff 201a          	bra	L1233
5446  0301               L7633:
5447                     ; 598                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
5449  0301 cc0002        	ldd	#2
5450  0304 3b            	pshd	
5451  0305 c604          	ldab	#4
5452  0307 3b            	pshd	
5453  0308 c7            	clrb	
5454  0309 3b            	pshd	
5455  030a ec88          	ldd	OFST+6,s
5456  030c 160000        	jsr	_OS_EventTaskRdy
5458  030f 1b86          	leas	6,s
5459                     ; 599                      nbr_tasks++;
5461  0311 6280          	inc	OFST-2,s
5462  0313 ed82          	ldy	OFST+0,s
5463  0315               L1733:
5464                     ; 596             case OS_PEND_OPT_BROADCAST:                    /* Do we need to abort ALL waiting tasks?   */
5464                     ; 597                  while (pevent->OSEventGrp != 0u) {        /* Yes, ready ALL tasks waiting on queue    */
5466  0315 e645          	ldab	5,y
5467  0317 26e8          	bne	L7633
5468                     ; 601                  break;
5470  0319 2012          	bra	L5633
5471  031b               L1233:
5472                     ; 603             case OS_PEND_OPT_NONE:
5472                     ; 604             default:                                       /* No,  ready HPT       waiting on queue    */
5472                     ; 605                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
5474  031b cc0002        	ldd	#2
5475  031e 3b            	pshd	
5476  031f c604          	ldab	#4
5477  0321 3b            	pshd	
5478  0322 c7            	clrb	
5479  0323 3b            	pshd	
5480  0324 b764          	tfr	y,d
5481  0326 160000        	jsr	_OS_EventTaskRdy
5483  0329 1b86          	leas	6,s
5484                     ; 606                  nbr_tasks++;
5486  032b 6280          	inc	OFST-2,s
5487                     ; 607                  break;
5489  032d               L5633:
5490                     ; 609         OS_EXIT_CRITICAL();
5492  032d e681          	ldab	OFST-1,s
5493  032f 87            	clra	
5494  0330 160000        	jsr	_OS_CPU_SR_Restore
5496                     ; 610         OS_Sched();                                        /* Find HPT ready to run                    */
5498  0333 160000        	jsr	_OS_Sched
5500                     ; 611         *perr = OS_ERR_PEND_ABORT;
5502  0336 c60e          	ldab	#14
5503  0338 6bf30008      	stab	[OFST+6,s]
5504                     ; 612         return (nbr_tasks);
5506  033c e680          	ldab	OFST-2,s
5508  033e 20a8          	bra	L03
5509  0340               L1633:
5510                     ; 614     OS_EXIT_CRITICAL();
5512  0340 87            	clra	
5513  0341 160000        	jsr	_OS_CPU_SR_Restore
5515                     ; 615     *perr = OS_ERR_NONE;
5517  0344 c7            	clrb	
5518  0345 6bf30008      	stab	[OFST+6,s]
5519                     ; 616     return (0u);                                           /* No tasks waiting on queue                */
5522  0349 209d          	bra	L03
5591                     ; 641 _NEAR INT8U  OSQPost (OS_EVENT  *pevent,
5591                     ; 642                      void      *pmsg)
5591                     ; 643 {
5592                     	switch	.text
5593  034b               _OSQPost:
5595  034b 3b            	pshd	
5596  034c 1b9d          	leas	-3,s
5597       00000003      OFST:	set	3
5600                     ; 646     OS_CPU_SR  cpu_sr = 0u;
5602                     ; 651     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
5604  034e 046404        	tbne	d,L1343
5605                     ; 652         return (OS_ERR_PEVENT_NULL);
5607  0351 c604          	ldab	#4
5609  0353 200a          	bra	L43
5610  0355               L1343:
5611                     ; 658     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {      /* Validate event block type                    */
5614  0355 e6f30003      	ldab	[OFST+0,s]
5615  0359 c102          	cmpb	#2
5616  035b 2705          	beq	L3343
5617                     ; 660         return (OS_ERR_EVENT_TYPE);
5620  035d c601          	ldab	#1
5622  035f               L43:
5624  035f 1b85          	leas	5,s
5625  0361 3d            	rts	
5626  0362               L3343:
5627                     ; 662     OS_ENTER_CRITICAL();
5629  0362 160000        	jsr	_OS_CPU_SR_Save
5631  0365 6b82          	stab	OFST-1,s
5632                     ; 663     if (pevent->OSEventGrp != 0u) {                    /* See if any task pending on queue             */
5634  0367 ed83          	ldy	OFST+0,s
5635  0369 e645          	ldab	5,y
5636  036b 271b          	beq	L5343
5637                     ; 665         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
5639  036d 87            	clra	
5640  036e c7            	clrb	
5641  036f 3b            	pshd	
5642  0370 c604          	ldab	#4
5643  0372 3b            	pshd	
5644  0373 ec8b          	ldd	OFST+8,s
5645  0375 3b            	pshd	
5646  0376 b764          	tfr	y,d
5647  0378 160000        	jsr	_OS_EventTaskRdy
5649  037b 1b86          	leas	6,s
5650                     ; 666         OS_EXIT_CRITICAL();
5652  037d e682          	ldab	OFST-1,s
5653  037f 87            	clra	
5654  0380 160000        	jsr	_OS_CPU_SR_Restore
5656                     ; 667         OS_Sched();                                    /* Find highest priority task ready to run      */
5658  0383 160000        	jsr	_OS_Sched
5660                     ; 669         return (OS_ERR_NONE);
5664  0386 2031          	bra	LC007
5665  0388               L5343:
5666                     ; 671     pq = (OS_Q *)pevent->OSEventPtr;                   /* Point to queue control block                 */
5668  0388 ed41          	ldy	1,y
5669  038a 6d80          	sty	OFST-3,s
5670                     ; 672     if (pq->OSQEntries >= pq->OSQSize) {               /* Make sure queue is not full                  */
5672  038c ec4c          	ldd	12,y
5673  038e ac4a          	cpd	10,y
5674  0390 250a          	blo	L7343
5675                     ; 673         OS_EXIT_CRITICAL();
5677  0392 e682          	ldab	OFST-1,s
5678  0394 87            	clra	
5679  0395 160000        	jsr	_OS_CPU_SR_Restore
5681                     ; 675         return (OS_ERR_Q_FULL);
5684  0398 c61e          	ldab	#30
5686  039a 20c3          	bra	L43
5687  039c               L7343:
5688                     ; 677     *pq->OSQIn++ = pmsg;                               /* Insert message into queue                    */
5690  039c ee46          	ldx	6,y
5691  039e 18028731      	movw	OFST+4,s,2,x+
5692  03a2 6e46          	stx	6,y
5693                     ; 678     pq->OSQEntries++;                                  /* Update the nbr of entries in the queue       */
5695  03a4 ee4c          	ldx	12,y
5696  03a6 08            	inx	
5697  03a7 6e4c          	stx	12,y
5698                     ; 679     if (pq->OSQIn == pq->OSQEnd) {                     /* Wrap IN ptr if we are at end of queue        */
5700  03a9 ec46          	ldd	6,y
5701  03ab ac44          	cpd	4,y
5702  03ad 2604          	bne	L1443
5703                     ; 680         pq->OSQIn = pq->OSQStart;
5705  03af 18024246      	movw	2,y,6,y
5706  03b3               L1443:
5707                     ; 682     OS_EXIT_CRITICAL();
5709  03b3 e682          	ldab	OFST-1,s
5710  03b5 87            	clra	
5711  03b6 160000        	jsr	_OS_CPU_SR_Restore
5713                     ; 685     return (OS_ERR_NONE);
5716  03b9               LC007:
5717  03b9 c7            	clrb	
5719  03ba 20a3          	bra	L43
5788                     ; 712 _NEAR INT8U  OSQPostFront (OS_EVENT  *pevent,
5788                     ; 713                           void      *pmsg)
5788                     ; 714 {
5789                     	switch	.text
5790  03bc               _OSQPostFront:
5792  03bc 3b            	pshd	
5793  03bd 1b9d          	leas	-3,s
5794       00000003      OFST:	set	3
5797                     ; 717     OS_CPU_SR  cpu_sr = 0u;
5799                     ; 723     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
5801  03bf 046404        	tbne	d,L7743
5802                     ; 724         return (OS_ERR_PEVENT_NULL);
5804  03c2 c604          	ldab	#4
5806  03c4 200a          	bra	L04
5807  03c6               L7743:
5808                     ; 730     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
5811  03c6 e6f30003      	ldab	[OFST+0,s]
5812  03ca c102          	cmpb	#2
5813  03cc 2705          	beq	L1053
5814                     ; 732         return (OS_ERR_EVENT_TYPE);
5817  03ce c601          	ldab	#1
5819  03d0               L04:
5821  03d0 1b85          	leas	5,s
5822  03d2 3d            	rts	
5823  03d3               L1053:
5824                     ; 734     OS_ENTER_CRITICAL();
5826  03d3 160000        	jsr	_OS_CPU_SR_Save
5828  03d6 6b82          	stab	OFST-1,s
5829                     ; 735     if (pevent->OSEventGrp != 0u) {                   /* See if any task pending on queue              */
5831  03d8 ed83          	ldy	OFST+0,s
5832  03da e645          	ldab	5,y
5833  03dc 271b          	beq	L3053
5834                     ; 737         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
5836  03de 87            	clra	
5837  03df c7            	clrb	
5838  03e0 3b            	pshd	
5839  03e1 c604          	ldab	#4
5840  03e3 3b            	pshd	
5841  03e4 ec8b          	ldd	OFST+8,s
5842  03e6 3b            	pshd	
5843  03e7 b764          	tfr	y,d
5844  03e9 160000        	jsr	_OS_EventTaskRdy
5846  03ec 1b86          	leas	6,s
5847                     ; 738         OS_EXIT_CRITICAL();
5849  03ee e682          	ldab	OFST-1,s
5850  03f0 87            	clra	
5851  03f1 160000        	jsr	_OS_CPU_SR_Restore
5853                     ; 739         OS_Sched();                                   /* Find highest priority task ready to run       */
5855  03f4 160000        	jsr	_OS_Sched
5857                     ; 741         return (OS_ERR_NONE);
5861  03f7 202f          	bra	LC008
5862  03f9               L3053:
5863                     ; 743     pq = (OS_Q *)pevent->OSEventPtr;                  /* Point to queue control block                  */
5865  03f9 ed41          	ldy	1,y
5866  03fb 6d80          	sty	OFST-3,s
5867                     ; 744     if (pq->OSQEntries >= pq->OSQSize) {              /* Make sure queue is not full                   */
5869  03fd ec4c          	ldd	12,y
5870  03ff ac4a          	cpd	10,y
5871  0401 250a          	blo	L5053
5872                     ; 745         OS_EXIT_CRITICAL();
5874  0403 e682          	ldab	OFST-1,s
5875  0405 87            	clra	
5876  0406 160000        	jsr	_OS_CPU_SR_Restore
5878                     ; 747         return (OS_ERR_Q_FULL);
5881  0409 c61e          	ldab	#30
5883  040b 20c3          	bra	L04
5884  040d               L5053:
5885                     ; 749     if (pq->OSQOut == pq->OSQStart) {                 /* Wrap OUT ptr if we are at the 1st queue entry */
5887  040d ee48          	ldx	8,y
5888  040f ae42          	cpx	2,y
5889  0411 2604          	bne	L7053
5890                     ; 750         pq->OSQOut = pq->OSQEnd;
5892  0413 ee44          	ldx	4,y
5893  0415 6e48          	stx	8,y
5894  0417               L7053:
5895                     ; 752     pq->OSQOut--;
5897                     ; 753     *pq->OSQOut = pmsg;                               /* Insert message into queue                     */
5899  0417 1802872e      	movw	OFST+4,s,2,-x
5900  041b 6e48          	stx	8,y
5901                     ; 754     pq->OSQEntries++;                                 /* Update the nbr of entries in the queue        */
5903  041d ee4c          	ldx	12,y
5904  041f 08            	inx	
5905  0420 6e4c          	stx	12,y
5906                     ; 755     OS_EXIT_CRITICAL();
5908  0422 e682          	ldab	OFST-1,s
5909  0424 87            	clra	
5910  0425 160000        	jsr	_OS_CPU_SR_Restore
5912                     ; 757     return (OS_ERR_NONE);
5915  0428               LC008:
5916  0428 c7            	clrb	
5918  0429 20a5          	bra	L04
5994                     ; 792 _NEAR INT8U  OSQPostOpt (OS_EVENT  *pevent,
5994                     ; 793                         void      *pmsg,
5994                     ; 794                         INT8U      opt)
5994                     ; 795 {
5995                     	switch	.text
5996  042b               _OSQPostOpt:
5998  042b 3b            	pshd	
5999  042c 1b9d          	leas	-3,s
6000       00000003      OFST:	set	3
6003                     ; 798     OS_CPU_SR  cpu_sr = 0u;
6005                     ; 804     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
6007  042e 046404        	tbne	d,L7453
6008                     ; 805         return (OS_ERR_PEVENT_NULL);
6010  0431 c604          	ldab	#4
6012  0433 200a          	bra	L44
6013  0435               L7453:
6014                     ; 811     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
6017  0435 e6f30003      	ldab	[OFST+0,s]
6018  0439 c102          	cmpb	#2
6019  043b 2705          	beq	L1553
6020                     ; 813         return (OS_ERR_EVENT_TYPE);
6023  043d c601          	ldab	#1
6025  043f               L44:
6027  043f 1b85          	leas	5,s
6028  0441 3d            	rts	
6029  0442               L1553:
6030                     ; 815     OS_ENTER_CRITICAL();
6032  0442 160000        	jsr	_OS_CPU_SR_Save
6034  0445 6b82          	stab	OFST-1,s
6035                     ; 816     if (pevent->OSEventGrp != 0x00u) {                /* See if any task pending on queue              */
6037  0447 ed83          	ldy	OFST+0,s
6038  0449 e645          	ldab	5,y
6039  044b 273e          	beq	L3553
6040                     ; 817         if ((opt & OS_POST_OPT_BROADCAST) != 0x00u) { /* Do we need to post msg to ALL waiting tasks ? */
6042  044d 0f8a011a      	brclr	OFST+7,s,1,L5553
6044  0451 2014          	bra	L1653
6045  0453               L7553:
6046                     ; 819                 (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
6048  0453 87            	clra	
6049  0454 c7            	clrb	
6050  0455 3b            	pshd	
6051  0456 c604          	ldab	#4
6052  0458 3b            	pshd	
6053  0459 ec8b          	ldd	OFST+8,s
6054  045b 3b            	pshd	
6055  045c ec89          	ldd	OFST+6,s
6056  045e 160000        	jsr	_OS_EventTaskRdy
6058  0461 1b86          	leas	6,s
6059  0463 ed83          	ldy	OFST+0,s
6060  0465 e645          	ldab	5,y
6061  0467               L1653:
6062                     ; 818             while (pevent->OSEventGrp != 0u) {        /* Yes, Post to ALL tasks waiting on queue       */
6064  0467 26ea          	bne	L7553
6066  0469 2010          	bra	L5653
6067  046b               L5553:
6068                     ; 822             (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
6070  046b 87            	clra	
6071  046c c7            	clrb	
6072  046d 3b            	pshd	
6073  046e c604          	ldab	#4
6074  0470 3b            	pshd	
6075  0471 ec8b          	ldd	OFST+8,s
6076  0473 3b            	pshd	
6077  0474 b764          	tfr	y,d
6078  0476 160000        	jsr	_OS_EventTaskRdy
6080  0479 1b86          	leas	6,s
6081  047b               L5653:
6082                     ; 824         OS_EXIT_CRITICAL();
6084  047b e682          	ldab	OFST-1,s
6085  047d 87            	clra	
6086  047e 160000        	jsr	_OS_CPU_SR_Restore
6088                     ; 825         if ((opt & OS_POST_OPT_NO_SCHED) == 0u) {     /* See if scheduler needs to be invoked          */
6090  0481 0e8a0403      	brset	OFST+7,s,4,L7653
6091                     ; 826             OS_Sched();                               /* Find highest priority task ready to run       */
6093  0485 160000        	jsr	_OS_Sched
6095  0488               L7653:
6096                     ; 829         return (OS_ERR_NONE);
6099  0488 c7            	clrb	
6101  0489 20b4          	bra	L44
6102  048b               L3553:
6103                     ; 831     pq = (OS_Q *)pevent->OSEventPtr;                  /* Point to queue control block                  */
6105  048b ed41          	ldy	1,y
6106  048d 6d80          	sty	OFST-3,s
6107                     ; 832     if (pq->OSQEntries >= pq->OSQSize) {              /* Make sure queue is not full                   */
6109  048f ec4c          	ldd	12,y
6110  0491 ac4a          	cpd	10,y
6111  0493 250a          	blo	L1753
6112                     ; 833         OS_EXIT_CRITICAL();
6114  0495 e682          	ldab	OFST-1,s
6115  0497 87            	clra	
6116  0498 160000        	jsr	_OS_CPU_SR_Restore
6118                     ; 835         return (OS_ERR_Q_FULL);
6121  049b c61e          	ldab	#30
6123  049d 20a0          	bra	L44
6124  049f               L1753:
6125                     ; 837     if ((opt & OS_POST_OPT_FRONT) != 0x00u) {         /* Do we post to the FRONT of the queue?         */
6127  049f 0f8a0212      	brclr	OFST+7,s,2,L3753
6128                     ; 838         if (pq->OSQOut == pq->OSQStart) {             /* Yes, Post as LIFO, Wrap OUT pointer if we ... */
6130  04a3 ee48          	ldx	8,y
6131  04a5 ae42          	cpx	2,y
6132  04a7 2604          	bne	L5753
6133                     ; 839             pq->OSQOut = pq->OSQEnd;                  /*      ... are at the 1st queue entry           */
6135  04a9 ee44          	ldx	4,y
6136  04ab 6e48          	stx	8,y
6137  04ad               L5753:
6138                     ; 841         pq->OSQOut--;
6140                     ; 842         *pq->OSQOut = pmsg;                           /*      Insert message into queue                */
6142  04ad 1802872e      	movw	OFST+4,s,2,-x
6143  04b1 6e48          	stx	8,y
6145  04b3 2010          	bra	L7753
6146  04b5               L3753:
6147                     ; 844         *pq->OSQIn++ = pmsg;                          /*      Insert message into queue                */
6149  04b5 ee46          	ldx	6,y
6150  04b7 18028731      	movw	OFST+4,s,2,x+
6151  04bb 6e46          	stx	6,y
6152                     ; 845         if (pq->OSQIn == pq->OSQEnd) {                /*      Wrap IN ptr if we are at end of queue    */
6154  04bd ae44          	cpx	4,y
6155  04bf 2604          	bne	L7753
6156                     ; 846             pq->OSQIn = pq->OSQStart;
6158  04c1 18024246      	movw	2,y,6,y
6159  04c5               L7753:
6160                     ; 849     pq->OSQEntries++;                                 /* Update the nbr of entries in the queue        */
6162  04c5 ee4c          	ldx	12,y
6163  04c7 08            	inx	
6164  04c8 6e4c          	stx	12,y
6165                     ; 850     OS_EXIT_CRITICAL();
6167  04ca e682          	ldab	OFST-1,s
6168  04cc 87            	clra	
6169  04cd 160000        	jsr	_OS_CPU_SR_Restore
6171                     ; 852     return (OS_ERR_NONE);
6174  04d0 c7            	clrb	
6177  04d1 1b85          	leas	5,s
6178  04d3 3d            	rts	
6322                     ; 876 _NEAR INT8U  OSQQuery (OS_EVENT  *pevent,
6322                     ; 877                       OS_Q_DATA *p_q_data)
6322                     ; 878 {
6323                     	switch	.text
6324  04d4               _OSQQuery:
6326  04d4 3b            	pshd	
6327  04d5 1b9a          	leas	-6,s
6328       00000006      OFST:	set	6
6331                     ; 884     OS_CPU_SR   cpu_sr = 0u;
6333                     ; 890     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
6335  04d7 046404        	tbne	d,L5763
6336                     ; 891         return (OS_ERR_PEVENT_NULL);
6338  04da c604          	ldab	#4
6340  04dc 2006          	bra	L05
6341  04de               L5763:
6342                     ; 893     if (p_q_data == (OS_Q_DATA *)0) {                  /* Validate 'p_q_data'                          */
6344  04de ec8a          	ldd	OFST+4,s
6345  04e0 2605          	bne	L7763
6346                     ; 894         return (OS_ERR_PDATA_NULL);
6348  04e2 c609          	ldab	#9
6350  04e4               L05:
6352  04e4 1b88          	leas	8,s
6353  04e6 3d            	rts	
6354  04e7               L7763:
6355                     ; 897     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {      /* Validate event block type                    */
6357  04e7 e6f30006      	ldab	[OFST+0,s]
6358  04eb c102          	cmpb	#2
6359  04ed 2704          	beq	L1073
6360                     ; 898         return (OS_ERR_EVENT_TYPE);
6362  04ef c601          	ldab	#1
6364  04f1 20f1          	bra	L05
6365  04f3               L1073:
6366                     ; 900     OS_ENTER_CRITICAL();
6368  04f3 160000        	jsr	_OS_CPU_SR_Save
6370  04f6 6b85          	stab	OFST-1,s
6371                     ; 901     p_q_data->OSEventGrp = pevent->OSEventGrp;         /* Copy message queue wait list                 */
6373  04f8 ed8a          	ldy	OFST+4,s
6374  04fa ee86          	ldx	OFST+0,s
6375  04fc 180a054e      	movb	5,x,14,y
6376                     ; 902     psrc                 = &pevent->OSEventTbl[0];
6378  0500 ed86          	ldy	OFST+0,s
6379  0502 1946          	leay	6,y
6380  0504 6d83          	sty	OFST-3,s
6381                     ; 903     pdest                = &p_q_data->OSEventTbl[0];
6383  0506 ed8a          	ldy	OFST+4,s
6384  0508 1946          	leay	6,y
6385  050a 6d80          	sty	OFST-6,s
6386                     ; 904     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
6388  050c 6982          	clr	OFST-4,s
6389  050e ee83          	ldx	OFST-3,s
6390  0510               L3073:
6391                     ; 905         *pdest++ = *psrc++;
6393  0510 180a3070      	movb	1,x+,1,y+
6394                     ; 904     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
6396  0514 6282          	inc	OFST-4,s
6399  0516 e682          	ldab	OFST-4,s
6400  0518 c108          	cmpb	#8
6401  051a 25f4          	blo	L3073
6402  051c 6e83          	stx	OFST-3,s
6403                     ; 907     pq = (OS_Q *)pevent->OSEventPtr;
6405  051e ed86          	ldy	OFST+0,s
6406  0520 ed41          	ldy	1,y
6407  0522 6d80          	sty	OFST-6,s
6408                     ; 908     if (pq->OSQEntries > 0u) {
6410  0524 ec4c          	ldd	12,y
6411  0526 2704          	beq	L1173
6412                     ; 909         p_q_data->OSMsg = *pq->OSQOut;                 /* Get next message to return if available      */
6414  0528 eceb0008      	ldd	[8,y]
6416  052c               L1173:
6417                     ; 911         p_q_data->OSMsg = (void *)0;
6419  052c ed8a          	ldy	OFST+4,s
6420  052e 6c40          	std	0,y
6421                     ; 913     p_q_data->OSNMsgs = pq->OSQEntries;
6423  0530 ee80          	ldx	OFST-6,s
6424  0532 18020c42      	movw	12,x,2,y
6425                     ; 914     p_q_data->OSQSize = pq->OSQSize;
6427  0536 18020a44      	movw	10,x,4,y
6428                     ; 915     OS_EXIT_CRITICAL();
6430  053a e685          	ldab	OFST-1,s
6431  053c 87            	clra	
6432  053d 160000        	jsr	_OS_CPU_SR_Restore
6434                     ; 916     return (OS_ERR_NONE);
6436  0540 c7            	clrb	
6438  0541 20a1          	bra	L05
6503                     ; 936 _NEAR void  OS_QInit (void)
6503                     ; 937 {
6504                     	switch	.text
6505  0543               _OS_QInit:
6507  0543 1b9a          	leas	-6,s
6508       00000006      OFST:	set	6
6511                     ; 951     OS_MemClr((INT8U *)&OSQTbl[0], sizeof(OSQTbl));  /* Clear the queue table                          */
6513  0545 cc0038        	ldd	#56
6514  0548 3b            	pshd	
6515  0549 cc0000        	ldd	#_OSQTbl
6516  054c 160000        	jsr	_OS_MemClr
6518  054f 1b82          	leas	2,s
6519                     ; 952     for (ix = 0u; ix < (OS_MAX_QS - 1u); ix++) {     /* Init. list of free QUEUE control blocks        */
6521  0551 87            	clra	
6522  0552 c7            	clrb	
6523  0553 b746          	tfr	d,y
6524  0555 6d80          	sty	OFST-6,s
6525  0557               L7473:
6526                     ; 953         ix_next = ix + 1u;
6528  0557 02            	iny	
6529  0558 6d82          	sty	OFST-4,s
6530                     ; 954         pq1 = &OSQTbl[ix];
6532  055a cd000e        	ldy	#14
6533  055d 13            	emul	
6534  055e c30000        	addd	#_OSQTbl
6535  0561 6c84          	std	OFST-2,s
6536                     ; 955         pq2 = &OSQTbl[ix_next];
6538  0563 ec82          	ldd	OFST-4,s
6539  0565 cd000e        	ldy	#14
6540  0568 13            	emul	
6541  0569 c30000        	addd	#_OSQTbl
6542  056c 6c82          	std	OFST-4,s
6543                     ; 956         pq1->OSQPtr = pq2;
6545  056e 6cf30004      	std	[OFST-2,s]
6546                     ; 952     for (ix = 0u; ix < (OS_MAX_QS - 1u); ix++) {     /* Init. list of free QUEUE control blocks        */
6548  0572 ed80          	ldy	OFST-6,s
6549  0574 02            	iny	
6552  0575 b764          	tfr	y,d
6553  0577 6c80          	std	OFST-6,s
6554  0579 8c0003        	cpd	#3
6555  057c 25d9          	blo	L7473
6556                     ; 958     pq1         = &OSQTbl[ix];
6558  057e cd000e        	ldy	#14
6559  0581 13            	emul	
6560  0582 c30000        	addd	#_OSQTbl
6561  0585 6c84          	std	OFST-2,s
6562                     ; 959     pq1->OSQPtr = (OS_Q *)0;
6564  0587 87            	clra	
6565  0588 c7            	clrb	
6566  0589 6cf30004      	std	[OFST-2,s]
6567                     ; 960     OSQFreeList = &OSQTbl[0];
6569  058d cc0000        	ldd	#_OSQTbl
6570  0590 7c0000        	std	_OSQFreeList
6571                     ; 962 }
6574  0593 1b86          	leas	6,s
6575  0595 3d            	rts	
6587                     	xref	_OS_Sched
6588                     	xdef	_OS_QInit
6589                     	xref	_OS_MemClr
6590                     	xref	_OS_EventWaitListInit
6591                     	xref	_OS_EventTaskRemove
6592                     	xref	_OS_EventTaskWait
6593                     	xref	_OS_EventTaskRdy
6594                     	xdef	_OSQQuery
6595                     	xdef	_OSQPostOpt
6596                     	xdef	_OSQPostFront
6597                     	xdef	_OSQPost
6598                     	xdef	_OSQPendAbort
6599                     	xdef	_OSQPend
6600                     	xdef	_OSQFlush
6601                     	xdef	_OSQDel
6602                     	xdef	_OSQCreate
6603                     	xdef	_OSQAccept
6604                     	xref	_OSQTbl
6605                     	xref	_OSQFreeList
6606                     	xref	_OSTCBCur
6607                     	xref	_OSLockNesting
6608                     	xref	_OSIntNesting
6609                     	xref	_OSEventFreeList
6610                     	xref	_OS_CPU_SR_Restore
6611                     	xref	_OS_CPU_SR_Save
6612                     .const:	section	.data
6613  0000               L7503:
6614  0000 3f00          	dc.b	"?",0
6635                     	end

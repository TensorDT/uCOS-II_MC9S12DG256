   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4101                     ; 56 _NEAR void  *OSMboxAccept (OS_EVENT *pevent)
4101                     ; 57 {
4102                     	switch	.text
4103  0000               _OSMboxAccept:
4105  0000 3b            	pshd	
4106  0001 1b9d          	leas	-3,s
4107       00000003      OFST:	set	3
4110                     ; 60     OS_CPU_SR  cpu_sr = 0u;
4112                     ; 66     if (pevent == (OS_EVENT *)0) {                        /* Validate 'pevent'                         */
4114  0003 046402        	tbne	d,L5272
4115                     ; 67         return ((void *)0);
4118  0006 2007          	bra	LC001
4119  0008               L5272:
4120                     ; 70     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {      /* Validate event block type                 */
4122  0008 e6f30003      	ldab	[OFST+0,s]
4123  000c 040105        	dbeq	b,L7272
4124                     ; 71         return ((void *)0);
4126  000f               LC001:
4127  000f 87            	clra	
4128  0010 c7            	clrb	
4130  0011               L6:
4132  0011 1b85          	leas	5,s
4133  0013 3d            	rts	
4134  0014               L7272:
4135                     ; 73     OS_ENTER_CRITICAL();
4137  0014 160000        	jsr	_OS_CPU_SR_Save
4139  0017 6b80          	stab	OFST-3,s
4140                     ; 74     pmsg               = pevent->OSEventPtr;
4142  0019 ed83          	ldy	OFST+0,s
4143  001b 18024181      	movw	1,y,OFST-2,s
4144                     ; 75     pevent->OSEventPtr = (void *)0;                       /* Clear the mailbox                         */
4146  001f 87            	clra	
4147  0020 c7            	clrb	
4148  0021 6c41          	std	1,y
4149                     ; 76     OS_EXIT_CRITICAL();
4151  0023 e680          	ldab	OFST-3,s
4152  0025 160000        	jsr	_OS_CPU_SR_Restore
4154                     ; 77     return (pmsg);                                        /* Return the message received (or NULL)     */
4156  0028 ec81          	ldd	OFST-2,s
4158  002a 20e5          	bra	L6
4219                     ; 98 _NEAR OS_EVENT  *OSMboxCreate (void *pmsg)
4219                     ; 99 {
4220                     	switch	.text
4221  002c               _OSMboxCreate:
4223  002c 3b            	pshd	
4224  002d 1b9d          	leas	-3,s
4225       00000003      OFST:	set	3
4228                     ; 102     OS_CPU_SR  cpu_sr = 0u;
4230                     ; 114     if (OSIntNesting > 0u) {                     /* See if called from ISR ...                         */
4232  002f f60000        	ldab	_OSIntNesting
4233  0032 2704          	beq	L1672
4234                     ; 115         return ((OS_EVENT *)0);                  /* ... can't CREATE from an ISR                       */
4236  0034 87            	clra	
4237  0035 c7            	clrb	
4239  0036 2031          	bra	L21
4240  0038               L1672:
4241                     ; 117     OS_ENTER_CRITICAL();
4243  0038 160000        	jsr	_OS_CPU_SR_Save
4245  003b 6b82          	stab	OFST-1,s
4246                     ; 118     pevent = OSEventFreeList;                    /* Get next free event control block                  */
4248  003d fd0000        	ldy	_OSEventFreeList
4249  0040 6d80          	sty	OFST-3,s
4250                     ; 119     if (OSEventFreeList != (OS_EVENT *)0) {      /* See if pool of free ECB pool was empty             */
4252  0042 2705          	beq	L3672
4253                     ; 120         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
4255  0044 1805410000    	movw	1,y,_OSEventFreeList
4256  0049               L3672:
4257                     ; 122     OS_EXIT_CRITICAL();
4259  0049 87            	clra	
4260  004a 160000        	jsr	_OS_CPU_SR_Restore
4262                     ; 123     if (pevent != (OS_EVENT *)0) {
4264  004d ed80          	ldy	OFST-3,s
4265  004f 2716          	beq	L5672
4266                     ; 124         pevent->OSEventType    = OS_EVENT_TYPE_MBOX;
4268  0051 c601          	ldab	#1
4269  0053 6b40          	stab	0,y
4270                     ; 125         pevent->OSEventCnt     = 0u;
4272  0055 87            	clra	
4273  0056 c7            	clrb	
4274  0057 6c43          	std	3,y
4275                     ; 126         pevent->OSEventPtr     = pmsg;           /* Deposit message in event control block             */
4277  0059 18028341      	movw	OFST+0,s,1,y
4278                     ; 128         pevent->OSEventName    = (INT8U *)(void *)"?";
4280  005d cc0000        	ldd	#L7672
4281  0060 6c4e          	std	14,y
4282                     ; 130         OS_EventWaitListInit(pevent);
4284  0062 b764          	tfr	y,d
4285  0064 160000        	jsr	_OS_EventWaitListInit
4288  0067               L5672:
4289                     ; 134     return (pevent);                             /* Return pointer to event control block              */
4291  0067 ec80          	ldd	OFST-3,s
4293  0069               L21:
4295  0069 1b85          	leas	5,s
4296  006b 3d            	rts	
4384                     ; 179 _NEAR OS_EVENT  *OSMboxDel (OS_EVENT  *pevent,
4384                     ; 180                            INT8U      opt,
4384                     ; 181                            INT8U     *perr)
4384                     ; 182 {
4385                     	switch	.text
4386  006c               _OSMboxDel:
4388  006c 3b            	pshd	
4389  006d 1b9c          	leas	-4,s
4390       00000004      OFST:	set	4
4393                     ; 186     OS_CPU_SR  cpu_sr = 0u;
4395                     ; 207     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
4397  006f 046404        	tbne	d,L1403
4398                     ; 208         *perr = OS_ERR_PEVENT_NULL;
4400  0072 c604          	ldab	#4
4401                     ; 209         return (pevent);
4404  0074 2009          	bra	L61
4405  0076               L1403:
4406                     ; 215     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
4409  0076 e6f30004      	ldab	[OFST+0,s]
4410  007a 04010b        	dbeq	b,L3403
4411                     ; 216         *perr = OS_ERR_EVENT_TYPE;
4413  007d c601          	ldab	#1
4414                     ; 218         return (pevent);
4418  007f               L61:
4419  007f 6bf3000a      	stab	[OFST+6,s]
4420  0083 ec84          	ldd	OFST+0,s
4422  0085 1b86          	leas	6,s
4423  0087 3d            	rts	
4424  0088               L3403:
4425                     ; 220     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4427  0088 f60000        	ldab	_OSIntNesting
4428  008b 2704          	beq	L5403
4429                     ; 221         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
4431  008d c60f          	ldab	#15
4432                     ; 223         return (pevent);
4436  008f 20ee          	bra	L61
4437  0091               L5403:
4438                     ; 225     OS_ENTER_CRITICAL();
4440  0091 160000        	jsr	_OS_CPU_SR_Save
4442  0094 6b80          	stab	OFST-4,s
4443                     ; 226     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on mailbox      */
4445  0096 ed84          	ldy	OFST+0,s
4446  0098 e645          	ldab	5,y
4447  009a 2706          	beq	L7403
4448                     ; 227         tasks_waiting = OS_TRUE;                           /* Yes                                      */
4450  009c c601          	ldab	#1
4451  009e 6b83          	stab	OFST-1,s
4453  00a0 2002          	bra	L1503
4454  00a2               L7403:
4455                     ; 229         tasks_waiting = OS_FALSE;                          /* No                                       */
4457  00a2 6983          	clr	OFST-1,s
4458  00a4               L1503:
4459                     ; 231     switch (opt) {
4461  00a4 e689          	ldab	OFST+5,s
4463  00a6 270d          	beq	L1772
4464  00a8 040152        	dbeq	b,L5603
4465                     ; 270         default:
4465                     ; 271              OS_EXIT_CRITICAL();
4467  00ab e680          	ldab	OFST-4,s
4468  00ad 87            	clra	
4469  00ae 160000        	jsr	_OS_CPU_SR_Restore
4471                     ; 272              *perr         = OS_ERR_INVALID_OPT;
4473  00b1 c607          	ldab	#7
4474                     ; 273              pevent_return = pevent;
4476                     ; 274              break;
4478  00b3 202e          	bra	LC003
4479  00b5               L1772:
4480                     ; 232         case OS_DEL_NO_PEND:                               /* Delete mailbox only if no task waiting   */
4480                     ; 233              if (tasks_waiting == OS_FALSE) {
4482  00b5 e683          	ldab	OFST-1,s
4483  00b7 2622          	bne	L7503
4484                     ; 235                  pevent->OSEventName = (INT8U *)(void *)"?";
4486  00b9 cc0000        	ldd	#L7672
4487  00bc 6c4e          	std	14,y
4488                     ; 237                  pevent->OSEventType = OS_EVENT_TYPE_UNUSED;
4490  00be 87            	clra	
4491  00bf 6a40          	staa	0,y
4492                     ; 238                  pevent->OSEventPtr  = OSEventFreeList;    /* Return Event Control Block to free list  */
4494  00c1 1801410000    	movw	_OSEventFreeList,1,y
4495                     ; 239                  pevent->OSEventCnt  = 0u;
4497  00c6 c7            	clrb	
4498  00c7 6c43          	std	3,y
4499                     ; 240                  OSEventFreeList     = pevent;             /* Get next free event control block        */
4501  00c9 1805840000    	movw	OFST+0,s,_OSEventFreeList
4502                     ; 241                  OS_EXIT_CRITICAL();
4504  00ce e680          	ldab	OFST-4,s
4505  00d0 160000        	jsr	_OS_CPU_SR_Restore
4507                     ; 242                  *perr               = OS_ERR_NONE;
4509  00d3 87            	clra	
4510  00d4 6af3000a      	staa	[OFST+6,s]
4511                     ; 243                  pevent_return       = (OS_EVENT *)0;      /* Mailbox has been deleted                 */
4513  00d8 c7            	clrb	
4515  00d9 200e          	bra	LC002
4516  00db               L7503:
4517                     ; 245                  OS_EXIT_CRITICAL();
4519  00db e680          	ldab	OFST-4,s
4520  00dd 87            	clra	
4521  00de 160000        	jsr	_OS_CPU_SR_Restore
4523                     ; 246                  *perr               = OS_ERR_TASK_WAITING;
4525  00e1 c649          	ldab	#73
4526                     ; 247                  pevent_return       = pevent;
4528  00e3               LC003:
4529  00e3 6bf3000a      	stab	[OFST+6,s]
4530  00e7 ec84          	ldd	OFST+0,s
4531  00e9               LC002:
4532  00e9 6c81          	std	OFST-3,s
4533  00eb 203c          	bra	L5503
4534  00ed               L3603:
4535                     ; 253                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
4537  00ed cc0002        	ldd	#2
4538  00f0 3b            	pshd	
4539  00f1 3b            	pshd	
4540  00f2 c7            	clrb	
4541  00f3 3b            	pshd	
4542  00f4 ec8a          	ldd	OFST+6,s
4543  00f6 160000        	jsr	_OS_EventTaskRdy
4545  00f9 1b86          	leas	6,s
4546  00fb ed84          	ldy	OFST+0,s
4547  00fd               L5603:
4548                     ; 251         case OS_DEL_ALWAYS:                                /* Always delete the mailbox                */
4548                     ; 252              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for mailbox      */
4550  00fd e645          	ldab	5,y
4551  00ff 26ec          	bne	L3603
4552                     ; 256              pevent->OSEventName    = (INT8U *)(void *)"?";
4554  0101 cc0000        	ldd	#L7672
4555  0104 6c4e          	std	14,y
4556                     ; 258              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
4558  0106 87            	clra	
4559  0107 6a40          	staa	0,y
4560                     ; 259              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
4562  0109 1801410000    	movw	_OSEventFreeList,1,y
4563                     ; 260              pevent->OSEventCnt     = 0u;
4565  010e c7            	clrb	
4566  010f 6c43          	std	3,y
4567                     ; 261              OSEventFreeList        = pevent;              /* Get next free event control block        */
4569  0111 1805840000    	movw	OFST+0,s,_OSEventFreeList
4570                     ; 262              OS_EXIT_CRITICAL();
4572  0116 e680          	ldab	OFST-4,s
4573  0118 160000        	jsr	_OS_CPU_SR_Restore
4575                     ; 263              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
4577  011b e683          	ldab	OFST-1,s
4578  011d 042103        	dbne	b,L1703
4579                     ; 264                  OS_Sched();                               /* Find highest priority task ready to run  */
4581  0120 160000        	jsr	_OS_Sched
4583  0123               L1703:
4584                     ; 266              *perr         = OS_ERR_NONE;
4586  0123 87            	clra	
4587  0124 6af3000a      	staa	[OFST+6,s]
4588                     ; 267              pevent_return = (OS_EVENT *)0;                /* Mailbox has been deleted                 */
4590  0128 c7            	clrb	
4591                     ; 268              break;
4593  0129               L5503:
4594                     ; 279     return (pevent_return);
4599  0129 1b86          	leas	6,s
4600  012b 3d            	rts	
4679                     ; 317 _NEAR void  *OSMboxPend (OS_EVENT  *pevent,
4679                     ; 318                         INT32U     timeout,
4679                     ; 319                         INT8U     *perr)
4679                     ; 320 {
4680                     	switch	.text
4681  012c               _OSMboxPend:
4683  012c 3b            	pshd	
4684  012d 1b9d          	leas	-3,s
4685       00000003      OFST:	set	3
4688                     ; 323     OS_CPU_SR  cpu_sr = 0u;
4690                     ; 335     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
4692  012f 046404        	tbne	d,L5313
4693                     ; 336         *perr = OS_ERR_PEVENT_NULL;
4695  0132 c604          	ldab	#4
4696                     ; 337         return ((void *)0);
4699  0134 2009          	bra	LC004
4700  0136               L5313:
4701                     ; 343     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
4704  0136 e6f30003      	ldab	[OFST+0,s]
4705  013a 04010b        	dbeq	b,L7313
4706                     ; 344         *perr = OS_ERR_EVENT_TYPE;
4708  013d c601          	ldab	#1
4709                     ; 346         return ((void *)0);
4712  013f               LC004:
4713  013f 6bf3000b      	stab	[OFST+8,s]
4714  0143 87            	clra	
4715  0144 c7            	clrb	
4717  0145               L22:
4719  0145 1b85          	leas	5,s
4720  0147 3d            	rts	
4721  0148               L7313:
4722                     ; 348     if (OSIntNesting > 0u) {                          /* See if called from ISR ...                    */
4724  0148 f60000        	ldab	_OSIntNesting
4725  014b 2704          	beq	L1413
4726                     ; 349         *perr = OS_ERR_PEND_ISR;                      /* ... can't PEND from an ISR                    */
4728  014d c602          	ldab	#2
4729                     ; 351         return ((void *)0);
4733  014f 20ee          	bra	LC004
4734  0151               L1413:
4735                     ; 353     if (OSLockNesting > 0u) {                         /* See if called with scheduler locked ...       */
4737  0151 f60000        	ldab	_OSLockNesting
4738  0154 2704          	beq	L3413
4739                     ; 354         *perr = OS_ERR_PEND_LOCKED;                   /* ... can't PEND when locked                    */
4741  0156 c60d          	ldab	#13
4742                     ; 356         return ((void *)0);
4746  0158 20e5          	bra	LC004
4747  015a               L3413:
4748                     ; 358     OS_ENTER_CRITICAL();
4750  015a 160000        	jsr	_OS_CPU_SR_Save
4752  015d 6b82          	stab	OFST-1,s
4753                     ; 359     pmsg = pevent->OSEventPtr;
4755  015f ed83          	ldy	OFST+0,s
4756  0161 ec41          	ldd	1,y
4757  0163 6c80          	std	OFST-3,s
4758                     ; 360     if (pmsg != (void *)0) {                          /* See if there is already a message             */
4760  0165 2711          	beq	L5413
4761                     ; 361         pevent->OSEventPtr = (void *)0;               /* Clear the mailbox                             */
4763  0167 87            	clra	
4764  0168 c7            	clrb	
4765  0169 6c41          	std	1,y
4766                     ; 362         OS_EXIT_CRITICAL();
4768  016b e682          	ldab	OFST-1,s
4769  016d 160000        	jsr	_OS_CPU_SR_Restore
4771                     ; 363         *perr = OS_ERR_NONE;
4773  0170 69f3000b      	clr	[OFST+8,s]
4774                     ; 365         return (pmsg);                                /* Return the message received (or NULL)         */
4777  0174 ec80          	ldd	OFST-3,s
4779  0176 20cd          	bra	L22
4780  0178               L5413:
4781                     ; 367     OSTCBCur->OSTCBStat     |= OS_STAT_MBOX;          /* Message not available, task will pend         */
4783  0178 fd0000        	ldy	_OSTCBCur
4784  017b 0ce82202      	bset	34,y,2
4785                     ; 368     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
4787  017f 69e823        	clr	35,y
4788                     ; 369     OSTCBCur->OSTCBDly       = timeout;               /* Load timeout in TCB                           */
4790  0182 ec89          	ldd	OFST+6,s
4791  0184 6ce820        	std	32,y
4792  0187 ec87          	ldd	OFST+4,s
4793  0189 6ce81e        	std	30,y
4794                     ; 370     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
4796  018c ec83          	ldd	OFST+0,s
4797  018e 160000        	jsr	_OS_EventTaskWait
4799                     ; 371     OS_EXIT_CRITICAL();
4801  0191 e682          	ldab	OFST-1,s
4802  0193 87            	clra	
4803  0194 160000        	jsr	_OS_CPU_SR_Restore
4805                     ; 372     OS_Sched();                                       /* Find next highest priority task ready to run  */
4807  0197 160000        	jsr	_OS_Sched
4809                     ; 373     OS_ENTER_CRITICAL();
4811  019a 160000        	jsr	_OS_CPU_SR_Save
4813  019d 6b82          	stab	OFST-1,s
4814                     ; 374     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
4816  019f fd0000        	ldy	_OSTCBCur
4817  01a2 e6e823        	ldab	35,y
4819  01a5 2708          	beq	L3703
4820  01a7 040117        	dbeq	b,L7703
4821  01aa 04010d        	dbeq	b,L5703
4822  01ad 2012          	bra	L7703
4823  01af               L3703:
4824                     ; 375         case OS_STAT_PEND_OK:
4824                     ; 376              pmsg =  OSTCBCur->OSTCBMsg;
4826  01af ece818        	ldd	24,y
4827  01b2 6c80          	std	OFST-3,s
4828                     ; 377             *perr =  OS_ERR_NONE;
4830  01b4 69f3000b      	clr	[OFST+8,s]
4831                     ; 378              break;
4833  01b8 201e          	bra	L1513
4834  01ba               L5703:
4835                     ; 380         case OS_STAT_PEND_ABORT:
4835                     ; 381              pmsg = (void *)0;
4837  01ba 87            	clra	
4838  01bb 6c80          	std	OFST-3,s
4839                     ; 382             *perr =  OS_ERR_PEND_ABORT;               /* Indicate that we aborted                      */
4841  01bd c60e          	ldab	#14
4842                     ; 383              break;
4844  01bf 2010          	bra	LC005
4845  01c1               L7703:
4846                     ; 385         case OS_STAT_PEND_TO:
4846                     ; 386         default:
4846                     ; 387              OS_EventTaskRemove(OSTCBCur, pevent);
4848  01c1 ec83          	ldd	OFST+0,s
4849  01c3 3b            	pshd	
4850  01c4 b764          	tfr	y,d
4851  01c6 160000        	jsr	_OS_EventTaskRemove
4853  01c9 1b82          	leas	2,s
4854                     ; 388              pmsg = (void *)0;
4856  01cb 87            	clra	
4857  01cc c7            	clrb	
4858  01cd 6c80          	std	OFST-3,s
4859                     ; 389             *perr =  OS_ERR_TIMEOUT;                  /* Indicate that we didn't get event within TO   */
4861  01cf c60a          	ldab	#10
4862  01d1               LC005:
4863  01d1 6bf3000b      	stab	[OFST+8,s]
4864                     ; 390              break;
4866  01d5 fd0000        	ldy	_OSTCBCur
4867  01d8               L1513:
4868                     ; 392     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
4870  01d8 c7            	clrb	
4871  01d9 6be822        	stab	34,y
4872                     ; 393     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
4874  01dc 87            	clra	
4875  01dd 6ae823        	staa	35,y
4876                     ; 394     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
4878  01e0 6ce812        	std	18,y
4879                     ; 396     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
4881  01e3 6ce814        	std	20,y
4882                     ; 397     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
4884  01e6 6ce816        	std	22,y
4885                     ; 399     OSTCBCur->OSTCBMsg           = (void      *)0;    /* Clear  received message                       */
4887  01e9 6ce818        	std	24,y
4888                     ; 400     OS_EXIT_CRITICAL();
4890  01ec e682          	ldab	OFST-1,s
4891  01ee 160000        	jsr	_OS_CPU_SR_Restore
4893                     ; 403     return (pmsg);                                    /* Return received message                       */
4896  01f1 ec80          	ldd	OFST-3,s
4899  01f3 1b85          	leas	5,s
4900  01f5 3d            	rts	
4971                     ; 440 _NEAR INT8U  OSMboxPendAbort (OS_EVENT  *pevent,
4971                     ; 441                              INT8U      opt,
4971                     ; 442                              INT8U     *perr)
4971                     ; 443 {
4972                     	switch	.text
4973  01f6               _OSMboxPendAbort:
4975  01f6 3b            	pshd	
4976       00000002      OFST:	set	2
4979                     ; 446     OS_CPU_SR  cpu_sr = 0u;
4981                     ; 459     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
4983  01f7 6cae          	std	2,-s
4984  01f9 2604          	bne	L1123
4985                     ; 460         *perr = OS_ERR_PEVENT_NULL;
4987  01fb c604          	ldab	#4
4988                     ; 461         return (0u);
4991  01fd 2009          	bra	LC006
4992  01ff               L1123:
4993                     ; 464     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
4995  01ff e6f30002      	ldab	[OFST+0,s]
4996  0203 04010a        	dbeq	b,L3123
4997                     ; 465         *perr = OS_ERR_EVENT_TYPE;
4999  0206 c601          	ldab	#1
5000                     ; 466         return (0u);
5002  0208               LC006:
5003  0208 6bf30008      	stab	[OFST+6,s]
5004  020c c7            	clrb	
5006  020d               L62:
5008  020d 1b84          	leas	4,s
5009  020f 3d            	rts	
5010  0210               L3123:
5011                     ; 468     OS_ENTER_CRITICAL();
5013  0210 160000        	jsr	_OS_CPU_SR_Save
5015  0213 6b81          	stab	OFST-1,s
5016                     ; 469     if (pevent->OSEventGrp != 0u) {                        /* See if any task waiting on mailbox?      */
5018  0215 ed82          	ldy	OFST+0,s
5019  0217 e745          	tst	5,y
5020  0219 2746          	beq	L5123
5021                     ; 470         nbr_tasks = 0u;
5023  021b 6980          	clr	OFST-2,s
5024                     ; 471         switch (opt) {
5026  021d e687          	ldab	OFST+5,s
5028  021f 271d          	beq	L5513
5029  0221 040114        	dbeq	b,L5223
5030  0224 2018          	bra	L5513
5031  0226               L3223:
5032                     ; 474                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
5034  0226 cc0002        	ldd	#2
5035  0229 3b            	pshd	
5036  022a 3b            	pshd	
5037  022b c7            	clrb	
5038  022c 3b            	pshd	
5039  022d ec88          	ldd	OFST+6,s
5040  022f 160000        	jsr	_OS_EventTaskRdy
5042  0232 1b86          	leas	6,s
5043                     ; 475                      nbr_tasks++;
5045  0234 6280          	inc	OFST-2,s
5046  0236 ed82          	ldy	OFST+0,s
5047  0238               L5223:
5048                     ; 472             case OS_PEND_OPT_BROADCAST:                    /* Do we need to abort ALL waiting tasks?   */
5048                     ; 473                  while (pevent->OSEventGrp != 0u) {        /* Yes, ready ALL tasks waiting on mailbox  */
5050  0238 e645          	ldab	5,y
5051  023a 26ea          	bne	L3223
5052                     ; 477                  break;
5054  023c 2010          	bra	L1223
5055  023e               L5513:
5056                     ; 479             case OS_PEND_OPT_NONE:
5056                     ; 480             default:                                       /* No,  ready HPT       waiting on mailbox  */
5056                     ; 481                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
5058  023e cc0002        	ldd	#2
5059  0241 3b            	pshd	
5060  0242 3b            	pshd	
5061  0243 c7            	clrb	
5062  0244 3b            	pshd	
5063  0245 b764          	tfr	y,d
5064  0247 160000        	jsr	_OS_EventTaskRdy
5066  024a 1b86          	leas	6,s
5067                     ; 482                  nbr_tasks++;
5069  024c 6280          	inc	OFST-2,s
5070                     ; 483                  break;
5072  024e               L1223:
5073                     ; 485         OS_EXIT_CRITICAL();
5075  024e e681          	ldab	OFST-1,s
5076  0250 87            	clra	
5077  0251 160000        	jsr	_OS_CPU_SR_Restore
5079                     ; 486         OS_Sched();                                        /* Find HPT ready to run                    */
5081  0254 160000        	jsr	_OS_Sched
5083                     ; 487         *perr = OS_ERR_PEND_ABORT;
5085  0257 c60e          	ldab	#14
5086  0259 6bf30008      	stab	[OFST+6,s]
5087                     ; 488         return (nbr_tasks);
5089  025d e680          	ldab	OFST-2,s
5091  025f 20ac          	bra	L62
5092  0261               L5123:
5093                     ; 490     OS_EXIT_CRITICAL();
5095  0261 87            	clra	
5096  0262 160000        	jsr	_OS_CPU_SR_Restore
5098                     ; 491     *perr = OS_ERR_NONE;
5100  0265 c7            	clrb	
5101  0266 6bf30008      	stab	[OFST+6,s]
5102                     ; 492     return (0u);                                           /* No tasks waiting on mailbox              */
5105  026a 20a1          	bra	L62
5162                     ; 520 _NEAR INT8U  OSMboxPost (OS_EVENT  *pevent,
5162                     ; 521                         void      *pmsg)
5162                     ; 522 {
5163                     	switch	.text
5164  026c               _OSMboxPost:
5166  026c 3b            	pshd	
5167  026d 37            	pshb	
5168       00000001      OFST:	set	1
5171                     ; 524     OS_CPU_SR  cpu_sr = 0u;
5173                     ; 530     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
5175  026e 046404        	tbne	d,L7523
5176                     ; 531         return (OS_ERR_PEVENT_NULL);
5178  0271 c604          	ldab	#4
5180  0273 2006          	bra	L23
5181  0275               L7523:
5182                     ; 533     if (pmsg == (void *)0) {                          /* Make sure we are not posting a NULL pointer   */
5184  0275 ec85          	ldd	OFST+4,s
5185  0277 2605          	bne	L1623
5186                     ; 534         return (OS_ERR_POST_NULL_PTR);
5188  0279 c603          	ldab	#3
5190  027b               L23:
5192  027b 1b83          	leas	3,s
5193  027d 3d            	rts	
5194  027e               L1623:
5195                     ; 540     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
5198  027e e6f30001      	ldab	[OFST+0,s]
5199  0282 040104        	dbeq	b,L3623
5200                     ; 542         return (OS_ERR_EVENT_TYPE);
5203  0285 c601          	ldab	#1
5205  0287 20f2          	bra	L23
5206  0289               L3623:
5207                     ; 544     OS_ENTER_CRITICAL();
5209  0289 160000        	jsr	_OS_CPU_SR_Save
5211  028c 6b80          	stab	OFST-1,s
5212                     ; 545     if (pevent->OSEventGrp != 0u) {                   /* See if any task pending on mailbox            */
5214  028e ed81          	ldy	OFST+0,s
5215  0290 e645          	ldab	5,y
5216  0292 271b          	beq	L5623
5217                     ; 547         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
5219  0294 87            	clra	
5220  0295 c7            	clrb	
5221  0296 3b            	pshd	
5222  0297 c602          	ldab	#2
5223  0299 3b            	pshd	
5224  029a ec89          	ldd	OFST+8,s
5225  029c 3b            	pshd	
5226  029d b764          	tfr	y,d
5227  029f 160000        	jsr	_OS_EventTaskRdy
5229  02a2 1b86          	leas	6,s
5230                     ; 548         OS_EXIT_CRITICAL();
5232  02a4 e680          	ldab	OFST-1,s
5233  02a6 87            	clra	
5234  02a7 160000        	jsr	_OS_CPU_SR_Restore
5236                     ; 549         OS_Sched();                                   /* Find highest priority task ready to run       */
5238  02aa 160000        	jsr	_OS_Sched
5240                     ; 551         return (OS_ERR_NONE);
5244  02ad 2017          	bra	LC007
5245  02af               L5623:
5246                     ; 553     if (pevent->OSEventPtr != (void *)0) {            /* Make sure mailbox doesn't already have a msg  */
5248  02af ec41          	ldd	1,y
5249  02b1 270a          	beq	L7623
5250                     ; 554         OS_EXIT_CRITICAL();
5252  02b3 e680          	ldab	OFST-1,s
5253  02b5 87            	clra	
5254  02b6 160000        	jsr	_OS_CPU_SR_Restore
5256                     ; 556         return (OS_ERR_MBOX_FULL);
5259  02b9 c614          	ldab	#20
5261  02bb 20be          	bra	L23
5262  02bd               L7623:
5263                     ; 558     pevent->OSEventPtr = pmsg;                        /* Place message in mailbox                      */
5265  02bd 18028541      	movw	OFST+4,s,1,y
5266                     ; 559     OS_EXIT_CRITICAL();
5268  02c1 e680          	ldab	OFST-1,s
5269  02c3 160000        	jsr	_OS_CPU_SR_Restore
5271                     ; 561     return (OS_ERR_NONE);
5274  02c6               LC007:
5275  02c6 c7            	clrb	
5277  02c7 20b2          	bra	L23
5341                     ; 599 _NEAR INT8U  OSMboxPostOpt (OS_EVENT  *pevent,
5341                     ; 600                            void      *pmsg,
5341                     ; 601                            INT8U      opt)
5341                     ; 602 {
5342                     	switch	.text
5343  02c9               _OSMboxPostOpt:
5345  02c9 3b            	pshd	
5346  02ca 37            	pshb	
5347       00000001      OFST:	set	1
5350                     ; 604     OS_CPU_SR  cpu_sr = 0u;
5352                     ; 610     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
5354  02cb 046404        	tbne	d,L1233
5355                     ; 611         return (OS_ERR_PEVENT_NULL);
5357  02ce c604          	ldab	#4
5359  02d0 2006          	bra	L63
5360  02d2               L1233:
5361                     ; 613     if (pmsg == (void *)0) {                          /* Make sure we are not posting a NULL pointer   */
5363  02d2 ec85          	ldd	OFST+4,s
5364  02d4 2605          	bne	L3233
5365                     ; 614         return (OS_ERR_POST_NULL_PTR);
5367  02d6 c603          	ldab	#3
5369  02d8               L63:
5371  02d8 1b83          	leas	3,s
5372  02da 3d            	rts	
5373  02db               L3233:
5374                     ; 620     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
5377  02db e6f30001      	ldab	[OFST+0,s]
5378  02df 040104        	dbeq	b,L5233
5379                     ; 622         return (OS_ERR_EVENT_TYPE);
5382  02e2 c601          	ldab	#1
5384  02e4 20f2          	bra	L63
5385  02e6               L5233:
5386                     ; 624     OS_ENTER_CRITICAL();
5388  02e6 160000        	jsr	_OS_CPU_SR_Save
5390  02e9 6b80          	stab	OFST-1,s
5391                     ; 625     if (pevent->OSEventGrp != 0u) {                   /* See if any task pending on mailbox            */
5393  02eb ed81          	ldy	OFST+0,s
5394  02ed e645          	ldab	5,y
5395  02ef 273e          	beq	L7233
5396                     ; 626         if ((opt & OS_POST_OPT_BROADCAST) != 0x00u) { /* Do we need to post msg to ALL waiting tasks ? */
5398  02f1 0f88011a      	brclr	OFST+7,s,1,L1333
5400  02f5 2014          	bra	L5333
5401  02f7               L3333:
5402                     ; 628                 (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
5404  02f7 87            	clra	
5405  02f8 c7            	clrb	
5406  02f9 3b            	pshd	
5407  02fa c602          	ldab	#2
5408  02fc 3b            	pshd	
5409  02fd ec89          	ldd	OFST+8,s
5410  02ff 3b            	pshd	
5411  0300 ec87          	ldd	OFST+6,s
5412  0302 160000        	jsr	_OS_EventTaskRdy
5414  0305 1b86          	leas	6,s
5415  0307 ed81          	ldy	OFST+0,s
5416  0309 e645          	ldab	5,y
5417  030b               L5333:
5418                     ; 627             while (pevent->OSEventGrp != 0u) {        /* Yes, Post to ALL tasks waiting on mailbox     */
5420  030b 26ea          	bne	L3333
5422  030d 2010          	bra	L1433
5423  030f               L1333:
5424                     ; 631             (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
5426  030f 87            	clra	
5427  0310 c7            	clrb	
5428  0311 3b            	pshd	
5429  0312 c602          	ldab	#2
5430  0314 3b            	pshd	
5431  0315 ec89          	ldd	OFST+8,s
5432  0317 3b            	pshd	
5433  0318 b764          	tfr	y,d
5434  031a 160000        	jsr	_OS_EventTaskRdy
5436  031d 1b86          	leas	6,s
5437  031f               L1433:
5438                     ; 633         OS_EXIT_CRITICAL();
5440  031f e680          	ldab	OFST-1,s
5441  0321 87            	clra	
5442  0322 160000        	jsr	_OS_CPU_SR_Restore
5444                     ; 634         if ((opt & OS_POST_OPT_NO_SCHED) == 0u) {     /* See if scheduler needs to be invoked          */
5446  0325 0e880403      	brset	OFST+7,s,4,L3433
5447                     ; 635             OS_Sched();                               /* Find HPT ready to run                         */
5449  0329 160000        	jsr	_OS_Sched
5451  032c               L3433:
5452                     ; 638         return (OS_ERR_NONE);
5455  032c c7            	clrb	
5457  032d 20a9          	bra	L63
5458  032f               L7233:
5459                     ; 640     if (pevent->OSEventPtr != (void *)0) {            /* Make sure mailbox doesn't already have a msg  */
5461  032f ec41          	ldd	1,y
5462  0331 270a          	beq	L5433
5463                     ; 641         OS_EXIT_CRITICAL();
5465  0333 e680          	ldab	OFST-1,s
5466  0335 87            	clra	
5467  0336 160000        	jsr	_OS_CPU_SR_Restore
5469                     ; 643         return (OS_ERR_MBOX_FULL);
5472  0339 c614          	ldab	#20
5474  033b 200a          	bra	L04
5475  033d               L5433:
5476                     ; 645     pevent->OSEventPtr = pmsg;                        /* Place message in mailbox                      */
5478  033d 18028541      	movw	OFST+4,s,1,y
5479                     ; 646     OS_EXIT_CRITICAL();
5481  0341 e680          	ldab	OFST-1,s
5482  0343 160000        	jsr	_OS_CPU_SR_Restore
5484                     ; 648     return (OS_ERR_NONE);
5487  0346 c7            	clrb	
5489  0347               L04:
5491  0347 1b83          	leas	3,s
5492  0349 3d            	rts	
5610                     ; 672 _NEAR INT8U  OSMboxQuery (OS_EVENT      *pevent,
5610                     ; 673                          OS_MBOX_DATA  *p_mbox_data)
5610                     ; 674 {
5611                     	switch	.text
5612  034a               _OSMboxQuery:
5614  034a 3b            	pshd	
5615  034b 1b9a          	leas	-6,s
5616       00000006      OFST:	set	6
5619                     ; 679     OS_CPU_SR   cpu_sr = 0u;
5621                     ; 685     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
5623  034d 046404        	tbne	d,L7243
5624                     ; 686         return (OS_ERR_PEVENT_NULL);
5626  0350 c604          	ldab	#4
5628  0352 2006          	bra	L44
5629  0354               L7243:
5630                     ; 688     if (p_mbox_data == (OS_MBOX_DATA *)0) {                /* Validate 'p_mbox_data'                   */
5632  0354 ec8a          	ldd	OFST+4,s
5633  0356 2605          	bne	L1343
5634                     ; 689         return (OS_ERR_PDATA_NULL);
5636  0358 c609          	ldab	#9
5638  035a               L44:
5640  035a 1b88          	leas	8,s
5641  035c 3d            	rts	
5642  035d               L1343:
5643                     ; 692     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
5645  035d e6f30006      	ldab	[OFST+0,s]
5646  0361 040104        	dbeq	b,L3343
5647                     ; 693         return (OS_ERR_EVENT_TYPE);
5649  0364 c601          	ldab	#1
5651  0366 20f2          	bra	L44
5652  0368               L3343:
5653                     ; 695     OS_ENTER_CRITICAL();
5655  0368 160000        	jsr	_OS_CPU_SR_Save
5657  036b 6b85          	stab	OFST-1,s
5658                     ; 696     p_mbox_data->OSEventGrp = pevent->OSEventGrp;          /* Copy message mailbox wait list           */
5660  036d ed8a          	ldy	OFST+4,s
5661  036f ee86          	ldx	OFST+0,s
5662  0371 180a054a      	movb	5,x,10,y
5663                     ; 697     psrc                    = &pevent->OSEventTbl[0];
5665  0375 ed86          	ldy	OFST+0,s
5666  0377 1946          	leay	6,y
5667  0379 6d81          	sty	OFST-5,s
5668                     ; 698     pdest                   = &p_mbox_data->OSEventTbl[0];
5670  037b ed8a          	ldy	OFST+4,s
5671  037d 1942          	leay	2,y
5672  037f 6d83          	sty	OFST-3,s
5673                     ; 699     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
5675  0381 6980          	clr	OFST-6,s
5676  0383 ee81          	ldx	OFST-5,s
5677  0385               L5343:
5678                     ; 700         *pdest++ = *psrc++;
5680  0385 180a3070      	movb	1,x+,1,y+
5681                     ; 699     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
5683  0389 6280          	inc	OFST-6,s
5686  038b e680          	ldab	OFST-6,s
5687  038d c108          	cmpb	#8
5688  038f 25f4          	blo	L5343
5689  0391 6e81          	stx	OFST-5,s
5690  0393 6d83          	sty	OFST-3,s
5691                     ; 702     p_mbox_data->OSMsg = pevent->OSEventPtr;               /* Get message from mailbox                 */
5693  0395 ed86          	ldy	OFST+0,s
5694  0397 ec41          	ldd	1,y
5695  0399 6cf3000a      	std	[OFST+4,s]
5696                     ; 703     OS_EXIT_CRITICAL();
5698  039d e685          	ldab	OFST-1,s
5699  039f 87            	clra	
5700  03a0 160000        	jsr	_OS_CPU_SR_Restore
5702                     ; 704     return (OS_ERR_NONE);
5704  03a3 c7            	clrb	
5706  03a4 20b4          	bra	L44
5718                     	xref	_OS_Sched
5719                     	xref	_OS_EventWaitListInit
5720                     	xref	_OS_EventTaskRemove
5721                     	xref	_OS_EventTaskWait
5722                     	xref	_OS_EventTaskRdy
5723                     	xdef	_OSMboxQuery
5724                     	xdef	_OSMboxPostOpt
5725                     	xdef	_OSMboxPost
5726                     	xdef	_OSMboxPendAbort
5727                     	xdef	_OSMboxPend
5728                     	xdef	_OSMboxDel
5729                     	xdef	_OSMboxCreate
5730                     	xdef	_OSMboxAccept
5731                     	xref	_OSTCBCur
5732                     	xref	_OSLockNesting
5733                     	xref	_OSIntNesting
5734                     	xref	_OSEventFreeList
5735                     	xref	_OS_CPU_SR_Restore
5736                     	xref	_OS_CPU_SR_Save
5737                     .const:	section	.data
5738  0000               L7672:
5739  0000 3f00          	dc.b	"?",0
5760                     	end

   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4097                     ; 57 _NEAR INT16U  OSSemAccept (OS_EVENT *pevent)
4097                     ; 58 {
4098                     	switch	.text
4099  0000               _OSSemAccept:
4101  0000 3b            	pshd	
4102  0001 1b9d          	leas	-3,s
4103       00000003      OFST:	set	3
4106                     ; 61     OS_CPU_SR  cpu_sr = 0u;
4108                     ; 67     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
4110  0003 046402        	tbne	d,L3272
4111                     ; 68         return (0u);
4114  0006 2008          	bra	LC001
4115  0008               L3272:
4116                     ; 71     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
4118  0008 e6f30003      	ldab	[OFST+0,s]
4119  000c c103          	cmpb	#3
4120  000e 2705          	beq	L5272
4121                     ; 72         return (0u);
4123  0010               LC001:
4124  0010 87            	clra	
4125  0011 c7            	clrb	
4127  0012               L6:
4129  0012 1b85          	leas	5,s
4130  0014 3d            	rts	
4131  0015               L5272:
4132                     ; 74     OS_ENTER_CRITICAL();
4134  0015 160000        	jsr	_OS_CPU_SR_Save
4136  0018 6b82          	stab	OFST-1,s
4137                     ; 75     cnt = pevent->OSEventCnt;
4139  001a ed83          	ldy	OFST+0,s
4140  001c ee43          	ldx	3,y
4141  001e 6e80          	stx	OFST-3,s
4142                     ; 76     if (cnt > 0u) {                                   /* See if resource is available                  */
4144  0020 2703          	beq	L7272
4145                     ; 77         pevent->OSEventCnt--;                         /* Yes, decrement semaphore and notify caller    */
4147  0022 09            	dex	
4148  0023 6e43          	stx	3,y
4149  0025               L7272:
4150                     ; 79     OS_EXIT_CRITICAL();
4152  0025 87            	clra	
4153  0026 160000        	jsr	_OS_CPU_SR_Restore
4155                     ; 80     return (cnt);                                     /* Return semaphore count                        */
4157  0029 ec80          	ldd	OFST-3,s
4159  002b 20e5          	bra	L6
4217                     ; 102 _NEAR OS_EVENT  *OSSemCreate (INT16U cnt)
4217                     ; 103 {
4218                     	switch	.text
4219  002d               _OSSemCreate:
4221  002d 3b            	pshd	
4222  002e 1b9d          	leas	-3,s
4223       00000003      OFST:	set	3
4226                     ; 106     OS_CPU_SR  cpu_sr = 0u;
4228                     ; 117     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4230  0030 f60000        	ldab	_OSIntNesting
4231  0033 2704          	beq	L7572
4232                     ; 118         return ((OS_EVENT *)0);                            /* ... can't CREATE from an ISR             */
4234  0035 87            	clra	
4235  0036 c7            	clrb	
4237  0037 2031          	bra	L21
4238  0039               L7572:
4239                     ; 120     OS_ENTER_CRITICAL();
4241  0039 160000        	jsr	_OS_CPU_SR_Save
4243  003c 6b82          	stab	OFST-1,s
4244                     ; 121     pevent = OSEventFreeList;                              /* Get next free event control block        */
4246  003e fd0000        	ldy	_OSEventFreeList
4247  0041 6d80          	sty	OFST-3,s
4248                     ; 122     if (OSEventFreeList != (OS_EVENT *)0) {                /* See if pool of free ECB pool was empty   */
4250  0043 2705          	beq	L1672
4251                     ; 123         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
4253  0045 1805410000    	movw	1,y,_OSEventFreeList
4254  004a               L1672:
4255                     ; 125     OS_EXIT_CRITICAL();
4257  004a 87            	clra	
4258  004b 160000        	jsr	_OS_CPU_SR_Restore
4260                     ; 126     if (pevent != (OS_EVENT *)0) {                         /* Get an event control block               */
4262  004e ed80          	ldy	OFST-3,s
4263  0050 2716          	beq	L3672
4264                     ; 127         pevent->OSEventType    = OS_EVENT_TYPE_SEM;
4266  0052 c603          	ldab	#3
4267  0054 6b40          	stab	0,y
4268                     ; 128         pevent->OSEventCnt     = cnt;                      /* Set semaphore value                      */
4270  0056 18028343      	movw	OFST+0,s,3,y
4271                     ; 129         pevent->OSEventPtr     = (void *)0;                /* Unlink from ECB free list                */
4273  005a 87            	clra	
4274  005b c7            	clrb	
4275  005c 6c41          	std	1,y
4276                     ; 131         pevent->OSEventName    = (INT8U *)(void *)"?";
4278  005e cc0000        	ldd	#L5672
4279  0061 6c4e          	std	14,y
4280                     ; 133         OS_EventWaitListInit(pevent);                      /* Initialize to 'nobody waiting' on sem.   */
4282  0063 b764          	tfr	y,d
4283  0065 160000        	jsr	_OS_EventWaitListInit
4286  0068               L3672:
4287                     ; 137     return (pevent);
4289  0068 ec80          	ldd	OFST-3,s
4291  006a               L21:
4293  006a 1b85          	leas	5,s
4294  006c 3d            	rts	
4382                     ; 185 _NEAR OS_EVENT  *OSSemDel (OS_EVENT  *pevent,
4382                     ; 186                           INT8U      opt,
4382                     ; 187                           INT8U     *perr)
4382                     ; 188 {
4383                     	switch	.text
4384  006d               _OSSemDel:
4386  006d 3b            	pshd	
4387  006e 1b9c          	leas	-4,s
4388       00000004      OFST:	set	4
4391                     ; 192     OS_CPU_SR  cpu_sr = 0u;
4393                     ; 212     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
4395  0070 046404        	tbne	d,L7303
4396                     ; 213         *perr = OS_ERR_PEVENT_NULL;
4398  0073 c604          	ldab	#4
4399                     ; 214         return (pevent);
4402  0075 200a          	bra	L61
4403  0077               L7303:
4404                     ; 220     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {        /* Validate event block type                */
4407  0077 e6f30004      	ldab	[OFST+0,s]
4408  007b c103          	cmpb	#3
4409  007d 270b          	beq	L1403
4410                     ; 221         *perr = OS_ERR_EVENT_TYPE;
4412  007f c601          	ldab	#1
4413                     ; 223         return (pevent);
4417  0081               L61:
4418  0081 6bf3000a      	stab	[OFST+6,s]
4419  0085 ec84          	ldd	OFST+0,s
4421  0087 1b86          	leas	6,s
4422  0089 3d            	rts	
4423  008a               L1403:
4424                     ; 225     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4426  008a f60000        	ldab	_OSIntNesting
4427  008d 2704          	beq	L3403
4428                     ; 226         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
4430  008f c60f          	ldab	#15
4431                     ; 228         return (pevent);
4435  0091 20ee          	bra	L61
4436  0093               L3403:
4437                     ; 230     OS_ENTER_CRITICAL();
4439  0093 160000        	jsr	_OS_CPU_SR_Save
4441  0096 6b80          	stab	OFST-4,s
4442                     ; 231     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on semaphore    */
4444  0098 ed84          	ldy	OFST+0,s
4445  009a e645          	ldab	5,y
4446  009c 2706          	beq	L5403
4447                     ; 232         tasks_waiting = OS_TRUE;                           /* Yes                                      */
4449  009e c601          	ldab	#1
4450  00a0 6b83          	stab	OFST-1,s
4452  00a2 2002          	bra	L7403
4453  00a4               L5403:
4454                     ; 234         tasks_waiting = OS_FALSE;                          /* No                                       */
4456  00a4 6983          	clr	OFST-1,s
4457  00a6               L7403:
4458                     ; 236     switch (opt) {
4460  00a6 e689          	ldab	OFST+5,s
4462  00a8 270d          	beq	L7672
4463  00aa 040153        	dbeq	b,L3603
4464                     ; 275         default:
4464                     ; 276              OS_EXIT_CRITICAL();
4466  00ad e680          	ldab	OFST-4,s
4467  00af 87            	clra	
4468  00b0 160000        	jsr	_OS_CPU_SR_Restore
4470                     ; 277              *perr                  = OS_ERR_INVALID_OPT;
4472  00b3 c607          	ldab	#7
4473                     ; 278              pevent_return          = pevent;
4475                     ; 279              break;
4477  00b5 202e          	bra	LC003
4478  00b7               L7672:
4479                     ; 237         case OS_DEL_NO_PEND:                               /* Delete semaphore only if no task waiting */
4479                     ; 238              if (tasks_waiting == OS_FALSE) {
4481  00b7 e683          	ldab	OFST-1,s
4482  00b9 2622          	bne	L5503
4483                     ; 240                  pevent->OSEventName    = (INT8U *)(void *)"?";
4485  00bb cc0000        	ldd	#L5672
4486  00be 6c4e          	std	14,y
4487                     ; 242                  pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
4489  00c0 87            	clra	
4490  00c1 6a40          	staa	0,y
4491                     ; 243                  pevent->OSEventPtr     = OSEventFreeList; /* Return Event Control Block to free list  */
4493  00c3 1801410000    	movw	_OSEventFreeList,1,y
4494                     ; 244                  pevent->OSEventCnt     = 0u;
4496  00c8 c7            	clrb	
4497  00c9 6c43          	std	3,y
4498                     ; 245                  OSEventFreeList        = pevent;          /* Get next free event control block        */
4500  00cb 1805840000    	movw	OFST+0,s,_OSEventFreeList
4501                     ; 246                  OS_EXIT_CRITICAL();
4503  00d0 e680          	ldab	OFST-4,s
4504  00d2 160000        	jsr	_OS_CPU_SR_Restore
4506                     ; 247                  *perr                  = OS_ERR_NONE;
4508  00d5 87            	clra	
4509  00d6 6af3000a      	staa	[OFST+6,s]
4510                     ; 248                  pevent_return          = (OS_EVENT *)0;   /* Semaphore has been deleted               */
4512  00da c7            	clrb	
4514  00db 200e          	bra	LC002
4515  00dd               L5503:
4516                     ; 250                  OS_EXIT_CRITICAL();
4518  00dd e680          	ldab	OFST-4,s
4519  00df 87            	clra	
4520  00e0 160000        	jsr	_OS_CPU_SR_Restore
4522                     ; 251                  *perr                  = OS_ERR_TASK_WAITING;
4524  00e3 c649          	ldab	#73
4525                     ; 252                  pevent_return          = pevent;
4527  00e5               LC003:
4528  00e5 6bf3000a      	stab	[OFST+6,s]
4529  00e9 ec84          	ldd	OFST+0,s
4530  00eb               LC002:
4531  00eb 6c81          	std	OFST-3,s
4532  00ed 203d          	bra	L3503
4533  00ef               L1603:
4534                     ; 258                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
4536  00ef cc0002        	ldd	#2
4537  00f2 3b            	pshd	
4538  00f3 53            	decb	
4539  00f4 3b            	pshd	
4540  00f5 c7            	clrb	
4541  00f6 3b            	pshd	
4542  00f7 ec8a          	ldd	OFST+6,s
4543  00f9 160000        	jsr	_OS_EventTaskRdy
4545  00fc 1b86          	leas	6,s
4546  00fe ed84          	ldy	OFST+0,s
4547  0100               L3603:
4548                     ; 256         case OS_DEL_ALWAYS:                                /* Always delete the semaphore              */
4548                     ; 257              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for semaphore    */
4550  0100 e645          	ldab	5,y
4551  0102 26eb          	bne	L1603
4552                     ; 261              pevent->OSEventName    = (INT8U *)(void *)"?";
4554  0104 cc0000        	ldd	#L5672
4555  0107 6c4e          	std	14,y
4556                     ; 263              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
4558  0109 87            	clra	
4559  010a 6a40          	staa	0,y
4560                     ; 264              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
4562  010c 1801410000    	movw	_OSEventFreeList,1,y
4563                     ; 265              pevent->OSEventCnt     = 0u;
4565  0111 c7            	clrb	
4566  0112 6c43          	std	3,y
4567                     ; 266              OSEventFreeList        = pevent;              /* Get next free event control block        */
4569  0114 1805840000    	movw	OFST+0,s,_OSEventFreeList
4570                     ; 267              OS_EXIT_CRITICAL();
4572  0119 e680          	ldab	OFST-4,s
4573  011b 160000        	jsr	_OS_CPU_SR_Restore
4575                     ; 268              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
4577  011e e683          	ldab	OFST-1,s
4578  0120 042103        	dbne	b,L7603
4579                     ; 269                  OS_Sched();                               /* Find highest priority task ready to run  */
4581  0123 160000        	jsr	_OS_Sched
4583  0126               L7603:
4584                     ; 271              *perr                  = OS_ERR_NONE;
4586  0126 87            	clra	
4587  0127 6af3000a      	staa	[OFST+6,s]
4588                     ; 272              pevent_return          = (OS_EVENT *)0;       /* Semaphore has been deleted               */
4590  012b c7            	clrb	
4591                     ; 273              break;
4593  012c               L3503:
4594                     ; 284     return (pevent_return);
4599  012c 1b86          	leas	6,s
4600  012e 3d            	rts	
4668                     ; 321 _NEAR void  OSSemPend (OS_EVENT  *pevent,
4668                     ; 322                       INT32U     timeout,
4668                     ; 323                       INT8U     *perr)
4668                     ; 324 {
4669                     	switch	.text
4670  012f               _OSSemPend:
4672  012f 3b            	pshd	
4673  0130 37            	pshb	
4674       00000001      OFST:	set	1
4677                     ; 326     OS_CPU_SR  cpu_sr = 0u;
4679                     ; 338     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
4681  0131 046404        	tbne	d,L7213
4682                     ; 339         *perr = OS_ERR_PEVENT_NULL;
4684  0134 c604          	ldab	#4
4685                     ; 340         return;
4687  0136 200a          	bra	LC004
4688  0138               L7213:
4689                     ; 346     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
4692  0138 e6f30001      	ldab	[OFST+0,s]
4693  013c c103          	cmpb	#3
4694  013e 2709          	beq	L1313
4695                     ; 347         *perr = OS_ERR_EVENT_TYPE;
4697  0140 c601          	ldab	#1
4698  0142               LC004:
4699  0142 6bf30009      	stab	[OFST+8,s]
4700                     ; 349         return;
4701  0146               L22:
4705  0146 1b83          	leas	3,s
4706  0148 3d            	rts	
4707  0149               L1313:
4708                     ; 351     if (OSIntNesting > 0u) {                          /* See if called from ISR ...                    */
4710  0149 f60000        	ldab	_OSIntNesting
4711  014c 2704          	beq	L3313
4712                     ; 352         *perr = OS_ERR_PEND_ISR;                      /* ... can't PEND from an ISR                    */
4714  014e c602          	ldab	#2
4715                     ; 354         return;
4718  0150 20f0          	bra	LC004
4719  0152               L3313:
4720                     ; 356     if (OSLockNesting > 0u) {                         /* See if called with scheduler locked ...       */
4722  0152 f60000        	ldab	_OSLockNesting
4723  0155 2704          	beq	L5313
4724                     ; 357         *perr = OS_ERR_PEND_LOCKED;                   /* ... can't PEND when locked                    */
4726  0157 c60d          	ldab	#13
4727                     ; 359         return;
4730  0159 20e7          	bra	LC004
4731  015b               L5313:
4732                     ; 361     OS_ENTER_CRITICAL();
4734  015b 160000        	jsr	_OS_CPU_SR_Save
4736  015e 6b80          	stab	OFST-1,s
4737                     ; 362     if (pevent->OSEventCnt > 0u) {                    /* If sem. is positive, resource available ...   */
4739  0160 ed81          	ldy	OFST+0,s
4740  0162 ee43          	ldx	3,y
4741  0164 270d          	beq	L7313
4742                     ; 363         pevent->OSEventCnt--;                         /* ... decrement semaphore only if positive.     */
4744  0166 09            	dex	
4745  0167 6e43          	stx	3,y
4746                     ; 364         OS_EXIT_CRITICAL();
4748  0169 87            	clra	
4749  016a 160000        	jsr	_OS_CPU_SR_Restore
4751                     ; 365         *perr = OS_ERR_NONE;
4753  016d 69f30009      	clr	[OFST+8,s]
4754                     ; 367         return;
4757  0171 20d3          	bra	L22
4758  0173               L7313:
4759                     ; 370     OSTCBCur->OSTCBStat     |= OS_STAT_SEM;           /* Resource not available, pend on semaphore     */
4761  0173 fd0000        	ldy	_OSTCBCur
4762  0176 0ce82201      	bset	34,y,1
4763                     ; 371     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
4765  017a 69e823        	clr	35,y
4766                     ; 372     OSTCBCur->OSTCBDly       = timeout;               /* Store pend timeout in TCB                     */
4768  017d ec87          	ldd	OFST+6,s
4769  017f 6ce820        	std	32,y
4770  0182 ec85          	ldd	OFST+4,s
4771  0184 6ce81e        	std	30,y
4772                     ; 373     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
4774  0187 ec81          	ldd	OFST+0,s
4775  0189 160000        	jsr	_OS_EventTaskWait
4777                     ; 374     OS_EXIT_CRITICAL();
4779  018c e680          	ldab	OFST-1,s
4780  018e 87            	clra	
4781  018f 160000        	jsr	_OS_CPU_SR_Restore
4783                     ; 375     OS_Sched();                                       /* Find next highest priority task ready         */
4785  0192 160000        	jsr	_OS_Sched
4787                     ; 376     OS_ENTER_CRITICAL();
4789  0195 160000        	jsr	_OS_CPU_SR_Save
4791  0198 6b80          	stab	OFST-1,s
4792                     ; 377     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
4794  019a fd0000        	ldy	_OSTCBCur
4795  019d e6e823        	ldab	35,y
4797  01a0 2708          	beq	L1703
4798  01a2 04010f        	dbeq	b,L5703
4799  01a5 040108        	dbeq	b,L3703
4800  01a8 200a          	bra	L5703
4801  01aa               L1703:
4802                     ; 378         case OS_STAT_PEND_OK:
4802                     ; 379              *perr = OS_ERR_NONE;
4804  01aa 69f30009      	clr	[OFST+8,s]
4805                     ; 380              break;
4807  01ae 2017          	bra	L3413
4808  01b0               L3703:
4809                     ; 382         case OS_STAT_PEND_ABORT:
4809                     ; 383              *perr = OS_ERR_PEND_ABORT;               /* Indicate that we aborted                      */
4811  01b0 c60e          	ldab	#14
4812                     ; 384              break;
4814  01b2 200c          	bra	LC005
4815  01b4               L5703:
4816                     ; 386         case OS_STAT_PEND_TO:
4816                     ; 387         default:
4816                     ; 388              OS_EventTaskRemove(OSTCBCur, pevent);
4818  01b4 ec81          	ldd	OFST+0,s
4819  01b6 3b            	pshd	
4820  01b7 b764          	tfr	y,d
4821  01b9 160000        	jsr	_OS_EventTaskRemove
4823  01bc 1b82          	leas	2,s
4824                     ; 389              *perr = OS_ERR_TIMEOUT;                  /* Indicate that we didn't get event within TO   */
4826  01be c60a          	ldab	#10
4827  01c0               LC005:
4828  01c0 6bf30009      	stab	[OFST+8,s]
4829                     ; 390              break;
4831  01c4 fd0000        	ldy	_OSTCBCur
4832  01c7               L3413:
4833                     ; 392     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
4835  01c7 c7            	clrb	
4836  01c8 6be822        	stab	34,y
4837                     ; 393     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
4839  01cb 87            	clra	
4840  01cc 6ae823        	staa	35,y
4841                     ; 394     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
4843  01cf 6ce812        	std	18,y
4844                     ; 396     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
4846  01d2 6ce814        	std	20,y
4847                     ; 397     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
4849  01d5 6ce816        	std	22,y
4850                     ; 399     OS_EXIT_CRITICAL();
4852  01d8 e680          	ldab	OFST-1,s
4853  01da 160000        	jsr	_OS_CPU_SR_Restore
4855                     ; 402 }
4859  01dd 1b83          	leas	3,s
4860  01df 3d            	rts	
4931                     ; 439 _NEAR INT8U  OSSemPendAbort (OS_EVENT  *pevent,
4931                     ; 440                             INT8U      opt,
4931                     ; 441                             INT8U     *perr)
4931                     ; 442 {
4932                     	switch	.text
4933  01e0               _OSSemPendAbort:
4935  01e0 3b            	pshd	
4936       00000002      OFST:	set	2
4939                     ; 445     OS_CPU_SR  cpu_sr = 0u;
4941                     ; 457     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
4943  01e1 6cae          	std	2,-s
4944  01e3 2604          	bne	L3023
4945                     ; 458         *perr = OS_ERR_PEVENT_NULL;
4947  01e5 c604          	ldab	#4
4948                     ; 459         return (0u);
4951  01e7 200a          	bra	LC006
4952  01e9               L3023:
4953                     ; 462     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
4955  01e9 e6f30002      	ldab	[OFST+0,s]
4956  01ed c103          	cmpb	#3
4957  01ef 270a          	beq	L5023
4958                     ; 463         *perr = OS_ERR_EVENT_TYPE;
4960  01f1 c601          	ldab	#1
4961                     ; 464         return (0u);
4963  01f3               LC006:
4964  01f3 6bf30008      	stab	[OFST+6,s]
4965  01f7 c7            	clrb	
4967  01f8               L62:
4969  01f8 1b84          	leas	4,s
4970  01fa 3d            	rts	
4971  01fb               L5023:
4972                     ; 466     OS_ENTER_CRITICAL();
4974  01fb 160000        	jsr	_OS_CPU_SR_Save
4976  01fe 6b81          	stab	OFST-1,s
4977                     ; 467     if (pevent->OSEventGrp != 0u) {                   /* See if any task waiting on semaphore?         */
4979  0200 ed82          	ldy	OFST+0,s
4980  0202 e745          	tst	5,y
4981  0204 2748          	beq	L7023
4982                     ; 468         nbr_tasks = 0u;
4984  0206 6980          	clr	OFST-2,s
4985                     ; 469         switch (opt) {
4987  0208 e687          	ldab	OFST+5,s
4989  020a 271e          	beq	L7413
4990  020c 040115        	dbeq	b,L7123
4991  020f 2019          	bra	L7413
4992  0211               L5123:
4993                     ; 472                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
4995  0211 cc0002        	ldd	#2
4996  0214 3b            	pshd	
4997  0215 53            	decb	
4998  0216 3b            	pshd	
4999  0217 c7            	clrb	
5000  0218 3b            	pshd	
5001  0219 ec88          	ldd	OFST+6,s
5002  021b 160000        	jsr	_OS_EventTaskRdy
5004  021e 1b86          	leas	6,s
5005                     ; 473                      nbr_tasks++;
5007  0220 6280          	inc	OFST-2,s
5008  0222 ed82          	ldy	OFST+0,s
5009  0224               L7123:
5010                     ; 470             case OS_PEND_OPT_BROADCAST:               /* Do we need to abort ALL waiting tasks?        */
5010                     ; 471                  while (pevent->OSEventGrp != 0u) {   /* Yes, ready ALL tasks waiting on semaphore     */
5012  0224 e645          	ldab	5,y
5013  0226 26e9          	bne	L5123
5014                     ; 475                  break;
5016  0228 2011          	bra	L3123
5017  022a               L7413:
5018                     ; 477             case OS_PEND_OPT_NONE:
5018                     ; 478             default:                                  /* No,  ready HPT       waiting on semaphore     */
5018                     ; 479                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
5020  022a cc0002        	ldd	#2
5021  022d 3b            	pshd	
5022  022e 53            	decb	
5023  022f 3b            	pshd	
5024  0230 c7            	clrb	
5025  0231 3b            	pshd	
5026  0232 b764          	tfr	y,d
5027  0234 160000        	jsr	_OS_EventTaskRdy
5029  0237 1b86          	leas	6,s
5030                     ; 480                  nbr_tasks++;
5032  0239 6280          	inc	OFST-2,s
5033                     ; 481                  break;
5035  023b               L3123:
5036                     ; 483         OS_EXIT_CRITICAL();
5038  023b e681          	ldab	OFST-1,s
5039  023d 87            	clra	
5040  023e 160000        	jsr	_OS_CPU_SR_Restore
5042                     ; 484         OS_Sched();                                   /* Find HPT ready to run                         */
5044  0241 160000        	jsr	_OS_Sched
5046                     ; 485         *perr = OS_ERR_PEND_ABORT;
5048  0244 c60e          	ldab	#14
5049  0246 6bf30008      	stab	[OFST+6,s]
5050                     ; 486         return (nbr_tasks);
5052  024a e680          	ldab	OFST-2,s
5054  024c 20aa          	bra	L62
5055  024e               L7023:
5056                     ; 488     OS_EXIT_CRITICAL();
5058  024e 87            	clra	
5059  024f 160000        	jsr	_OS_CPU_SR_Restore
5061                     ; 489     *perr = OS_ERR_NONE;
5063  0252 c7            	clrb	
5064  0253 6bf30008      	stab	[OFST+6,s]
5065                     ; 490     return (0u);                                      /* No tasks waiting on semaphore                 */
5068  0257 209f          	bra	L62
5115                     ; 513 _NEAR INT8U  OSSemPost (OS_EVENT *pevent)
5115                     ; 514 {
5116                     	switch	.text
5117  0259               _OSSemPost:
5119  0259 3b            	pshd	
5120  025a 37            	pshb	
5121       00000001      OFST:	set	1
5124                     ; 516     OS_CPU_SR  cpu_sr = 0u;
5126                     ; 521     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
5128  025b 046404        	tbne	d,L5423
5129                     ; 522         return (OS_ERR_PEVENT_NULL);
5131  025e c604          	ldab	#4
5133  0260 200a          	bra	L23
5134  0262               L5423:
5135                     ; 528     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
5138  0262 e6f30001      	ldab	[OFST+0,s]
5139  0266 c103          	cmpb	#3
5140  0268 2705          	beq	L7423
5141                     ; 530         return (OS_ERR_EVENT_TYPE);
5144  026a c601          	ldab	#1
5146  026c               L23:
5148  026c 1b83          	leas	3,s
5149  026e 3d            	rts	
5150  026f               L7423:
5151                     ; 532     OS_ENTER_CRITICAL();
5153  026f 160000        	jsr	_OS_CPU_SR_Save
5155  0272 6b80          	stab	OFST-1,s
5156                     ; 533     if (pevent->OSEventGrp != 0u) {                   /* See if any task waiting for semaphore         */
5158  0274 ed81          	ldy	OFST+0,s
5159  0276 e745          	tst	5,y
5160  0278 271a          	beq	L1523
5161                     ; 535         (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_OK);
5163  027a 87            	clra	
5164  027b c7            	clrb	
5165  027c 3b            	pshd	
5166  027d 52            	incb	
5167  027e 3b            	pshd	
5168  027f c7            	clrb	
5169  0280 3b            	pshd	
5170  0281 b764          	tfr	y,d
5171  0283 160000        	jsr	_OS_EventTaskRdy
5173  0286 1b86          	leas	6,s
5174                     ; 536         OS_EXIT_CRITICAL();
5176  0288 e680          	ldab	OFST-1,s
5177  028a 87            	clra	
5178  028b 160000        	jsr	_OS_CPU_SR_Restore
5180                     ; 537         OS_Sched();                                   /* Find HPT ready to run                         */
5182  028e 160000        	jsr	_OS_Sched
5184                     ; 539         return (OS_ERR_NONE);
5187  0291 c7            	clrb	
5189  0292 20d8          	bra	L23
5190  0294               L1523:
5191                     ; 541     if (pevent->OSEventCnt < 65535u) {                /* Make sure semaphore will not overflow         */
5193  0294 ee43          	ldx	3,y
5194  0296 8effff        	cpx	#-1
5195  0299 240a          	bhs	L3523
5196                     ; 542         pevent->OSEventCnt++;                         /* Increment semaphore count to register event   */
5198  029b 08            	inx	
5199  029c 6e43          	stx	3,y
5200                     ; 543         OS_EXIT_CRITICAL();
5202  029e 87            	clra	
5203  029f 160000        	jsr	_OS_CPU_SR_Restore
5205                     ; 545         return (OS_ERR_NONE);
5208  02a2 c7            	clrb	
5210  02a3 20c7          	bra	L23
5211  02a5               L3523:
5212                     ; 547     OS_EXIT_CRITICAL();                               /* Semaphore value has reached its maximum       */
5214  02a5 87            	clra	
5215  02a6 160000        	jsr	_OS_CPU_SR_Restore
5217                     ; 550     return (OS_ERR_SEM_OVF);
5220  02a9 c633          	ldab	#51
5222  02ab 20bf          	bra	L23
5337                     ; 574 _NEAR INT8U  OSSemQuery (OS_EVENT     *pevent,
5337                     ; 575                         OS_SEM_DATA  *p_sem_data)
5337                     ; 576 {
5338                     	switch	.text
5339  02ad               _OSSemQuery:
5341  02ad 3b            	pshd	
5342  02ae 1b9a          	leas	-6,s
5343       00000006      OFST:	set	6
5346                     ; 581     OS_CPU_SR   cpu_sr = 0u;
5348                     ; 587     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
5350  02b0 046404        	tbne	d,L3333
5351                     ; 588         return (OS_ERR_PEVENT_NULL);
5353  02b3 c604          	ldab	#4
5355  02b5 2006          	bra	L63
5356  02b7               L3333:
5357                     ; 590     if (p_sem_data == (OS_SEM_DATA *)0) {                  /* Validate 'p_sem_data'                    */
5359  02b7 ec8a          	ldd	OFST+4,s
5360  02b9 2605          	bne	L5333
5361                     ; 591         return (OS_ERR_PDATA_NULL);
5363  02bb c609          	ldab	#9
5365  02bd               L63:
5367  02bd 1b88          	leas	8,s
5368  02bf 3d            	rts	
5369  02c0               L5333:
5370                     ; 594     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {        /* Validate event block type                */
5372  02c0 e6f30006      	ldab	[OFST+0,s]
5373  02c4 c103          	cmpb	#3
5374  02c6 2704          	beq	L7333
5375                     ; 595         return (OS_ERR_EVENT_TYPE);
5377  02c8 c601          	ldab	#1
5379  02ca 20f1          	bra	L63
5380  02cc               L7333:
5381                     ; 597     OS_ENTER_CRITICAL();
5383  02cc 160000        	jsr	_OS_CPU_SR_Save
5385  02cf 6b85          	stab	OFST-1,s
5386                     ; 598     p_sem_data->OSEventGrp = pevent->OSEventGrp;           /* Copy message mailbox wait list           */
5388  02d1 ed8a          	ldy	OFST+4,s
5389  02d3 ee86          	ldx	OFST+0,s
5390  02d5 180a054a      	movb	5,x,10,y
5391                     ; 599     psrc                   = &pevent->OSEventTbl[0];
5393  02d9 ed86          	ldy	OFST+0,s
5394  02db 1946          	leay	6,y
5395  02dd 6d81          	sty	OFST-5,s
5396                     ; 600     pdest                  = &p_sem_data->OSEventTbl[0];
5398  02df ed8a          	ldy	OFST+4,s
5399  02e1 1942          	leay	2,y
5400  02e3 6d83          	sty	OFST-3,s
5401                     ; 601     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
5403  02e5 6980          	clr	OFST-6,s
5404  02e7 ee81          	ldx	OFST-5,s
5405  02e9               L1433:
5406                     ; 602         *pdest++ = *psrc++;
5408  02e9 180a3070      	movb	1,x+,1,y+
5409                     ; 601     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
5411  02ed 6280          	inc	OFST-6,s
5414  02ef e680          	ldab	OFST-6,s
5415  02f1 c108          	cmpb	#8
5416  02f3 25f4          	blo	L1433
5417  02f5 6e81          	stx	OFST-5,s
5418  02f7 6d83          	sty	OFST-3,s
5419                     ; 604     p_sem_data->OSCnt = pevent->OSEventCnt;                /* Get semaphore count                      */
5421  02f9 ed86          	ldy	OFST+0,s
5422  02fb ec43          	ldd	3,y
5423  02fd 6cf3000a      	std	[OFST+4,s]
5424                     ; 605     OS_EXIT_CRITICAL();
5426  0301 e685          	ldab	OFST-1,s
5427  0303 87            	clra	
5428  0304 160000        	jsr	_OS_CPU_SR_Restore
5430                     ; 606     return (OS_ERR_NONE);
5432  0307 c7            	clrb	
5434  0308 20b3          	bra	L63
5496                     ; 636 _NEAR void  OSSemSet (OS_EVENT  *pevent,
5496                     ; 637                      INT16U     cnt,
5496                     ; 638                      INT8U     *perr)
5496                     ; 639 {
5497                     	switch	.text
5498  030a               _OSSemSet:
5500  030a 3b            	pshd	
5501  030b 37            	pshb	
5502       00000001      OFST:	set	1
5505                     ; 641     OS_CPU_SR  cpu_sr = 0u;
5507                     ; 654     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
5509  030c 046404        	tbne	d,L7733
5510                     ; 655         *perr = OS_ERR_PEVENT_NULL;
5512  030f c604          	ldab	#4
5513                     ; 656         return;
5515  0311 200a          	bra	LC007
5516  0313               L7733:
5517                     ; 659     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
5519  0313 e6f30001      	ldab	[OFST+0,s]
5520  0317 c103          	cmpb	#3
5521  0319 2709          	beq	L1043
5522                     ; 660         *perr = OS_ERR_EVENT_TYPE;
5524  031b c601          	ldab	#1
5525  031d               LC007:
5526  031d 6bf30007      	stab	[OFST+6,s]
5527                     ; 661         return;
5528  0321               L24:
5531  0321 1b83          	leas	3,s
5532  0323 3d            	rts	
5533  0324               L1043:
5534                     ; 663     OS_ENTER_CRITICAL();
5536  0324 160000        	jsr	_OS_CPU_SR_Save
5538  0327 6b80          	stab	OFST-1,s
5539                     ; 664     *perr = OS_ERR_NONE;
5541  0329 69f30007      	clr	[OFST+6,s]
5542                     ; 665     if (pevent->OSEventCnt > 0u) {                    /* See if semaphore already has a count          */
5544  032d ed81          	ldy	OFST+0,s
5545  032f ec43          	ldd	3,y
5546                     ; 666         pevent->OSEventCnt = cnt;                     /* Yes, set it to the new value specified.       */
5549  0331 2604          	bne	LC008
5550                     ; 668         if (pevent->OSEventGrp == 0u) {               /*      See if task(s) waiting?                  */
5552  0333 e645          	ldab	5,y
5553  0335 2606          	bne	L7043
5554                     ; 669             pevent->OSEventCnt = cnt;                 /*      No, OK to set the value                  */
5556  0337               LC008:
5557  0337 18028543      	movw	OFST+4,s,3,y
5559  033b 2006          	bra	L5043
5560  033d               L7043:
5561                     ; 671             *perr              = OS_ERR_TASK_WAITING;
5563  033d c649          	ldab	#73
5564  033f 6bf30007      	stab	[OFST+6,s]
5565  0343               L5043:
5566                     ; 674     OS_EXIT_CRITICAL();
5568  0343 e680          	ldab	OFST-1,s
5569  0345 87            	clra	
5570  0346 160000        	jsr	_OS_CPU_SR_Restore
5572                     ; 675 }
5574  0349 20d6          	bra	L24
5586                     	xref	_OS_Sched
5587                     	xref	_OS_EventWaitListInit
5588                     	xref	_OS_EventTaskRemove
5589                     	xref	_OS_EventTaskWait
5590                     	xref	_OS_EventTaskRdy
5591                     	xdef	_OSSemSet
5592                     	xdef	_OSSemQuery
5593                     	xdef	_OSSemPost
5594                     	xdef	_OSSemPendAbort
5595                     	xdef	_OSSemPend
5596                     	xdef	_OSSemDel
5597                     	xdef	_OSSemCreate
5598                     	xdef	_OSSemAccept
5599                     	xref	_OSTCBCur
5600                     	xref	_OSLockNesting
5601                     	xref	_OSIntNesting
5602                     	xref	_OSEventFreeList
5603                     	xref	_OS_CPU_SR_Restore
5604                     	xref	_OS_CPU_SR_Save
5605                     .const:	section	.data
5606  0000               L5672:
5607  0000 3f00          	dc.b	"?",0
5628                     	end

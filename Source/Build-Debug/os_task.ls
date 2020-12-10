   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4504                     ; 60 _NEAR INT8U  OSTaskChangePrio (INT8U  oldprio,
4504                     ; 61                               INT8U  newprio)
4504                     ; 62 {
4505                     	switch	.text
4506  0000               _OSTaskChangePrio:
4508  0000 3b            	pshd	
4509  0001 1b92          	leas	-14,s
4510       0000000e      OFST:	set	14
4513                     ; 78     OS_CPU_SR  cpu_sr = 0u;                                 /* Storage for CPU status register         */
4515                     ; 83     if (oldprio >= OS_LOWEST_PRIO) {
4517  0003 c13f          	cmpb	#63
4518  0005 2503          	blo	L1513
4519                     ; 84         if (oldprio != OS_PRIO_SELF) {
4521  0007 52            	incb	
4522                     ; 85             return (OS_ERR_PRIO_INVALID);
4525  0008 2607          	bne	LC001
4526  000a               L1513:
4527                     ; 88     if (newprio >= OS_LOWEST_PRIO) {
4529  000a e6f013        	ldab	OFST+5,s
4530  000d c13f          	cmpb	#63
4531  000f 2506          	blo	L5513
4532                     ; 89         return (OS_ERR_PRIO_INVALID);
4534  0011               LC001:
4535  0011 c62a          	ldab	#42
4537  0013               L61:
4539  0013 1bf010        	leas	16,s
4540  0016 3d            	rts	
4541  0017               L5513:
4542                     ; 92     OS_ENTER_CRITICAL();
4544  0017 160000        	jsr	_OS_CPU_SR_Save
4546  001a 6b8c          	stab	OFST-2,s
4547                     ; 93     if (OSTCBPrioTbl[newprio] != (OS_TCB *)0) {             /* New priority must not already exist     */
4549  001c e6f013        	ldab	OFST+5,s
4550  001f 87            	clra	
4551  0020 59            	lsld	
4552  0021 b746          	tfr	d,y
4553  0023 ecea0000      	ldd	_OSTCBPrioTbl,y
4554  0027 270a          	beq	L7513
4555                     ; 94         OS_EXIT_CRITICAL();
4557  0029 e68c          	ldab	OFST-2,s
4558  002b 87            	clra	
4559  002c 160000        	jsr	_OS_CPU_SR_Restore
4561                     ; 95         return (OS_ERR_PRIO_EXIST);
4563  002f c628          	ldab	#40
4565  0031 20e0          	bra	L61
4566  0033               L7513:
4567                     ; 97     if (oldprio == OS_PRIO_SELF) {                          /* See if changing self                    */
4569  0033 e68f          	ldab	OFST+1,s
4570  0035 c1ff          	cmpb	#255
4571  0037 2608          	bne	L1613
4572                     ; 98         oldprio = OSTCBCur->OSTCBPrio;                      /* Yes, get priority                       */
4574  0039 fd0000        	ldy	_OSTCBCur
4575  003c e6e824        	ldab	36,y
4576  003f 6b8f          	stab	OFST+1,s
4577  0041               L1613:
4578                     ; 100     ptcb = OSTCBPrioTbl[oldprio];
4580  0041 87            	clra	
4581  0042 59            	lsld	
4582  0043 b746          	tfr	d,y
4583  0045 ecea0000      	ldd	_OSTCBPrioTbl,y
4584  0049 6c82          	std	OFST-12,s
4585                     ; 101     if (ptcb == (OS_TCB *)0) {                              /* Does task to change exist?              */
4587  004b 2609          	bne	L3613
4588                     ; 102         OS_EXIT_CRITICAL();                                 /* No, can't change its priority!          */
4590  004d e68c          	ldab	OFST-2,s
4591  004f 160000        	jsr	_OS_CPU_SR_Restore
4593                     ; 103         return (OS_ERR_PRIO);
4595  0052 c629          	ldab	#41
4597  0054 20bd          	bra	L61
4598  0056               L3613:
4599                     ; 105     if (ptcb == OS_TCB_RESERVED) {                          /* Is task assigned to Mutex               */
4601  0056 042409        	dbne	d,L5613
4602                     ; 106         OS_EXIT_CRITICAL();                                 /* No, can't change its priority!          */
4604  0059 e68c          	ldab	OFST-2,s
4605  005b 160000        	jsr	_OS_CPU_SR_Restore
4607                     ; 107         return (OS_ERR_TASK_NOT_EXIST);
4609  005e c643          	ldab	#67
4611  0060 20b1          	bra	L61
4612  0062               L5613:
4613                     ; 110     y_new                 = (INT8U)(newprio >> 3u);         /* Yes, compute new TCB fields             */
4615  0062 e6f013        	ldab	OFST+5,s
4616  0065 54            	lsrb	
4617  0066 54            	lsrb	
4618  0067 54            	lsrb	
4619  0068 6b87          	stab	OFST-7,s
4620                     ; 111     x_new                 = (INT8U)(newprio & 0x07u);
4622  006a e6f013        	ldab	OFST+5,s
4623  006d c407          	andb	#7
4624  006f 6b8d          	stab	OFST-1,s
4625                     ; 116     bity_new              = (OS_PRIO)(1uL << y_new);
4627  0071 c601          	ldab	#1
4628  0073 a687          	ldaa	OFST-7,s
4629  0075 2704          	beq	L6
4630  0077               L01:
4631  0077 58            	lslb	
4632  0078 0430fc        	dbne	a,L01
4633  007b               L6:
4634  007b 6b88          	stab	OFST-6,s
4635                     ; 117     bitx_new              = (OS_PRIO)(1uL << x_new);
4637  007d c601          	ldab	#1
4638  007f a68d          	ldaa	OFST-1,s
4639  0081 2704          	beq	L21
4640  0083               L41:
4641  0083 58            	lslb	
4642  0084 0430fc        	dbne	a,L41
4643  0087               L21:
4644  0087 6b89          	stab	OFST-5,s
4645                     ; 119     OSTCBPrioTbl[oldprio] = (OS_TCB *)0;                    /* Remove TCB from old priority            */
4647  0089 e68f          	ldab	OFST+1,s
4648  008b 87            	clra	
4649  008c 59            	lsld	
4650  008d b746          	tfr	d,y
4651  008f 87            	clra	
4652  0090 c7            	clrb	
4653  0091 6cea0000      	std	_OSTCBPrioTbl,y
4654                     ; 120     OSTCBPrioTbl[newprio] =  ptcb;                          /* Place pointer to TCB @ new priority     */
4656  0095 e6f013        	ldab	OFST+5,s
4657  0098 59            	lsld	
4658  0099 b746          	tfr	d,y
4659  009b ec82          	ldd	OFST-12,s
4660  009d 6cea0000      	std	_OSTCBPrioTbl,y
4661                     ; 121     y_old                 =  ptcb->OSTCBY;
4663  00a1 b746          	tfr	d,y
4664  00a3 e6e826        	ldab	38,y
4665  00a6 6b84          	stab	OFST-10,s
4666                     ; 122     bity_old              =  ptcb->OSTCBBitY;
4668  00a8 e6e828        	ldab	40,y
4669  00ab 6b8b          	stab	OFST-3,s
4670                     ; 123     bitx_old              =  ptcb->OSTCBBitX;
4672  00ad e6e827        	ldab	39,y
4673  00b0 6b8a          	stab	OFST-4,s
4674                     ; 124     if ((OSRdyTbl[y_old] &   bitx_old) != 0u) {             /* If task is ready make it not            */
4676  00b2 e684          	ldab	OFST-10,s
4677  00b4 b796          	exg	b,y
4678  00b6 e6ea0000      	ldab	_OSRdyTbl,y
4679  00ba e48a          	andb	OFST-4,s
4680  00bc 272c          	beq	L7613
4681                     ; 125          OSRdyTbl[y_old] &= (OS_PRIO)~bitx_old;
4683  00be e68a          	ldab	OFST-4,s
4684  00c0 51            	comb	
4685  00c1 e4ea0000      	andb	_OSRdyTbl,y
4686  00c5 6bea0000      	stab	_OSRdyTbl,y
4687                     ; 126          if (OSRdyTbl[y_old] == 0u) {
4689  00c9 2609          	bne	L1713
4690                     ; 127              OSRdyGrp &= (OS_PRIO)~bity_old;
4692  00cb e68b          	ldab	OFST-3,s
4693  00cd 51            	comb	
4694  00ce f40000        	andb	_OSRdyGrp
4695  00d1 7b0000        	stab	_OSRdyGrp
4696  00d4               L1713:
4697                     ; 129          OSRdyGrp        |= bity_new;                       /* Make new priority ready to run          */
4699  00d4 e688          	ldab	OFST-6,s
4700  00d6 fa0000        	orab	_OSRdyGrp
4701  00d9 7b0000        	stab	_OSRdyGrp
4702                     ; 130          OSRdyTbl[y_new] |= bitx_new;
4704  00dc e687          	ldab	OFST-7,s
4705  00de b796          	exg	b,y
4706  00e0 e689          	ldab	OFST-5,s
4707  00e2 eaea0000      	orab	_OSRdyTbl,y
4708  00e6 6bea0000      	stab	_OSRdyTbl,y
4710  00ea               L7613:
4711                     ; 135     pevent = ptcb->OSTCBEventPtr;
4713  00ea ed82          	ldy	OFST-12,s
4714  00ec ede812        	ldy	18,y
4715  00ef 6d80          	sty	OFST-14,s
4716                     ; 136     if (pevent != (OS_EVENT *)0) {
4718  00f1 2730          	beq	L3713
4719                     ; 137         pevent->OSEventTbl[y_old] &= (OS_PRIO)~bitx_old;    /* Remove old task prio from wait list     */
4721  00f3 e684          	ldab	OFST-10,s
4722  00f5 19ed          	leay	b,y
4723  00f7 e68a          	ldab	OFST-4,s
4724  00f9 51            	comb	
4725  00fa e446          	andb	6,y
4726  00fc 6b46          	stab	6,y
4727                     ; 138         if (pevent->OSEventTbl[y_old] == 0u) {
4729  00fe ed80          	ldy	OFST-14,s
4730  0100 e684          	ldab	OFST-10,s
4731  0102 19ed          	leay	b,y
4732  0104 e646          	ldab	6,y
4733  0106 2609          	bne	L5713
4734                     ; 139             pevent->OSEventGrp    &= (OS_PRIO)~bity_old;
4736  0108 ed80          	ldy	OFST-14,s
4737  010a e68b          	ldab	OFST-3,s
4738  010c 51            	comb	
4739  010d e445          	andb	5,y
4740  010f 6b45          	stab	5,y
4741  0111               L5713:
4742                     ; 141         pevent->OSEventGrp        |= bity_new;              /* Add    new task prio to   wait list     */
4744  0111 ed80          	ldy	OFST-14,s
4745  0113 e688          	ldab	OFST-6,s
4746  0115 ea45          	orab	5,y
4747  0117 6b45          	stab	5,y
4748                     ; 142         pevent->OSEventTbl[y_new] |= bitx_new;
4750  0119 e687          	ldab	OFST-7,s
4751  011b 19ed          	leay	b,y
4752  011d e689          	ldab	OFST-5,s
4753  011f ea46          	orab	6,y
4754  0121 6b46          	stab	6,y
4755  0123               L3713:
4756                     ; 145     if (ptcb->OSTCBEventMultiPtr != (OS_EVENT **)0) {
4758  0123 ed82          	ldy	OFST-12,s
4759  0125 ece814        	ldd	20,y
4760  0128 273e          	beq	L7713
4761                     ; 146         pevents =  ptcb->OSTCBEventMultiPtr;
4763  012a 6c85          	std	OFST-9,s
4764                     ; 147         pevent  = *pevents;
4766  012c ecf30005      	ldd	[OFST-9,s]
4768  0130 202e          	bra	L5023
4769  0132               L1023:
4770                     ; 149             pevent->OSEventTbl[y_old] &= (OS_PRIO)~bitx_old;   /* Remove old task prio from wait lists */
4772  0132 e684          	ldab	OFST-10,s
4773  0134 19ed          	leay	b,y
4774  0136 e68a          	ldab	OFST-4,s
4775  0138 51            	comb	
4776  0139 e446          	andb	6,y
4777  013b 6b46          	stab	6,y
4778                     ; 150             if (pevent->OSEventTbl[y_old] == 0u) {
4780  013d 2609          	bne	L1123
4781                     ; 151                 pevent->OSEventGrp    &= (OS_PRIO)~bity_old;
4783  013f ed80          	ldy	OFST-14,s
4784  0141 e68b          	ldab	OFST-3,s
4785  0143 51            	comb	
4786  0144 e445          	andb	5,y
4787  0146 6b45          	stab	5,y
4788  0148               L1123:
4789                     ; 153             pevent->OSEventGrp        |= bity_new;          /* Add    new task prio to   wait lists    */
4791  0148 ed80          	ldy	OFST-14,s
4792  014a e688          	ldab	OFST-6,s
4793  014c ea45          	orab	5,y
4794  014e 6b45          	stab	5,y
4795                     ; 154             pevent->OSEventTbl[y_new] |= bitx_new;
4797  0150 e687          	ldab	OFST-7,s
4798  0152 19ed          	leay	b,y
4799  0154 e689          	ldab	OFST-5,s
4800  0156 ea46          	orab	6,y
4801  0158 6b46          	stab	6,y
4802                     ; 155             pevents++;
4804  015a ed85          	ldy	OFST-9,s
4805                     ; 156             pevent                     = *pevents;
4807  015c ec61          	ldd	2,+y
4808  015e 6d85          	sty	OFST-9,s
4809  0160               L5023:
4810  0160 6c80          	std	OFST-14,s
4811                     ; 148         while (pevent != (OS_EVENT *)0) {
4813  0162 ed80          	ldy	OFST-14,s
4814  0164 26cc          	bne	L1023
4815  0166 ed82          	ldy	OFST-12,s
4816  0168               L7713:
4817                     ; 162     ptcb->OSTCBPrio = newprio;                              /* Set new task priority                   */
4819  0168 e6f013        	ldab	OFST+5,s
4820  016b 6be824        	stab	36,y
4821                     ; 163     ptcb->OSTCBY    = y_new;
4823  016e e687          	ldab	OFST-7,s
4824  0170 6be826        	stab	38,y
4825                     ; 164     ptcb->OSTCBX    = x_new;
4827  0173 e68d          	ldab	OFST-1,s
4828  0175 6be825        	stab	37,y
4829                     ; 165     ptcb->OSTCBBitY = bity_new;
4831  0178 e688          	ldab	OFST-6,s
4832  017a 6be828        	stab	40,y
4833                     ; 166     ptcb->OSTCBBitX = bitx_new;
4835  017d e689          	ldab	OFST-5,s
4836  017f 6be827        	stab	39,y
4837                     ; 167     OS_EXIT_CRITICAL();
4839  0182 e68c          	ldab	OFST-2,s
4840  0184 87            	clra	
4841  0185 160000        	jsr	_OS_CPU_SR_Restore
4843                     ; 168     if (OSRunning == OS_TRUE) {
4845  0188 f60000        	ldab	_OSRunning
4846  018b 042103        	dbne	b,L3123
4847                     ; 169         OS_Sched();                                         /* Find new highest priority task          */
4849  018e 160000        	jsr	_OS_Sched
4851  0191               L3123:
4852                     ; 171     return (OS_ERR_NONE);
4854  0191 c7            	clrb	
4856  0192 060013        	bra	L61
4950                     ; 219 _NEAR INT8U  OSTaskCreate (void   (*task)(void *p_arg),
4950                     ; 220                           void    *p_arg,
4950                     ; 221                           OS_STK  *ptos,
4950                     ; 222                           INT8U    prio)
4950                     ; 223 {
4951                     	switch	.text
4952  0195               _OSTaskCreate:
4954  0195 3b            	pshd	
4955  0196 1b9c          	leas	-4,s
4956       00000004      OFST:	set	4
4959                     ; 227     OS_CPU_SR   cpu_sr = 0u;
4961                     ; 240     if (prio > OS_LOWEST_PRIO) {             /* Make sure priority is within allowable range           */
4963  0198 e68d          	ldab	OFST+9,s
4964  019a c13f          	cmpb	#63
4965  019c 2304          	bls	L5523
4966                     ; 241         return (OS_ERR_PRIO_INVALID);
4968  019e c62a          	ldab	#42
4970  01a0 2010          	bra	L22
4971  01a2               L5523:
4972                     ; 244     OS_ENTER_CRITICAL();
4974  01a2 160000        	jsr	_OS_CPU_SR_Save
4976  01a5 6b80          	stab	OFST-4,s
4977                     ; 245     if (OSIntNesting > 0u) {                 /* Make sure we don't create the task from within an ISR  */
4979  01a7 b60000        	ldaa	_OSIntNesting
4980  01aa 2709          	beq	L7523
4981                     ; 246         OS_EXIT_CRITICAL();
4983  01ac 87            	clra	
4984  01ad 160000        	jsr	_OS_CPU_SR_Restore
4986                     ; 247         return (OS_ERR_TASK_CREATE_ISR);
4988  01b0 c63c          	ldab	#60
4990  01b2               L22:
4992  01b2 1b86          	leas	6,s
4993  01b4 3d            	rts	
4994  01b5               L7523:
4995                     ; 249     if (OSTCBPrioTbl[prio] == (OS_TCB *)0) { /* Make sure task doesn't already exist at this priority  */
4997  01b5 e68d          	ldab	OFST+9,s
4998  01b7 59            	lsld	
4999  01b8 b746          	tfr	d,y
5000  01ba ecea0000      	ldd	_OSTCBPrioTbl,y
5001  01be 265b          	bne	L1623
5002                     ; 250         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;/* Reserve the priority to prevent others from doing ...  */
5004  01c0 cc0001        	ldd	#1
5005  01c3 6cea0000      	std	_OSTCBPrioTbl,y
5006                     ; 252         OS_EXIT_CRITICAL();
5008  01c7 e680          	ldab	OFST-4,s
5009  01c9 160000        	jsr	_OS_CPU_SR_Restore
5011                     ; 253         psp = OSTaskStkInit(task, p_arg, ptos, 0u);             /* Initialize the task's stack         */
5013  01cc 87            	clra	
5014  01cd c7            	clrb	
5015  01ce 3b            	pshd	
5016  01cf ec8c          	ldd	OFST+8,s
5017  01d1 3b            	pshd	
5018  01d2 ec8c          	ldd	OFST+8,s
5019  01d4 3b            	pshd	
5020  01d5 ec8a          	ldd	OFST+6,s
5021  01d7 160000        	jsr	_OSTaskStkInit
5023  01da 1b86          	leas	6,s
5024  01dc 6c82          	std	OFST-2,s
5025                     ; 254         err = OS_TCBInit(prio, psp, (OS_STK *)0, 0u, 0u, (void *)0, 0u);
5027  01de 87            	clra	
5028  01df c7            	clrb	
5029  01e0 3b            	pshd	
5030  01e1 3b            	pshd	
5031  01e2 3b            	pshd	
5032  01e3 3b            	pshd	
5033  01e4 3b            	pshd	
5034  01e5 3b            	pshd	
5035  01e6 ec8e          	ldd	OFST+10,s
5036  01e8 3b            	pshd	
5037  01e9 e6f01b        	ldab	OFST+23,s
5038  01ec 87            	clra	
5039  01ed 160000        	jsr	_OS_TCBInit
5041  01f0 1b8e          	leas	14,s
5042  01f2 6b81          	stab	OFST-3,s
5043                     ; 255         if (err == OS_ERR_NONE) {
5045  01f4 260b          	bne	L3623
5046                     ; 257             if (OSRunning == OS_TRUE) {      /* Find highest priority task if multitasking has started */
5049  01f6 f60000        	ldab	_OSRunning
5050  01f9 04211b        	dbne	b,L7623
5051                     ; 258                 OS_Sched();
5053  01fc 160000        	jsr	_OS_Sched
5055  01ff 2016          	bra	L7623
5056  0201               L3623:
5057                     ; 262             OS_ENTER_CRITICAL();
5060  0201 160000        	jsr	_OS_CPU_SR_Save
5062  0204 6b80          	stab	OFST-4,s
5063                     ; 263             OSTCBPrioTbl[prio] = (OS_TCB *)0;/* Make this priority available to others                 */
5065  0206 e68d          	ldab	OFST+9,s
5066  0208 87            	clra	
5067  0209 59            	lsld	
5068  020a b746          	tfr	d,y
5069  020c 87            	clra	
5070  020d c7            	clrb	
5071  020e 6cea0000      	std	_OSTCBPrioTbl,y
5072                     ; 264             OS_EXIT_CRITICAL();
5074  0212 e680          	ldab	OFST-4,s
5075  0214 160000        	jsr	_OS_CPU_SR_Restore
5077  0217               L7623:
5078                     ; 266         return (err);
5080  0217 e681          	ldab	OFST-3,s
5082  0219 2008          	bra	L42
5083  021b               L1623:
5084                     ; 268     OS_EXIT_CRITICAL();
5086  021b e680          	ldab	OFST-4,s
5087  021d 87            	clra	
5088  021e 160000        	jsr	_OS_CPU_SR_Restore
5090                     ; 269     return (OS_ERR_PRIO_EXIST);
5092  0221 c628          	ldab	#40
5094  0223               L42:
5096  0223 1b86          	leas	6,s
5097  0225 3d            	rts	
5233                     ; 347 _NEAR INT8U  OSTaskCreateExt (void   (*task)(void *p_arg),
5233                     ; 348                              void    *p_arg,
5233                     ; 349                              OS_STK  *ptos,
5233                     ; 350                              INT8U    prio,
5233                     ; 351                              INT16U   id,
5233                     ; 352                              OS_STK  *pbos,
5233                     ; 353                              INT32U   stk_size,
5233                     ; 354                              void    *pext,
5233                     ; 355                              INT16U   opt)
5233                     ; 356 {
5234                     	switch	.text
5235  0226               _OSTaskCreateExt:
5237  0226 3b            	pshd	
5238  0227 1b9c          	leas	-4,s
5239       00000004      OFST:	set	4
5242                     ; 360     OS_CPU_SR   cpu_sr = 0u;
5244                     ; 373     if (prio > OS_LOWEST_PRIO) {             /* Make sure priority is within allowable range           */
5246  0229 e68d          	ldab	OFST+9,s
5247  022b c13f          	cmpb	#63
5248  022d 2304          	bls	L7433
5249                     ; 374         return (OS_ERR_PRIO_INVALID);
5251  022f c62a          	ldab	#42
5253  0231 2010          	bra	L03
5254  0233               L7433:
5255                     ; 377     OS_ENTER_CRITICAL();
5257  0233 160000        	jsr	_OS_CPU_SR_Save
5259  0236 6b80          	stab	OFST-4,s
5260                     ; 378     if (OSIntNesting > 0u) {                 /* Make sure we don't create the task from within an ISR  */
5262  0238 b60000        	ldaa	_OSIntNesting
5263  023b 2709          	beq	L1533
5264                     ; 379         OS_EXIT_CRITICAL();
5266  023d 87            	clra	
5267  023e 160000        	jsr	_OS_CPU_SR_Restore
5269                     ; 380         return (OS_ERR_TASK_CREATE_ISR);
5271  0241 c63c          	ldab	#60
5273  0243               L03:
5275  0243 1b86          	leas	6,s
5276  0245 3d            	rts	
5277  0246               L1533:
5278                     ; 382     if (OSTCBPrioTbl[prio] == (OS_TCB *)0) { /* Make sure task doesn't already exist at this priority  */
5280  0246 e68d          	ldab	OFST+9,s
5281  0248 59            	lsld	
5282  0249 b746          	tfr	d,y
5283  024b ecea0000      	ldd	_OSTCBPrioTbl,y
5284  024f 18260080      	bne	L3533
5285                     ; 383         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;/* Reserve the priority to prevent others from doing ...  */
5287  0253 cc0001        	ldd	#1
5288  0256 6cea0000      	std	_OSTCBPrioTbl,y
5289                     ; 385         OS_EXIT_CRITICAL();
5291  025a e680          	ldab	OFST-4,s
5292  025c 160000        	jsr	_OS_CPU_SR_Restore
5294                     ; 388         OS_TaskStkClr(pbos, stk_size, opt);                    /* Clear the task stack (if needed)     */
5296  025f ecf018        	ldd	OFST+20,s
5297  0262 3b            	pshd	
5298  0263 ecf016        	ldd	OFST+18,s
5299  0266 3b            	pshd	
5300  0267 ecf016        	ldd	OFST+18,s
5301  026a 3b            	pshd	
5302  026b ecf016        	ldd	OFST+18,s
5303  026e 1607a3        	jsr	_OS_TaskStkClr
5305  0271 1b86          	leas	6,s
5306                     ; 391         psp = OSTaskStkInit(task, p_arg, ptos, opt);           /* Initialize the task's stack          */
5308  0273 ecf018        	ldd	OFST+20,s
5309  0276 3b            	pshd	
5310  0277 ec8c          	ldd	OFST+8,s
5311  0279 3b            	pshd	
5312  027a ec8c          	ldd	OFST+8,s
5313  027c 3b            	pshd	
5314  027d ec8a          	ldd	OFST+6,s
5315  027f 160000        	jsr	_OSTaskStkInit
5317  0282 1b86          	leas	6,s
5318  0284 6c82          	std	OFST-2,s
5319                     ; 392         err = OS_TCBInit(prio, psp, pbos, id, stk_size, pext, opt);
5321  0286 ecf018        	ldd	OFST+20,s
5322  0289 3b            	pshd	
5323  028a ecf018        	ldd	OFST+20,s
5324  028d 3b            	pshd	
5325  028e ecf018        	ldd	OFST+20,s
5326  0291 3b            	pshd	
5327  0292 ecf018        	ldd	OFST+20,s
5328  0295 3b            	pshd	
5329  0296 ecf016        	ldd	OFST+18,s
5330  0299 3b            	pshd	
5331  029a ecf01a        	ldd	OFST+22,s
5332  029d 3b            	pshd	
5333  029e ec8e          	ldd	OFST+10,s
5334  02a0 3b            	pshd	
5335  02a1 e6f01b        	ldab	OFST+23,s
5336  02a4 87            	clra	
5337  02a5 160000        	jsr	_OS_TCBInit
5339  02a8 1b8e          	leas	14,s
5340  02aa 6b81          	stab	OFST-3,s
5341                     ; 393         if (err == OS_ERR_NONE) {
5343  02ac 260b          	bne	L5533
5344                     ; 395             if (OSRunning == OS_TRUE) {                        /* Find HPT if multitasking has started */
5347  02ae f60000        	ldab	_OSRunning
5348  02b1 04211b        	dbne	b,L1633
5349                     ; 396                 OS_Sched();
5351  02b4 160000        	jsr	_OS_Sched
5353  02b7 2016          	bra	L1633
5354  02b9               L5533:
5355                     ; 399             OS_ENTER_CRITICAL();
5357  02b9 160000        	jsr	_OS_CPU_SR_Save
5359  02bc 6b80          	stab	OFST-4,s
5360                     ; 400             OSTCBPrioTbl[prio] = (OS_TCB *)0;                  /* Make this priority avail. to others  */
5362  02be e68d          	ldab	OFST+9,s
5363  02c0 87            	clra	
5364  02c1 59            	lsld	
5365  02c2 b746          	tfr	d,y
5366  02c4 87            	clra	
5367  02c5 c7            	clrb	
5368  02c6 6cea0000      	std	_OSTCBPrioTbl,y
5369                     ; 401             OS_EXIT_CRITICAL();
5371  02ca e680          	ldab	OFST-4,s
5372  02cc 160000        	jsr	_OS_CPU_SR_Restore
5374  02cf               L1633:
5375                     ; 403         return (err);
5377  02cf e681          	ldab	OFST-3,s
5379  02d1 2008          	bra	L23
5380  02d3               L3533:
5381                     ; 405     OS_EXIT_CRITICAL();
5383  02d3 e680          	ldab	OFST-4,s
5384  02d5 87            	clra	
5385  02d6 160000        	jsr	_OS_CPU_SR_Restore
5387                     ; 406     return (OS_ERR_PRIO_EXIST);
5389  02d9 c628          	ldab	#40
5391  02db               L23:
5393  02db 1b86          	leas	6,s
5394  02dd 3d            	rts	
5474                     ; 450 _NEAR INT8U  OSTaskDel (INT8U prio)
5474                     ; 451 {
5475                     	switch	.text
5476  02de               _OSTaskDel:
5478  02de 3b            	pshd	
5479  02df 1b9b          	leas	-5,s
5480       00000005      OFST:	set	5
5483                     ; 457     OS_CPU_SR     cpu_sr = 0u;
5485                     ; 469     if (OSIntNesting > 0u) {                            /* See if trying to delete from ISR            */
5487  02e1 f60000        	ldab	_OSIntNesting
5488  02e4 2704          	beq	L5143
5489                     ; 470         return (OS_ERR_TASK_DEL_ISR);
5491  02e6 c640          	ldab	#64
5493  02e8 2008          	bra	L63
5494  02ea               L5143:
5495                     ; 472     if (prio == OS_TASK_IDLE_PRIO) {                    /* Not allowed to delete idle task             */
5497  02ea e686          	ldab	OFST+1,s
5498  02ec c13f          	cmpb	#63
5499  02ee 2605          	bne	L7143
5500                     ; 473         return (OS_ERR_TASK_DEL_IDLE);
5502  02f0 c63e          	ldab	#62
5504  02f2               L63:
5506  02f2 1b87          	leas	7,s
5507  02f4 3d            	rts	
5508  02f5               L7143:
5509                     ; 476     if (prio >= OS_LOWEST_PRIO) {                       /* Task priority valid ?                       */
5511  02f5 2507          	blo	L1243
5512                     ; 477         if (prio != OS_PRIO_SELF) {
5514  02f7 048104        	ibeq	b,L1243
5515                     ; 478             return (OS_ERR_PRIO_INVALID);
5517  02fa c62a          	ldab	#42
5519  02fc 20f4          	bra	L63
5520  02fe               L1243:
5521                     ; 483     OS_ENTER_CRITICAL();
5523  02fe 160000        	jsr	_OS_CPU_SR_Save
5525  0301 6b82          	stab	OFST-3,s
5526                     ; 484     if (prio == OS_PRIO_SELF) {                         /* See if requesting to delete self            */
5528  0303 e686          	ldab	OFST+1,s
5529  0305 c1ff          	cmpb	#255
5530  0307 2608          	bne	L5243
5531                     ; 485         prio = OSTCBCur->OSTCBPrio;                     /* Set priority to delete to current           */
5533  0309 fd0000        	ldy	_OSTCBCur
5534  030c e6e824        	ldab	36,y
5535  030f 6b86          	stab	OFST+1,s
5536  0311               L5243:
5537                     ; 487     ptcb = OSTCBPrioTbl[prio];
5539  0311 87            	clra	
5540  0312 59            	lsld	
5541  0313 b746          	tfr	d,y
5542  0315 ecea0000      	ldd	_OSTCBPrioTbl,y
5543  0319 6c80          	std	OFST-5,s
5544                     ; 488     if (ptcb == (OS_TCB *)0) {                          /* Task to delete must exist                   */
5546  031b 2609          	bne	L7243
5547                     ; 489         OS_EXIT_CRITICAL();
5549  031d e682          	ldab	OFST-3,s
5550  031f 160000        	jsr	_OS_CPU_SR_Restore
5552                     ; 490         return (OS_ERR_TASK_NOT_EXIST);
5554  0322 c643          	ldab	#67
5556  0324 20cc          	bra	L63
5557  0326               L7243:
5558                     ; 492     if (ptcb == OS_TCB_RESERVED) {                      /* Must not be assigned to Mutex               */
5560  0326 8c0001        	cpd	#1
5561  0329 260a          	bne	L1343
5562                     ; 493         OS_EXIT_CRITICAL();
5564  032b e682          	ldab	OFST-3,s
5565  032d 87            	clra	
5566  032e 160000        	jsr	_OS_CPU_SR_Restore
5568                     ; 494         return (OS_ERR_TASK_DEL);
5570  0331 c63d          	ldab	#61
5572  0333 20bd          	bra	L63
5573  0335               L1343:
5574                     ; 497     OSRdyTbl[ptcb->OSTCBY] &= (OS_PRIO)~ptcb->OSTCBBitX;
5576  0335 b746          	tfr	d,y
5577  0337 e6e826        	ldab	38,y
5578  033a b796          	exg	b,y
5579  033c ee80          	ldx	OFST-5,s
5580  033e e6e027        	ldab	39,x
5581  0341 51            	comb	
5582  0342 e4ea0000      	andb	_OSRdyTbl,y
5583  0346 6bea0000      	stab	_OSRdyTbl,y
5584                     ; 499     if (OSRdyTbl[ptcb->OSTCBY] == 0u) {                 /* Make task not ready                         */
5587  034a 260c          	bne	L3343
5588                     ; 500         OSRdyGrp           &= (OS_PRIO)~ptcb->OSTCBBitY;
5590  034c b756          	tfr	x,y
5591  034e e6e828        	ldab	40,y
5592  0351 51            	comb	
5593  0352 f40000        	andb	_OSRdyGrp
5594  0355 7b0000        	stab	_OSRdyGrp
5595  0358               L3343:
5596                     ; 504     if (ptcb->OSTCBEventPtr != (OS_EVENT *)0) {
5598  0358 b756          	tfr	x,y
5599  035a ece812        	ldd	18,y
5600  035d 270a          	beq	L5343
5601                     ; 505         OS_EventTaskRemove(ptcb, ptcb->OSTCBEventPtr);  /* Remove this task from any event   wait list */
5603  035f 3b            	pshd	
5604  0360 b754          	tfr	x,d
5605  0362 160000        	jsr	_OS_EventTaskRemove
5607  0365 1b82          	leas	2,s
5608  0367 ed80          	ldy	OFST-5,s
5609  0369               L5343:
5610                     ; 508     if (ptcb->OSTCBEventMultiPtr != (OS_EVENT **)0) {   /* Remove this task from any events' wait lists*/
5612  0369 ece814        	ldd	20,y
5613  036c 270a          	beq	L7343
5614                     ; 509         OS_EventTaskRemoveMulti(ptcb, ptcb->OSTCBEventMultiPtr);
5616  036e 3b            	pshd	
5617  036f ec82          	ldd	OFST-3,s
5618  0371 160000        	jsr	_OS_EventTaskRemoveMulti
5620  0374 1b82          	leas	2,s
5621  0376 ed80          	ldy	OFST-5,s
5622  0378               L7343:
5623                     ; 515     pnode = ptcb->OSTCBFlagNode;
5625  0378 ece81a        	ldd	26,y
5626  037b 6c83          	std	OFST-2,s
5627                     ; 516     if (pnode != (OS_FLAG_NODE *)0) {                   /* If task is waiting on event flag            */
5629  037d 2705          	beq	L1443
5630                     ; 517         OS_FlagUnlink(pnode);                           /* Remove from wait list                       */
5632  037f 160000        	jsr	_OS_FlagUnlink
5634  0382 ed80          	ldy	OFST-5,s
5635  0384               L1443:
5636                     ; 521     ptcb->OSTCBDly      = 0u;                           /* Prevent OSTimeTick() from updating          */
5638  0384 87            	clra	
5639  0385 c7            	clrb	
5640  0386 6ce820        	std	32,y
5641  0389 6ce81e        	std	30,y
5642                     ; 522     ptcb->OSTCBStat     = OS_STAT_RDY;                  /* Prevent task from being resumed             */
5644                     ; 523     ptcb->OSTCBStatPend = OS_STAT_PEND_OK;
5646  038c 6ce822        	std	34,y
5647                     ; 524     if (OSLockNesting < 255u) {                         /* Make sure we don't context switch           */
5649  038f f60000        	ldab	_OSLockNesting
5650  0392 c1ff          	cmpb	#255
5651  0394 2403          	bhs	L3443
5652                     ; 525         OSLockNesting++;
5654  0396 720000        	inc	_OSLockNesting
5655  0399               L3443:
5656                     ; 527     OS_EXIT_CRITICAL();                                 /* Enabling INT. ignores next instruc.         */
5658  0399 e682          	ldab	OFST-3,s
5659  039b 87            	clra	
5660  039c 160000        	jsr	_OS_CPU_SR_Restore
5662                     ; 528     OS_Dummy();                                         /* ... Dummy ensures that INTs will be         */
5664  039f 160000        	jsr	_OS_Dummy
5666                     ; 529     OS_ENTER_CRITICAL();                                /* ... disabled HERE!                          */
5668  03a2 160000        	jsr	_OS_CPU_SR_Save
5670  03a5 6b82          	stab	OFST-3,s
5671                     ; 530     if (OSLockNesting > 0u) {                           /* Remove context switch lock                  */
5673  03a7 f70000        	tst	_OSLockNesting
5674  03aa 2703          	beq	L5443
5675                     ; 531         OSLockNesting--;
5677  03ac 730000        	dec	_OSLockNesting
5678  03af               L5443:
5679                     ; 533     OSTaskDelHook(ptcb);                                /* Call user defined hook                      */
5681  03af ec80          	ldd	OFST-5,s
5682  03b1 160000        	jsr	_OSTaskDelHook
5684                     ; 541     OSTaskCtr--;                                        /* One less task being managed                 */
5686  03b4 730000        	dec	_OSTaskCtr
5687                     ; 542     OSTCBPrioTbl[prio] = (OS_TCB *)0;                   /* Clear old priority entry                    */
5689  03b7 e686          	ldab	OFST+1,s
5690  03b9 87            	clra	
5691  03ba 59            	lsld	
5692  03bb b746          	tfr	d,y
5693  03bd 87            	clra	
5694  03be c7            	clrb	
5695  03bf 6cea0000      	std	_OSTCBPrioTbl,y
5696                     ; 543     if (ptcb->OSTCBPrev == (OS_TCB *)0) {               /* Remove from TCB chain                       */
5698  03c3 ed80          	ldy	OFST-5,s
5699  03c5 eee810        	ldx	16,y
5700  03c8 260e          	bne	L7443
5701                     ; 544         ptcb->OSTCBNext->OSTCBPrev = (OS_TCB *)0;
5703  03ca ed4e          	ldy	14,y
5704  03cc 6ce810        	std	16,y
5705                     ; 545         OSTCBList                  = ptcb->OSTCBNext;
5707  03cf ed80          	ldy	OFST-5,s
5708  03d1 18054e0000    	movw	14,y,_OSTCBList
5710  03d6 2012          	bra	L1543
5711  03d8               L7443:
5712                     ; 547         ptcb->OSTCBPrev->OSTCBNext = ptcb->OSTCBNext;
5714  03d8 18024e0e      	movw	14,y,14,x
5715                     ; 548         ptcb->OSTCBNext->OSTCBPrev = ptcb->OSTCBPrev;
5717  03dc ee4e          	ldx	14,y
5718  03de 1ae010        	leax	16,x
5719  03e1 19e810        	leay	16,y
5720  03e4 18024000      	movw	0,y,0,x
5721  03e8 ed80          	ldy	OFST-5,s
5722  03ea               L1543:
5723                     ; 550     ptcb->OSTCBNext     = OSTCBFreeList;                /* Return TCB to free TCB list                 */
5725  03ea 18014e0000    	movw	_OSTCBFreeList,14,y
5726                     ; 551     OSTCBFreeList       = ptcb;
5728  03ef 7d0000        	sty	_OSTCBFreeList
5729                     ; 553     ptcb->OSTCBTaskName = (INT8U *)(void *)"?";
5731  03f2 cc0000        	ldd	#L3543
5732  03f5 6ce83c        	std	60,y
5733                     ; 555     OS_EXIT_CRITICAL();
5735  03f8 e682          	ldab	OFST-3,s
5736  03fa 87            	clra	
5737  03fb 160000        	jsr	_OS_CPU_SR_Restore
5739                     ; 556     if (OSRunning == OS_TRUE) {
5741  03fe f60000        	ldab	_OSRunning
5742  0401 042103        	dbne	b,L5543
5743                     ; 557         OS_Sched();                                     /* Find new highest priority task              */
5745  0404 160000        	jsr	_OS_Sched
5747  0407               L5543:
5748                     ; 559     return (OS_ERR_NONE);
5750  0407 c7            	clrb	
5753  0408 1b87          	leas	7,s
5754  040a 3d            	rts	
5815                     ; 613 _NEAR INT8U  OSTaskDelReq (INT8U prio)
5815                     ; 614 {
5816                     	switch	.text
5817  040b               _OSTaskDelReq:
5819  040b 3b            	pshd	
5820  040c 1b9c          	leas	-4,s
5821       00000004      OFST:	set	4
5824                     ; 618     OS_CPU_SR  cpu_sr = 0u;
5826                     ; 630     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to delete idle task     */
5828  040e c13f          	cmpb	#63
5829  0410 2604          	bne	L5053
5830                     ; 631         return (OS_ERR_TASK_DEL_IDLE);
5832  0412 c63e          	ldab	#62
5834  0414 200c          	bra	L24
5835  0416               L5053:
5836                     ; 634     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
5838  0416 e685          	ldab	OFST+1,s
5839  0418 c13f          	cmpb	#63
5840  041a 2509          	blo	L7053
5841                     ; 635         if (prio != OS_PRIO_SELF) {
5843  041c c1ff          	cmpb	#255
5844  041e 2705          	beq	L7053
5845                     ; 636             return (OS_ERR_PRIO_INVALID);
5847  0420 c62a          	ldab	#42
5849  0422               L24:
5851  0422 1b86          	leas	6,s
5852  0424 3d            	rts	
5853  0425               L7053:
5854                     ; 640     if (prio == OS_PRIO_SELF) {                                 /* See if a task is requesting to ...  */
5856  0425 04a117        	ibne	b,L3153
5857                     ; 641         OS_ENTER_CRITICAL();                                    /* ... this task to delete itself      */
5859  0428 160000        	jsr	_OS_CPU_SR_Save
5861  042b 6b80          	stab	OFST-4,s
5862                     ; 642         stat = OSTCBCur->OSTCBDelReq;                           /* Return request status to caller     */
5864  042d fd0000        	ldy	_OSTCBCur
5865  0430 e6e829        	ldab	41,y
5866  0433 6b83          	stab	OFST-1,s
5867                     ; 643         OS_EXIT_CRITICAL();
5869  0435 e680          	ldab	OFST-4,s
5870  0437 87            	clra	
5871  0438 160000        	jsr	_OS_CPU_SR_Restore
5873                     ; 644         return (stat);
5875  043b e683          	ldab	OFST-1,s
5877  043d 20e3          	bra	L24
5878  043f               L3153:
5879                     ; 646     OS_ENTER_CRITICAL();
5881  043f 160000        	jsr	_OS_CPU_SR_Save
5883  0442 6b80          	stab	OFST-4,s
5884                     ; 647     ptcb = OSTCBPrioTbl[prio];
5886  0444 e685          	ldab	OFST+1,s
5887  0446 87            	clra	
5888  0447 59            	lsld	
5889  0448 b746          	tfr	d,y
5890  044a ecea0000      	ldd	_OSTCBPrioTbl,y
5891  044e 6c81          	std	OFST-3,s
5892                     ; 648     if (ptcb == (OS_TCB *)0) {                                  /* Task to delete must exist           */
5894  0450 2609          	bne	L5153
5895                     ; 649         OS_EXIT_CRITICAL();
5897  0452 e680          	ldab	OFST-4,s
5898  0454 160000        	jsr	_OS_CPU_SR_Restore
5900                     ; 650         return (OS_ERR_TASK_NOT_EXIST);                         /* Task must already be deleted        */
5902  0457 c643          	ldab	#67
5904  0459 20c7          	bra	L24
5905  045b               L5153:
5906                     ; 652     if (ptcb == OS_TCB_RESERVED) {                              /* Must NOT be assigned to a Mutex     */
5908  045b 042409        	dbne	d,L7153
5909                     ; 653         OS_EXIT_CRITICAL();
5911  045e e680          	ldab	OFST-4,s
5912  0460 160000        	jsr	_OS_CPU_SR_Restore
5914                     ; 654         return (OS_ERR_TASK_DEL);
5916  0463 c63d          	ldab	#61
5918  0465 20bb          	bra	L24
5919  0467               L7153:
5920                     ; 656     ptcb->OSTCBDelReq = OS_ERR_TASK_DEL_REQ;                    /* Set flag indicating task to be DEL. */
5922  0467 c63f          	ldab	#63
5923  0469 ee81          	ldx	OFST-3,s
5924  046b 6be029        	stab	41,x
5925                     ; 657     OS_EXIT_CRITICAL();
5927  046e e680          	ldab	OFST-4,s
5928  0470 87            	clra	
5929  0471 160000        	jsr	_OS_CPU_SR_Restore
5931                     ; 658     return (OS_ERR_NONE);
5933  0474 c7            	clrb	
5935  0475 20ab          	bra	L24
6019                     ; 688 _NEAR INT8U  OSTaskNameGet (INT8U    prio,
6019                     ; 689                            INT8U  **pname,
6019                     ; 690                            INT8U   *perr)
6019                     ; 691 {
6020                     	switch	.text
6021  0477               _OSTaskNameGet:
6023  0477 3b            	pshd	
6024  0478 1b9c          	leas	-4,s
6025       00000004      OFST:	set	4
6028                     ; 695     OS_CPU_SR  cpu_sr = 0u;
6030                     ; 708     if (prio > OS_LOWEST_PRIO) {                         /* Task priority valid ?                      */
6032  047a c13f          	cmpb	#63
6033  047c 2307          	bls	L7553
6034                     ; 709         if (prio != OS_PRIO_SELF) {
6036  047e 048104        	ibeq	b,L7553
6037                     ; 710             *perr = OS_ERR_PRIO_INVALID;                 /* No                                         */
6039  0481 c62a          	ldab	#42
6040                     ; 711             return (0u);
6043  0483 2006          	bra	LC002
6044  0485               L7553:
6045                     ; 714     if (pname == (INT8U **)0) {                          /* Is 'pname' a NULL pointer?                 */
6047  0485 ec88          	ldd	OFST+4,s
6048  0487 260a          	bne	L3653
6049                     ; 715         *perr = OS_ERR_PNAME_NULL;                       /* Yes                                        */
6051  0489 c60c          	ldab	#12
6052                     ; 716         return (0u);
6054  048b               LC002:
6055  048b 6bf3000a      	stab	[OFST+6,s]
6056  048f c7            	clrb	
6058  0490               L64:
6060  0490 1b86          	leas	6,s
6061  0492 3d            	rts	
6062  0493               L3653:
6063                     ; 719     if (OSIntNesting > 0u) {                              /* See if trying to call from an ISR          */
6065  0493 f60000        	ldab	_OSIntNesting
6066  0496 2704          	beq	L5653
6067                     ; 720         *perr = OS_ERR_NAME_GET_ISR;
6069  0498 c611          	ldab	#17
6070                     ; 721         return (0u);
6073  049a 20ef          	bra	LC002
6074  049c               L5653:
6075                     ; 723     OS_ENTER_CRITICAL();
6077  049c 160000        	jsr	_OS_CPU_SR_Save
6079  049f 6b80          	stab	OFST-4,s
6080                     ; 724     if (prio == OS_PRIO_SELF) {                          /* See if caller desires it's own name        */
6082  04a1 e685          	ldab	OFST+1,s
6083  04a3 c1ff          	cmpb	#255
6084  04a5 2608          	bne	L7653
6085                     ; 725         prio = OSTCBCur->OSTCBPrio;
6087  04a7 fd0000        	ldy	_OSTCBCur
6088  04aa e6e824        	ldab	36,y
6089  04ad 6b85          	stab	OFST+1,s
6090  04af               L7653:
6091                     ; 727     ptcb = OSTCBPrioTbl[prio];
6093  04af 87            	clra	
6094  04b0 59            	lsld	
6095  04b1 b746          	tfr	d,y
6096  04b3 ecea0000      	ldd	_OSTCBPrioTbl,y
6097  04b7 6c81          	std	OFST-3,s
6098                     ; 728     if (ptcb == (OS_TCB *)0) {                           /* Does task exist?                           */
6100  04b9 260a          	bne	L1753
6101                     ; 729         OS_EXIT_CRITICAL();                              /* No                                         */
6104                     ; 730         *perr = OS_ERR_TASK_NOT_EXIST;
6106  04bb               LC003:
6107  04bb e680          	ldab	OFST-4,s
6108  04bd 87            	clra	
6109  04be 160000        	jsr	_OS_CPU_SR_Restore
6110  04c1 c643          	ldab	#67
6111                     ; 731         return (0u);
6114  04c3 20c6          	bra	LC002
6115  04c5               L1753:
6116                     ; 733     if (ptcb == OS_TCB_RESERVED) {                       /* Task assigned to a Mutex?                  */
6118  04c5 8c0001        	cpd	#1
6119                     ; 734         OS_EXIT_CRITICAL();                              /* Yes                                        */
6122                     ; 735         *perr = OS_ERR_TASK_NOT_EXIST;
6124                     ; 736         return (0u);
6127  04c8 27f1          	beq	LC003
6128                     ; 738     *pname = ptcb->OSTCBTaskName;
6130  04ca b746          	tfr	d,y
6131  04cc ece83c        	ldd	60,y
6132  04cf ee88          	ldx	OFST+4,s
6133  04d1 6c00          	std	0,x
6134                     ; 739     len    = OS_StrLen(*pname);
6136  04d3 160000        	jsr	_OS_StrLen
6138  04d6 6b83          	stab	OFST-1,s
6139                     ; 740     OS_EXIT_CRITICAL();
6141  04d8 e680          	ldab	OFST-4,s
6142  04da 87            	clra	
6143  04db 160000        	jsr	_OS_CPU_SR_Restore
6145                     ; 741     *perr  = OS_ERR_NONE;
6147  04de 69f3000a      	clr	[OFST+6,s]
6148                     ; 742     return (len);
6150  04e2 e683          	ldab	OFST-1,s
6152  04e4 20aa          	bra	L64
6227                     ; 770 _NEAR void  OSTaskNameSet (INT8U   prio,
6227                     ; 771                           INT8U  *pname,
6227                     ; 772                           INT8U  *perr)
6227                     ; 773 {
6228                     	switch	.text
6229  04e6               _OSTaskNameSet:
6231  04e6 3b            	pshd	
6232  04e7 1b9d          	leas	-3,s
6233       00000003      OFST:	set	3
6236                     ; 776     OS_CPU_SR  cpu_sr = 0u;
6238                     ; 789     if (prio > OS_LOWEST_PRIO) {                     /* Task priority valid ?                          */
6240  04e9 c13f          	cmpb	#63
6241  04eb 2307          	bls	L1363
6242                     ; 790         if (prio != OS_PRIO_SELF) {
6244  04ed 048104        	ibeq	b,L1363
6245                     ; 791             *perr = OS_ERR_PRIO_INVALID;             /* No                                             */
6247  04f0 c62a          	ldab	#42
6248                     ; 792             return;
6250  04f2 2006          	bra	LC004
6251  04f4               L1363:
6252                     ; 795     if (pname == (INT8U *)0) {                       /* Is 'pname' a NULL pointer?                     */
6254  04f4 ec87          	ldd	OFST+4,s
6255  04f6 2609          	bne	L5363
6256                     ; 796         *perr = OS_ERR_PNAME_NULL;                   /* Yes                                            */
6258  04f8 c60c          	ldab	#12
6259  04fa               LC004:
6260  04fa 6bf30009      	stab	[OFST+6,s]
6261                     ; 797         return;
6262  04fe               L25:
6265  04fe 1b85          	leas	5,s
6266  0500 3d            	rts	
6267  0501               L5363:
6268                     ; 800     if (OSIntNesting > 0u) {                         /* See if trying to call from an ISR              */
6270  0501 f60000        	ldab	_OSIntNesting
6271  0504 2704          	beq	L7363
6272                     ; 801         *perr = OS_ERR_NAME_SET_ISR;
6274  0506 c612          	ldab	#18
6275                     ; 802         return;
6277  0508 20f0          	bra	LC004
6278  050a               L7363:
6279                     ; 804     OS_ENTER_CRITICAL();
6281  050a 160000        	jsr	_OS_CPU_SR_Save
6283  050d 6b80          	stab	OFST-3,s
6284                     ; 805     if (prio == OS_PRIO_SELF) {                      /* See if caller desires to set it's own name     */
6286  050f e684          	ldab	OFST+1,s
6287  0511 c1ff          	cmpb	#255
6288  0513 2608          	bne	L1463
6289                     ; 806         prio = OSTCBCur->OSTCBPrio;
6291  0515 fd0000        	ldy	_OSTCBCur
6292  0518 e6e824        	ldab	36,y
6293  051b 6b84          	stab	OFST+1,s
6294  051d               L1463:
6295                     ; 808     ptcb = OSTCBPrioTbl[prio];
6297  051d 87            	clra	
6298  051e 59            	lsld	
6299  051f b746          	tfr	d,y
6300  0521 ecea0000      	ldd	_OSTCBPrioTbl,y
6301  0525 6c81          	std	OFST-2,s
6302                     ; 809     if (ptcb == (OS_TCB *)0) {                       /* Does task exist?                               */
6304  0527 260a          	bne	L3463
6305                     ; 810         OS_EXIT_CRITICAL();                          /* No                                             */
6308                     ; 811         *perr = OS_ERR_TASK_NOT_EXIST;
6310  0529               LC005:
6311  0529 e680          	ldab	OFST-3,s
6312  052b 87            	clra	
6313  052c 160000        	jsr	_OS_CPU_SR_Restore
6314  052f c643          	ldab	#67
6315                     ; 812         return;
6317  0531 20c7          	bra	LC004
6318  0533               L3463:
6319                     ; 814     if (ptcb == OS_TCB_RESERVED) {                   /* Task assigned to a Mutex?                      */
6321  0533 8c0001        	cpd	#1
6322                     ; 815         OS_EXIT_CRITICAL();                          /* Yes                                            */
6325                     ; 816         *perr = OS_ERR_TASK_NOT_EXIST;
6327                     ; 817         return;
6329  0536 27f1          	beq	LC005
6330                     ; 819     ptcb->OSTCBTaskName = pname;
6332  0538 ec87          	ldd	OFST+4,s
6333  053a ee81          	ldx	OFST-2,s
6334  053c 6ce03c        	std	60,x
6335                     ; 821     OS_EXIT_CRITICAL();
6338  053f e680          	ldab	OFST-3,s
6339  0541 87            	clra	
6340  0542 160000        	jsr	_OS_CPU_SR_Restore
6342                     ; 822     *perr               = OS_ERR_NONE;
6344  0545 69f30009      	clr	[OFST+6,s]
6345                     ; 823 }
6347  0549 20b3          	bra	L25
6404                     ; 846 _NEAR INT8U  OSTaskResume (INT8U prio)
6404                     ; 847 {
6405                     	switch	.text
6406  054b               _OSTaskResume:
6408  054b 3b            	pshd	
6409  054c 1b9d          	leas	-3,s
6410       00000003      OFST:	set	3
6413                     ; 850     OS_CPU_SR  cpu_sr = 0u;
6415                     ; 856     if (prio >= OS_LOWEST_PRIO) {                             /* Make sure task priority is valid      */
6417  054e c13f          	cmpb	#63
6418  0550 2504          	blo	L3763
6419                     ; 857         return (OS_ERR_PRIO_INVALID);
6421  0552 c62a          	ldab	#42
6423  0554 201a          	bra	L06
6424  0556               L3763:
6425                     ; 860     OS_ENTER_CRITICAL();
6427  0556 160000        	jsr	_OS_CPU_SR_Save
6429  0559 6b82          	stab	OFST-1,s
6430                     ; 861     ptcb = OSTCBPrioTbl[prio];
6432  055b e684          	ldab	OFST+1,s
6433  055d 87            	clra	
6434  055e 59            	lsld	
6435  055f b746          	tfr	d,y
6436  0561 ecea0000      	ldd	_OSTCBPrioTbl,y
6437  0565 6c80          	std	OFST-3,s
6438                     ; 862     if (ptcb == (OS_TCB *)0) {                                /* Task to suspend must exist            */
6440  0567 260a          	bne	L5763
6441                     ; 863         OS_EXIT_CRITICAL();
6443  0569 e682          	ldab	OFST-1,s
6444  056b 160000        	jsr	_OS_CPU_SR_Restore
6446                     ; 864         return (OS_ERR_TASK_RESUME_PRIO);
6448  056e c646          	ldab	#70
6450  0570               L06:
6452  0570 1b85          	leas	5,s
6453  0572 3d            	rts	
6454  0573               L5763:
6455                     ; 866     if (ptcb == OS_TCB_RESERVED) {                            /* See if assigned to Mutex              */
6457  0573 8c0001        	cpd	#1
6458  0576 260a          	bne	L7763
6459                     ; 867         OS_EXIT_CRITICAL();
6461  0578 e682          	ldab	OFST-1,s
6462  057a 87            	clra	
6463  057b 160000        	jsr	_OS_CPU_SR_Restore
6465                     ; 868         return (OS_ERR_TASK_NOT_EXIST);
6467  057e c643          	ldab	#67
6469  0580 20ee          	bra	L06
6470  0582               L7763:
6471                     ; 870     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) != OS_STAT_RDY) { /* Task must be suspended                */
6473  0582 b746          	tfr	d,y
6474  0584 0fe8220849    	brclr	34,y,8,L1073
6475                     ; 871         ptcb->OSTCBStat &= (INT8U)~(INT8U)OS_STAT_SUSPEND;    /* Remove suspension                     */
6477  0589 0de82208      	bclr	34,y,8
6478                     ; 872         if ((ptcb->OSTCBStat & OS_STAT_PEND_ANY) == OS_STAT_RDY) { /* See if task is now ready         */
6480  058d e6e822        	ldab	34,y
6481  0590 c537          	bitb	#55
6482  0592 2635          	bne	L5073
6483                     ; 873             if (ptcb->OSTCBDly == 0u) {
6485  0594 ece81e        	ldd	30,y
6486  0597 2630          	bne	L5073
6487  0599 ece820        	ldd	32,y
6488  059c 262b          	bne	L5073
6489                     ; 874                 OSRdyGrp               |= ptcb->OSTCBBitY;    /* Yes, Make task ready to run           */
6491  059e e6e828        	ldab	40,y
6492  05a1 fa0000        	orab	_OSRdyGrp
6493  05a4 7b0000        	stab	_OSRdyGrp
6494                     ; 875                 OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
6496  05a7 e6e826        	ldab	38,y
6497  05aa b746          	tfr	d,y
6498  05ac ee80          	ldx	OFST-3,s
6499  05ae e6e027        	ldab	39,x
6500  05b1 eaea0000      	orab	_OSRdyTbl,y
6501  05b5 6bea0000      	stab	_OSRdyTbl,y
6502                     ; 877                 OS_EXIT_CRITICAL();
6505  05b9 e682          	ldab	OFST-1,s
6506  05bb 160000        	jsr	_OS_CPU_SR_Restore
6508                     ; 878                 if (OSRunning == OS_TRUE) {
6510  05be f60000        	ldab	_OSRunning
6511  05c1 04210b        	dbne	b,L3173
6512                     ; 880                     OS_Sched();                               /* Find new highest priority task        */
6515  05c4 160000        	jsr	_OS_Sched
6517  05c7 2006          	bra	L3173
6518  05c9               L5073:
6519                     ; 883                 OS_EXIT_CRITICAL();
6522                     ; 886             OS_EXIT_CRITICAL();
6524  05c9 e682          	ldab	OFST-1,s
6525  05cb 87            	clra	
6526  05cc 160000        	jsr	_OS_CPU_SR_Restore
6528  05cf               L3173:
6529                     ; 888         return (OS_ERR_NONE);
6531  05cf c7            	clrb	
6533  05d0 2008          	bra	L26
6534  05d2               L1073:
6535                     ; 890     OS_EXIT_CRITICAL();
6537  05d2 e682          	ldab	OFST-1,s
6538  05d4 87            	clra	
6539  05d5 160000        	jsr	_OS_CPU_SR_Restore
6541                     ; 891     return (OS_ERR_TASK_NOT_SUSPENDED);
6543  05d8 c644          	ldab	#68
6545  05da               L26:
6547  05da 1b85          	leas	5,s
6548  05dc 3d            	rts	
6659                     ; 916 _NEAR INT8U  OSTaskStkChk (INT8U         prio,
6659                     ; 917                           OS_STK_DATA  *p_stk_data)
6659                     ; 918 {
6660                     	switch	.text
6661  05dd               _OSTaskStkChk:
6663  05dd 3b            	pshd	
6664  05de 1b95          	leas	-11,s
6665       0000000b      OFST:	set	11
6668                     ; 924     OS_CPU_SR  cpu_sr = 0u;
6670                     ; 930     if (prio > OS_LOWEST_PRIO) {                       /* Make sure task priority is valid             */
6672  05e0 c13f          	cmpb	#63
6673  05e2 2307          	bls	L7673
6674                     ; 931         if (prio != OS_PRIO_SELF) {
6676  05e4 048104        	ibeq	b,L7673
6677                     ; 932             return (OS_ERR_PRIO_INVALID);
6679  05e7 c62a          	ldab	#42
6681  05e9 2006          	bra	L07
6682  05eb               L7673:
6683                     ; 935     if (p_stk_data == (OS_STK_DATA *)0) {              /* Validate 'p_stk_data'                        */
6685  05eb ed8f          	ldy	OFST+4,s
6686  05ed 2605          	bne	L3773
6687                     ; 936         return (OS_ERR_PDATA_NULL);
6689  05ef c609          	ldab	#9
6691  05f1               L07:
6693  05f1 1b8d          	leas	13,s
6694  05f3 3d            	rts	
6695  05f4               L3773:
6696                     ; 939     p_stk_data->OSFree = 0u;                           /* Assume failure, set to 0 size                */
6698  05f4 87            	clra	
6699  05f5 c7            	clrb	
6700  05f6 6c42          	std	2,y
6701  05f8 6c40          	std	0,y
6702                     ; 940     p_stk_data->OSUsed = 0u;
6704  05fa 6c46          	std	6,y
6705  05fc 6c44          	std	4,y
6706                     ; 941     OS_ENTER_CRITICAL();
6708  05fe 160000        	jsr	_OS_CPU_SR_Save
6710  0601 6b86          	stab	OFST-5,s
6711                     ; 942     if (prio == OS_PRIO_SELF) {                        /* See if check for SELF                        */
6713  0603 e68c          	ldab	OFST+1,s
6714  0605 c1ff          	cmpb	#255
6715  0607 2608          	bne	L5773
6716                     ; 943         prio = OSTCBCur->OSTCBPrio;
6718  0609 fd0000        	ldy	_OSTCBCur
6719  060c e6e824        	ldab	36,y
6720  060f 6b8c          	stab	OFST+1,s
6721  0611               L5773:
6722                     ; 945     ptcb = OSTCBPrioTbl[prio];
6724  0611 87            	clra	
6725  0612 59            	lsld	
6726  0613 b746          	tfr	d,y
6727  0615 ecea0000      	ldd	_OSTCBPrioTbl,y
6728  0619 6c80          	std	OFST-11,s
6729                     ; 946     if (ptcb == (OS_TCB *)0) {                         /* Make sure task exist                         */
6731  061b 2609          	bne	L7773
6732                     ; 947         OS_EXIT_CRITICAL();
6734  061d e686          	ldab	OFST-5,s
6735  061f 160000        	jsr	_OS_CPU_SR_Restore
6737                     ; 948         return (OS_ERR_TASK_NOT_EXIST);
6739  0622 c643          	ldab	#67
6741  0624 20cb          	bra	L07
6742  0626               L7773:
6743                     ; 950     if (ptcb == OS_TCB_RESERVED) {
6745  0626 8c0001        	cpd	#1
6746  0629 260a          	bne	L1004
6747                     ; 951         OS_EXIT_CRITICAL();
6749  062b e686          	ldab	OFST-5,s
6750  062d 87            	clra	
6751  062e 160000        	jsr	_OS_CPU_SR_Restore
6753                     ; 952         return (OS_ERR_TASK_NOT_EXIST);
6755  0631 c643          	ldab	#67
6757  0633 20bc          	bra	L07
6758  0635               L1004:
6759                     ; 954     if ((ptcb->OSTCBOpt & OS_TASK_OPT_STK_CHK) == 0u) { /* Make sure stack checking option is set      */
6761  0635 b746          	tfr	d,y
6762  0637 0e4b010a      	brset	11,y,1,L3004
6763                     ; 955         OS_EXIT_CRITICAL();
6765  063b e686          	ldab	OFST-5,s
6766  063d 87            	clra	
6767  063e 160000        	jsr	_OS_CPU_SR_Restore
6769                     ; 956         return (OS_ERR_TASK_OPT);
6771  0641 c645          	ldab	#69
6773  0643 20ac          	bra	L07
6774  0645               L3004:
6775                     ; 958     nfree = 0u;
6777  0645 87            	clra	
6778  0646 c7            	clrb	
6779  0647 6c84          	std	OFST-7,s
6780  0649 6c82          	std	OFST-9,s
6781                     ; 959     size  = ptcb->OSTCBStkSize;
6783  064b 18024889      	movw	8,y,OFST-2,s
6784  064f 18024687      	movw	6,y,OFST-4,s
6785                     ; 960     pchk  = ptcb->OSTCBStkBottom;
6787  0653 18024480      	movw	4,y,OFST-11,s
6788                     ; 961     OS_EXIT_CRITICAL();
6790  0657 e686          	ldab	OFST-5,s
6791  0659 160000        	jsr	_OS_CPU_SR_Restore
6794  065c ed80          	ldy	OFST-11,s
6795  065e 200f          	bra	L66
6796  0660               L5004:
6797                     ; 964         nfree++;
6799  0660 ec84          	ldd	OFST-7,s
6800  0662 c30001        	addd	#1
6801  0665 6c84          	std	OFST-7,s
6802  0667 2406          	bcc	L66
6803  0669 6283          	inc	OFST-8,s
6804  066b 2602          	bne	L66
6805  066d 6282          	inc	OFST-9,s
6806  066f               L66:
6807                     ; 963     while (*pchk++ == (OS_STK)0) {                    /* Compute the number of zero entries on the stk */
6809  066f e670          	ldab	1,y+
6810  0671 6d80          	sty	OFST-11,s
6811  0673 0451ea        	tbeq	b,L5004
6812                     ; 971     p_stk_data->OSFree = nfree;                       /* Store   number of free entries on the stk     */
6814  0676 ed8f          	ldy	OFST+4,s
6815  0678 18028442      	movw	OFST-7,s,2,y
6816  067c 18028240      	movw	OFST-9,s,0,y
6817                     ; 972     p_stk_data->OSUsed = size - nfree;                /* Compute number of entries used on the stk     */
6819  0680 ec89          	ldd	OFST-2,s
6820  0682 ee87          	ldx	OFST-4,s
6821  0684 1982          	leay	OFST-9,s
6822  0686 160000        	jsr	c_lsub
6824  0689 ed8f          	ldy	OFST+4,s
6825  068b 6c46          	std	6,y
6826  068d 6e44          	stx	4,y
6827                     ; 973     return (OS_ERR_NONE);
6829  068f c7            	clrb	
6832  0690 1b8d          	leas	13,s
6833  0692 3d            	rts	
6904                     ; 1002 _NEAR INT8U  OSTaskSuspend (INT8U prio)
6904                     ; 1003 {
6905                     	switch	.text
6906  0693               _OSTaskSuspend:
6908  0693 3b            	pshd	
6909  0694 1b9b          	leas	-5,s
6910       00000005      OFST:	set	5
6913                     ; 1008     OS_CPU_SR  cpu_sr = 0u;
6915                     ; 1014     if (prio == OS_TASK_IDLE_PRIO) {                            /* Not allowed to suspend idle task    */
6917  0696 c13f          	cmpb	#63
6918  0698 2604          	bne	L3404
6919                     ; 1015         return (OS_ERR_TASK_SUSPEND_IDLE);
6921  069a c647          	ldab	#71
6923  069c 200b          	bra	L47
6924  069e               L3404:
6925                     ; 1017     if (prio >= OS_LOWEST_PRIO) {                               /* Task priority valid ?               */
6927  069e e686          	ldab	OFST+1,s
6928  06a0 c13f          	cmpb	#63
6929  06a2 2508          	blo	L5404
6930                     ; 1018         if (prio != OS_PRIO_SELF) {
6932  06a4 048105        	ibeq	b,L5404
6933                     ; 1019             return (OS_ERR_PRIO_INVALID);
6935  06a7 c62a          	ldab	#42
6937  06a9               L47:
6939  06a9 1b87          	leas	7,s
6940  06ab 3d            	rts	
6941  06ac               L5404:
6942                     ; 1023     OS_ENTER_CRITICAL();
6944  06ac 160000        	jsr	_OS_CPU_SR_Save
6946  06af 6b82          	stab	OFST-3,s
6947                     ; 1024     if (prio == OS_PRIO_SELF) {                                 /* See if suspend SELF                 */
6949  06b1 e686          	ldab	OFST+1,s
6950  06b3 c1ff          	cmpb	#255
6951  06b5 260a          	bne	L1504
6952                     ; 1025         prio = OSTCBCur->OSTCBPrio;
6954  06b7 fd0000        	ldy	_OSTCBCur
6955  06ba e6e824        	ldab	36,y
6956  06bd 6b86          	stab	OFST+1,s
6957                     ; 1026         self = OS_TRUE;
6960  06bf 2008          	bra	LC007
6961  06c1               L1504:
6962                     ; 1027     } else if (prio == OSTCBCur->OSTCBPrio) {                   /* See if suspending self              */
6964  06c1 fd0000        	ldy	_OSTCBCur
6965  06c4 e1e824        	cmpb	36,y
6966  06c7 2608          	bne	L5504
6967                     ; 1028         self = OS_TRUE;
6969  06c9               LC007:
6970  06c9 c601          	ldab	#1
6971  06cb 6b83          	stab	OFST-2,s
6973  06cd e686          	ldab	OFST+1,s
6974  06cf 2002          	bra	L3504
6975  06d1               L5504:
6976                     ; 1030         self = OS_FALSE;                                        /* No suspending another task          */
6978  06d1 6983          	clr	OFST-2,s
6979  06d3               L3504:
6980                     ; 1032     ptcb = OSTCBPrioTbl[prio];
6982  06d3 87            	clra	
6983  06d4 59            	lsld	
6984  06d5 b746          	tfr	d,y
6985  06d7 ecea0000      	ldd	_OSTCBPrioTbl,y
6986  06db 6c80          	std	OFST-5,s
6987                     ; 1033     if (ptcb == (OS_TCB *)0) {                                  /* Task to suspend must exist          */
6989  06dd 2609          	bne	L1604
6990                     ; 1034         OS_EXIT_CRITICAL();
6992  06df e682          	ldab	OFST-3,s
6993  06e1 160000        	jsr	_OS_CPU_SR_Restore
6995                     ; 1035         return (OS_ERR_TASK_SUSPEND_PRIO);
6997  06e4 c648          	ldab	#72
6999  06e6 20c1          	bra	L47
7000  06e8               L1604:
7001                     ; 1037     if (ptcb == OS_TCB_RESERVED) {                              /* See if assigned to Mutex            */
7003  06e8 8c0001        	cpd	#1
7004  06eb 260a          	bne	L3604
7005                     ; 1038         OS_EXIT_CRITICAL();
7007  06ed e682          	ldab	OFST-3,s
7008  06ef 87            	clra	
7009  06f0 160000        	jsr	_OS_CPU_SR_Restore
7011                     ; 1039         return (OS_ERR_TASK_NOT_EXIST);
7013  06f3 c643          	ldab	#67
7015  06f5 20b2          	bra	L47
7016  06f7               L3604:
7017                     ; 1041     y            = ptcb->OSTCBY;
7019  06f7 b746          	tfr	d,y
7020  06f9 e6e826        	ldab	38,y
7021  06fc 6b84          	stab	OFST-1,s
7022                     ; 1042     OSRdyTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;                   /* Make task not ready                 */
7024  06fe b796          	exg	b,y
7025  0700 ee80          	ldx	OFST-5,s
7026  0702 e6e027        	ldab	39,x
7027  0705 51            	comb	
7028  0706 e4ea0000      	andb	_OSRdyTbl,y
7029  070a 6bea0000      	stab	_OSRdyTbl,y
7030                     ; 1043     if (OSRdyTbl[y] == 0u) {
7032  070e 260c          	bne	L5604
7033                     ; 1044         OSRdyGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
7035  0710 b756          	tfr	x,y
7036  0712 e6e828        	ldab	40,y
7037  0715 51            	comb	
7038  0716 f40000        	andb	_OSRdyGrp
7039  0719 7b0000        	stab	_OSRdyGrp
7040  071c               L5604:
7041                     ; 1046     ptcb->OSTCBStat |= OS_STAT_SUSPEND;                         /* Status of task is 'SUSPENDED'       */
7043  071c b756          	tfr	x,y
7044  071e 0ce82208      	bset	34,y,8
7045                     ; 1047     OS_EXIT_CRITICAL();
7047  0722 e682          	ldab	OFST-3,s
7048  0724 87            	clra	
7049  0725 160000        	jsr	_OS_CPU_SR_Restore
7051                     ; 1050     if (self == OS_TRUE) {                                      /* Context switch only if SELF         */
7055  0728 e683          	ldab	OFST-2,s
7056  072a 042103        	dbne	b,L7604
7057                     ; 1051         OS_Sched();                                             /* Find new highest priority task      */
7059  072d 160000        	jsr	_OS_Sched
7061  0730               L7604:
7062                     ; 1053     return (OS_ERR_NONE);
7064  0730 c7            	clrb	
7067  0731 1b87          	leas	7,s
7068  0733 3d            	rts	
7135                     ; 1078 _NEAR INT8U  OSTaskQuery (INT8U    prio,
7135                     ; 1079                          OS_TCB  *p_task_data)
7135                     ; 1080 {
7136                     	switch	.text
7137  0734               _OSTaskQuery:
7139  0734 3b            	pshd	
7140  0735 1b9d          	leas	-3,s
7141       00000003      OFST:	set	3
7144                     ; 1083     OS_CPU_SR  cpu_sr = 0u;
7146                     ; 1089     if (prio > OS_LOWEST_PRIO) {                 /* Task priority valid ?                              */
7148  0737 c13f          	cmpb	#63
7149  0739 2307          	bls	L3214
7150                     ; 1090         if (prio != OS_PRIO_SELF) {
7152  073b 048104        	ibeq	b,L3214
7153                     ; 1091             return (OS_ERR_PRIO_INVALID);
7155  073e c62a          	ldab	#42
7157  0740 2006          	bra	L001
7158  0742               L3214:
7159                     ; 1094     if (p_task_data == (OS_TCB *)0) {            /* Validate 'p_task_data'                             */
7161  0742 ec87          	ldd	OFST+4,s
7162  0744 2605          	bne	L7214
7163                     ; 1095         return (OS_ERR_PDATA_NULL);
7165  0746 c609          	ldab	#9
7167  0748               L001:
7169  0748 1b85          	leas	5,s
7170  074a 3d            	rts	
7171  074b               L7214:
7172                     ; 1098     OS_ENTER_CRITICAL();
7174  074b 160000        	jsr	_OS_CPU_SR_Save
7176  074e 6b80          	stab	OFST-3,s
7177                     ; 1099     if (prio == OS_PRIO_SELF) {                  /* See if suspend SELF                                */
7179  0750 e684          	ldab	OFST+1,s
7180  0752 c1ff          	cmpb	#255
7181  0754 2608          	bne	L1314
7182                     ; 1100         prio = OSTCBCur->OSTCBPrio;
7184  0756 fd0000        	ldy	_OSTCBCur
7185  0759 e6e824        	ldab	36,y
7186  075c 6b84          	stab	OFST+1,s
7187  075e               L1314:
7188                     ; 1102     ptcb = OSTCBPrioTbl[prio];
7190  075e 87            	clra	
7191  075f 59            	lsld	
7192  0760 b746          	tfr	d,y
7193  0762 ecea0000      	ldd	_OSTCBPrioTbl,y
7194  0766 6c81          	std	OFST-2,s
7195                     ; 1103     if (ptcb == (OS_TCB *)0) {                   /* Task to query must exist                           */
7197  0768 2609          	bne	L3314
7198                     ; 1104         OS_EXIT_CRITICAL();
7200  076a e680          	ldab	OFST-3,s
7201  076c 160000        	jsr	_OS_CPU_SR_Restore
7203                     ; 1105         return (OS_ERR_PRIO);
7205  076f c629          	ldab	#41
7207  0771 20d5          	bra	L001
7208  0773               L3314:
7209                     ; 1107     if (ptcb == OS_TCB_RESERVED) {               /* Task to query must not be assigned to a Mutex      */
7211  0773 042409        	dbne	d,L5314
7212                     ; 1108         OS_EXIT_CRITICAL();
7214  0776 e680          	ldab	OFST-3,s
7215  0778 160000        	jsr	_OS_CPU_SR_Restore
7217                     ; 1109         return (OS_ERR_TASK_NOT_EXIST);
7219  077b c643          	ldab	#67
7221  077d 20c9          	bra	L001
7222  077f               L5314:
7223                     ; 1112     OS_MemCopy((INT8U *)p_task_data, (INT8U *)ptcb, sizeof(OS_TCB));
7225  077f cc003e        	ldd	#62
7226  0782 3b            	pshd	
7227  0783 ec83          	ldd	OFST+0,s
7228  0785 3b            	pshd	
7229  0786 ec8b          	ldd	OFST+8,s
7230  0788 160000        	jsr	_OS_MemCopy
7232  078b 1b84          	leas	4,s
7233                     ; 1113     OS_EXIT_CRITICAL();
7235  078d e680          	ldab	OFST-3,s
7236  078f 87            	clra	
7237  0790 160000        	jsr	_OS_CPU_SR_Restore
7239                     ; 1114     return (OS_ERR_NONE);
7241  0793 c7            	clrb	
7243  0794 20b2          	bra	L001
7268                     ; 1327 _NEAR void  OS_TaskReturn (void)
7268                     ; 1328 {
7269                     	switch	.text
7270  0796               _OS_TaskReturn:
7274                     ; 1329     OSTaskReturnHook(OSTCBCur);                   /* Call hook to let user decide on what to do        */
7276  0796 fc0000        	ldd	_OSTCBCur
7277  0799 160000        	jsr	_OSTaskReturnHook
7279                     ; 1332     (void)OSTaskDel(OS_PRIO_SELF);                /* Delete task if it accidentally returns!           */
7281  079c cc00ff        	ldd	#255
7282  079f 1602de        	jsr	_OSTaskDel
7284                     ; 1338 }
7287  07a2 3d            	rts	
7335                     ; 1364 _NEAR void  OS_TaskStkClr (OS_STK  *pbos,
7335                     ; 1365                      INT32U   size,
7335                     ; 1366                      INT16U   opt)
7335                     ; 1367 {
7336                     	switch	.text
7337  07a3               _OS_TaskStkClr:
7339  07a3 3b            	pshd	
7340       00000000      OFST:	set	0
7343                     ; 1368     if ((opt & OS_TASK_OPT_STK_CHK) != 0x0000u) {      /* See if stack checking has been enabled       */
7345  07a4 e689          	ldab	OFST+9,s
7346  07a6 c501          	bitb	#1
7347  07a8 2723          	beq	L1714
7348                     ; 1369         if ((opt & OS_TASK_OPT_STK_CLR) != 0x0000u) {  /* See if stack needs to be cleared             */
7350  07aa c502          	bitb	#2
7351  07ac 271f          	beq	L1714
7353  07ae 2015          	bra	L7714
7354  07b0               L5714:
7355                     ; 1372                 size--;
7357  07b0 ec86          	ldd	OFST+6,s
7358  07b2 830001        	subd	#1
7359  07b5 6c86          	std	OFST+6,s
7360  07b7 ec84          	ldd	OFST+4,s
7361  07b9 c200          	sbcb	#0
7362  07bb 8200          	sbca	#0
7363  07bd 6c84          	std	OFST+4,s
7364                     ; 1373                 *pbos++ = (OS_STK)0;                   /* Clear from bottom of stack and up!           */
7366  07bf ed80          	ldy	OFST+0,s
7367  07c1 6970          	clr	1,y+
7368  07c3 6d80          	sty	OFST+0,s
7369  07c5               L7714:
7370                     ; 1371             while (size > 0u) {                        /* Stack grows from HIGH to LOW memory          */
7372  07c5 ec84          	ldd	OFST+4,s
7373  07c7 26e7          	bne	L5714
7374  07c9 ec86          	ldd	OFST+6,s
7375  07cb 26e3          	bne	L5714
7376  07cd               L1714:
7377                     ; 1383 }
7380  07cd 31            	puly	
7381  07ce 3d            	rts	
7393                     	xref	_OSTaskStkInit
7394                     	xref	_OSTaskReturnHook
7395                     	xref	_OSTaskDelHook
7396                     	xref	_OS_TCBInit
7397                     	xdef	_OS_TaskStkClr
7398                     	xdef	_OS_TaskReturn
7399                     	xref	_OS_StrLen
7400                     	xref	_OS_Sched
7401                     	xref	_OS_MemCopy
7402                     	xref	_OS_FlagUnlink
7403                     	xref	_OS_EventTaskRemoveMulti
7404                     	xref	_OS_EventTaskRemove
7405                     	xref	_OS_Dummy
7406                     	xdef	_OSTaskQuery
7407                     	xdef	_OSTaskStkChk
7408                     	xdef	_OSTaskSuspend
7409                     	xdef	_OSTaskResume
7410                     	xdef	_OSTaskNameSet
7411                     	xdef	_OSTaskNameGet
7412                     	xdef	_OSTaskDelReq
7413                     	xdef	_OSTaskDel
7414                     	xdef	_OSTaskCreateExt
7415                     	xdef	_OSTaskCreate
7416                     	xdef	_OSTaskChangePrio
7417                     	xref	_OSTCBPrioTbl
7418                     	xref	_OSTCBList
7419                     	xref	_OSTCBFreeList
7420                     	xref	_OSTCBCur
7421                     	xref	_OSTaskCtr
7422                     	xref	_OSRunning
7423                     	xref	_OSRdyTbl
7424                     	xref	_OSRdyGrp
7425                     	xref	_OSLockNesting
7426                     	xref	_OSIntNesting
7427                     	xref	_OS_CPU_SR_Restore
7428                     	xref	_OS_CPU_SR_Save
7429                     .const:	section	.data
7430  0000               L3543:
7431  0000 3f00          	dc.b	"?",0
7452                     	xref	c_lsub
7453                     	end

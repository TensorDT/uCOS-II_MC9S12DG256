   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4163                     .const:	section	.data
4164                     	even
4165  0000               L6:
4166  0000 00000001      	dc.l	1
4167                     ; 70 _NEAR OS_MEM  *OSMemCreate (void   *addr,
4167                     ; 71                            INT32U  nblks,
4167                     ; 72                            INT32U  blksize,
4167                     ; 73                            INT8U  *perr)
4167                     ; 74 {
4168                     	switch	.text
4169  0000               _OSMemCreate:
4171  0000 3b            	pshd	
4172  0001 1b91          	leas	-15,s
4173       0000000f      OFST:	set	15
4176                     ; 81     OS_CPU_SR  cpu_sr = 0u;
4178                     ; 102     if (addr == (void *)0) {                          /* Must pass a valid address for the memory part.*/
4180  0003 046402        	tbne	d,L3572
4181                     ; 103         *perr = OS_ERR_MEM_INVALID_ADDR;
4183                     ; 104         return ((OS_MEM *)0);
4186  0006 2005          	bra	LC002
4187  0008               L3572:
4188                     ; 106     if (((INT32U)addr & (sizeof(void *) - 1u)) != 0u){  /* Must be pointer size aligned                */
4190  0008 0ff010010c    	brclr	OFST+1,s,1,L5572
4191                     ; 107         *perr = OS_ERR_MEM_INVALID_ADDR;
4193  000d               LC002:
4194  000d c662          	ldab	#98
4195                     ; 108         return ((OS_MEM *)0);
4197  000f               LC001:
4198  000f 6bf3001b      	stab	[OFST+12,s]
4199  0013 87            	clra	
4200  0014 c7            	clrb	
4202  0015               L21:
4204  0015 1bf011        	leas	17,s
4205  0018 3d            	rts	
4206  0019               L5572:
4207                     ; 110     if (nblks < 2u) {                                 /* Must have at least 2 blocks per partition     */
4209  0019 ecf015        	ldd	OFST+6,s
4210  001c 8c0002        	cpd	#2
4211  001f ecf013        	ldd	OFST+4,s
4212  0022 c200          	sbcb	#0
4213  0024 8200          	sbca	#0
4214  0026 2404          	bhs	L7572
4215                     ; 111         *perr = OS_ERR_MEM_INVALID_BLKS;
4217  0028 c65b          	ldab	#91
4218                     ; 112         return ((OS_MEM *)0);
4221  002a 20e3          	bra	LC001
4222  002c               L7572:
4223                     ; 114     if (blksize < sizeof(void *)) {                   /* Must contain space for at least a pointer     */
4225  002c ecf019        	ldd	OFST+10,s
4226  002f 8c0002        	cpd	#2
4227  0032 ecf017        	ldd	OFST+8,s
4228  0035 c200          	sbcb	#0
4229  0037 8200          	sbca	#0
4230  0039 2404          	bhs	L1672
4231                     ; 115         *perr = OS_ERR_MEM_INVALID_SIZE;
4233  003b c65c          	ldab	#92
4234                     ; 116         return ((OS_MEM *)0);
4237  003d 20d0          	bra	LC001
4238  003f               L1672:
4239                     ; 119     OS_ENTER_CRITICAL();
4241  003f 160000        	jsr	_OS_CPU_SR_Save
4243  0042 6b8e          	stab	OFST-1,s
4244                     ; 120     pmem = OSMemFreeList;                             /* Get next free memory partition                */
4246  0044 fd0000        	ldy	_OSMemFreeList
4247  0047 6d82          	sty	OFST-13,s
4248                     ; 121     if (OSMemFreeList != (OS_MEM *)0) {               /* See if pool of free partitions was empty      */
4250  0049 2705          	beq	L3672
4251                     ; 122         OSMemFreeList = (OS_MEM *)OSMemFreeList->OSMemFreeList;
4253  004b 1805420000    	movw	2,y,_OSMemFreeList
4254  0050               L3672:
4255                     ; 124     OS_EXIT_CRITICAL();
4257  0050 87            	clra	
4258  0051 160000        	jsr	_OS_CPU_SR_Restore
4260                     ; 125     if (pmem == (OS_MEM *)0) {                        /* See if we have a memory partition             */
4262  0054 ec82          	ldd	OFST-13,s
4263  0056 2604          	bne	L5672
4264                     ; 126         *perr = OS_ERR_MEM_INVALID_PART;
4266  0058 c65a          	ldab	#90
4267                     ; 127         return ((OS_MEM *)0);
4270  005a 20b3          	bra	LC001
4271  005c               L5672:
4272                     ; 129     plink = (void **)addr;                            /* Create linked list of free memory blocks      */
4274  005c ec8f          	ldd	OFST+0,s
4275  005e 6c84          	std	OFST-11,s
4276                     ; 130     pblk  = (INT8U *)addr;
4278  0060 6c80          	std	OFST-15,s
4279                     ; 131     loops  = nblks - 1u;
4281  0062 ecf015        	ldd	OFST+6,s
4282  0065 eef013        	ldx	OFST+4,s
4283  0068 cd0000        	ldy	#L6
4284  006b 160000        	jsr	c_lsub
4286  006e 6c8c          	std	OFST-3,s
4287  0070 6e8a          	stx	OFST-5,s
4288                     ; 132     for (i = 0u; i < loops; i++) {
4290  0072 87            	clra	
4291  0073 c7            	clrb	
4292  0074 6c88          	std	OFST-7,s
4293  0076 6c86          	std	OFST-9,s
4295  0078 2022          	bra	L01
4296  007a               L7672:
4297                     ; 133         pblk +=  blksize;                             /* Point to the FOLLOWING block                  */
4299  007a ec80          	ldd	OFST-15,s
4300  007c ce0000        	ldx	#0
4301  007f 19f017        	leay	OFST+8,s
4302  0082 160000        	jsr	c_ladd
4304  0085 6c80          	std	OFST-15,s
4305                     ; 134        *plink = (void  *)pblk;                        /* Save pointer to NEXT block in CURRENT block   */
4307  0087 6cf30004      	std	[OFST-11,s]
4308                     ; 135         plink = (void **)pblk;                        /* Position to  NEXT      block                  */
4310  008b 6c84          	std	OFST-11,s
4311                     ; 132     for (i = 0u; i < loops; i++) {
4313  008d ec88          	ldd	OFST-7,s
4314  008f c30001        	addd	#1
4315  0092 6c88          	std	OFST-7,s
4316  0094 2406          	bcc	L01
4317  0096 6287          	inc	OFST-8,s
4318  0098 2602          	bne	L01
4319  009a 6286          	inc	OFST-9,s
4320  009c               L01:
4323  009c ac8c          	cpd	OFST-3,s
4324  009e ec86          	ldd	OFST-9,s
4325  00a0 e28b          	sbcb	OFST-4,s
4326  00a2 a28a          	sbca	OFST-5,s
4327  00a4 25d4          	blo	L7672
4328                     ; 137     *plink              = (void *)0;                  /* Last memory block points to NULL              */
4330  00a6 87            	clra	
4331  00a7 c7            	clrb	
4332  00a8 6cf30004      	std	[OFST-11,s]
4333                     ; 138     pmem->OSMemAddr     = addr;                       /* Store start address of memory partition       */
4335  00ac ec8f          	ldd	OFST+0,s
4336  00ae ed82          	ldy	OFST-13,s
4337  00b0 6c40          	std	0,y
4338                     ; 139     pmem->OSMemFreeList = addr;                       /* Initialize pointer to pool of free blocks     */
4340  00b2 6c42          	std	2,y
4341                     ; 140     pmem->OSMemNFree    = nblks;                      /* Store number of free blocks in MCB            */
4343  00b4 ecf015        	ldd	OFST+6,s
4344  00b7 6c4e          	std	14,y
4345  00b9 ecf013        	ldd	OFST+4,s
4346  00bc 6c4c          	std	12,y
4347                     ; 141     pmem->OSMemNBlks    = nblks;
4349  00be ecf015        	ldd	OFST+6,s
4350  00c1 6c4a          	std	10,y
4351  00c3 ecf013        	ldd	OFST+4,s
4352  00c6 6c48          	std	8,y
4353                     ; 142     pmem->OSMemBlkSize  = blksize;                    /* Store block size of each memory blocks        */
4355  00c8 ecf019        	ldd	OFST+10,s
4356  00cb 6c46          	std	6,y
4357  00cd ecf017        	ldd	OFST+8,s
4358  00d0 6c44          	std	4,y
4359                     ; 146     *perr               = OS_ERR_NONE;
4362  00d2 69f3001b      	clr	[OFST+12,s]
4363                     ; 147     return (pmem);
4365  00d6 b764          	tfr	y,d
4367  00d8 060015        	bra	L21
4433                     ; 171 _NEAR void  *OSMemGet (OS_MEM  *pmem,
4433                     ; 172                       INT8U   *perr)
4433                     ; 173 {
4434                     	switch	.text
4435  00db               _OSMemGet:
4437  00db 3b            	pshd	
4438  00dc 1b9d          	leas	-3,s
4439       00000003      OFST:	set	3
4442                     ; 176     OS_CPU_SR  cpu_sr = 0u;
4444                     ; 188     if (pmem == (OS_MEM *)0) {                        /* Must point to a valid memory partition        */
4446  00de 046404        	tbne	d,L1303
4447                     ; 189         *perr = OS_ERR_MEM_INVALID_PMEM;
4449  00e1 c660          	ldab	#96
4450                     ; 190         return ((void *)0);
4453  00e3 203c          	bra	LC004
4454  00e5               L1303:
4455                     ; 196     OS_ENTER_CRITICAL();
4458  00e5 160000        	jsr	_OS_CPU_SR_Save
4460  00e8 6b80          	stab	OFST-3,s
4461                     ; 197     if (pmem->OSMemNFree > 0u) {                      /* See if there are any free memory blocks       */
4463  00ea ed83          	ldy	OFST+0,s
4464  00ec ec4c          	ldd	12,y
4465  00ee 2604          	bne	LC003
4466  00f0 ec4e          	ldd	14,y
4467  00f2 2726          	beq	L3303
4468  00f4               LC003:
4469                     ; 198         pblk                = pmem->OSMemFreeList;    /* Yes, point to next free memory block          */
4471  00f4 ee42          	ldx	2,y
4472  00f6 6e81          	stx	OFST-2,s
4473                     ; 199         pmem->OSMemFreeList = *(void **)pblk;         /*      Adjust pointer to new free list          */
4475  00f8 18020042      	movw	0,x,2,y
4476                     ; 200         pmem->OSMemNFree--;                           /*      One less memory block in this partition  */
4478  00fc ec4e          	ldd	14,y
4479  00fe 830001        	subd	#1
4480  0101 6c4e          	std	14,y
4481  0103 ec4c          	ldd	12,y
4482  0105 c200          	sbcb	#0
4483  0107 8200          	sbca	#0
4484  0109 6c4c          	std	12,y
4485                     ; 201         OS_EXIT_CRITICAL();
4487  010b e680          	ldab	OFST-3,s
4488  010d 87            	clra	
4489  010e 160000        	jsr	_OS_CPU_SR_Restore
4491                     ; 202         *perr = OS_ERR_NONE;                          /*      No error                                 */
4493  0111 69f30007      	clr	[OFST+4,s]
4494                     ; 204         return (pblk);                                /*      Return memory block to caller            */
4497  0115 ec81          	ldd	OFST-2,s
4499  0117               L02:
4501  0117 1b85          	leas	5,s
4502  0119 3d            	rts	
4503  011a               L3303:
4504                     ; 206     OS_EXIT_CRITICAL();
4506  011a e680          	ldab	OFST-3,s
4507  011c 160000        	jsr	_OS_CPU_SR_Restore
4509                     ; 207     *perr = OS_ERR_MEM_NO_FREE_BLKS;                  /* No,  Notify caller of empty memory partition  */
4511  011f c65d          	ldab	#93
4512                     ; 209     return ((void *)0);                               /*      Return NULL pointer to caller            */
4515  0121               LC004:
4516  0121 6bf30007      	stab	[OFST+4,s]
4517  0125 87            	clra	
4518  0126 c7            	clrb	
4520  0127 20ee          	bra	L02
4595                     ; 235 _NEAR INT8U  OSMemNameGet (OS_MEM   *pmem,
4595                     ; 236                           INT8U   **pname,
4595                     ; 237                           INT8U    *perr)
4595                     ; 238 {
4596                     	switch	.text
4597  0129               _OSMemNameGet:
4599  0129 3b            	pshd	
4600       00000002      OFST:	set	2
4603                     ; 241     OS_CPU_SR  cpu_sr = 0u;
4605                     ; 254     if (pmem == (OS_MEM *)0) {                   /* Is 'pmem' a NULL pointer?                          */
4607  012a 6cae          	std	2,-s
4608  012c 2604          	bne	L1703
4609                     ; 255         *perr = OS_ERR_MEM_INVALID_PMEM;
4611  012e c660          	ldab	#96
4612                     ; 256         return (0u);
4615  0130 2006          	bra	LC005
4616  0132               L1703:
4617                     ; 258     if (pname == (INT8U **)0) {                  /* Is 'pname' a NULL pointer?                         */
4619  0132 ec86          	ldd	OFST+4,s
4620  0134 260a          	bne	L3703
4621                     ; 259         *perr = OS_ERR_PNAME_NULL;
4623  0136 c60c          	ldab	#12
4624                     ; 260         return (0u);
4626  0138               LC005:
4627  0138 6bf30008      	stab	[OFST+6,s]
4628  013c c7            	clrb	
4630  013d               L42:
4632  013d 1b84          	leas	4,s
4633  013f 3d            	rts	
4634  0140               L3703:
4635                     ; 263     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
4637  0140 f60000        	ldab	_OSIntNesting
4638  0143 2704          	beq	L5703
4639                     ; 264         *perr = OS_ERR_NAME_GET_ISR;
4641  0145 c611          	ldab	#17
4642                     ; 265         return (0u);
4645  0147 20ef          	bra	LC005
4646  0149               L5703:
4647                     ; 267     OS_ENTER_CRITICAL();
4649  0149 160000        	jsr	_OS_CPU_SR_Save
4651  014c 6b80          	stab	OFST-2,s
4652                     ; 268     *pname = pmem->OSMemName;
4654  014e ed82          	ldy	OFST+0,s
4655  0150 ece810        	ldd	16,y
4656  0153 ee86          	ldx	OFST+4,s
4657  0155 6c00          	std	0,x
4658                     ; 269     len    = OS_StrLen(*pname);
4660  0157 160000        	jsr	_OS_StrLen
4662  015a 6b81          	stab	OFST-1,s
4663                     ; 270     OS_EXIT_CRITICAL();
4665  015c e680          	ldab	OFST-2,s
4666  015e 87            	clra	
4667  015f 160000        	jsr	_OS_CPU_SR_Restore
4669                     ; 271     *perr  = OS_ERR_NONE;
4671  0162 69f30008      	clr	[OFST+6,s]
4672                     ; 272     return (len);
4674  0166 e681          	ldab	OFST-1,s
4676  0168 20d3          	bra	L42
4742                     ; 300 _NEAR void  OSMemNameSet (OS_MEM  *pmem,
4742                     ; 301                          INT8U   *pname,
4742                     ; 302                          INT8U   *perr)
4742                     ; 303 {
4743                     	switch	.text
4744  016a               _OSMemNameSet:
4746  016a 3b            	pshd	
4747  016b 37            	pshb	
4748       00000001      OFST:	set	1
4751                     ; 305     OS_CPU_SR  cpu_sr = 0u;
4753                     ; 318     if (pmem == (OS_MEM *)0) {                   /* Is 'pmem' a NULL pointer?                          */
4755  016c 046404        	tbne	d,L1313
4756                     ; 319         *perr = OS_ERR_MEM_INVALID_PMEM;
4758  016f c660          	ldab	#96
4759                     ; 320         return;
4761  0171 2006          	bra	LC006
4762  0173               L1313:
4763                     ; 322     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
4765  0173 ec85          	ldd	OFST+4,s
4766  0175 2609          	bne	L3313
4767                     ; 323         *perr = OS_ERR_PNAME_NULL;
4769  0177 c60c          	ldab	#12
4770  0179               LC006:
4771  0179 6bf30007      	stab	[OFST+6,s]
4772                     ; 324         return;
4773  017d               L03:
4776  017d 1b83          	leas	3,s
4777  017f 3d            	rts	
4778  0180               L3313:
4779                     ; 327     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
4781  0180 f60000        	ldab	_OSIntNesting
4782  0183 2704          	beq	L5313
4783                     ; 328         *perr = OS_ERR_NAME_SET_ISR;
4785  0185 c612          	ldab	#18
4786                     ; 329         return;
4788  0187 20f0          	bra	LC006
4789  0189               L5313:
4790                     ; 331     OS_ENTER_CRITICAL();
4792  0189 160000        	jsr	_OS_CPU_SR_Save
4794  018c 6b80          	stab	OFST-1,s
4795                     ; 332     pmem->OSMemName = pname;
4797  018e ec85          	ldd	OFST+4,s
4798  0190 ee81          	ldx	OFST+0,s
4799  0192 6ce010        	std	16,x
4800                     ; 333     OS_EXIT_CRITICAL();
4802  0195 e680          	ldab	OFST-1,s
4803  0197 87            	clra	
4804  0198 160000        	jsr	_OS_CPU_SR_Restore
4806                     ; 335     *perr           = OS_ERR_NONE;
4809  019b 69f30007      	clr	[OFST+6,s]
4810                     ; 336 }
4812  019f 20dc          	bra	L03
4867                     ; 358 _NEAR INT8U  OSMemPut (OS_MEM  *pmem,
4867                     ; 359                       void    *pblk)
4867                     ; 360 {
4868                     	switch	.text
4869  01a1               _OSMemPut:
4871  01a1 3b            	pshd	
4872  01a2 37            	pshb	
4873       00000001      OFST:	set	1
4876                     ; 362     OS_CPU_SR  cpu_sr = 0u;
4878                     ; 367     if (pmem == (OS_MEM *)0) {                   /* Must point to a valid memory partition             */
4880  01a3 046404        	tbne	d,L5613
4881                     ; 368         return (OS_ERR_MEM_INVALID_PMEM);
4883  01a6 c660          	ldab	#96
4885  01a8 2006          	bra	L63
4886  01aa               L5613:
4887                     ; 370     if (pblk == (void *)0) {                     /* Must release a valid block                         */
4889  01aa ec85          	ldd	OFST+4,s
4890  01ac 2605          	bne	L7613
4891                     ; 371         return (OS_ERR_MEM_INVALID_PBLK);
4893  01ae c65f          	ldab	#95
4895  01b0               L63:
4897  01b0 1b83          	leas	3,s
4898  01b2 3d            	rts	
4899  01b3               L7613:
4900                     ; 377     OS_ENTER_CRITICAL();
4903  01b3 160000        	jsr	_OS_CPU_SR_Save
4905  01b6 6b80          	stab	OFST-1,s
4906                     ; 378     if (pmem->OSMemNFree >= pmem->OSMemNBlks) {  /* Make sure all blocks not already returned          */
4908  01b8 ed81          	ldy	OFST+0,s
4909  01ba ec4e          	ldd	14,y
4910  01bc ac4a          	cpd	10,y
4911  01be ec4c          	ldd	12,y
4912  01c0 e249          	sbcb	9,y
4913  01c2 a248          	sbca	8,y
4914  01c4 250a          	blo	L1713
4915                     ; 379         OS_EXIT_CRITICAL();
4917  01c6 e680          	ldab	OFST-1,s
4918  01c8 87            	clra	
4919  01c9 160000        	jsr	_OS_CPU_SR_Restore
4921                     ; 381         return (OS_ERR_MEM_FULL);
4924  01cc c65e          	ldab	#94
4926  01ce 20e0          	bra	L63
4927  01d0               L1713:
4928                     ; 383     *(void **)pblk      = pmem->OSMemFreeList;   /* Insert released block into free block list         */
4930  01d0 ec42          	ldd	2,y
4931  01d2 6cf30005      	std	[OFST+4,s]
4932                     ; 384     pmem->OSMemFreeList = pblk;
4934  01d6 18028542      	movw	OFST+4,s,2,y
4935                     ; 385     pmem->OSMemNFree++;                          /* One more memory block in this partition            */
4937  01da ec4e          	ldd	14,y
4938  01dc c30001        	addd	#1
4939  01df 6c4e          	std	14,y
4940  01e1 2406          	bcc	L43
4941  01e3 624d          	inc	13,y
4942  01e5 2602          	bne	L43
4943  01e7 624c          	inc	12,y
4944  01e9               L43:
4945                     ; 386     OS_EXIT_CRITICAL();
4947  01e9 e680          	ldab	OFST-1,s
4948  01eb 87            	clra	
4949  01ec 160000        	jsr	_OS_CPU_SR_Restore
4951                     ; 388     return (OS_ERR_NONE);                        /* Notify caller that memory block was released       */
4954  01ef c7            	clrb	
4956  01f0 20be          	bra	L63
5068                     ; 411 _NEAR INT8U  OSMemQuery (OS_MEM       *pmem,
5068                     ; 412                         OS_MEM_DATA  *p_mem_data)
5068                     ; 413 {
5069                     	switch	.text
5070  01f2               _OSMemQuery:
5072  01f2 3b            	pshd	
5073  01f3 37            	pshb	
5074       00000001      OFST:	set	1
5077                     ; 415     OS_CPU_SR  cpu_sr = 0u;
5079                     ; 421     if (pmem == (OS_MEM *)0) {                   /* Must point to a valid memory partition             */
5081  01f4 046404        	tbne	d,L7423
5082                     ; 422         return (OS_ERR_MEM_INVALID_PMEM);
5084  01f7 c660          	ldab	#96
5086  01f9 2006          	bra	L24
5087  01fb               L7423:
5088                     ; 424     if (p_mem_data == (OS_MEM_DATA *)0) {        /* Must release a valid storage area for the data     */
5090  01fb ec85          	ldd	OFST+4,s
5091  01fd 2605          	bne	L1523
5092                     ; 425         return (OS_ERR_MEM_INVALID_PDATA);
5094  01ff c661          	ldab	#97
5096  0201               L24:
5098  0201 1b83          	leas	3,s
5099  0203 3d            	rts	
5100  0204               L1523:
5101                     ; 428     OS_ENTER_CRITICAL();
5103  0204 160000        	jsr	_OS_CPU_SR_Save
5105  0207 6b80          	stab	OFST-1,s
5106                     ; 429     p_mem_data->OSAddr     = pmem->OSMemAddr;
5108  0209 ee81          	ldx	OFST+0,s
5109  020b ed85          	ldy	OFST+4,s
5110  020d 18020040      	movw	0,x,0,y
5111                     ; 430     p_mem_data->OSFreeList = pmem->OSMemFreeList;
5113  0211 18020242      	movw	2,x,2,y
5114                     ; 431     p_mem_data->OSBlkSize  = pmem->OSMemBlkSize;
5116  0215 18020444      	movw	4,x,4,y
5117  0219 18020646      	movw	6,x,6,y
5118                     ; 432     p_mem_data->OSNBlks    = pmem->OSMemNBlks;
5120  021d 18020848      	movw	8,x,8,y
5121  0221 18020a4a      	movw	10,x,10,y
5122                     ; 433     p_mem_data->OSNFree    = pmem->OSMemNFree;
5124  0225 18020c4c      	movw	12,x,12,y
5125  0229 18020e4e      	movw	14,x,14,y
5126                     ; 434     OS_EXIT_CRITICAL();
5128  022d 87            	clra	
5129  022e 160000        	jsr	_OS_CPU_SR_Restore
5131                     ; 435     p_mem_data->OSNUsed    = p_mem_data->OSNBlks - p_mem_data->OSNFree;
5133  0231 ed85          	ldy	OFST+4,s
5134  0233 ec4a          	ldd	10,y
5135  0235 ee48          	ldx	8,y
5136  0237 194c          	leay	12,y
5137  0239 160000        	jsr	c_lsub
5139  023c ed85          	ldy	OFST+4,s
5140  023e 6ce812        	std	18,y
5141  0241 6ee810        	stx	16,y
5142                     ; 436     return (OS_ERR_NONE);
5144  0244 c7            	clrb	
5146  0245 20ba          	bra	L24
5192                     ; 456 _NEAR void  OS_MemInit (void)
5192                     ; 457 {
5193                     	switch	.text
5194  0247               _OS_MemInit:
5196  0247 1b9c          	leas	-4,s
5197       00000004      OFST:	set	4
5200                     ; 471     OS_MemClr((INT8U *)&OSMemTbl[0], sizeof(OSMemTbl));   /* Clear the memory partition table          */
5202  0249 cc005a        	ldd	#90
5203  024c 3b            	pshd	
5204  024d cc0000        	ldd	#_OSMemTbl
5205  0250 160000        	jsr	_OS_MemClr
5207  0253 1b82          	leas	2,s
5208                     ; 472     for (i = 0u; i < (OS_MAX_MEM_PART - 1u); i++) {       /* Init. list of free memory partitions      */
5210  0255 87            	clra	
5211  0256 c7            	clrb	
5212  0257 6c80          	std	OFST-4,s
5213  0259               L5723:
5214                     ; 473         pmem                = &OSMemTbl[i];               /* Point to memory control block (MCB)       */
5216  0259 cd0012        	ldy	#18
5217  025c 13            	emul	
5218  025d c30000        	addd	#_OSMemTbl
5219  0260 6c82          	std	OFST-2,s
5220                     ; 474         pmem->OSMemFreeList = (void *)&OSMemTbl[i + 1u];  /* Chain list of free partitions             */
5222  0262 ec80          	ldd	OFST-4,s
5223  0264 cd0012        	ldy	#18
5224  0267 13            	emul	
5225  0268 c30012        	addd	#_OSMemTbl+18
5226  026b ed82          	ldy	OFST-2,s
5227  026d 6c42          	std	2,y
5228                     ; 476         pmem->OSMemName  = (INT8U *)(void *)"?";
5230  026f cc0004        	ldd	#L3033
5231  0272 6ce810        	std	16,y
5232                     ; 472     for (i = 0u; i < (OS_MAX_MEM_PART - 1u); i++) {       /* Init. list of free memory partitions      */
5234  0275 ec80          	ldd	OFST-4,s
5235  0277 c30001        	addd	#1
5236  027a 6c80          	std	OFST-4,s
5239  027c 8c0004        	cpd	#4
5240  027f 25d8          	blo	L5723
5241                     ; 479     pmem                = &OSMemTbl[i];
5243  0281 cd0012        	ldy	#18
5244  0284 13            	emul	
5245  0285 c30000        	addd	#_OSMemTbl
5246  0288 6c82          	std	OFST-2,s
5247                     ; 480     pmem->OSMemFreeList = (void *)0;                      /* Initialize last node                      */
5249  028a 87            	clra	
5250  028b c7            	clrb	
5251  028c ed82          	ldy	OFST-2,s
5252  028e 6c42          	std	2,y
5253                     ; 482     pmem->OSMemName = (INT8U *)(void *)"?";
5255  0290 cc0004        	ldd	#L3033
5256  0293 6ce810        	std	16,y
5257                     ; 485     OSMemFreeList   = &OSMemTbl[0];                       /* Point to beginning of free list           */
5259  0296 cc0000        	ldd	#_OSMemTbl
5260  0299 7c0000        	std	_OSMemFreeList
5261                     ; 487 }
5264  029c 1b84          	leas	4,s
5265  029e 3d            	rts	
5277                     	xref	_OS_StrLen
5278                     	xdef	_OS_MemInit
5279                     	xref	_OS_MemClr
5280                     	xdef	_OSMemQuery
5281                     	xdef	_OSMemPut
5282                     	xdef	_OSMemNameSet
5283                     	xdef	_OSMemNameGet
5284                     	xdef	_OSMemGet
5285                     	xdef	_OSMemCreate
5286                     	xref	_OSMemTbl
5287                     	xref	_OSMemFreeList
5288                     	xref	_OSIntNesting
5289                     	xref	_OS_CPU_SR_Restore
5290                     	xref	_OS_CPU_SR_Save
5291                     	switch	.const
5292  0004               L3033:
5293  0004 3f00          	dc.b	"?",0
5314                     	xref	c_ladd
5315                     	xref	c_lsub
5316                     	end

   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4172                     ; 121 _NEAR OS_TMR  *OSTmrCreate (INT32U           dly,
4172                     ; 122                            INT32U           period,
4172                     ; 123                            INT8U            opt,
4172                     ; 124                            OS_TMR_CALLBACK  callback,
4172                     ; 125                            void            *callback_arg,
4172                     ; 126                            INT8U           *pname,
4172                     ; 127                            INT8U           *perr)
4172                     ; 128 {
4173                     	switch	.text
4174  0000               _OSTmrCreate:
4176  0000 3b            	pshd	
4177  0001 34            	pshx	
4178  0002 3b            	pshd	
4179       00000002      OFST:	set	2
4182                     ; 148     switch (opt) {                                          /* Validate arguments                                     */
4184  0003 e68d          	ldab	OFST+11,s
4186  0005 04011a        	dbeq	b,L1662
4187  0008 040104        	dbeq	b,L7562
4188                     ; 163         default:
4188                     ; 164              *perr = OS_ERR_TMR_INVALID_OPT;
4190  000b c684          	ldab	#132
4191                     ; 165              return ((OS_TMR *)0);
4194  000d 200a          	bra	LC001
4195  000f               L7562:
4196                     ; 149         case OS_TMR_OPT_PERIODIC:
4196                     ; 150              if (period == 0u) {
4198  000f ec88          	ldd	OFST+6,s
4199  0011 261b          	bne	L1003
4200  0013 ec8a          	ldd	OFST+8,s
4201  0015 2617          	bne	L1003
4202                     ; 151                  *perr = OS_ERR_TMR_INVALID_PERIOD;
4204  0017 c683          	ldab	#131
4205                     ; 152                  return ((OS_TMR *)0);
4207  0019               LC001:
4208  0019 6bf30014      	stab	[OFST+18,s]
4209  001d 87            	clra	
4210  001e c7            	clrb	
4212  001f               L21:
4214  001f 1b86          	leas	6,s
4215  0021 3d            	rts	
4216  0022               L1662:
4217                     ; 156         case OS_TMR_OPT_ONE_SHOT:
4217                     ; 157              if (dly == 0u) {
4219  0022 ec82          	ldd	OFST+0,s
4220  0024 2608          	bne	L1003
4221  0026 ec84          	ldd	OFST+2,s
4222  0028 2604          	bne	L1003
4223                     ; 158                  *perr = OS_ERR_TMR_INVALID_DLY;
4225  002a c682          	ldab	#130
4226                     ; 159                  return ((OS_TMR *)0);
4229  002c 20eb          	bra	LC001
4230  002e               L1003:
4231                     ; 168     if (OSIntNesting > 0u) {                                /* See if trying to call from an ISR                      */
4233  002e f60000        	ldab	_OSIntNesting
4234  0031 2704          	beq	L7003
4235                     ; 169         *perr  = OS_ERR_TMR_ISR;
4237  0033 c68b          	ldab	#139
4238                     ; 170         return ((OS_TMR *)0);
4241  0035 20e2          	bra	LC001
4242  0037               L7003:
4243                     ; 172     OSSchedLock();
4245  0037 160000        	jsr	_OSSchedLock
4247                     ; 173     ptmr = OSTmr_Alloc();                                   /* Obtain a timer from the free pool                      */
4249  003a 16031a        	jsr	L3462_OSTmr_Alloc
4251  003d 6c80          	std	OFST-2,s
4252                     ; 174     if (ptmr == (OS_TMR *)0) {
4254  003f 2607          	bne	L1103
4255                     ; 175         OSSchedUnlock();
4257  0041 160000        	jsr	_OSSchedUnlock
4259                     ; 176         *perr = OS_ERR_TMR_NON_AVAIL;
4261  0044 c686          	ldab	#134
4262                     ; 177         return ((OS_TMR *)0);
4265  0046 20d1          	bra	LC001
4266  0048               L1103:
4267                     ; 179     ptmr->OSTmrState       = OS_TMR_STATE_STOPPED;          /* Indicate that timer is not running yet                 */
4269  0048 c601          	ldab	#1
4270  004a ed80          	ldy	OFST-2,s
4271  004c 6be816        	stab	22,y
4272                     ; 180     ptmr->OSTmrDly         = dly;
4274  004f 1802844f      	movw	OFST+2,s,15,y
4275  0053 1802824d      	movw	OFST+0,s,13,y
4276                     ; 181     ptmr->OSTmrPeriod      = period;
4278  0057 ec8a          	ldd	OFST+8,s
4279  0059 6ce813        	std	19,y
4280  005c ec88          	ldd	OFST+6,s
4281  005e 6ce811        	std	17,y
4282                     ; 182     ptmr->OSTmrOpt         = opt;
4284  0061 e68d          	ldab	OFST+11,s
4285  0063 6be815        	stab	21,y
4286                     ; 183     ptmr->OSTmrCallback    = callback;
4288  0066 18028e41      	movw	OFST+12,s,1,y
4289                     ; 184     ptmr->OSTmrCallbackArg = callback_arg;
4291  006a ecf010        	ldd	OFST+14,s
4292  006d 6c43          	std	3,y
4293                     ; 192     OSSchedUnlock();
4295  006f 160000        	jsr	_OSSchedUnlock
4297                     ; 194     *perr = OS_ERR_NONE;
4300  0072 69f30014      	clr	[OFST+18,s]
4301                     ; 195     return (ptmr);
4303  0076 ec80          	ldd	OFST-2,s
4305  0078 20a5          	bra	L21
4356                     ; 225 _NEAR BOOLEAN  OSTmrDel (OS_TMR  *ptmr,
4356                     ; 226                         INT8U   *perr)
4356                     ; 227 {
4357                     	switch	.text
4358  007a               _OSTmrDel:
4360       00000000      OFST:	set	0
4363                     ; 244     if (ptmr == (OS_TMR *)0) {
4365  007a 6cae          	std	2,-s
4366  007c 2609          	bne	L7403
4367                     ; 245         *perr = OS_ERR_TMR_INVALID;
4369  007e c68a          	ldab	#138
4370  0080 6bf30004      	stab	[OFST+4,s]
4371                     ; 246         return (OS_FALSE);
4373  0084 c7            	clrb	
4376  0085 31            	puly	
4377  0086 3d            	rts	
4378  0087               L7403:
4379                     ; 252     if (ptmr->OSTmrType != OS_TMR_TYPE) {                   /* Validate timer structure                               */
4382  0087 e6f30000      	ldab	[OFST+0,s]
4383  008b c164          	cmpb	#100
4384  008d 2709          	beq	L1503
4385                     ; 253         *perr = OS_ERR_TMR_INVALID_TYPE;
4387  008f c689          	ldab	#137
4388  0091 6bf30004      	stab	[OFST+4,s]
4389                     ; 255         return (OS_FALSE);
4392  0095 c7            	clrb	
4395  0096 31            	puly	
4396  0097 3d            	rts	
4397  0098               L1503:
4398                     ; 257     if (OSIntNesting > 0u) {                                /* See if trying to call from an ISR                      */
4400  0098 f60000        	ldab	_OSIntNesting
4401  009b 2709          	beq	L3503
4402                     ; 258         *perr  = OS_ERR_TMR_ISR;
4404  009d c68b          	ldab	#139
4405  009f 6bf30004      	stab	[OFST+4,s]
4406                     ; 260         return (OS_FALSE);
4409  00a3 c7            	clrb	
4412  00a4 31            	puly	
4413  00a5 3d            	rts	
4414  00a6               L3503:
4415                     ; 262     OSSchedLock();
4417  00a6 160000        	jsr	_OSSchedLock
4419                     ; 263     switch (ptmr->OSTmrState) {
4421  00a9 ed80          	ldy	OFST+0,s
4422  00ab e6e816        	ldab	22,y
4424  00ae 273a          	beq	L7103
4425  00b0 040127        	dbeq	b,L5103
4426  00b3 040124        	dbeq	b,L5103
4427  00b6 04010c        	dbeq	b,L3103
4428                     ; 286         default:
4428                     ; 287              OSSchedUnlock();
4430  00b9 160000        	jsr	_OSSchedUnlock
4432                     ; 288              *perr = OS_ERR_TMR_INVALID_STATE;
4434  00bc c68d          	ldab	#141
4435  00be 6bf30004      	stab	[OFST+4,s]
4436                     ; 290              return (OS_FALSE);
4439  00c2 c7            	clrb	
4442  00c3 31            	puly	
4443  00c4 3d            	rts	
4444  00c5               L3103:
4445                     ; 264         case OS_TMR_STATE_RUNNING:
4445                     ; 265              OSTmr_Unlink(ptmr);                            /* Remove from current wheel spoke                        */
4447  00c5 b764          	tfr	y,d
4448  00c7 1604c2        	jsr	L3562_OSTmr_Unlink
4450                     ; 266              OSTmr_Free(ptmr);                              /* Return timer to free list of timers                    */
4452  00ca ec80          	ldd	OFST+0,s
4453  00cc 160343        	jsr	L5462_OSTmr_Free
4455                     ; 267              OSSchedUnlock();
4457  00cf 160000        	jsr	_OSSchedUnlock
4459                     ; 268              *perr = OS_ERR_NONE;
4461  00d2 69f30004      	clr	[OFST+4,s]
4462                     ; 270              return (OS_TRUE);
4465  00d6 c601          	ldab	#1
4468  00d8 31            	puly	
4469  00d9 3d            	rts	
4470  00da               L5103:
4471                     ; 272         case OS_TMR_STATE_STOPPED:                          /* Timer has not started or ...                           */
4471                     ; 273         case OS_TMR_STATE_COMPLETED:                        /* ... timer has completed the ONE-SHOT time              */
4471                     ; 274              OSTmr_Free(ptmr);                              /* Return timer to free list of timers                    */
4473  00da b764          	tfr	y,d
4474  00dc 160343        	jsr	L5462_OSTmr_Free
4476                     ; 275              OSSchedUnlock();
4478  00df 160000        	jsr	_OSSchedUnlock
4480                     ; 276              *perr = OS_ERR_NONE;
4482  00e2 69f30004      	clr	[OFST+4,s]
4483                     ; 278              return (OS_TRUE);
4486  00e6 c601          	ldab	#1
4489  00e8 31            	puly	
4490  00e9 3d            	rts	
4491  00ea               L7103:
4492                     ; 280         case OS_TMR_STATE_UNUSED:                           /* Already deleted                                        */
4492                     ; 281              OSSchedUnlock();
4494  00ea 160000        	jsr	_OSSchedUnlock
4496                     ; 282              *perr = OS_ERR_TMR_INACTIVE;
4498  00ed c687          	ldab	#135
4499  00ef 6bf30004      	stab	[OFST+4,s]
4500                     ; 284              return (OS_FALSE);
4503  00f3 c7            	clrb	
4506  00f4 31            	puly	
4507  00f5 3d            	rts	
4564                     ; 400 _NEAR INT32U  OSTmrRemainGet (OS_TMR  *ptmr,
4564                     ; 401                              INT8U   *perr)
4564                     ; 402 {
4565                     	switch	.text
4566  00f6               _OSTmrRemainGet:
4568  00f6 3b            	pshd	
4569  00f7 1b9c          	leas	-4,s
4570       00000004      OFST:	set	4
4573                     ; 414     if (ptmr == (OS_TMR *)0) {
4575  00f9 046404        	tbne	d,L5213
4576                     ; 415         *perr = OS_ERR_TMR_INVALID;
4578  00fc c68a          	ldab	#138
4579                     ; 416         return (0u);
4582  00fe 200a          	bra	LC002
4583  0100               L5213:
4584                     ; 419     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
4586  0100 e6f30004      	ldab	[OFST+0,s]
4587  0104 c164          	cmpb	#100
4588  0106 270d          	beq	L7213
4589                     ; 420         *perr = OS_ERR_TMR_INVALID_TYPE;
4591  0108 c689          	ldab	#137
4592                     ; 421         return (0u);
4594  010a               LC002:
4595  010a 6bf30008      	stab	[OFST+4,s]
4596  010e 87            	clra	
4597  010f c7            	clrb	
4598  0110 b745          	tfr	d,x
4600  0112               L22:
4602  0112 1b86          	leas	6,s
4603  0114 3d            	rts	
4604  0115               L7213:
4605                     ; 423     if (OSIntNesting > 0u) {                           /* See if trying to call from an ISR                           */
4607  0115 f60000        	ldab	_OSIntNesting
4608  0118 2704          	beq	L1313
4609                     ; 424         *perr = OS_ERR_TMR_ISR;
4611  011a c68b          	ldab	#139
4612                     ; 425         return (0u);
4615  011c 20ec          	bra	LC002
4616  011e               L1313:
4617                     ; 427     OSSchedLock();
4619  011e 160000        	jsr	_OSSchedLock
4621                     ; 428     switch (ptmr->OSTmrState) {
4623  0121 ed84          	ldy	OFST+0,s
4624  0123 e6e816        	ldab	22,y
4626  0126 276b          	beq	L3703
4627  0128 040128        	dbeq	b,L3603
4628  012b 040157        	dbeq	b,L1703
4629  012e 040107        	dbeq	b,L1603
4630                     ; 466         default:
4630                     ; 467              OSSchedUnlock();
4632  0131 160000        	jsr	_OSSchedUnlock
4634                     ; 468              *perr = OS_ERR_TMR_INVALID_STATE;
4636  0134 c68d          	ldab	#141
4637                     ; 469              return (0u);
4640  0136 20d2          	bra	LC002
4641  0138               L1603:
4642                     ; 429         case OS_TMR_STATE_RUNNING:
4642                     ; 430              remain = ptmr->OSTmrMatch - OSTmrTime;    /* Determine how much time is left to timeout                  */
4644  0138 ec4b          	ldd	11,y
4645  013a ee49          	ldx	9,y
4646  013c cd0000        	ldy	#_OSTmrTime
4647  013f 160000        	jsr	c_lsub
4649  0142 6c82          	std	OFST-2,s
4650  0144 6e80          	stx	OFST-4,s
4651                     ; 431              OSSchedUnlock();
4653  0146 160000        	jsr	_OSSchedUnlock
4655                     ; 432              *perr  = OS_ERR_NONE;
4657  0149 69f30008      	clr	[OFST+4,s]
4658                     ; 433              return (remain);
4660  014d ec82          	ldd	OFST-2,s
4661  014f ee80          	ldx	OFST-4,s
4663  0151 20bf          	bra	L22
4664  0153               L3603:
4665                     ; 435         case OS_TMR_STATE_STOPPED:                     /* It's assumed that the timer has not started yet             */
4665                     ; 436              switch (ptmr->OSTmrOpt) {
4667  0153 e6e815        	ldab	21,y
4669  0156 040117        	dbeq	b,L7603
4670  0159 042114        	dbne	b,L7603
4671                     ; 437                  case OS_TMR_OPT_PERIODIC:
4671                     ; 438                       if (ptmr->OSTmrDly == 0u) {
4673  015c ec4d          	ldd	13,y
4674  015e 260e          	bne	L3413
4675  0160 ec4f          	ldd	15,y
4676  0162 260a          	bne	L3413
4677                     ; 439                           remain = ptmr->OSTmrPeriod;
4679  0164 ece813        	ldd	19,y
4680  0167 6c82          	std	OFST-2,s
4681  0169 ece811        	ldd	17,y
4683  016c 2008          	bra	L1413
4684  016e               L3413:
4685                     ; 441                           remain = ptmr->OSTmrDly;
4687  016e ed84          	ldy	OFST+0,s
4688                     ; 443                       OSSchedUnlock();
4691                     ; 444                       *perr  = OS_ERR_NONE;
4693                     ; 445                       break;
4695  0170               L7603:
4696                     ; 447                  case OS_TMR_OPT_ONE_SHOT:
4696                     ; 448                  default:
4696                     ; 449                       remain = ptmr->OSTmrDly;
4698  0170 18024f82      	movw	15,y,OFST-2,s
4699  0174 ec4d          	ldd	13,y
4700                     ; 450                       OSSchedUnlock();
4703                     ; 451                       *perr  = OS_ERR_NONE;
4705                     ; 452                       break;
4707  0176               L1413:
4708  0176 6c80          	std	OFST-4,s
4709  0178 160000        	jsr	_OSSchedUnlock
4710  017b 69f30008      	clr	[OFST+4,s]
4711                     ; 454              return (remain);
4713  017f ec82          	ldd	OFST-2,s
4714  0181 ee80          	ldx	OFST-4,s
4716  0183 200b          	bra	L42
4717  0185               L1703:
4718                     ; 456         case OS_TMR_STATE_COMPLETED:                   /* Only ONE-SHOT that timed out can be in this state           */
4718                     ; 457              OSSchedUnlock();
4720  0185 160000        	jsr	_OSSchedUnlock
4722                     ; 458              *perr = OS_ERR_NONE;
4724  0188 c7            	clrb	
4725  0189 6bf30008      	stab	[OFST+4,s]
4726                     ; 459              return (0u);
4728  018d 87            	clra	
4729  018e               LC003:
4730  018e b745          	tfr	d,x
4732  0190               L42:
4734  0190 1b86          	leas	6,s
4735  0192 3d            	rts	
4736  0193               L3703:
4737                     ; 461         case OS_TMR_STATE_UNUSED:
4737                     ; 462              OSSchedUnlock();
4739  0193 160000        	jsr	_OSSchedUnlock
4741                     ; 463              *perr = OS_ERR_TMR_INACTIVE;
4743  0196 c687          	ldab	#135
4744  0198 6bf30008      	stab	[OFST+4,s]
4745                     ; 464              return (0u);
4747  019c 87            	clra	
4748  019d c7            	clrb	
4750  019e 20ee          	bra	LC003
4806                     ; 501 _NEAR INT8U  OSTmrStateGet (OS_TMR  *ptmr,
4806                     ; 502                            INT8U   *perr)
4806                     ; 503 {
4807                     	switch	.text
4808  01a0               _OSTmrStateGet:
4810  01a0 3b            	pshd	
4811  01a1 37            	pshb	
4812       00000001      OFST:	set	1
4815                     ; 515     if (ptmr == (OS_TMR *)0) {
4817  01a2 046404        	tbne	d,L1023
4818                     ; 516         *perr = OS_ERR_TMR_INVALID;
4820  01a5 c68a          	ldab	#138
4821                     ; 517         return (0u);
4824  01a7 200a          	bra	LC005
4825  01a9               L1023:
4826                     ; 520     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
4828  01a9 e6f30001      	ldab	[OFST+0,s]
4829  01ad c164          	cmpb	#100
4830  01af 270a          	beq	L3023
4831                     ; 521         *perr = OS_ERR_TMR_INVALID_TYPE;
4833  01b1 c689          	ldab	#137
4834                     ; 522         return (0u);
4836  01b3               LC005:
4837  01b3 6bf30005      	stab	[OFST+4,s]
4838  01b7 c7            	clrb	
4840  01b8               L03:
4842  01b8 1b83          	leas	3,s
4843  01ba 3d            	rts	
4844  01bb               L3023:
4845                     ; 524     if (OSIntNesting > 0u) {                           /* See if trying to call from an ISR                           */
4847  01bb f60000        	ldab	_OSIntNesting
4848  01be 2704          	beq	L5023
4849                     ; 525         *perr = OS_ERR_TMR_ISR;
4851  01c0 c68b          	ldab	#139
4852                     ; 526         return (0u);
4855  01c2 20ef          	bra	LC005
4856  01c4               L5023:
4857                     ; 528     OSSchedLock();
4859  01c4 160000        	jsr	_OSSchedLock
4861                     ; 529     state = ptmr->OSTmrState;
4863  01c7 ed81          	ldy	OFST+0,s
4864  01c9 e6e816        	ldab	22,y
4865  01cc 6b80          	stab	OFST-1,s
4866                     ; 530     switch (state) {
4869  01ce 2711          	beq	L7413
4870  01d0 04010e        	dbeq	b,L7413
4871  01d3 04010b        	dbeq	b,L7413
4872  01d6 040108        	dbeq	b,L7413
4873                     ; 538         default:
4873                     ; 539              *perr = OS_ERR_TMR_INVALID_STATE;
4875  01d9 c68d          	ldab	#141
4876  01db 6bf30005      	stab	[OFST+4,s]
4877                     ; 540              break;
4879  01df 2004          	bra	L1123
4880  01e1               L7413:
4881                     ; 531         case OS_TMR_STATE_UNUSED:
4881                     ; 532         case OS_TMR_STATE_STOPPED:
4881                     ; 533         case OS_TMR_STATE_COMPLETED:
4881                     ; 534         case OS_TMR_STATE_RUNNING:
4881                     ; 535              *perr = OS_ERR_NONE;
4883  01e1 69f30005      	clr	[OFST+4,s]
4884                     ; 536              break;
4886  01e5               L1123:
4887                     ; 542     OSSchedUnlock();
4889  01e5 160000        	jsr	_OSSchedUnlock
4891                     ; 543     return (state);
4893  01e8 e680          	ldab	OFST-1,s
4895  01ea 20cc          	bra	L03
4946                     ; 570 _NEAR BOOLEAN  OSTmrStart (OS_TMR   *ptmr,
4946                     ; 571                           INT8U    *perr)
4946                     ; 572 {
4947                     	switch	.text
4948  01ec               _OSTmrStart:
4950       00000000      OFST:	set	0
4953                     ; 581     if (ptmr == (OS_TMR *)0) {
4955  01ec 6cae          	std	2,-s
4956  01ee 2609          	bne	L7423
4957                     ; 582         *perr = OS_ERR_TMR_INVALID;
4959  01f0 c68a          	ldab	#138
4960  01f2 6bf30004      	stab	[OFST+4,s]
4961                     ; 583         return (OS_FALSE);
4963  01f6 c7            	clrb	
4966  01f7 31            	puly	
4967  01f8 3d            	rts	
4968  01f9               L7423:
4969                     ; 589     if (ptmr->OSTmrType != OS_TMR_TYPE) {                   /* Validate timer structure                               */
4972  01f9 e6f30000      	ldab	[OFST+0,s]
4973  01fd c164          	cmpb	#100
4974  01ff 2709          	beq	L1523
4975                     ; 590         *perr = OS_ERR_TMR_INVALID_TYPE;
4977  0201 c689          	ldab	#137
4978  0203 6bf30004      	stab	[OFST+4,s]
4979                     ; 592         return (OS_FALSE);
4982  0207 c7            	clrb	
4985  0208 31            	puly	
4986  0209 3d            	rts	
4987  020a               L1523:
4988                     ; 594     if (OSIntNesting > 0u) {                                /* See if trying to call from an ISR                      */
4990  020a f60000        	ldab	_OSIntNesting
4991  020d 2709          	beq	L3523
4992                     ; 595         *perr  = OS_ERR_TMR_ISR;
4994  020f c68b          	ldab	#139
4995  0211 6bf30004      	stab	[OFST+4,s]
4996                     ; 597         return (OS_FALSE);
4999  0215 c7            	clrb	
5002  0216 31            	puly	
5003  0217 3d            	rts	
5004  0218               L3523:
5005                     ; 599     OSSchedLock();
5007  0218 160000        	jsr	_OSSchedLock
5009                     ; 600     switch (ptmr->OSTmrState) {
5011  021b ed80          	ldy	OFST+0,s
5012  021d e6e816        	ldab	22,y
5014  0220 2744          	beq	L7123
5015  0222 04012c        	dbeq	b,L5123
5016  0225 040129        	dbeq	b,L5123
5017  0228 04010c        	dbeq	b,L3123
5018                     ; 623         default:
5018                     ; 624              OSSchedUnlock();
5020  022b 160000        	jsr	_OSSchedUnlock
5022                     ; 625              *perr = OS_ERR_TMR_INVALID_STATE;
5024  022e c68d          	ldab	#141
5025  0230 6bf30004      	stab	[OFST+4,s]
5026                     ; 627              return (OS_FALSE);
5029  0234 c7            	clrb	
5032  0235 31            	puly	
5033  0236 3d            	rts	
5034  0237               L3123:
5035                     ; 601         case OS_TMR_STATE_RUNNING:                          /* Restart the timer                                      */
5035                     ; 602              OSTmr_Unlink(ptmr);                            /* ... Stop the timer                                     */
5037  0237 b764          	tfr	y,d
5038  0239 1604c2        	jsr	L3562_OSTmr_Unlink
5040                     ; 603              OSTmr_Link(ptmr, OS_TMR_LINK_DLY);             /* ... Link timer to timer wheel                          */
5042  023c 87            	clra	
5043  023d c7            	clrb	
5044  023e 3b            	pshd	
5045  023f ec82          	ldd	OFST+2,s
5046  0241 16045a        	jsr	L1562_OSTmr_Link
5048  0244 1b82          	leas	2,s
5049                     ; 604              OSSchedUnlock();
5051  0246 160000        	jsr	_OSSchedUnlock
5053                     ; 605              *perr = OS_ERR_NONE;
5055  0249 69f30004      	clr	[OFST+4,s]
5056                     ; 607              return (OS_TRUE);
5059  024d c601          	ldab	#1
5062  024f 31            	puly	
5063  0250 3d            	rts	
5064  0251               L5123:
5065                     ; 609         case OS_TMR_STATE_STOPPED:                          /* Start the timer                                        */
5065                     ; 610         case OS_TMR_STATE_COMPLETED:
5065                     ; 611              OSTmr_Link(ptmr, OS_TMR_LINK_DLY);             /* ... Link timer to timer wheel                          */
5067  0251 87            	clra	
5068  0252 c7            	clrb	
5069  0253 3b            	pshd	
5070  0254 b764          	tfr	y,d
5071  0256 16045a        	jsr	L1562_OSTmr_Link
5073  0259 1b82          	leas	2,s
5074                     ; 612              OSSchedUnlock();
5076  025b 160000        	jsr	_OSSchedUnlock
5078                     ; 613              *perr = OS_ERR_NONE;
5080  025e 69f30004      	clr	[OFST+4,s]
5081                     ; 615              return (OS_TRUE);
5084  0262 c601          	ldab	#1
5087  0264 31            	puly	
5088  0265 3d            	rts	
5089  0266               L7123:
5090                     ; 617         case OS_TMR_STATE_UNUSED:                           /* Timer not created                                      */
5090                     ; 618              OSSchedUnlock();
5092  0266 160000        	jsr	_OSSchedUnlock
5094                     ; 619              *perr = OS_ERR_TMR_INACTIVE;
5096  0269 c687          	ldab	#135
5097  026b 6bf30004      	stab	[OFST+4,s]
5098                     ; 621              return (OS_FALSE);
5101  026f c7            	clrb	
5104  0270 31            	puly	
5105  0271 3d            	rts	
5183                     ; 671 _NEAR BOOLEAN  OSTmrStop (OS_TMR  *ptmr,
5183                     ; 672                          INT8U    opt,
5183                     ; 673                          void    *callback_arg,
5183                     ; 674                          INT8U   *perr)
5183                     ; 675 {
5184                     	switch	.text
5185  0272               _OSTmrStop:
5187  0272 3b            	pshd	
5188       00000002      OFST:	set	2
5191                     ; 687     if (ptmr == (OS_TMR *)0) {
5193  0273 6cae          	std	2,-s
5194  0275 2604          	bne	L7333
5195                     ; 688         *perr = OS_ERR_TMR_INVALID;
5197  0277 c68a          	ldab	#138
5198                     ; 689         return (OS_FALSE);
5201  0279 200a          	bra	L63
5202  027b               L7333:
5203                     ; 695     if (ptmr->OSTmrType != OS_TMR_TYPE) {                         /* Validate timer structure                         */
5206  027b e6f30002      	ldab	[OFST+0,s]
5207  027f c164          	cmpb	#100
5208  0281 270a          	beq	L1433
5209                     ; 696         *perr = OS_ERR_TMR_INVALID_TYPE;
5211  0283 c689          	ldab	#137
5212                     ; 698         return (OS_FALSE);
5216  0285               L63:
5217  0285 6bf3000a      	stab	[OFST+8,s]
5218  0289 c7            	clrb	
5220  028a 1b84          	leas	4,s
5221  028c 3d            	rts	
5222  028d               L1433:
5223                     ; 700     if (OSIntNesting > 0u) {                                      /* See if trying to call from an ISR                */
5225  028d f60000        	ldab	_OSIntNesting
5226  0290 2704          	beq	L3433
5227                     ; 701         *perr  = OS_ERR_TMR_ISR;
5229  0292 c68b          	ldab	#139
5230                     ; 703         return (OS_FALSE);
5234  0294 20ef          	bra	L63
5235  0296               L3433:
5236                     ; 705     OSSchedLock();
5238  0296 160000        	jsr	_OSSchedLock
5240                     ; 706     switch (ptmr->OSTmrState) {
5242  0299 ed82          	ldy	OFST+0,s
5243  029b e6e816        	ldab	22,y
5245  029e 2764          	beq	L5723
5246  02a0 040153        	dbeq	b,L3723
5247  02a3 040150        	dbeq	b,L3723
5248  02a6 040107        	dbeq	b,L1623
5249                     ; 753         default:
5249                     ; 754              OSSchedUnlock();
5251  02a9 160000        	jsr	_OSSchedUnlock
5253                     ; 755              *perr = OS_ERR_TMR_INVALID_STATE;
5255  02ac c68d          	ldab	#141
5256                     ; 757              return (OS_FALSE);
5260  02ae 20d5          	bra	L63
5261  02b0               L1623:
5262                     ; 707         case OS_TMR_STATE_RUNNING:
5262                     ; 708              OSTmr_Unlink(ptmr);                                  /* Remove from current wheel spoke                  */
5264  02b0 b764          	tfr	y,d
5265  02b2 1604c2        	jsr	L3562_OSTmr_Unlink
5267                     ; 709              *perr = OS_ERR_NONE;
5269  02b5 ed8a          	ldy	OFST+8,s
5270  02b7 6940          	clr	0,y
5271                     ; 710              switch (opt) {
5273  02b9 e687          	ldab	OFST+5,s
5275  02bb 2734          	beq	L3533
5276  02bd c003          	subb	#3
5277  02bf 2709          	beq	L3623
5278  02c1 040112        	dbeq	b,L5623
5279                     ; 732                  default:
5279                     ; 733                      *perr = OS_ERR_TMR_INVALID_OPT;
5281  02c4 c684          	ldab	#132
5282  02c6 6b40          	stab	0,y
5283                     ; 734                      break;
5285  02c8 2027          	bra	L3533
5286  02ca               L3623:
5287                     ; 711                  case OS_TMR_OPT_CALLBACK:
5287                     ; 712                       pfnct = ptmr->OSTmrCallback;                /* Execute callback function if available ...       */
5289  02ca ed82          	ldy	OFST+0,s
5290  02cc ec41          	ldd	1,y
5291  02ce 6c80          	std	OFST-2,s
5292                     ; 713                       if (pfnct != (OS_TMR_CALLBACK)0) {
5294  02d0 2719          	beq	L1633
5295                     ; 714                           (*pfnct)((void *)ptmr, ptmr->OSTmrCallbackArg);  /* Use callback arg when timer was created */
5297  02d2 ec43          	ldd	3,y
5300  02d4 200a          	bra	LC007
5301                     ; 716                           *perr = OS_ERR_TMR_NO_CALLBACK;
5303  02d6               L5623:
5304                     ; 720                  case OS_TMR_OPT_CALLBACK_ARG:
5304                     ; 721                       pfnct = ptmr->OSTmrCallback;                /* Execute callback function if available ...       */
5306  02d6 ed82          	ldy	OFST+0,s
5307  02d8 ec41          	ldd	1,y
5308  02da 6c80          	std	OFST-2,s
5309                     ; 722                       if (pfnct != (OS_TMR_CALLBACK)0) {
5311  02dc 270d          	beq	L1633
5312                     ; 723                           (*pfnct)((void *)ptmr, callback_arg);   /* ... using the 'callback_arg' provided in call    */
5314  02de ec88          	ldd	OFST+6,s
5316  02e0               LC007:
5317  02e0 3b            	pshd	
5318  02e1 ec84          	ldd	OFST+2,s
5319  02e3 15f30002      	jsr	[OFST+0,s]
5320  02e7 1b82          	leas	2,s
5322  02e9 2006          	bra	L3533
5323  02eb               L1633:
5324                     ; 725                           *perr = OS_ERR_TMR_NO_CALLBACK;
5326  02eb c68f          	ldab	#143
5327  02ed 6bf3000a      	stab	[OFST+8,s]
5328  02f1               L3533:
5329                     ; 736              OSSchedUnlock();
5331  02f1 160000        	jsr	_OSSchedUnlock
5333                     ; 738              return (OS_TRUE);
5337  02f4 2009          	bra	LC008
5338  02f6               L3723:
5339                     ; 740         case OS_TMR_STATE_COMPLETED:                              /* Timer has already completed the ONE-SHOT or ...  */
5339                     ; 741         case OS_TMR_STATE_STOPPED:                                /* ... timer has not started yet.                   */
5339                     ; 742              OSSchedUnlock();
5341  02f6 160000        	jsr	_OSSchedUnlock
5343                     ; 743              *perr = OS_ERR_TMR_STOPPED;
5345  02f9 c68e          	ldab	#142
5346  02fb 6bf3000a      	stab	[OFST+8,s]
5347                     ; 745              return (OS_TRUE);
5350  02ff               LC008:
5351  02ff c601          	ldab	#1
5353  0301               L04:
5355  0301 1b84          	leas	4,s
5356  0303 3d            	rts	
5357  0304               L5723:
5358                     ; 747         case OS_TMR_STATE_UNUSED:                                 /* Timer was not created                            */
5358                     ; 748              OSSchedUnlock();
5360  0304 160000        	jsr	_OSSchedUnlock
5362                     ; 749              *perr = OS_ERR_TMR_INACTIVE;
5364  0307 c687          	ldab	#135
5365  0309 6bf3000a      	stab	[OFST+8,s]
5366                     ; 751              return (OS_FALSE);
5369  030d c7            	clrb	
5371  030e 20f1          	bra	L04
5404                     ; 783 _NEAR INT8U  OSTmrSignal (void)
5404                     ; 784 {
5405                     	switch	.text
5406  0310               _OSTmrSignal:
5408  0310 37            	pshb	
5409       00000001      OFST:	set	1
5412                     ; 788     err = OSSemPost(OSTmrSemSignal);
5414  0311 fc0000        	ldd	_OSTmrSemSignal
5415  0314 160000        	jsr	_OSSemPost
5417                     ; 789     return (err);
5421  0317 1b81          	leas	1,s
5422  0319 3d            	rts	
5464                     ; 807 static  OS_TMR  *OSTmr_Alloc (void)
5464                     ; 808 {
5465                     	switch	.text
5466  031a               L3462_OSTmr_Alloc:
5468  031a 3b            	pshd	
5469       00000002      OFST:	set	2
5472                     ; 812     if (OSTmrFreeList == (OS_TMR *)0) {
5474  031b fd0000        	ldy	_OSTmrFreeList
5475  031e 2604          	bne	L3243
5476                     ; 813         return ((OS_TMR *)0);
5478  0320 87            	clra	
5479  0321 c7            	clrb	
5482  0322 31            	puly	
5483  0323 3d            	rts	
5484  0324               L3243:
5485                     ; 815     ptmr            = (OS_TMR *)OSTmrFreeList;
5487  0324 6d80          	sty	OFST-2,s
5488                     ; 816     OSTmrFreeList   = (OS_TMR *)ptmr->OSTmrNext;
5490  0326 1805450000    	movw	5,y,_OSTmrFreeList
5491                     ; 817     ptmr->OSTmrNext = (OS_TCB *)0;
5493  032b 87            	clra	
5494  032c c7            	clrb	
5495  032d 6c45          	std	5,y
5496                     ; 818     ptmr->OSTmrPrev = (OS_TCB *)0;
5498  032f 6c47          	std	7,y
5499                     ; 819     OSTmrUsed++;
5501  0331 fd0000        	ldy	_OSTmrUsed
5502  0334 02            	iny	
5503  0335 7d0000        	sty	_OSTmrUsed
5504                     ; 820     OSTmrFree--;
5506  0338 fd0000        	ldy	_OSTmrFree
5507  033b 03            	dey	
5508  033c 7d0000        	sty	_OSTmrFree
5509                     ; 821     return (ptmr);
5511  033f ec80          	ldd	OFST-2,s
5514  0341 31            	puly	
5515  0342 3d            	rts	
5554                     ; 839 static  void  OSTmr_Free (OS_TMR *ptmr)
5554                     ; 840 {
5555                     	switch	.text
5556  0343               L5462_OSTmr_Free:
5558  0343 3b            	pshd	
5559       00000000      OFST:	set	0
5562                     ; 841     ptmr->OSTmrState       = OS_TMR_STATE_UNUSED;      /* Clear timer object fields                                   */
5564  0344 b746          	tfr	d,y
5565                     ; 842     ptmr->OSTmrOpt         = OS_TMR_OPT_NONE;
5567  0346 87            	clra	
5568  0347 c7            	clrb	
5569  0348 6ce815        	std	21,y
5570                     ; 843     ptmr->OSTmrPeriod      = 0u;
5572  034b 6ce813        	std	19,y
5573  034e 6ce811        	std	17,y
5574                     ; 844     ptmr->OSTmrMatch       = 0u;
5576  0351 ed80          	ldy	OFST+0,s
5577  0353 6c4b          	std	11,y
5578  0355 6c49          	std	9,y
5579                     ; 845     ptmr->OSTmrCallback    = (OS_TMR_CALLBACK)0;
5581  0357 6c41          	std	1,y
5582                     ; 846     ptmr->OSTmrCallbackArg = (void *)0;
5584  0359 6c43          	std	3,y
5585                     ; 851     ptmr->OSTmrPrev        = (OS_TCB *)0;              /* Chain timer to free list                                    */
5587  035b 6c47          	std	7,y
5588                     ; 852     ptmr->OSTmrNext        = OSTmrFreeList;
5590  035d 1801450000    	movw	_OSTmrFreeList,5,y
5591                     ; 853     OSTmrFreeList          = ptmr;
5593  0362 7d0000        	sty	_OSTmrFreeList
5594                     ; 855     OSTmrUsed--;                                       /* Update timer object statistics                              */
5596  0365 fd0000        	ldy	_OSTmrUsed
5597  0368 03            	dey	
5598  0369 7d0000        	sty	_OSTmrUsed
5599                     ; 856     OSTmrFree++;
5601  036c fd0000        	ldy	_OSTmrFree
5602  036f 02            	iny	
5603  0370 7d0000        	sty	_OSTmrFree
5604                     ; 857 }
5607  0373 31            	puly	
5608  0374 3d            	rts	
5689                     ; 875 _NEAR void  OSTmr_Init (void)
5689                     ; 876 {
5690                     	switch	.text
5691  0375               _OSTmr_Init:
5693  0375 1b99          	leas	-7,s
5694       00000007      OFST:	set	7
5697                     ; 886     OS_MemClr((INT8U *)&OSTmrTbl[0],      sizeof(OSTmrTbl));            /* Clear all the TMRs                         */
5699  0377 cc0170        	ldd	#368
5700  037a 3b            	pshd	
5701  037b cc0000        	ldd	#_OSTmrTbl
5702  037e 160000        	jsr	_OS_MemClr
5704                     ; 887     OS_MemClr((INT8U *)&OSTmrWheelTbl[0], sizeof(OSTmrWheelTbl));       /* Clear the timer wheel                      */
5706  0381 cc0020        	ldd	#32
5707  0384 6c80          	std	0,s
5708  0386 cc0000        	ldd	#_OSTmrWheelTbl
5709  0389 160000        	jsr	_OS_MemClr
5711  038c 1b82          	leas	2,s
5712                     ; 889     for (ix = 0u; ix < (OS_TMR_CFG_MAX - 1u); ix++) {                   /* Init. list of free TMRs                    */
5714  038e 87            	clra	
5715  038f c7            	clrb	
5716  0390 b746          	tfr	d,y
5717  0392 6d82          	sty	OFST-5,s
5718  0394               L1053:
5719                     ; 890         ix_next = ix + 1u;
5721  0394 02            	iny	
5722  0395 6d84          	sty	OFST-3,s
5723                     ; 891         ptmr1 = &OSTmrTbl[ix];
5725  0397 cd0017        	ldy	#23
5726  039a 13            	emul	
5727  039b c30000        	addd	#_OSTmrTbl
5728  039e 6c80          	std	OFST-7,s
5729                     ; 892         ptmr2 = &OSTmrTbl[ix_next];
5731  03a0 ec84          	ldd	OFST-3,s
5732  03a2 cd0017        	ldy	#23
5733  03a5 13            	emul	
5734  03a6 c30000        	addd	#_OSTmrTbl
5735  03a9 6c84          	std	OFST-3,s
5736                     ; 893         ptmr1->OSTmrType    = OS_TMR_TYPE;
5738  03ab c664          	ldab	#100
5739  03ad ed80          	ldy	OFST-7,s
5740  03af 6b40          	stab	0,y
5741                     ; 894         ptmr1->OSTmrState   = OS_TMR_STATE_UNUSED;                      /* Indicate that timer is inactive            */
5743  03b1 69e816        	clr	22,y
5744                     ; 895         ptmr1->OSTmrNext    = (void *)ptmr2;                            /* Link to next timer                         */
5746  03b4 18028445      	movw	OFST-3,s,5,y
5747                     ; 889     for (ix = 0u; ix < (OS_TMR_CFG_MAX - 1u); ix++) {                   /* Init. list of free TMRs                    */
5749  03b8 ed82          	ldy	OFST-5,s
5750  03ba 02            	iny	
5753  03bb b764          	tfr	y,d
5754  03bd 6c82          	std	OFST-5,s
5755  03bf 8c000f        	cpd	#15
5756  03c2 25d0          	blo	L1053
5757                     ; 900     ptmr1               = &OSTmrTbl[ix];
5759  03c4 cd0017        	ldy	#23
5760  03c7 13            	emul	
5761  03c8 c30000        	addd	#_OSTmrTbl
5762  03cb 6c80          	std	OFST-7,s
5763                     ; 901     ptmr1->OSTmrType    = OS_TMR_TYPE;
5765  03cd c664          	ldab	#100
5766  03cf ed80          	ldy	OFST-7,s
5767  03d1 6b40          	stab	0,y
5768                     ; 902     ptmr1->OSTmrState   = OS_TMR_STATE_UNUSED;                          /* Indicate that timer is inactive            */
5770  03d3 87            	clra	
5771  03d4 6ae816        	staa	22,y
5772                     ; 903     ptmr1->OSTmrNext    = (void *)0;                                    /* Last OS_TMR                                */
5774  03d7 c7            	clrb	
5775  03d8 6c45          	std	5,y
5776                     ; 907     OSTmrTime           = 0u;
5778  03da 7c0002        	std	_OSTmrTime+2
5779  03dd 7c0000        	std	_OSTmrTime
5780                     ; 908     OSTmrUsed           = 0u;
5782  03e0 7c0000        	std	_OSTmrUsed
5783                     ; 909     OSTmrFree           = OS_TMR_CFG_MAX;
5785  03e3 c610          	ldab	#16
5786  03e5 7c0000        	std	_OSTmrFree
5787                     ; 910     OSTmrFreeList       = &OSTmrTbl[0];
5789  03e8 cc0000        	ldd	#_OSTmrTbl
5790  03eb 7c0000        	std	_OSTmrFreeList
5791                     ; 911     OSTmrSem            = OSSemCreate(1u);
5793  03ee cc0001        	ldd	#1
5794  03f1 160000        	jsr	_OSSemCreate
5796  03f4 7c0000        	std	_OSTmrSem
5797                     ; 912     OSTmrSemSignal      = OSSemCreate(0u);
5799  03f7 87            	clra	
5800  03f8 c7            	clrb	
5801  03f9 160000        	jsr	_OSSemCreate
5803  03fc 7c0000        	std	_OSTmrSemSignal
5804                     ; 915     OSEventNameSet(OSTmrSem,       (INT8U *)(void *)"uC/OS-II TmrLock",   &err);
5806  03ff 1a86          	leax	OFST-1,s
5807  0401 34            	pshx	
5808  0402 cc0020        	ldd	#L7053
5809  0405 3b            	pshd	
5810  0406 fc0000        	ldd	_OSTmrSem
5811  0409 160000        	jsr	_OSEventNameSet
5813  040c 1b84          	leas	4,s
5814                     ; 916     OSEventNameSet(OSTmrSemSignal, (INT8U *)(void *)"uC/OS-II TmrSignal", &err);
5816  040e 1a86          	leax	OFST-1,s
5817  0410 34            	pshx	
5818  0411 cc000d        	ldd	#L1153
5819  0414 3b            	pshd	
5820  0415 fc0000        	ldd	_OSTmrSemSignal
5821  0418 160000        	jsr	_OSEventNameSet
5823  041b 1b84          	leas	4,s
5824                     ; 919     OSTmr_InitTask();
5826  041d 0703          	jsr	L7462_OSTmr_InitTask
5828                     ; 920 }
5831  041f 1b87          	leas	7,s
5832  0421 3d            	rts	
5868                     ; 936 static  void  OSTmr_InitTask (void)
5868                     ; 937 {
5869                     	switch	.text
5870  0422               L7462_OSTmr_InitTask:
5872  0422 37            	pshb	
5873       00000001      OFST:	set	1
5876                     ; 945     (void)OSTaskCreateExt(OSTmr_Task,
5876                     ; 946                           (void *)0,                                       /* No arguments passed to OSTmrTask()      */
5876                     ; 947                           &OSTmrTaskStk[OS_TASK_TMR_STK_SIZE - 1u],        /* Set Top-Of-Stack                        */
5876                     ; 948                           OS_TASK_TMR_PRIO,
5876                     ; 949                           OS_TASK_TMR_ID,
5876                     ; 950                           &OSTmrTaskStk[0],                                /* Set Bottom-Of-Stack                     */
5876                     ; 951                           OS_TASK_TMR_STK_SIZE,
5876                     ; 952                           (void *)0,                                       /* No TCB extension                        */
5876                     ; 953                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);      /* Enable stack checking + clear stack     */
5878  0423 cc0003        	ldd	#3
5879  0426 3b            	pshd	
5880  0427 c7            	clrb	
5881  0428 3b            	pshd	
5882  0429 c6a0          	ldab	#160
5883  042b 3b            	pshd	
5884  042c c7            	clrb	
5885  042d 3b            	pshd	
5886  042e cc0000        	ldd	#_OSTmrTaskStk
5887  0431 3b            	pshd	
5888  0432 ccfffd        	ldd	#-3
5889  0435 3b            	pshd	
5890  0436 cc003d        	ldd	#61
5891  0439 3b            	pshd	
5892  043a cc009f        	ldd	#_OSTmrTaskStk+159
5893  043d 3b            	pshd	
5894  043e 87            	clra	
5895  043f c7            	clrb	
5896  0440 3b            	pshd	
5897  0441 cc0518        	ldd	#L5562_OSTmr_Task
5898  0444 160000        	jsr	_OSTaskCreateExt
5900  0447 1bf012        	leas	18,s
5901                     ; 980     OSTaskNameSet(OS_TASK_TMR_PRIO, (INT8U *)(void *)"uC/OS-II Tmr", &err);
5903  044a 1a80          	leax	OFST-1,s
5904  044c 34            	pshx	
5905  044d cc0000        	ldd	#L7253
5906  0450 3b            	pshd	
5907  0451 cc003d        	ldd	#61
5908  0454 160000        	jsr	_OSTaskNameSet
5910                     ; 982 }
5913  0457 1b85          	leas	5,s
5914  0459 3d            	rts	
6016                     ; 1004 static  void  OSTmr_Link (OS_TMR  *ptmr,
6016                     ; 1005                           INT8U    type)
6016                     ; 1006 {
6017                     	switch	.text
6018  045a               L1562_OSTmr_Link:
6020  045a 3b            	pshd	
6021  045b 1b9c          	leas	-4,s
6022       00000004      OFST:	set	4
6025                     ; 1012     ptmr->OSTmrState = OS_TMR_STATE_RUNNING;
6027  045d c603          	ldab	#3
6028  045f ed84          	ldy	OFST+0,s
6029  0461 6be816        	stab	22,y
6030                     ; 1013     if (type == OS_TMR_LINK_PERIODIC) {                            /* Determine when timer will expire                */
6032  0464 e689          	ldab	OFST+5,s
6033  0466 53            	decb	
6034                     ; 1014         ptmr->OSTmrMatch = ptmr->OSTmrPeriod + OSTmrTime;
6038  0467 2708          	beq	LC009
6039                     ; 1016         if (ptmr->OSTmrDly == 0u) {
6041  0469 ec4d          	ldd	13,y
6042  046b 260c          	bne	L1163
6043  046d ec4f          	ldd	15,y
6044  046f 2608          	bne	L1163
6045                     ; 1017             ptmr->OSTmrMatch = ptmr->OSTmrPeriod + OSTmrTime;
6047  0471               LC009:
6048  0471 ece813        	ldd	19,y
6049  0474 eee811        	ldx	17,y
6052  0477 2004          	bra	L7063
6053  0479               L1163:
6054                     ; 1019             ptmr->OSTmrMatch = ptmr->OSTmrDly    + OSTmrTime;
6056  0479 ec4f          	ldd	15,y
6057  047b ee4d          	ldx	13,y
6059  047d               L7063:
6060  047d cd0000        	ldy	#_OSTmrTime
6061  0480 160000        	jsr	c_ladd
6062  0483 ed84          	ldy	OFST+0,s
6063  0485 6c4b          	std	11,y
6064  0487 6e49          	stx	9,y
6065                     ; 1022     spoke  = (INT16U)(ptmr->OSTmrMatch % OS_TMR_CFG_WHEEL_SIZE);
6067  0489 c407          	andb	#7
6068  048b 87            	clra	
6069  048c 6c82          	std	OFST-2,s
6070                     ; 1023     pspoke = &OSTmrWheelTbl[spoke];
6072  048e 59            	lsld	
6073  048f 59            	lsld	
6074  0490 c30000        	addd	#_OSTmrWheelTbl
6075                     ; 1025     if (pspoke->OSTmrFirst == (OS_TMR *)0) {                       /* Link into timer wheel                           */
6077  0493 b745          	tfr	d,x
6078  0495 6e80          	stx	OFST-4,s
6079  0497 ec00          	ldd	0,x
6080  0499 2609          	bne	L5163
6081                     ; 1026         pspoke->OSTmrFirst   = ptmr;
6083  049b 6d00          	sty	0,x
6084                     ; 1027         ptmr->OSTmrNext      = (OS_TMR *)0;
6086  049d 6c45          	std	5,y
6087                     ; 1028         pspoke->OSTmrEntries = 1u;
6089  049f 52            	incb	
6090  04a0 b756          	tfr	x,y
6092  04a2 2013          	bra	L7163
6093  04a4               L5163:
6094                     ; 1030         ptmr1                = pspoke->OSTmrFirst;                 /* Point to first timer in the spoke               */
6096  04a4 6c82          	std	OFST-2,s
6097                     ; 1031         pspoke->OSTmrFirst   = ptmr;
6099  04a6 6d00          	sty	0,x
6100                     ; 1032         ptmr->OSTmrNext      = (void *)ptmr1;
6102  04a8 6c45          	std	5,y
6103                     ; 1033         ptmr1->OSTmrPrev     = (void *)ptmr;
6105  04aa b764          	tfr	y,d
6106  04ac ed82          	ldy	OFST-2,s
6107  04ae 6c47          	std	7,y
6108                     ; 1034         pspoke->OSTmrEntries++;
6110  04b0 b756          	tfr	x,y
6111  04b2 ec42          	ldd	2,y
6112  04b4 c30001        	addd	#1
6113  04b7               L7163:
6114  04b7 6c42          	std	2,y
6115                     ; 1036     ptmr->OSTmrPrev = (void *)0;                                   /* Timer always inserted as first node in list     */
6117  04b9 87            	clra	
6118  04ba c7            	clrb	
6119  04bb ee84          	ldx	OFST+0,s
6120  04bd 6c07          	std	7,x
6121                     ; 1037 }
6124  04bf 1b86          	leas	6,s
6125  04c1 3d            	rts	
6205                     ; 1054 static  void  OSTmr_Unlink (OS_TMR *ptmr)
6205                     ; 1055 {
6206                     	switch	.text
6207  04c2               L3562_OSTmr_Unlink:
6209  04c2 3b            	pshd	
6210  04c3 1b9a          	leas	-6,s
6211       00000006      OFST:	set	6
6214                     ; 1062     spoke  = (INT16U)(ptmr->OSTmrMatch % OS_TMR_CFG_WHEEL_SIZE);
6216  04c5 b746          	tfr	d,y
6217  04c7 e64c          	ldab	12,y
6218  04c9 c407          	andb	#7
6219  04cb 87            	clra	
6220  04cc 6c82          	std	OFST-4,s
6221                     ; 1063     pspoke = &OSTmrWheelTbl[spoke];
6223  04ce 59            	lsld	
6224  04cf 59            	lsld	
6225  04d0 c30000        	addd	#_OSTmrWheelTbl
6226                     ; 1065     if (pspoke->OSTmrFirst == ptmr) {                       /* See if timer to remove is at the beginning of list     */
6228  04d3 b745          	tfr	d,x
6229  04d5 6e84          	stx	OFST-2,s
6230  04d7 ec00          	ldd	0,x
6231  04d9 ac86          	cpd	OFST+0,s
6232  04db 260e          	bne	L5663
6233                     ; 1066         ptmr1              = (OS_TMR *)ptmr->OSTmrNext;
6235  04dd ed86          	ldy	OFST+0,s
6236  04df ed45          	ldy	5,y
6237  04e1 6d80          	sty	OFST-6,s
6238                     ; 1067         pspoke->OSTmrFirst = (OS_TMR *)ptmr1;
6240  04e3 6d00          	sty	0,x
6241                     ; 1068         if (ptmr1 != (OS_TMR *)0) {
6243  04e5 271a          	beq	L1763
6244                     ; 1069             ptmr1->OSTmrPrev = (void *)0;
6246  04e7 87            	clra	
6247  04e8 c7            	clrb	
6248  04e9 2014          	bra	LC010
6249  04eb               L5663:
6250                     ; 1072         ptmr1            = (OS_TMR *)ptmr->OSTmrPrev;       /* Remove timer from somewhere in the list                */
6252  04eb ed86          	ldy	OFST+0,s
6253  04ed 18024780      	movw	7,y,OFST-6,s
6254                     ; 1073         ptmr2            = (OS_TMR *)ptmr->OSTmrNext;
6256  04f1 ec45          	ldd	5,y
6257  04f3 6c82          	std	OFST-4,s
6258                     ; 1074         ptmr1->OSTmrNext = ptmr2;
6260  04f5 ed80          	ldy	OFST-6,s
6261  04f7 6c45          	std	5,y
6262                     ; 1075         if (ptmr2 != (OS_TMR *)0) {
6264  04f9 2706          	beq	L1763
6265                     ; 1076             ptmr2->OSTmrPrev = (void *)ptmr1;
6267  04fb b764          	tfr	y,d
6268  04fd ed82          	ldy	OFST-4,s
6269  04ff               LC010:
6270  04ff 6c47          	std	7,y
6271  0501               L1763:
6272                     ; 1079     ptmr->OSTmrState = OS_TMR_STATE_STOPPED;
6274  0501 c601          	ldab	#1
6275  0503 ed86          	ldy	OFST+0,s
6276  0505 6be816        	stab	22,y
6277                     ; 1080     ptmr->OSTmrNext  = (void *)0;
6279  0508 87            	clra	
6280  0509 c7            	clrb	
6281  050a 6c45          	std	5,y
6282                     ; 1081     ptmr->OSTmrPrev  = (void *)0;
6284  050c 6c47          	std	7,y
6285                     ; 1082     pspoke->OSTmrEntries--;
6287  050e b756          	tfr	x,y
6288  0510 ee42          	ldx	2,y
6289  0512 09            	dex	
6290  0513 6e42          	stx	2,y
6291                     ; 1083 }
6294  0515 1b88          	leas	8,s
6295  0517 3d            	rts	
6398                     ; 1100 static  void  OSTmr_Task (void *p_arg)
6398                     ; 1101 {
6399                     	switch	.text
6400  0518               L5562_OSTmr_Task:
6402  0518 3b            	pshd	
6403  0519 1b99          	leas	-7,s
6404       00000007      OFST:	set	7
6407                     ; 1110     p_arg = p_arg;                                               /* Prevent compiler warning for not using 'p_arg'    */
6409  051b               L5473:
6410                     ; 1112         OSSemPend(OSTmrSemSignal, 0u, &err);                     /* Wait for signal indicating time to update timers  */
6412  051b 1a86          	leax	OFST-1,s
6413  051d 34            	pshx	
6414  051e 87            	clra	
6415  051f c7            	clrb	
6416  0520 3b            	pshd	
6417  0521 3b            	pshd	
6418  0522 fc0000        	ldd	_OSTmrSemSignal
6419  0525 160000        	jsr	_OSSemPend
6421  0528 1b86          	leas	6,s
6422                     ; 1113         OSSchedLock();
6424  052a 160000        	jsr	_OSSchedLock
6426                     ; 1114         OSTmrTime++;                                             /* Increment the current time                        */
6428  052d fc0002        	ldd	_OSTmrTime+2
6429  0530 c30001        	addd	#1
6430  0533 7c0002        	std	_OSTmrTime+2
6431  0536 2408          	bcc	L46
6432  0538 720001        	inc	_OSTmrTime+1
6433  053b 2603          	bne	L46
6434  053d 720000        	inc	_OSTmrTime
6435  0540               L46:
6436                     ; 1115         spoke  = (INT16U)(OSTmrTime % OS_TMR_CFG_WHEEL_SIZE);    /* Position on current timer wheel entry             */
6438  0540 c407          	andb	#7
6439  0542 87            	clra	
6440                     ; 1116         pspoke = &OSTmrWheelTbl[spoke];
6442  0543 59            	lsld	
6443  0544 59            	lsld	
6444  0545 c30000        	addd	#_OSTmrWheelTbl
6445  0548 6c82          	std	OFST-5,s
6446                     ; 1117         ptmr   = pspoke->OSTmrFirst;
6448  054a ecf30002      	ldd	[OFST-5,s]
6450  054e 2049          	bra	L5573
6451  0550               L1573:
6452                     ; 1119             ptmr_next = (OS_TMR *)ptmr->OSTmrNext;               /* Point to next timer to update because current ... */
6454  0550 b746          	tfr	d,y
6455  0552 18024582      	movw	5,y,OFST-5,s
6456                     ; 1121             if (OSTmrTime == ptmr->OSTmrMatch) {                 /* Process each timer that expires                   */
6458  0556 fc0000        	ldd	_OSTmrTime
6459  0559 ac49          	cpd	9,y
6460  055b 263a          	bne	L1673
6461  055d fc0002        	ldd	_OSTmrTime+2
6462  0560 ac4b          	cpd	11,y
6463  0562 2633          	bne	L1673
6464                     ; 1123                 OSTmr_Unlink(ptmr);                              /* Remove from current wheel spoke                   */
6467  0564 ec80          	ldd	OFST-7,s
6468  0566 1604c2        	jsr	L3562_OSTmr_Unlink
6470                     ; 1124                 if (ptmr->OSTmrOpt == OS_TMR_OPT_PERIODIC) {
6472  0569 ed80          	ldy	OFST-7,s
6473  056b e6e815        	ldab	21,y
6474  056e c102          	cmpb	#2
6475  0570 260f          	bne	L3673
6476                     ; 1125                     OSTmr_Link(ptmr, OS_TMR_LINK_PERIODIC);      /* Recalculate new position of timer in wheel        */
6478  0572 cc0001        	ldd	#1
6479  0575 3b            	pshd	
6480  0576 b764          	tfr	y,d
6481  0578 16045a        	jsr	L1562_OSTmr_Link
6483  057b 1b82          	leas	2,s
6485  057d ed80          	ldy	OFST-7,s
6486  057f 2005          	bra	L5673
6487  0581               L3673:
6488                     ; 1127                     ptmr->OSTmrState = OS_TMR_STATE_COMPLETED;   /* Indicate that the timer has completed             */
6490  0581 c602          	ldab	#2
6491  0583 6be816        	stab	22,y
6492  0586               L5673:
6493                     ; 1129                 pfnct = ptmr->OSTmrCallback;                     /* Execute callback function if available            */
6495  0586 ec41          	ldd	1,y
6496  0588 6c84          	std	OFST-3,s
6497                     ; 1130                 if (pfnct != (OS_TMR_CALLBACK)0) {
6499  058a 270b          	beq	L1673
6500                     ; 1131                     (*pfnct)((void *)ptmr, ptmr->OSTmrCallbackArg);
6502  058c ec43          	ldd	3,y
6503  058e 3b            	pshd	
6504  058f ec82          	ldd	OFST-5,s
6505  0591 15f30006      	jsr	[OFST-1,s]
6507  0595 1b82          	leas	2,s
6508  0597               L1673:
6509                     ; 1134             ptmr = ptmr_next;
6511  0597 ec82          	ldd	OFST-5,s
6512  0599               L5573:
6513  0599 6c80          	std	OFST-7,s
6514                     ; 1118         while (ptmr != (OS_TMR *)0) {
6516  059b 26b3          	bne	L1573
6517                     ; 1136         OSSchedUnlock();
6519  059d 160000        	jsr	_OSSchedUnlock
6522  05a0 06051b        	bra	L5473
6534                     	xdef	_OSTmr_Init
6535                     	xref	_OS_MemClr
6536                     	xref	_OSSchedUnlock
6537                     	xref	_OSSchedLock
6538                     	xdef	_OSTmrSignal
6539                     	xdef	_OSTmrStop
6540                     	xdef	_OSTmrStart
6541                     	xdef	_OSTmrStateGet
6542                     	xdef	_OSTmrRemainGet
6543                     	xdef	_OSTmrDel
6544                     	xdef	_OSTmrCreate
6545                     	xref	_OSTaskNameSet
6546                     	xref	_OSTaskCreateExt
6547                     	xref	_OSSemPost
6548                     	xref	_OSSemPend
6549                     	xref	_OSSemCreate
6550                     	xref	_OSEventNameSet
6551                     	xref	_OSTmrWheelTbl
6552                     	xref	_OSTmrTaskStk
6553                     	xref	_OSTmrFreeList
6554                     	xref	_OSTmrTbl
6555                     	xref	_OSTmrSemSignal
6556                     	xref	_OSTmrSem
6557                     	xref	_OSTmrTime
6558                     	xref	_OSTmrUsed
6559                     	xref	_OSTmrFree
6560                     	xref	_OSIntNesting
6561                     .const:	section	.data
6562  0000               L7253:
6563  0000 75432f4f532d  	dc.b	"uC/OS-II Tmr",0
6564  000d               L1153:
6565  000d 75432f4f532d  	dc.b	"uC/OS-II TmrSignal",0
6566  0020               L7053:
6567  0020 75432f4f532d  	dc.b	"uC/OS-II TmrLock",0
6588                     	xref	c_ladd
6589                     	xref	c_lsub
6590                     	end

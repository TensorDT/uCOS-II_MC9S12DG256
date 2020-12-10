   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4118                     ; 101 _NEAR OS_FLAGS  OSFlagAccept (OS_FLAG_GRP  *pgrp,
4118                     ; 102                              OS_FLAGS      flags,
4118                     ; 103                              INT8U         wait_type,
4118                     ; 104                              INT8U        *perr)
4118                     ; 105 {
4119                     	switch	.text
4120  0000               _OSFlagAccept:
4122  0000 3b            	pshd	
4123  0001 1b9c          	leas	-4,s
4124       00000004      OFST:	set	4
4127                     ; 110     OS_CPU_SR     cpu_sr = 0u;
4129                     ; 123     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
4131  0003 046404        	tbne	d,L7472
4132                     ; 124         *perr = OS_ERR_FLAG_INVALID_PGRP;
4134  0006 c66e          	ldab	#110
4135                     ; 125         return ((OS_FLAGS)0);
4138  0008 200a          	bra	L6
4139  000a               L7472:
4140                     ; 128     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event block type                */
4142  000a e6f30004      	ldab	[OFST+0,s]
4143  000e c105          	cmpb	#5
4144  0010 270b          	beq	L1572
4145                     ; 129         *perr = OS_ERR_EVENT_TYPE;
4147  0012 c601          	ldab	#1
4148                     ; 130         return ((OS_FLAGS)0);
4151  0014               L6:
4152  0014 6bf3000c      	stab	[OFST+8,s]
4153  0018 87            	clra	
4154  0019 c7            	clrb	
4156  001a 1b86          	leas	6,s
4157  001c 3d            	rts	
4158  001d               L1572:
4159                     ; 132     result = (INT8U)(wait_type & OS_FLAG_CONSUME);
4161  001d e68b          	ldab	OFST+7,s
4162  001f c480          	andb	#128
4163  0021 6b82          	stab	OFST-2,s
4164                     ; 133     if (result != (INT8U)0) {                              /* See if we need to consume the flags      */
4166  0023 2709          	beq	L3572
4167                     ; 134         wait_type &= ~OS_FLAG_CONSUME;
4169  0025 0d8b80        	bclr	OFST+7,s,128
4170                     ; 135         consume    = OS_TRUE;
4172  0028 c601          	ldab	#1
4173  002a 6b82          	stab	OFST-2,s
4175  002c 2002          	bra	L5572
4176  002e               L3572:
4177                     ; 137         consume    = OS_FALSE;
4179  002e 6982          	clr	OFST-2,s
4180  0030               L5572:
4181                     ; 140     *perr = OS_ERR_NONE;                                   /* Assume NO error until proven otherwise.  */
4183  0030 69f3000c      	clr	[OFST+8,s]
4184                     ; 141     OS_ENTER_CRITICAL();
4186  0034 160000        	jsr	_OS_CPU_SR_Save
4188  0037 6b83          	stab	OFST-1,s
4189                     ; 142     switch (wait_type) {
4191  0039 e68b          	ldab	OFST+7,s
4193  003b 2748          	beq	L3562
4194  003d 53            	decb	
4195  003e 2762          	beq	L5562
4196  0040 040115        	dbeq	b,L7462
4197  0043 040131        	dbeq	b,L1562
4198                     ; 193         default:
4198                     ; 194              OS_EXIT_CRITICAL();
4200  0046 e683          	ldab	OFST-1,s
4201  0048 87            	clra	
4202  0049 160000        	jsr	_OS_CPU_SR_Restore
4204                     ; 195              flags_rdy = (OS_FLAGS)0;
4206  004c 87            	clra	
4207  004d c7            	clrb	
4208  004e 6c80          	std	OFST-4,s
4209                     ; 196              *perr     = OS_ERR_FLAG_WAIT_TYPE;
4211  0050 c66f          	ldab	#111
4212  0052 6bf3000c      	stab	[OFST+8,s]
4213                     ; 197              break;
4215  0056 206b          	bra	L1672
4216  0058               L7462:
4217                     ; 143         case OS_FLAG_WAIT_SET_ALL:                         /* See if all required flags are set        */
4217                     ; 144              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);     /* Extract only the bits we want   */
4219  0058 ed84          	ldy	OFST+0,s
4220  005a ec43          	ldd	3,y
4221  005c e489          	andb	OFST+5,s
4222  005e a488          	anda	OFST+4,s
4223  0060 6c80          	std	OFST-4,s
4224                     ; 145              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
4226  0062 ac88          	cpd	OFST+4,s
4227  0064 2651          	bne	L5003
4228                     ; 146                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
4230                     ; 147                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;     /* Clear ONLY the flags we wanted  */
4232  0066               LC004:
4233  0066 e682          	ldab	OFST-2,s
4234  0068 53            	decb	
4235  0069 2652          	bne	L1103
4236  006b ec80          	ldd	OFST-4,s
4237  006d 51            	comb	
4238  006e 41            	coma	
4239  006f e444          	andb	4,y
4240  0071 a443          	anda	3,y
4241  0073               LC003:
4242  0073 6c43          	std	3,y
4243  0075 2046          	bra	L1103
4244                     ; 150                  *perr = OS_ERR_FLAG_NOT_RDY;
4246                     ; 152              OS_EXIT_CRITICAL();
4249                     ; 153              break;
4251  0077               L1562:
4252                     ; 155         case OS_FLAG_WAIT_SET_ANY:
4252                     ; 156              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);     /* Extract only the bits we want   */
4254  0077 ed84          	ldy	OFST+0,s
4255  0079 ec43          	ldd	3,y
4256  007b e489          	andb	OFST+5,s
4257  007d a488          	anda	OFST+4,s
4258  007f 6c80          	std	OFST-4,s
4259                     ; 157              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag set                      */
4261  0081 2734          	beq	L5003
4262                     ; 158                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
4264                     ; 159                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;     /* Clear ONLY the flags we got     */
4266  0083 20e1          	bra	LC004
4267                     ; 162                  *perr = OS_ERR_FLAG_NOT_RDY;
4269                     ; 164              OS_EXIT_CRITICAL();
4272                     ; 165              break;
4274  0085               L3562:
4275                     ; 168         case OS_FLAG_WAIT_CLR_ALL:                         /* See if all required flags are cleared    */
4275                     ; 169              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;    /* Extract only the bits we want     */
4277  0085 ed84          	ldy	OFST+0,s
4278  0087 ec43          	ldd	3,y
4279  0089 51            	comb	
4280  008a 41            	coma	
4281  008b e489          	andb	OFST+5,s
4282  008d a488          	anda	OFST+4,s
4283  008f 6c80          	std	OFST-4,s
4284                     ; 170              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
4286  0091 ac88          	cpd	OFST+4,s
4287  0093 2622          	bne	L5003
4288                     ; 171                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
4290  0095 e682          	ldab	OFST-2,s
4291  0097 53            	decb	
4292  0098 2623          	bne	L1103
4293                     ; 172                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we wanted        */
4295  009a               LC005:
4296  009a ec43          	ldd	3,y
4297  009c ea81          	orab	OFST-3,s
4298  009e aa80          	oraa	OFST-4,s
4299  00a0 20d1          	bra	LC003
4300                     ; 175                  *perr = OS_ERR_FLAG_NOT_RDY;
4302                     ; 177              OS_EXIT_CRITICAL();
4305                     ; 178              break;
4307  00a2               L5562:
4308                     ; 180         case OS_FLAG_WAIT_CLR_ANY:
4308                     ; 181              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;   /* Extract only the bits we want      */
4310  00a2 ed84          	ldy	OFST+0,s
4311  00a4 ec43          	ldd	3,y
4312  00a6 51            	comb	
4313  00a7 41            	coma	
4314  00a8 e489          	andb	OFST+5,s
4315  00aa a488          	anda	OFST+4,s
4316  00ac 6c80          	std	OFST-4,s
4317                     ; 182              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag cleared                  */
4319  00ae 2707          	beq	L5003
4320                     ; 183                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
4322  00b0 e682          	ldab	OFST-2,s
4323  00b2 042108        	dbne	b,L1103
4324                     ; 184                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we got           */
4326  00b5 20e3          	bra	LC005
4327  00b7               L5003:
4328                     ; 187                  *perr = OS_ERR_FLAG_NOT_RDY;
4330  00b7 c670          	ldab	#112
4331  00b9 6bf3000c      	stab	[OFST+8,s]
4332  00bd               L1103:
4333                     ; 189              OS_EXIT_CRITICAL();
4335  00bd e683          	ldab	OFST-1,s
4336  00bf 87            	clra	
4337  00c0 160000        	jsr	_OS_CPU_SR_Restore
4339                     ; 190              break;
4341  00c3               L1672:
4342                     ; 199     return (flags_rdy);
4344  00c3 ec80          	ldd	OFST-4,s
4347  00c5 1b86          	leas	6,s
4348  00c7 3d            	rts	
4415                     ; 226 _NEAR OS_FLAG_GRP  *OSFlagCreate (OS_FLAGS  flags,
4415                     ; 227                                  INT8U    *perr)
4415                     ; 228 {
4416                     	switch	.text
4417  00c8               _OSFlagCreate:
4419  00c8 3b            	pshd	
4420  00c9 1b9d          	leas	-3,s
4421       00000003      OFST:	set	3
4424                     ; 231     OS_CPU_SR    cpu_sr = 0u;
4426                     ; 251     if (OSIntNesting > 0u) {                        /* See if called from ISR ...                      */
4428  00cb f60000        	ldab	_OSIntNesting
4429  00ce 270a          	beq	L5403
4430                     ; 252         *perr = OS_ERR_CREATE_ISR;                  /* ... can't CREATE from an ISR                    */
4432  00d0 c610          	ldab	#16
4433  00d2 6bf30007      	stab	[OFST+4,s]
4434                     ; 253         return ((OS_FLAG_GRP *)0);
4436  00d6 87            	clra	
4437  00d7 c7            	clrb	
4439  00d8 203c          	bra	L21
4440  00da               L5403:
4441                     ; 255     OS_ENTER_CRITICAL();
4443  00da 160000        	jsr	_OS_CPU_SR_Save
4445  00dd 6b82          	stab	OFST-1,s
4446                     ; 256     pgrp = OSFlagFreeList;                          /* Get next free event flag                        */
4448  00df fd0000        	ldy	_OSFlagFreeList
4449  00e2 6d80          	sty	OFST-3,s
4450                     ; 257     if (pgrp != (OS_FLAG_GRP *)0) {                 /* See if we have event flag groups available      */
4452  00e4 ee80          	ldx	OFST-3,s
4453  00e6 2722          	beq	L7403
4454                     ; 259         OSFlagFreeList       = (OS_FLAG_GRP *)OSFlagFreeList->OSFlagWaitList;
4456  00e8 1805410000    	movw	1,y,_OSFlagFreeList
4457                     ; 260         pgrp->OSFlagType     = OS_EVENT_TYPE_FLAG;  /* Set to event flag group type                    */
4459  00ed c605          	ldab	#5
4460  00ef 6b00          	stab	0,x
4461                     ; 261         pgrp->OSFlagFlags    = flags;               /* Set to desired initial value                    */
4463  00f1 18028343      	movw	OFST+0,s,3,y
4464                     ; 262         pgrp->OSFlagWaitList = (void *)0;           /* Clear list of tasks waiting on flags            */
4466  00f5 87            	clra	
4467  00f6 c7            	clrb	
4468  00f7 6c41          	std	1,y
4469                     ; 264         pgrp->OSFlagName     = (INT8U *)(void *)"?";
4471  00f9 cc0000        	ldd	#L1503
4472  00fc 6c45          	std	5,y
4473                     ; 267         OS_EXIT_CRITICAL();
4476  00fe e682          	ldab	OFST-1,s
4477  0100 87            	clra	
4478  0101 160000        	jsr	_OS_CPU_SR_Restore
4480                     ; 268         *perr                = OS_ERR_NONE;
4482  0104 69f30007      	clr	[OFST+4,s]
4484  0108 200a          	bra	L3503
4485  010a               L7403:
4486                     ; 270         OS_EXIT_CRITICAL();
4488  010a 87            	clra	
4489  010b 160000        	jsr	_OS_CPU_SR_Restore
4491                     ; 271         *perr                = OS_ERR_FLAG_GRP_DEPLETED;
4493  010e c672          	ldab	#114
4494  0110 6bf30007      	stab	[OFST+4,s]
4495  0114               L3503:
4496                     ; 273     return (pgrp);                                  /* Return pointer to event flag group              */
4498  0114 ec80          	ldd	OFST-3,s
4500  0116               L21:
4502  0116 1b85          	leas	5,s
4503  0118 3d            	rts	
4664                     ; 318 _NEAR OS_FLAG_GRP  *OSFlagDel (OS_FLAG_GRP  *pgrp,
4664                     ; 319                               INT8U         opt,
4664                     ; 320                               INT8U        *perr)
4664                     ; 321 {
4665                     	switch	.text
4666  0119               _OSFlagDel:
4668  0119 3b            	pshd	
4669  011a 1b9c          	leas	-4,s
4670       00000004      OFST:	set	4
4673                     ; 326     OS_CPU_SR     cpu_sr = 0u;
4675                     ; 346     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
4677  011c 046404        	tbne	d,L3613
4678                     ; 347         *perr = OS_ERR_FLAG_INVALID_PGRP;
4680  011f c66e          	ldab	#110
4681                     ; 348         return (pgrp);
4684  0121 2007          	bra	L61
4685  0123               L3613:
4686                     ; 354     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
4689  0123 f60000        	ldab	_OSIntNesting
4690  0126 270b          	beq	L5613
4691                     ; 355         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
4693  0128 c60f          	ldab	#15
4694                     ; 357         return (pgrp);
4698  012a               L61:
4699  012a 6bf3000a      	stab	[OFST+6,s]
4700  012e ec84          	ldd	OFST+0,s
4702  0130 1b86          	leas	6,s
4703  0132 3d            	rts	
4704  0133               L5613:
4705                     ; 359     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event group type                */
4707  0133 e6f30004      	ldab	[OFST+0,s]
4708  0137 c105          	cmpb	#5
4709  0139 2704          	beq	L7613
4710                     ; 360         *perr = OS_ERR_EVENT_TYPE;
4712  013b c601          	ldab	#1
4713                     ; 362         return (pgrp);
4717  013d 20eb          	bra	L61
4718  013f               L7613:
4719                     ; 364     OS_ENTER_CRITICAL();
4721  013f 160000        	jsr	_OS_CPU_SR_Save
4723  0142 6b82          	stab	OFST-2,s
4724                     ; 365     if (pgrp->OSFlagWaitList != (void *)0) {               /* See if any tasks waiting on event flags  */
4726  0144 ed84          	ldy	OFST+0,s
4727  0146 ec41          	ldd	1,y
4728  0148 2706          	beq	L1713
4729                     ; 366         tasks_waiting = OS_TRUE;                           /* Yes                                      */
4731  014a c601          	ldab	#1
4732  014c 6b83          	stab	OFST-1,s
4734  014e 2002          	bra	L3713
4735  0150               L1713:
4736                     ; 368         tasks_waiting = OS_FALSE;                          /* No                                       */
4738  0150 6983          	clr	OFST-1,s
4739  0152               L3713:
4740                     ; 370     switch (opt) {
4742  0152 e689          	ldab	OFST+5,s
4744  0154 270d          	beq	L5503
4745  0156 040142        	dbeq	b,L7503
4746                     ; 411         default:
4746                     ; 412              OS_EXIT_CRITICAL();
4748  0159 e682          	ldab	OFST-2,s
4749  015b 87            	clra	
4750  015c 160000        	jsr	_OS_CPU_SR_Restore
4752                     ; 413              *perr                = OS_ERR_INVALID_OPT;
4754  015f c607          	ldab	#7
4755                     ; 414              pgrp_return          = pgrp;
4757                     ; 415              break;
4759  0161 202e          	bra	LC007
4760  0163               L5503:
4761                     ; 371         case OS_DEL_NO_PEND:                               /* Delete group if no task waiting          */
4761                     ; 372              if (tasks_waiting == OS_FALSE) {
4763  0163 e683          	ldab	OFST-1,s
4764  0165 2622          	bne	L1023
4765                     ; 374                  pgrp->OSFlagName     = (INT8U *)(void *)"?";
4767  0167 cc0000        	ldd	#L1503
4768  016a 6c45          	std	5,y
4769                     ; 376                  pgrp->OSFlagType     = OS_EVENT_TYPE_UNUSED;
4771  016c 87            	clra	
4772  016d 6a40          	staa	0,y
4773                     ; 377                  pgrp->OSFlagWaitList = (void *)OSFlagFreeList; /* Return group to free list           */
4775  016f 1801410000    	movw	_OSFlagFreeList,1,y
4776                     ; 378                  pgrp->OSFlagFlags    = (OS_FLAGS)0;
4778  0174 c7            	clrb	
4779  0175 6c43          	std	3,y
4780                     ; 379                  OSFlagFreeList       = pgrp;
4782  0177 1805840000    	movw	OFST+0,s,_OSFlagFreeList
4783                     ; 380                  OS_EXIT_CRITICAL();
4785  017c e682          	ldab	OFST-2,s
4786  017e 160000        	jsr	_OS_CPU_SR_Restore
4788                     ; 381                  *perr                = OS_ERR_NONE;
4790  0181 87            	clra	
4791  0182 6af3000a      	staa	[OFST+6,s]
4792                     ; 382                  pgrp_return          = (OS_FLAG_GRP *)0;  /* Event Flag Group has been deleted        */
4794  0186 c7            	clrb	
4796  0187 200e          	bra	LC006
4797  0189               L1023:
4798                     ; 384                  OS_EXIT_CRITICAL();
4800  0189 e682          	ldab	OFST-2,s
4801  018b 87            	clra	
4802  018c 160000        	jsr	_OS_CPU_SR_Restore
4804                     ; 385                  *perr                = OS_ERR_TASK_WAITING;
4806  018f c649          	ldab	#73
4807                     ; 386                  pgrp_return          = pgrp;
4809  0191               LC007:
4810  0191 6bf3000a      	stab	[OFST+6,s]
4811  0195 ec84          	ldd	OFST+0,s
4812  0197               LC006:
4813  0197 6c80          	std	OFST-4,s
4814  0199 2041          	bra	L7713
4815  019b               L7503:
4816                     ; 390         case OS_DEL_ALWAYS:                                /* Always delete the event flag group       */
4816                     ; 391              pnode = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
4818  019b ec41          	ldd	1,y
4820  019d 2011          	bra	L1123
4821  019f               L5023:
4822                     ; 393                  (void)OS_FlagTaskRdy(pnode, (OS_FLAGS)0, OS_STAT_PEND_ABORT);
4824  019f cc0002        	ldd	#2
4825  01a2 3b            	pshd	
4826  01a3 c7            	clrb	
4827  01a4 3b            	pshd	
4828  01a5 ec84          	ldd	OFST+0,s
4829  01a7 160611        	jsr	L5462_OS_FlagTaskRdy
4831  01aa 1b84          	leas	4,s
4832                     ; 394                  pnode = (OS_FLAG_NODE *)pnode->OSFlagNodeNext;
4834  01ac ecf30000      	ldd	[OFST-4,s]
4835  01b0               L1123:
4836  01b0 6c80          	std	OFST-4,s
4837                     ; 392              while (pnode != (OS_FLAG_NODE *)0) {          /* Ready ALL tasks waiting for flags        */
4839  01b2 26eb          	bne	L5023
4840                     ; 397              pgrp->OSFlagName     = (INT8U *)(void *)"?";
4842  01b4 cc0000        	ldd	#L1503
4843  01b7 ed84          	ldy	OFST+0,s
4844  01b9 6c45          	std	5,y
4845                     ; 399              pgrp->OSFlagType     = OS_EVENT_TYPE_UNUSED;
4847  01bb 87            	clra	
4848  01bc 6a40          	staa	0,y
4849                     ; 400              pgrp->OSFlagWaitList = (void *)OSFlagFreeList;/* Return group to free list                */
4851  01be 1801410000    	movw	_OSFlagFreeList,1,y
4852                     ; 401              pgrp->OSFlagFlags    = (OS_FLAGS)0;
4854  01c3 c7            	clrb	
4855  01c4 6c43          	std	3,y
4856                     ; 402              OSFlagFreeList       = pgrp;
4858  01c6 7d0000        	sty	_OSFlagFreeList
4859                     ; 403              OS_EXIT_CRITICAL();
4861  01c9 e682          	ldab	OFST-2,s
4862  01cb 160000        	jsr	_OS_CPU_SR_Restore
4864                     ; 404              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
4866  01ce e683          	ldab	OFST-1,s
4867  01d0 042103        	dbne	b,L5123
4868                     ; 405                  OS_Sched();                               /* Find highest priority task ready to run  */
4870  01d3 160000        	jsr	_OS_Sched
4872  01d6               L5123:
4873                     ; 407              *perr = OS_ERR_NONE;
4875  01d6 87            	clra	
4876  01d7 6af3000a      	staa	[OFST+6,s]
4877                     ; 408              pgrp_return          = (OS_FLAG_GRP *)0;      /* Event Flag Group has been deleted        */
4879  01db c7            	clrb	
4880                     ; 409              break;
4882  01dc               L7713:
4883                     ; 420     return (pgrp_return);
4888  01dc 1b86          	leas	6,s
4889  01de 3d            	rts	
4964                     ; 449 _NEAR INT8U  OSFlagNameGet (OS_FLAG_GRP   *pgrp,
4964                     ; 450                            INT8U        **pname,
4964                     ; 451                            INT8U         *perr)
4964                     ; 452 {
4965                     	switch	.text
4966  01df               _OSFlagNameGet:
4968  01df 3b            	pshd	
4969       00000002      OFST:	set	2
4972                     ; 455     OS_CPU_SR  cpu_sr = 0u;
4974                     ; 468     if (pgrp == (OS_FLAG_GRP *)0) {              /* Is 'pgrp' a NULL pointer?                          */
4976  01e0 6cae          	std	2,-s
4977  01e2 2604          	bne	L3523
4978                     ; 469         *perr = OS_ERR_FLAG_INVALID_PGRP;
4980  01e4 c66e          	ldab	#110
4981                     ; 470         return (0u);
4984  01e6 2006          	bra	LC008
4985  01e8               L3523:
4986                     ; 472     if (pname == (INT8U **)0) {                   /* Is 'pname' a NULL pointer?                         */
4988  01e8 ec86          	ldd	OFST+4,s
4989  01ea 260a          	bne	L5523
4990                     ; 473         *perr = OS_ERR_PNAME_NULL;
4992  01ec c60c          	ldab	#12
4993                     ; 474         return (0u);
4995  01ee               LC008:
4996  01ee 6bf30008      	stab	[OFST+6,s]
4997  01f2 c7            	clrb	
4999  01f3               L22:
5001  01f3 1b84          	leas	4,s
5002  01f5 3d            	rts	
5003  01f6               L5523:
5004                     ; 477     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
5006  01f6 f60000        	ldab	_OSIntNesting
5007  01f9 2704          	beq	L7523
5008                     ; 478         *perr = OS_ERR_NAME_GET_ISR;
5010  01fb c611          	ldab	#17
5011                     ; 479         return (0u);
5014  01fd 20ef          	bra	LC008
5015  01ff               L7523:
5016                     ; 481     OS_ENTER_CRITICAL();
5018  01ff 160000        	jsr	_OS_CPU_SR_Save
5020  0202 6b80          	stab	OFST-2,s
5021                     ; 482     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {
5023  0204 ed82          	ldy	OFST+0,s
5024  0206 e640          	ldab	0,y
5025  0208 c105          	cmpb	#5
5026  020a 270a          	beq	L1623
5027                     ; 483         OS_EXIT_CRITICAL();
5029  020c e680          	ldab	OFST-2,s
5030  020e 87            	clra	
5031  020f 160000        	jsr	_OS_CPU_SR_Restore
5033                     ; 484         *perr = OS_ERR_EVENT_TYPE;
5035  0212 c601          	ldab	#1
5036                     ; 485         return (0u);
5039  0214 20d8          	bra	LC008
5040  0216               L1623:
5041                     ; 487     *pname = pgrp->OSFlagName;
5043  0216 ec45          	ldd	5,y
5044  0218 ee86          	ldx	OFST+4,s
5045  021a 6c00          	std	0,x
5046                     ; 488     len    = OS_StrLen(*pname);
5048  021c 160000        	jsr	_OS_StrLen
5050  021f 6b81          	stab	OFST-1,s
5051                     ; 489     OS_EXIT_CRITICAL();
5053  0221 e680          	ldab	OFST-2,s
5054  0223 87            	clra	
5055  0224 160000        	jsr	_OS_CPU_SR_Restore
5057                     ; 490     *perr  = OS_ERR_NONE;
5059  0227 69f30008      	clr	[OFST+6,s]
5060                     ; 491     return (len);
5062  022b e681          	ldab	OFST-1,s
5064  022d 20c4          	bra	L22
5130                     ; 520 _NEAR void  OSFlagNameSet (OS_FLAG_GRP  *pgrp,
5130                     ; 521                           INT8U        *pname,
5130                     ; 522                           INT8U        *perr)
5130                     ; 523 {
5131                     	switch	.text
5132  022f               _OSFlagNameSet:
5134  022f 3b            	pshd	
5135  0230 37            	pshb	
5136       00000001      OFST:	set	1
5139                     ; 525     OS_CPU_SR  cpu_sr = 0u;
5141                     ; 538     if (pgrp == (OS_FLAG_GRP *)0) {              /* Is 'pgrp' a NULL pointer?                          */
5143  0231 046404        	tbne	d,L5133
5144                     ; 539         *perr = OS_ERR_FLAG_INVALID_PGRP;
5146  0234 c66e          	ldab	#110
5147                     ; 540         return;
5149  0236 2006          	bra	LC009
5150  0238               L5133:
5151                     ; 542     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
5153  0238 ec85          	ldd	OFST+4,s
5154  023a 2609          	bne	L7133
5155                     ; 543         *perr = OS_ERR_PNAME_NULL;
5157  023c c60c          	ldab	#12
5158  023e               LC009:
5159  023e 6bf30007      	stab	[OFST+6,s]
5160                     ; 544         return;
5161  0242               L62:
5164  0242 1b83          	leas	3,s
5165  0244 3d            	rts	
5166  0245               L7133:
5167                     ; 547     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
5169  0245 f60000        	ldab	_OSIntNesting
5170  0248 2704          	beq	L1233
5171                     ; 548         *perr = OS_ERR_NAME_SET_ISR;
5173  024a c612          	ldab	#18
5174                     ; 549         return;
5176  024c 20f0          	bra	LC009
5177  024e               L1233:
5178                     ; 551     OS_ENTER_CRITICAL();
5180  024e 160000        	jsr	_OS_CPU_SR_Save
5182  0251 6b80          	stab	OFST-1,s
5183                     ; 552     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {
5185  0253 ed81          	ldy	OFST+0,s
5186  0255 e640          	ldab	0,y
5187  0257 c105          	cmpb	#5
5188  0259 270a          	beq	L3233
5189                     ; 553         OS_EXIT_CRITICAL();
5191  025b e680          	ldab	OFST-1,s
5192  025d 87            	clra	
5193  025e 160000        	jsr	_OS_CPU_SR_Restore
5195                     ; 554         *perr = OS_ERR_EVENT_TYPE;
5197  0261 c601          	ldab	#1
5198                     ; 555         return;
5200  0263 20d9          	bra	LC009
5201  0265               L3233:
5202                     ; 557     pgrp->OSFlagName = pname;
5204  0265 18028545      	movw	OFST+4,s,5,y
5205                     ; 558     OS_EXIT_CRITICAL();
5207  0269 e680          	ldab	OFST-1,s
5208  026b 87            	clra	
5209  026c 160000        	jsr	_OS_CPU_SR_Restore
5211                     ; 560     *perr            = OS_ERR_NONE;
5214  026f 69f30007      	clr	[OFST+6,s]
5215                     ; 561     return;
5217  0273 20cd          	bra	L62
5337                     ; 620 _NEAR OS_FLAGS  OSFlagPend (OS_FLAG_GRP  *pgrp,
5337                     ; 621                            OS_FLAGS      flags,
5337                     ; 622                            INT8U         wait_type,
5337                     ; 623                            INT32U        timeout,
5337                     ; 624                            INT8U        *perr)
5337                     ; 625 {
5338                     	switch	.text
5339  0275               _OSFlagPend:
5341  0275 3b            	pshd	
5342  0276 1b91          	leas	-15,s
5343       0000000f      OFST:	set	15
5346                     ; 632     OS_CPU_SR     cpu_sr = 0u;
5348                     ; 644     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
5350  0278 046404        	tbne	d,L1243
5351                     ; 645         *perr = OS_ERR_FLAG_INVALID_PGRP;
5353  027b c66e          	ldab	#110
5354                     ; 646         return ((OS_FLAGS)0);
5357  027d 2007          	bra	LC010
5358  027f               L1243:
5359                     ; 652     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
5362  027f f60000        	ldab	_OSIntNesting
5363  0282 270c          	beq	L3243
5364                     ; 653         *perr = OS_ERR_PEND_ISR;                           /* ... can't PEND from an ISR               */
5366  0284 c602          	ldab	#2
5367                     ; 655         return ((OS_FLAGS)0);
5370  0286               LC010:
5371  0286 6bf3001b      	stab	[OFST+12,s]
5372  028a 87            	clra	
5373  028b c7            	clrb	
5375  028c               L23:
5377  028c 1bf011        	leas	17,s
5378  028f 3d            	rts	
5379  0290               L3243:
5380                     ; 657     if (OSLockNesting > 0u) {                              /* See if called with scheduler locked ...  */
5382  0290 f60000        	ldab	_OSLockNesting
5383  0293 2704          	beq	L5243
5384                     ; 658         *perr = OS_ERR_PEND_LOCKED;                        /* ... can't PEND when locked               */
5386  0295 c60d          	ldab	#13
5387                     ; 660         return ((OS_FLAGS)0);
5391  0297 20ed          	bra	LC010
5392  0299               L5243:
5393                     ; 662     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event block type                */
5395  0299 e6f3000f      	ldab	[OFST+0,s]
5396  029d c105          	cmpb	#5
5397  029f 2704          	beq	L7243
5398                     ; 663         *perr = OS_ERR_EVENT_TYPE;
5400  02a1 c601          	ldab	#1
5401                     ; 665         return ((OS_FLAGS)0);
5405  02a3 20e1          	bra	LC010
5406  02a5               L7243:
5407                     ; 667     result = (INT8U)(wait_type & OS_FLAG_CONSUME);
5409  02a5 e6f016        	ldab	OFST+7,s
5410  02a8 c480          	andb	#128
5411  02aa 6b83          	stab	OFST-12,s
5412                     ; 668     if (result != (INT8U)0) {                              /* See if we need to consume the flags      */
5414  02ac 270a          	beq	L1343
5415                     ; 669         wait_type &= (INT8U)~(INT8U)OS_FLAG_CONSUME;
5417  02ae 0df01680      	bclr	OFST+7,s,128
5418                     ; 670         consume    = OS_TRUE;
5420  02b2 c601          	ldab	#1
5421  02b4 6b83          	stab	OFST-12,s
5423  02b6 2002          	bra	L3343
5424  02b8               L1343:
5425                     ; 672         consume    = OS_FALSE;
5427  02b8 6983          	clr	OFST-12,s
5428  02ba               L3343:
5429                     ; 675     OS_ENTER_CRITICAL();
5431  02ba 160000        	jsr	_OS_CPU_SR_Save
5433  02bd 6b82          	stab	OFST-13,s
5434                     ; 676     switch (wait_type) {
5436  02bf e6f016        	ldab	OFST+7,s
5438  02c2 275f          	beq	L1333
5439  02c4 53            	decb	
5440  02c5 277c          	beq	L3333
5441  02c7 04010d        	dbeq	b,L5233
5442  02ca 040122        	dbeq	b,L7233
5443                     ; 747         default:
5443                     ; 748              OS_EXIT_CRITICAL();
5446                     ; 749              flags_rdy = (OS_FLAGS)0;
5448                     ; 750              *perr      = OS_ERR_FLAG_WAIT_TYPE;
5450  02cd               LC011:
5451  02cd e682          	ldab	OFST-13,s
5452  02cf 87            	clra	
5453  02d0 160000        	jsr	_OS_CPU_SR_Restore
5454  02d3 c66f          	ldab	#111
5455                     ; 752              return (flags_rdy);
5459  02d5 20af          	bra	LC010
5460  02d7               L5233:
5461                     ; 677         case OS_FLAG_WAIT_SET_ALL:                         /* See if all required flags are set        */
5461                     ; 678              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);   /* Extract only the bits we want     */
5463  02d7 ed8f          	ldy	OFST+0,s
5464  02d9 ec43          	ldd	3,y
5465  02db e4f014        	andb	OFST+5,s
5466  02de a4f013        	anda	OFST+4,s
5467  02e1 6c80          	std	OFST-15,s
5468                     ; 679              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
5470  02e3 acf013        	cpd	OFST+4,s
5471  02e6 266b          	bne	L3643
5472                     ; 680                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
5474  02e8 e683          	ldab	OFST-12,s
5475  02ea 53            	decb	
5476  02eb 261f          	bne	L1543
5477                     ; 681                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;   /* Clear ONLY the flags we wanted    */
5479                     ; 683                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
5481                     ; 684                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
5484                     ; 685                  *perr                   = OS_ERR_NONE;
5486                     ; 687                  return (flags_rdy);
5490  02ed 2013          	bra	LC017
5491                     ; 689                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
5494                     ; 690                  OS_EXIT_CRITICAL();
5497  02ef               L7233:
5498                     ; 694         case OS_FLAG_WAIT_SET_ANY:
5498                     ; 695              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);    /* Extract only the bits we want    */
5500  02ef ed8f          	ldy	OFST+0,s
5501  02f1 ec43          	ldd	3,y
5502  02f3 e4f014        	andb	OFST+5,s
5503  02f6 a4f013        	anda	OFST+4,s
5504  02f9 6c80          	std	OFST-15,s
5505                     ; 696              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag set                      */
5507  02fb 2756          	beq	L3643
5508                     ; 697                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
5510  02fd e683          	ldab	OFST-12,s
5511  02ff 04210a        	dbne	b,L1543
5512                     ; 698                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;    /* Clear ONLY the flags that we got */
5514  0302               LC017:
5515  0302 ec80          	ldd	OFST-15,s
5516  0304 51            	comb	
5517  0305 41            	coma	
5518  0306 e444          	andb	4,y
5519  0308 a443          	anda	3,y
5520  030a               LC016:
5521  030a 6c43          	std	3,y
5522  030c               L1543:
5523                     ; 700                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
5525  030c ec80          	ldd	OFST-15,s
5526  030e fd0000        	ldy	_OSTCBCur
5527  0311 6ce81c        	std	28,y
5528                     ; 701                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
5531                     ; 702                  *perr                   = OS_ERR_NONE;
5533  0314               LC013:
5534  0314 e682          	ldab	OFST-13,s
5535  0316 87            	clra	
5536  0317 160000        	jsr	_OS_CPU_SR_Restore
5537  031a 69f3001b      	clr	[OFST+12,s]
5538                     ; 704                  return (flags_rdy);
5541  031e               LC012:
5542  031e ec80          	ldd	OFST-15,s
5544  0320 06028c        	bra	L23
5545                     ; 706                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
5548                     ; 707                  OS_EXIT_CRITICAL();
5551  0323               L1333:
5552                     ; 712         case OS_FLAG_WAIT_CLR_ALL:                         /* See if all required flags are cleared    */
5552                     ; 713              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;    /* Extract only the bits we want     */
5554  0323 ed8f          	ldy	OFST+0,s
5555  0325 ec43          	ldd	3,y
5556  0327 51            	comb	
5557  0328 41            	coma	
5558  0329 e4f014        	andb	OFST+5,s
5559  032c a4f013        	anda	OFST+4,s
5560  032f 6c80          	std	OFST-15,s
5561                     ; 714              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
5563  0331 acf013        	cpd	OFST+4,s
5564  0334 261d          	bne	L3643
5565                     ; 715                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
5567                     ; 716                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we wanted        */
5569  0336               LC018:
5570  0336 e683          	ldab	OFST-12,s
5571  0338 53            	decb	
5572  0339 26d1          	bne	L1543
5573  033b ec43          	ldd	3,y
5574  033d ea81          	orab	OFST-14,s
5575  033f aa80          	oraa	OFST-15,s
5576                     ; 718                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
5578                     ; 719                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
5581                     ; 720                  *perr                   = OS_ERR_NONE;
5583                     ; 722                  return (flags_rdy);
5587  0341 20c7          	bra	LC016
5588                     ; 724                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
5591                     ; 725                  OS_EXIT_CRITICAL();
5594  0343               L3333:
5595                     ; 729         case OS_FLAG_WAIT_CLR_ANY:
5595                     ; 730              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;   /* Extract only the bits we want      */
5597  0343 ed8f          	ldy	OFST+0,s
5598  0345 ec43          	ldd	3,y
5599  0347 51            	comb	
5600  0348 41            	coma	
5601  0349 e4f014        	andb	OFST+5,s
5602  034c a4f013        	anda	OFST+4,s
5603  034f 6c80          	std	OFST-15,s
5604                     ; 731              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag cleared                  */
5606                     ; 732                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
5608                     ; 733                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we got           */
5610                     ; 735                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
5612                     ; 736                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
5615                     ; 737                  *perr                   = OS_ERR_NONE;
5617                     ; 739                  return (flags_rdy);
5621  0351 26e3          	bne	LC018
5622  0353               L3643:
5623                     ; 741                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
5626                     ; 742                  OS_EXIT_CRITICAL();
5629  0353 ecf019        	ldd	OFST+10,s
5630  0356 3b            	pshd	
5631  0357 ecf019        	ldd	OFST+10,s
5632  035a 3b            	pshd	
5633  035b e6f01a        	ldab	OFST+11,s
5634  035e 87            	clra	
5635  035f 3b            	pshd	
5636  0360 ecf019        	ldd	OFST+10,s
5637  0363 3b            	pshd	
5638  0364 1a8c          	leax	OFST-3,s
5639  0366 34            	pshx	
5640  0367 ecf019        	ldd	OFST+10,s
5641  036a 16053b        	jsr	L3462_OS_FlagBlock
5642  036d 1b8a          	leas	10,s
5643  036f e682          	ldab	OFST-13,s
5644  0371 87            	clra	
5645  0372 160000        	jsr	_OS_CPU_SR_Restore
5646                     ; 755     OS_Sched();                                            /* Find next HPT ready to run               */
5648  0375 160000        	jsr	_OS_Sched
5650                     ; 756     OS_ENTER_CRITICAL();
5652  0378 160000        	jsr	_OS_CPU_SR_Save
5654  037b 6b82          	stab	OFST-13,s
5655                     ; 757     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) {      /* Have we timed-out or aborted?            */
5657  037d fd0000        	ldy	_OSTCBCur
5658  0380 e6e823        	ldab	35,y
5659  0383 2732          	beq	L1743
5660                     ; 758         pend_stat                = OSTCBCur->OSTCBStatPend;
5662  0385 6b83          	stab	OFST-12,s
5663                     ; 759         OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
5665  0387 69e823        	clr	35,y
5666                     ; 760         OS_FlagUnlink(&node);
5668  038a b774          	tfr	s,d
5669  038c c30004        	addd	#-11+OFST
5670  038f 160661        	jsr	_OS_FlagUnlink
5672                     ; 761         OSTCBCur->OSTCBStat      = OS_STAT_RDY;            /* Yes, make task ready-to-run              */
5674  0392 fd0000        	ldy	_OSTCBCur
5675  0395 87            	clra	
5676  0396 6ae822        	staa	34,y
5677                     ; 762         OS_EXIT_CRITICAL();
5679  0399 e682          	ldab	OFST-13,s
5680  039b 160000        	jsr	_OS_CPU_SR_Restore
5682                     ; 763         flags_rdy                = (OS_FLAGS)0;
5684  039e 87            	clra	
5685  039f c7            	clrb	
5686  03a0 6c80          	std	OFST-15,s
5687                     ; 764         switch (pend_stat) {
5689  03a2 e683          	ldab	OFST-12,s
5691  03a4 040107        	dbeq	b,L1433
5692  03a7 042104        	dbne	b,L1433
5693                     ; 765             case OS_STAT_PEND_ABORT:
5693                     ; 766                  *perr = OS_ERR_PEND_ABORT;                /* Indicate that we aborted   waiting       */
5695  03aa c60e          	ldab	#14
5696                     ; 767                  break;
5698  03ac 2002          	bra	L5743
5699  03ae               L1433:
5700                     ; 769             case OS_STAT_PEND_TO:
5700                     ; 770             default:
5700                     ; 771                  *perr = OS_ERR_TIMEOUT;                   /* Indicate that we timed-out waiting       */
5702  03ae c60a          	ldab	#10
5703                     ; 772                  break;
5705  03b0               L5743:
5706  03b0 6bf3001b      	stab	[OFST+12,s]
5707                     ; 775         return (flags_rdy);
5711  03b4 06031e        	bra	LC012
5712  03b7               L1743:
5713                     ; 777     flags_rdy = OSTCBCur->OSTCBFlagsRdy;
5715  03b7 ece81c        	ldd	28,y
5716  03ba 6c80          	std	OFST-15,s
5717                     ; 778     if (consume == OS_TRUE) {                              /* See if we need to consume the flags      */
5719  03bc e683          	ldab	OFST-12,s
5720  03be 53            	decb	
5721  03bf 1826ff51      	bne	LC013
5722                     ; 779         switch (wait_type) {
5724  03c3 e6f016        	ldab	OFST+7,s
5726  03c6 2718          	beq	L5433
5727  03c8 040115        	dbeq	b,L5433
5728  03cb 040106        	dbeq	b,L3433
5729  03ce 040103        	dbeq	b,L3433
5730                     ; 791             default:
5730                     ; 792                  OS_EXIT_CRITICAL();
5733                     ; 793                  *perr = OS_ERR_FLAG_WAIT_TYPE;
5735                     ; 795                  return ((OS_FLAGS)0);
5739  03d1 0602cd        	bra	LC011
5740  03d4               L3433:
5741                     ; 780             case OS_FLAG_WAIT_SET_ALL:
5741                     ; 781             case OS_FLAG_WAIT_SET_ANY:                     /* Clear ONLY the flags we got              */
5741                     ; 782                  pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;
5743  03d4 ed8f          	ldy	OFST+0,s
5744  03d6 ec80          	ldd	OFST-15,s
5745  03d8 51            	comb	
5746  03d9 41            	coma	
5747  03da e444          	andb	4,y
5748  03dc a443          	anda	3,y
5749                     ; 783                  break;
5751  03de 2008          	bra	LC015
5752  03e0               L5433:
5753                     ; 786             case OS_FLAG_WAIT_CLR_ALL:
5753                     ; 787             case OS_FLAG_WAIT_CLR_ANY:                     /* Set   ONLY the flags we got              */
5753                     ; 788                  pgrp->OSFlagFlags |=  flags_rdy;
5755  03e0 ed8f          	ldy	OFST+0,s
5756  03e2 ec43          	ldd	3,y
5757  03e4 ea81          	orab	OFST-14,s
5758  03e6 aa80          	oraa	OFST-15,s
5759  03e8               LC015:
5760  03e8 6c43          	std	3,y
5761                     ; 789                  break;
5763                     ; 798     OS_EXIT_CRITICAL();
5766                     ; 799     *perr = OS_ERR_NONE;                                   /* Event(s) must have occurred              */
5768                     ; 801     return (flags_rdy);
5772  03ea 060314        	bra	LC013
5814                     ; 820 _NEAR OS_FLAGS  OSFlagPendGetFlagsRdy (void)
5814                     ; 821 {
5815                     	switch	.text
5816  03ed               _OSFlagPendGetFlagsRdy:
5818  03ed 1b9d          	leas	-3,s
5819       00000003      OFST:	set	3
5822                     ; 824     OS_CPU_SR     cpu_sr = 0u;
5824                     ; 829     OS_ENTER_CRITICAL();
5826  03ef 160000        	jsr	_OS_CPU_SR_Save
5828  03f2 6b80          	stab	OFST-3,s
5829                     ; 830     flags = OSTCBCur->OSTCBFlagsRdy;
5831  03f4 fd0000        	ldy	_OSTCBCur
5832  03f7 ece81c        	ldd	28,y
5833  03fa 6c81          	std	OFST-2,s
5834                     ; 831     OS_EXIT_CRITICAL();
5836  03fc e680          	ldab	OFST-3,s
5837  03fe 87            	clra	
5838  03ff 160000        	jsr	_OS_CPU_SR_Restore
5840                     ; 832     return (flags);
5842  0402 ec81          	ldd	OFST-2,s
5845  0404 1b83          	leas	3,s
5846  0406 3d            	rts	
5957                     ; 877 _NEAR OS_FLAGS  OSFlagPost (OS_FLAG_GRP  *pgrp,
5957                     ; 878                            OS_FLAGS      flags,
5957                     ; 879                            INT8U         opt,
5957                     ; 880                            INT8U        *perr)
5957                     ; 881 {
5958                     	switch	.text
5959  0407               _OSFlagPost:
5961  0407 3b            	pshd	
5962  0408 1b99          	leas	-7,s
5963       00000007      OFST:	set	7
5966                     ; 888     OS_CPU_SR     cpu_sr = 0u;
5968                     ; 900     if (pgrp == (OS_FLAG_GRP *)0) {                  /* Validate 'pgrp'                                */
5970  040a 046404        	tbne	d,L3163
5971                     ; 901         *perr = OS_ERR_FLAG_INVALID_PGRP;
5973  040d c66e          	ldab	#110
5974                     ; 902         return ((OS_FLAGS)0);
5977  040f 200a          	bra	L04
5978  0411               L3163:
5979                     ; 908     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {    /* Make sure we are pointing to an event flag grp */
5982  0411 e6f30007      	ldab	[OFST+0,s]
5983  0415 c105          	cmpb	#5
5984  0417 270b          	beq	L5163
5985                     ; 909         *perr = OS_ERR_EVENT_TYPE;
5987  0419 c601          	ldab	#1
5988                     ; 911         return ((OS_FLAGS)0);
5992  041b               L04:
5993  041b 6bf3000f      	stab	[OFST+8,s]
5994  041f 87            	clra	
5995  0420 c7            	clrb	
5997  0421 1b89          	leas	9,s
5998  0423 3d            	rts	
5999  0424               L5163:
6000                     ; 914     OS_ENTER_CRITICAL();
6002  0424 160000        	jsr	_OS_CPU_SR_Save
6004  0427 6b86          	stab	OFST-1,s
6005                     ; 915     switch (opt) {
6007  0429 e68e          	ldab	OFST+7,s
6009  042b 270d          	beq	L3253
6010  042d 040116        	dbeq	b,L5253
6011                     ; 924         default:
6011                     ; 925              OS_EXIT_CRITICAL();                     /* INVALID option                                 */
6013  0430 e686          	ldab	OFST-1,s
6014  0432 87            	clra	
6015  0433 160000        	jsr	_OS_CPU_SR_Restore
6017                     ; 926              *perr = OS_ERR_FLAG_INVALID_OPT;
6019  0436 c671          	ldab	#113
6020                     ; 928              return ((OS_FLAGS)0);
6024  0438 20e1          	bra	L04
6025  043a               L3253:
6026                     ; 916         case OS_FLAG_CLR:
6026                     ; 917              pgrp->OSFlagFlags &= (OS_FLAGS)~flags;  /* Clear the flags specified in the group         */
6028  043a ed87          	ldy	OFST+0,s
6029  043c ec8b          	ldd	OFST+4,s
6030  043e 51            	comb	
6031  043f 41            	coma	
6032  0440 e444          	andb	4,y
6033  0442 a443          	anda	3,y
6034                     ; 918              break;
6036  0444 2008          	bra	L1263
6037  0446               L5253:
6038                     ; 920         case OS_FLAG_SET:
6038                     ; 921              pgrp->OSFlagFlags |=  flags;            /* Set   the flags specified in the group         */
6040  0446 ed87          	ldy	OFST+0,s
6041  0448 ec43          	ldd	3,y
6042  044a ea8c          	orab	OFST+5,s
6043  044c aa8b          	oraa	OFST+4,s
6044                     ; 922              break;
6046  044e               L1263:
6047  044e 6c43          	std	3,y
6048                     ; 930     sched = OS_FALSE;                                /* Indicate that we don't need rescheduling       */
6050  0450 6985          	clr	OFST-2,s
6051                     ; 931     pnode = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
6053  0452 ec41          	ldd	1,y
6055  0454 0604dc        	bra	L5263
6056  0457               L3263:
6057                     ; 933         switch (pnode->OSFlagNodeWaitType) {
6059  0457 b746          	tfr	d,y
6060  0459 e64a          	ldab	10,y
6062  045b 2741          	beq	L5353
6063  045d 53            	decb	
6064  045e 2752          	beq	L7353
6065  0460 04010d        	dbeq	b,L1353
6066  0463 04012e        	dbeq	b,L3353
6067                     ; 975             default:
6067                     ; 976                  OS_EXIT_CRITICAL();
6069  0466 e686          	ldab	OFST-1,s
6070  0468 87            	clra	
6071  0469 160000        	jsr	_OS_CPU_SR_Restore
6073                     ; 977                  *perr = OS_ERR_FLAG_WAIT_TYPE;
6075  046c c66f          	ldab	#111
6076                     ; 979                  return ((OS_FLAGS)0);
6080  046e 20ab          	bra	L04
6081  0470               L1353:
6082                     ; 934             case OS_FLAG_WAIT_SET_ALL:               /* See if all req. flags are set for current node */
6082                     ; 935                  flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
6084  0470 ec48          	ldd	8,y
6085  0472 ed87          	ldy	OFST+0,s
6086  0474 e444          	andb	4,y
6087  0476 a443          	anda	3,y
6088  0478 6c82          	std	OFST-5,s
6089                     ; 936                  if (flags_rdy == pnode->OSFlagNodeFlags) {   /* Make task RTR, event(s) Rx'd          */
6091  047a ed80          	ldy	OFST-7,s
6092  047c ac48          	cpd	8,y
6093  047e 2658          	bne	L3363
6094                     ; 937                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
6096  0480 87            	clra	
6097  0481 c7            	clrb	
6098  0482 3b            	pshd	
6099  0483 ec84          	ldd	OFST-3,s
6100  0485 3b            	pshd	
6101  0486 b764          	tfr	y,d
6102  0488 160611        	jsr	L5462_OS_FlagTaskRdy
6104  048b 1b84          	leas	4,s
6105  048d 6b84          	stab	OFST-3,s
6106                     ; 938                      if (rdy == OS_TRUE) {
6108  048f 53            	decb	
6109  0490 2646          	bne	L3363
6110                     ; 939                          sched = OS_TRUE;                     /* When done we will reschedule          */
6112  0492 2040          	bra	LC019
6113  0494               L3353:
6114                     ; 944             case OS_FLAG_WAIT_SET_ANY:               /* See if any flag set                            */
6114                     ; 945                  flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
6116  0494 ec48          	ldd	8,y
6117  0496 ed87          	ldy	OFST+0,s
6118  0498 e444          	andb	4,y
6119  049a a443          	anda	3,y
6120                     ; 946                  if (flags_rdy != (OS_FLAGS)0) {              /* Make task RTR, event(s) Rx'd          */
6122                     ; 947                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
6125                     ; 948                      if (rdy == OS_TRUE) {
6127                     ; 949                          sched = OS_TRUE;                     /* When done we will reschedule          */
6129  049c 2020          	bra	LC021
6130  049e               L5353:
6131                     ; 955             case OS_FLAG_WAIT_CLR_ALL:               /* See if all req. flags are set for current node */
6131                     ; 956                  flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & pnode->OSFlagNodeFlags;
6133  049e ed87          	ldy	OFST+0,s
6134  04a0 ec43          	ldd	3,y
6135  04a2 51            	comb	
6136  04a3 41            	coma	
6137  04a4 ed80          	ldy	OFST-7,s
6138  04a6 e449          	andb	9,y
6139  04a8 a448          	anda	8,y
6140  04aa 6c82          	std	OFST-5,s
6141                     ; 957                  if (flags_rdy == pnode->OSFlagNodeFlags) {   /* Make task RTR, event(s) Rx'd          */
6143  04ac ac48          	cpd	8,y
6144  04ae 2628          	bne	L3363
6145                     ; 958                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
6148                     ; 959                      if (rdy == OS_TRUE) {
6150                     ; 960                          sched = OS_TRUE;                     /* When done we will reschedule          */
6152  04b0 2010          	bra	LC020
6153  04b2               L7353:
6154                     ; 965             case OS_FLAG_WAIT_CLR_ANY:               /* See if any flag set                            */
6154                     ; 966                  flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & pnode->OSFlagNodeFlags;
6156  04b2 ed87          	ldy	OFST+0,s
6157  04b4 ec43          	ldd	3,y
6158  04b6 51            	comb	
6159  04b7 41            	coma	
6160  04b8 ed80          	ldy	OFST-7,s
6161  04ba e449          	andb	9,y
6162  04bc a448          	anda	8,y
6163                     ; 967                  if (flags_rdy != (OS_FLAGS)0) {              /* Make task RTR, event(s) Rx'd          */
6165  04be               LC021:
6166  04be 6c82          	std	OFST-5,s
6167  04c0 2716          	beq	L3363
6168                     ; 968                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
6171                     ; 969                      if (rdy == OS_TRUE) {
6173  04c2               LC020:
6174  04c2 87            	clra	
6175  04c3 c7            	clrb	
6176  04c4 3b            	pshd	
6177  04c5 ec84          	ldd	OFST-3,s
6178  04c7 3b            	pshd	
6179  04c8 ec84          	ldd	OFST-3,s
6180  04ca 160611        	jsr	L5462_OS_FlagTaskRdy
6181  04cd 1b84          	leas	4,s
6182  04cf 6b84          	stab	OFST-3,s
6183  04d1 042104        	dbne	b,L3363
6184                     ; 970                          sched = OS_TRUE;                     /* When done we will reschedule          */
6186  04d4               LC019:
6187  04d4 c601          	ldab	#1
6188  04d6 6b85          	stab	OFST-2,s
6189  04d8               L3363:
6190                     ; 981         pnode = (OS_FLAG_NODE *)pnode->OSFlagNodeNext; /* Point to next task waiting for event flag(s) */
6192  04d8 ecf30000      	ldd	[OFST-7,s]
6193  04dc               L5263:
6194  04dc 6c80          	std	OFST-7,s
6195                     ; 932     while (pnode != (OS_FLAG_NODE *)0) {             /* Go through all tasks waiting on event flag(s)  */
6197  04de 1826ff75      	bne	L3263
6198                     ; 983     OS_EXIT_CRITICAL();
6200  04e2 e686          	ldab	OFST-1,s
6201  04e4 160000        	jsr	_OS_CPU_SR_Restore
6203                     ; 984     if (sched == OS_TRUE) {
6205  04e7 e685          	ldab	OFST-2,s
6206  04e9 042103        	dbne	b,L5563
6207                     ; 985         OS_Sched();
6209  04ec 160000        	jsr	_OS_Sched
6211  04ef               L5563:
6212                     ; 987     OS_ENTER_CRITICAL();
6214  04ef 160000        	jsr	_OS_CPU_SR_Save
6216  04f2 6b86          	stab	OFST-1,s
6217                     ; 988     flags_cur = pgrp->OSFlagFlags;
6219  04f4 ed87          	ldy	OFST+0,s
6220  04f6 18024382      	movw	3,y,OFST-5,s
6221                     ; 989     OS_EXIT_CRITICAL();
6223  04fa 87            	clra	
6224  04fb 160000        	jsr	_OS_CPU_SR_Restore
6226                     ; 990     *perr     = OS_ERR_NONE;
6228  04fe 69f3000f      	clr	[OFST+8,s]
6229                     ; 993     return (flags_cur);
6232  0502 ec82          	ldd	OFST-5,s
6235  0504 1b89          	leas	9,s
6236  0506 3d            	rts	
6298                     ; 1017 _NEAR OS_FLAGS  OSFlagQuery (OS_FLAG_GRP  *pgrp,
6298                     ; 1018                             INT8U        *perr)
6298                     ; 1019 {
6299                     	switch	.text
6300  0507               _OSFlagQuery:
6302  0507 3b            	pshd	
6303  0508 1b9d          	leas	-3,s
6304       00000003      OFST:	set	3
6307                     ; 1022     OS_CPU_SR  cpu_sr = 0u;
6309                     ; 1035     if (pgrp == (OS_FLAG_GRP *)0) {               /* Validate 'pgrp'                                   */
6311  050a 046404        	tbne	d,L7073
6312                     ; 1036         *perr = OS_ERR_FLAG_INVALID_PGRP;
6314  050d c66e          	ldab	#110
6315                     ; 1037         return ((OS_FLAGS)0);
6318  050f 200a          	bra	LC022
6319  0511               L7073:
6320                     ; 1040     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) { /* Validate event block type                         */
6322  0511 e6f30003      	ldab	[OFST+0,s]
6323  0515 c105          	cmpb	#5
6324  0517 270b          	beq	L1173
6325                     ; 1041         *perr = OS_ERR_EVENT_TYPE;
6327  0519 c601          	ldab	#1
6328                     ; 1042         return ((OS_FLAGS)0);
6330  051b               LC022:
6331  051b 6bf30007      	stab	[OFST+4,s]
6332  051f 87            	clra	
6333  0520 c7            	clrb	
6335  0521               L44:
6337  0521 1b85          	leas	5,s
6338  0523 3d            	rts	
6339  0524               L1173:
6340                     ; 1044     OS_ENTER_CRITICAL();
6342  0524 160000        	jsr	_OS_CPU_SR_Save
6344  0527 6b80          	stab	OFST-3,s
6345                     ; 1045     flags = pgrp->OSFlagFlags;
6347  0529 ed83          	ldy	OFST+0,s
6348  052b 18024381      	movw	3,y,OFST-2,s
6349                     ; 1046     OS_EXIT_CRITICAL();
6351  052f 87            	clra	
6352  0530 160000        	jsr	_OS_CPU_SR_Restore
6354                     ; 1047     *perr = OS_ERR_NONE;
6356  0533 69f30007      	clr	[OFST+4,s]
6357                     ; 1048     return (flags);                               /* Return the current value of the event flags       */
6359  0537 ec81          	ldd	OFST-2,s
6361  0539 20e6          	bra	L44
6452                     ; 1090 static  void  OS_FlagBlock (OS_FLAG_GRP  *pgrp,
6452                     ; 1091                             OS_FLAG_NODE *pnode,
6452                     ; 1092                             OS_FLAGS      flags,
6452                     ; 1093                             INT8U         wait_type,
6452                     ; 1094                             INT32U        timeout)
6452                     ; 1095 {
6453                     	switch	.text
6454  053b               L3462_OS_FlagBlock:
6456  053b 3b            	pshd	
6457  053c 1b9d          	leas	-3,s
6458       00000003      OFST:	set	3
6461                     ; 1100     OSTCBCur->OSTCBStat      |= OS_STAT_FLAG;
6463  053e fd0000        	ldy	_OSTCBCur
6464  0541 0ce82220      	bset	34,y,32
6465                     ; 1101     OSTCBCur->OSTCBStatPend   = OS_STAT_PEND_OK;
6467  0545 69e823        	clr	35,y
6468                     ; 1102     OSTCBCur->OSTCBDly        = timeout;              /* Store timeout in task's TCB                   */
6470  0548 ec8f          	ldd	OFST+12,s
6471  054a 6ce820        	std	32,y
6472  054d ec8d          	ldd	OFST+10,s
6473  054f 6ce81e        	std	30,y
6474                     ; 1104     OSTCBCur->OSTCBFlagNode   = pnode;                /* TCB to link to node                           */
6476  0552 ec87          	ldd	OFST+4,s
6477  0554 6ce81a        	std	26,y
6478                     ; 1106     pnode->OSFlagNodeFlags    = flags;                /* Save the flags that we need to wait for       */
6480  0557 b746          	tfr	d,y
6481  0559 18028948      	movw	OFST+6,s,8,y
6482                     ; 1107     pnode->OSFlagNodeWaitType = wait_type;            /* Save the type of wait we are doing            */
6484  055d 180a8c4a      	movb	OFST+9,s,10,y
6485                     ; 1108     pnode->OSFlagNodeTCB      = (void *)OSTCBCur;     /* Link to task's TCB                            */
6487  0561 1801440000    	movw	_OSTCBCur,4,y
6488                     ; 1109     pnode->OSFlagNodeNext     = pgrp->OSFlagWaitList; /* Add node at beginning of event flag wait list */
6490  0566 ee83          	ldx	OFST+0,s
6491  0568 ed87          	ldy	OFST+4,s
6492  056a 18020140      	movw	1,x,0,y
6493                     ; 1110     pnode->OSFlagNodePrev     = (void *)0;
6495  056e 87            	clra	
6496  056f c7            	clrb	
6497  0570 6c42          	std	2,y
6498                     ; 1111     pnode->OSFlagNodeFlagGrp  = (void *)pgrp;         /* Link to Event Flag Group                      */
6500  0572 18028346      	movw	OFST+0,s,6,y
6501                     ; 1112     pnode_next                = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
6503  0576 ed83          	ldy	OFST+0,s
6504  0578 ed41          	ldy	1,y
6505  057a 6d80          	sty	OFST-3,s
6506                     ; 1113     if (pnode_next != (void *)0) {                    /* Is this the first NODE to insert?             */
6508  057c 2704          	beq	L7573
6509                     ; 1114         pnode_next->OSFlagNodePrev = pnode;           /* No, link in doubly linked list                */
6511  057e 18028742      	movw	OFST+4,s,2,y
6512  0582               L7573:
6513                     ; 1116     pgrp->OSFlagWaitList = (void *)pnode;
6515  0582 ed83          	ldy	OFST+0,s
6516  0584 18028741      	movw	OFST+4,s,1,y
6517                     ; 1118     y            =  OSTCBCur->OSTCBY;                 /* Suspend current task until flag(s) received   */
6519  0588 fd0000        	ldy	_OSTCBCur
6520  058b e6e826        	ldab	38,y
6521                     ; 1119     OSRdyTbl[y] &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
6523  058e b796          	exg	b,y
6524  0590 fe0000        	ldx	_OSTCBCur
6525  0593 e6e027        	ldab	39,x
6526  0596 51            	comb	
6527  0597 e4ea0000      	andb	_OSRdyTbl,y
6528  059b 6bea0000      	stab	_OSRdyTbl,y
6529                     ; 1121     if (OSRdyTbl[y] == 0x00u) {
6532  059f 260c          	bne	L1673
6533                     ; 1122         OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
6535  05a1 b756          	tfr	x,y
6536  05a3 e6e828        	ldab	40,y
6537  05a6 51            	comb	
6538  05a7 f40000        	andb	_OSRdyGrp
6539  05aa 7b0000        	stab	_OSRdyGrp
6540  05ad               L1673:
6541                     ; 1124 }
6544  05ad 1b85          	leas	5,s
6545  05af 3d            	rts	
6610                     ; 1142 _NEAR void  OS_FlagInit (void)
6610                     ; 1143 {
6611                     	switch	.text
6612  05b0               _OS_FlagInit:
6614  05b0 1b9a          	leas	-6,s
6615       00000006      OFST:	set	6
6618                     ; 1161     OS_MemClr((INT8U *)&OSFlagTbl[0], sizeof(OSFlagTbl));           /* Clear the flag group table      */
6620  05b2 cc0023        	ldd	#35
6621  05b5 3b            	pshd	
6622  05b6 cc0000        	ldd	#_OSFlagTbl
6623  05b9 160000        	jsr	_OS_MemClr
6625  05bc 1b82          	leas	2,s
6626                     ; 1162     for (ix = 0u; ix < (OS_MAX_FLAGS - 1u); ix++) {                 /* Init. list of free EVENT FLAGS  */
6628  05be 87            	clra	
6629  05bf c7            	clrb	
6630  05c0 b746          	tfr	d,y
6631  05c2 6d82          	sty	OFST-4,s
6632  05c4               L5104:
6633                     ; 1163         ix_next = ix + 1u;
6635  05c4 02            	iny	
6636  05c5 6d84          	sty	OFST-2,s
6637                     ; 1164         pgrp1 = &OSFlagTbl[ix];
6639  05c7 cd0007        	ldy	#7
6640  05ca 13            	emul	
6641  05cb c30000        	addd	#_OSFlagTbl
6642  05ce 6c80          	std	OFST-6,s
6643                     ; 1165         pgrp2 = &OSFlagTbl[ix_next];
6645  05d0 ec84          	ldd	OFST-2,s
6646  05d2 cd0007        	ldy	#7
6647  05d5 13            	emul	
6648  05d6 c30000        	addd	#_OSFlagTbl
6649  05d9 6c84          	std	OFST-2,s
6650                     ; 1166         pgrp1->OSFlagType     = OS_EVENT_TYPE_UNUSED;
6652  05db ed80          	ldy	OFST-6,s
6653  05dd 6940          	clr	0,y
6654                     ; 1167         pgrp1->OSFlagWaitList = (void *)pgrp2;
6656  05df 6c41          	std	1,y
6657                     ; 1169         pgrp1->OSFlagName     = (INT8U *)(void *)"?";               /* Unknown name                    */
6659  05e1 cc0000        	ldd	#L1503
6660  05e4 6c45          	std	5,y
6661                     ; 1162     for (ix = 0u; ix < (OS_MAX_FLAGS - 1u); ix++) {                 /* Init. list of free EVENT FLAGS  */
6663  05e6 ed82          	ldy	OFST-4,s
6664  05e8 02            	iny	
6667  05e9 b764          	tfr	y,d
6668  05eb 6c82          	std	OFST-4,s
6669  05ed 8c0004        	cpd	#4
6670  05f0 25d2          	blo	L5104
6671                     ; 1172     pgrp1                 = &OSFlagTbl[ix];
6673  05f2 cd0007        	ldy	#7
6674  05f5 13            	emul	
6675  05f6 c30000        	addd	#_OSFlagTbl
6676  05f9 6c80          	std	OFST-6,s
6677                     ; 1173     pgrp1->OSFlagType     = OS_EVENT_TYPE_UNUSED;
6679  05fb 87            	clra	
6680  05fc ed80          	ldy	OFST-6,s
6681  05fe 6a40          	staa	0,y
6682                     ; 1174     pgrp1->OSFlagWaitList = (void *)0;
6684  0600 c7            	clrb	
6685  0601 6c41          	std	1,y
6686                     ; 1176     pgrp1->OSFlagName     = (INT8U *)(void *)"?";                   /* Unknown name                    */
6688  0603 cc0000        	ldd	#L1503
6689  0606 6c45          	std	5,y
6690                     ; 1178     OSFlagFreeList        = &OSFlagTbl[0];
6692  0608 cc0000        	ldd	#_OSFlagTbl
6693  060b 7c0000        	std	_OSFlagFreeList
6694                     ; 1180 }
6697  060e 1b86          	leas	6,s
6698  0610 3d            	rts	
7087                     ; 1209 static  BOOLEAN  OS_FlagTaskRdy (OS_FLAG_NODE *pnode,
7087                     ; 1210                                  OS_FLAGS      flags_rdy,
7087                     ; 1211                                  INT8U         pend_stat)
7087                     ; 1212 {
7088                     	switch	.text
7089  0611               L5462_OS_FlagTaskRdy:
7091  0611 3b            	pshd	
7092  0612 1b9d          	leas	-3,s
7093       00000003      OFST:	set	3
7096                     ; 1217     ptcb                 = (OS_TCB *)pnode->OSFlagNodeTCB; /* Point to TCB of waiting task             */
7098  0614 b746          	tfr	d,y
7099  0616 ed44          	ldy	4,y
7100  0618 6d80          	sty	OFST-3,s
7101                     ; 1218     ptcb->OSTCBDly       = 0u;
7103  061a 87            	clra	
7104  061b c7            	clrb	
7105  061c 6ce820        	std	32,y
7106  061f 6ce81e        	std	30,y
7107                     ; 1219     ptcb->OSTCBFlagsRdy  = flags_rdy;
7109  0622 ec87          	ldd	OFST+4,s
7110  0624 6ce81c        	std	28,y
7111                     ; 1220     ptcb->OSTCBStat     &= (INT8U)~(INT8U)OS_STAT_FLAG;
7113  0627 0de82220      	bclr	34,y,32
7114                     ; 1221     ptcb->OSTCBStatPend  = pend_stat;
7116  062b e68a          	ldab	OFST+7,s
7117  062d 6be823        	stab	35,y
7118                     ; 1222     if (ptcb->OSTCBStat == OS_STAT_RDY) {                  /* Task now ready?                          */
7120  0630 e6e822        	ldab	34,y
7121  0633 2621          	bne	L7424
7122                     ; 1223         OSRdyGrp               |= ptcb->OSTCBBitY;         /* Put task into ready list                 */
7124  0635 e6e828        	ldab	40,y
7125  0638 fa0000        	orab	_OSRdyGrp
7126  063b 7b0000        	stab	_OSRdyGrp
7127                     ; 1224         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
7129  063e e6e826        	ldab	38,y
7130  0641 b796          	exg	b,y
7131  0643 ee80          	ldx	OFST-3,s
7132  0645 e6e027        	ldab	39,x
7133  0648 eaea0000      	orab	_OSRdyTbl,y
7134  064c 6bea0000      	stab	_OSRdyTbl,y
7135                     ; 1226         sched                   = OS_TRUE;
7138  0650 c601          	ldab	#1
7139  0652 6b82          	stab	OFST-1,s
7141  0654 2002          	bra	L1524
7142  0656               L7424:
7143                     ; 1228         sched                   = OS_FALSE;
7145  0656 6982          	clr	OFST-1,s
7146  0658               L1524:
7147                     ; 1230     OS_FlagUnlink(pnode);
7149  0658 ec83          	ldd	OFST+0,s
7150  065a 0705          	jsr	_OS_FlagUnlink
7152                     ; 1231     return (sched);
7154  065c e682          	ldab	OFST-1,s
7157  065e 1b85          	leas	5,s
7158  0660 3d            	rts	
7242                     ; 1256 _NEAR void  OS_FlagUnlink (OS_FLAG_NODE *pnode)
7242                     ; 1257 {
7243                     	switch	.text
7244  0661               _OS_FlagUnlink:
7246  0661 3b            	pshd	
7247  0662 1b9c          	leas	-4,s
7248       00000004      OFST:	set	4
7251                     ; 1266     pnode_prev = (OS_FLAG_NODE *)pnode->OSFlagNodePrev;
7253  0664 b746          	tfr	d,y
7254  0666 18024280      	movw	2,y,OFST-4,s
7255                     ; 1267     pnode_next = (OS_FLAG_NODE *)pnode->OSFlagNodeNext;
7257  066a ed84          	ldy	OFST+0,s
7258  066c ec40          	ldd	0,y
7259  066e 6c82          	std	OFST-2,s
7260                     ; 1268     if (pnode_prev == (OS_FLAG_NODE *)0) {                      /* Is it first node in wait list?      */
7262  0670 ee80          	ldx	OFST-4,s
7263  0672 260e          	bne	L3234
7264                     ; 1269         pgrp                 = (OS_FLAG_GRP *)pnode->OSFlagNodeFlagGrp;
7266  0674 ed46          	ldy	6,y
7267  0676 6d80          	sty	OFST-4,s
7268                     ; 1270         pgrp->OSFlagWaitList = (void *)pnode_next;              /*      Update list for new 1st node   */
7270  0678 6c41          	std	1,y
7271                     ; 1271         if (pnode_next != (OS_FLAG_NODE *)0) {
7273  067a 2710          	beq	L7234
7274                     ; 1272             pnode_next->OSFlagNodePrev = (OS_FLAG_NODE *)0;     /*      Link new 1st node PREV to NULL */
7276  067c 87            	clra	
7277  067d c7            	clrb	
7278  067e ed82          	ldy	OFST-2,s
7279  0680 2008          	bra	LC023
7280  0682               L3234:
7281                     ; 1275         pnode_prev->OSFlagNodeNext = pnode_next;                /*      Link around the node to unlink */
7283  0682 b746          	tfr	d,y
7284  0684 6d00          	sty	0,x
7285                     ; 1276         if (pnode_next != (OS_FLAG_NODE *)0) {                  /*      Was this the LAST node?        */
7287  0686 2704          	beq	L7234
7288                     ; 1277             pnode_next->OSFlagNodePrev = pnode_prev;            /*      No, Link around current node   */
7290  0688 b754          	tfr	x,d
7291  068a               LC023:
7292  068a 6c42          	std	2,y
7293  068c               L7234:
7294                     ; 1281     ptcb                = (OS_TCB *)pnode->OSFlagNodeTCB;
7296  068c ed84          	ldy	OFST+0,s
7297  068e ed44          	ldy	4,y
7298                     ; 1282     ptcb->OSTCBFlagNode = (OS_FLAG_NODE *)0;
7300  0690 87            	clra	
7301  0691 c7            	clrb	
7302  0692 6ce81a        	std	26,y
7303                     ; 1284 }
7306  0695 1b86          	leas	6,s
7307  0697 3d            	rts	
7319                     	xref	_OS_StrLen
7320                     	xref	_OS_Sched
7321                     	xref	_OS_MemClr
7322                     	xdef	_OS_FlagUnlink
7323                     	xdef	_OS_FlagInit
7324                     	xdef	_OSFlagQuery
7325                     	xdef	_OSFlagPost
7326                     	xdef	_OSFlagPendGetFlagsRdy
7327                     	xdef	_OSFlagPend
7328                     	xdef	_OSFlagNameSet
7329                     	xdef	_OSFlagNameGet
7330                     	xdef	_OSFlagDel
7331                     	xdef	_OSFlagCreate
7332                     	xdef	_OSFlagAccept
7333                     	xref	_OSTCBCur
7334                     	xref	_OSRdyTbl
7335                     	xref	_OSRdyGrp
7336                     	xref	_OSLockNesting
7337                     	xref	_OSIntNesting
7338                     	xref	_OSFlagFreeList
7339                     	xref	_OSFlagTbl
7340                     	xref	_OS_CPU_SR_Restore
7341                     	xref	_OS_CPU_SR_Save
7342                     .const:	section	.data
7343  0000               L1503:
7344  0000 3f00          	dc.b	"?",0
7365                     	end

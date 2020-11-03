   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 151                     ; 101 _NEAR OS_FLAGS  OSFlagAccept (OS_FLAG_GRP  *pgrp,
 151                     ; 102                              OS_FLAGS      flags,
 151                     ; 103                              INT8U         wait_type,
 151                     ; 104                              INT8U        *perr)
 151                     ; 105 {
 152                     	switch	.text
 153  0000               _OSFlagAccept:
 155  0000 3b            	pshd	
 156  0001 1b9c          	leas	-4,s
 157       00000004      OFST:	set	4
 160                     ; 110     OS_CPU_SR     cpu_sr = 0u;
 162                     ; 123     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
 164  0003 046404        	tbne	d,L701
 165                     ; 124         *perr = OS_ERR_FLAG_INVALID_PGRP;
 167  0006 c66e          	ldab	#110
 168                     ; 125         return ((OS_FLAGS)0);
 171  0008 200a          	bra	L6
 172  000a               L701:
 173                     ; 128     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event block type                */
 175  000a e6f30004      	ldab	[OFST+0,s]
 176  000e c105          	cmpb	#5
 177  0010 270b          	beq	L111
 178                     ; 129         *perr = OS_ERR_EVENT_TYPE;
 180  0012 c601          	ldab	#1
 181                     ; 130         return ((OS_FLAGS)0);
 184  0014               L6:
 185  0014 6bf3000c      	stab	[OFST+8,s]
 186  0018 87            	clra	
 187  0019 c7            	clrb	
 189  001a 1b86          	leas	6,s
 190  001c 3d            	rts	
 191  001d               L111:
 192                     ; 132     result = (INT8U)(wait_type & OS_FLAG_CONSUME);
 194  001d e68b          	ldab	OFST+7,s
 195  001f c480          	andb	#128
 196  0021 6b82          	stab	OFST-2,s
 197                     ; 133     if (result != (INT8U)0) {                              /* See if we need to consume the flags      */
 199  0023 2709          	beq	L311
 200                     ; 134         wait_type &= ~OS_FLAG_CONSUME;
 202  0025 0d8b80        	bclr	OFST+7,s,128
 203                     ; 135         consume    = OS_TRUE;
 205  0028 c601          	ldab	#1
 206  002a 6b82          	stab	OFST-2,s
 208  002c 2002          	bra	L511
 209  002e               L311:
 210                     ; 137         consume    = OS_FALSE;
 212  002e 6982          	clr	OFST-2,s
 213  0030               L511:
 214                     ; 140     *perr = OS_ERR_NONE;                                   /* Assume NO error until proven otherwise.  */
 216  0030 69f3000c      	clr	[OFST+8,s]
 217                     ; 141     OS_ENTER_CRITICAL();
 219  0034 160000        	jsr	_OS_CPU_SR_Save
 221  0037 6b83          	stab	OFST-1,s
 222                     ; 142     switch (wait_type) {
 224  0039 e68b          	ldab	OFST+7,s
 226  003b 2748          	beq	L31
 227  003d 53            	decb	
 228  003e 2762          	beq	L51
 229  0040 040115        	dbeq	b,L7
 230  0043 040131        	dbeq	b,L11
 231                     ; 193         default:
 231                     ; 194              OS_EXIT_CRITICAL();
 233  0046 e683          	ldab	OFST-1,s
 234  0048 87            	clra	
 235  0049 160000        	jsr	_OS_CPU_SR_Restore
 237                     ; 195              flags_rdy = (OS_FLAGS)0;
 239  004c 87            	clra	
 240  004d c7            	clrb	
 241  004e 6c80          	std	OFST-4,s
 242                     ; 196              *perr     = OS_ERR_FLAG_WAIT_TYPE;
 244  0050 c66f          	ldab	#111
 245  0052 6bf3000c      	stab	[OFST+8,s]
 246                     ; 197              break;
 248  0056 206b          	bra	L121
 249  0058               L7:
 250                     ; 143         case OS_FLAG_WAIT_SET_ALL:                         /* See if all required flags are set        */
 250                     ; 144              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);     /* Extract only the bits we want   */
 252  0058 ed84          	ldy	OFST+0,s
 253  005a ec43          	ldd	3,y
 254  005c e489          	andb	OFST+5,s
 255  005e a488          	anda	OFST+4,s
 256  0060 6c80          	std	OFST-4,s
 257                     ; 145              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
 259  0062 ac88          	cpd	OFST+4,s
 260  0064 2651          	bne	L541
 261                     ; 146                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
 263                     ; 147                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;     /* Clear ONLY the flags we wanted  */
 265  0066               LC004:
 266  0066 e682          	ldab	OFST-2,s
 267  0068 53            	decb	
 268  0069 2652          	bne	L151
 269  006b ec80          	ldd	OFST-4,s
 270  006d 51            	comb	
 271  006e 41            	coma	
 272  006f e444          	andb	4,y
 273  0071 a443          	anda	3,y
 274  0073               LC003:
 275  0073 6c43          	std	3,y
 276  0075 2046          	bra	L151
 277                     ; 150                  *perr = OS_ERR_FLAG_NOT_RDY;
 279                     ; 152              OS_EXIT_CRITICAL();
 282                     ; 153              break;
 284  0077               L11:
 285                     ; 155         case OS_FLAG_WAIT_SET_ANY:
 285                     ; 156              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);     /* Extract only the bits we want   */
 287  0077 ed84          	ldy	OFST+0,s
 288  0079 ec43          	ldd	3,y
 289  007b e489          	andb	OFST+5,s
 290  007d a488          	anda	OFST+4,s
 291  007f 6c80          	std	OFST-4,s
 292                     ; 157              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag set                      */
 294  0081 2734          	beq	L541
 295                     ; 158                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
 297                     ; 159                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;     /* Clear ONLY the flags we got     */
 299  0083 20e1          	bra	LC004
 300                     ; 162                  *perr = OS_ERR_FLAG_NOT_RDY;
 302                     ; 164              OS_EXIT_CRITICAL();
 305                     ; 165              break;
 307  0085               L31:
 308                     ; 168         case OS_FLAG_WAIT_CLR_ALL:                         /* See if all required flags are cleared    */
 308                     ; 169              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;    /* Extract only the bits we want     */
 310  0085 ed84          	ldy	OFST+0,s
 311  0087 ec43          	ldd	3,y
 312  0089 51            	comb	
 313  008a 41            	coma	
 314  008b e489          	andb	OFST+5,s
 315  008d a488          	anda	OFST+4,s
 316  008f 6c80          	std	OFST-4,s
 317                     ; 170              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
 319  0091 ac88          	cpd	OFST+4,s
 320  0093 2622          	bne	L541
 321                     ; 171                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
 323  0095 e682          	ldab	OFST-2,s
 324  0097 53            	decb	
 325  0098 2623          	bne	L151
 326                     ; 172                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we wanted        */
 328  009a               LC005:
 329  009a ec43          	ldd	3,y
 330  009c ea81          	orab	OFST-3,s
 331  009e aa80          	oraa	OFST-4,s
 332  00a0 20d1          	bra	LC003
 333                     ; 175                  *perr = OS_ERR_FLAG_NOT_RDY;
 335                     ; 177              OS_EXIT_CRITICAL();
 338                     ; 178              break;
 340  00a2               L51:
 341                     ; 180         case OS_FLAG_WAIT_CLR_ANY:
 341                     ; 181              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;   /* Extract only the bits we want      */
 343  00a2 ed84          	ldy	OFST+0,s
 344  00a4 ec43          	ldd	3,y
 345  00a6 51            	comb	
 346  00a7 41            	coma	
 347  00a8 e489          	andb	OFST+5,s
 348  00aa a488          	anda	OFST+4,s
 349  00ac 6c80          	std	OFST-4,s
 350                     ; 182              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag cleared                  */
 352  00ae 2707          	beq	L541
 353                     ; 183                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
 355  00b0 e682          	ldab	OFST-2,s
 356  00b2 042108        	dbne	b,L151
 357                     ; 184                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we got           */
 359  00b5 20e3          	bra	LC005
 360  00b7               L541:
 361                     ; 187                  *perr = OS_ERR_FLAG_NOT_RDY;
 363  00b7 c670          	ldab	#112
 364  00b9 6bf3000c      	stab	[OFST+8,s]
 365  00bd               L151:
 366                     ; 189              OS_EXIT_CRITICAL();
 368  00bd e683          	ldab	OFST-1,s
 369  00bf 87            	clra	
 370  00c0 160000        	jsr	_OS_CPU_SR_Restore
 372                     ; 190              break;
 374  00c3               L121:
 375                     ; 199     return (flags_rdy);
 377  00c3 ec80          	ldd	OFST-4,s
 380  00c5 1b86          	leas	6,s
 381  00c7 3d            	rts	
 448                     ; 226 _NEAR OS_FLAG_GRP  *OSFlagCreate (OS_FLAGS  flags,
 448                     ; 227                                  INT8U    *perr)
 448                     ; 228 {
 449                     	switch	.text
 450  00c8               _OSFlagCreate:
 452  00c8 3b            	pshd	
 453  00c9 1b9d          	leas	-3,s
 454       00000003      OFST:	set	3
 457                     ; 231     OS_CPU_SR    cpu_sr = 0u;
 459                     ; 251     if (OSIntNesting > 0u) {                        /* See if called from ISR ...                      */
 461  00cb f60000        	ldab	_OSIntNesting
 462  00ce 270a          	beq	L502
 463                     ; 252         *perr = OS_ERR_CREATE_ISR;                  /* ... can't CREATE from an ISR                    */
 465  00d0 c610          	ldab	#16
 466  00d2 6bf30007      	stab	[OFST+4,s]
 467                     ; 253         return ((OS_FLAG_GRP *)0);
 469  00d6 87            	clra	
 470  00d7 c7            	clrb	
 472  00d8 203c          	bra	L21
 473  00da               L502:
 474                     ; 255     OS_ENTER_CRITICAL();
 476  00da 160000        	jsr	_OS_CPU_SR_Save
 478  00dd 6b82          	stab	OFST-1,s
 479                     ; 256     pgrp = OSFlagFreeList;                          /* Get next free event flag                        */
 481  00df fd0000        	ldy	_OSFlagFreeList
 482  00e2 6d80          	sty	OFST-3,s
 483                     ; 257     if (pgrp != (OS_FLAG_GRP *)0) {                 /* See if we have event flag groups available      */
 485  00e4 ee80          	ldx	OFST-3,s
 486  00e6 2722          	beq	L702
 487                     ; 259         OSFlagFreeList       = (OS_FLAG_GRP *)OSFlagFreeList->OSFlagWaitList;
 489  00e8 1805410000    	movw	1,y,_OSFlagFreeList
 490                     ; 260         pgrp->OSFlagType     = OS_EVENT_TYPE_FLAG;  /* Set to event flag group type                    */
 492  00ed c605          	ldab	#5
 493  00ef 6b00          	stab	0,x
 494                     ; 261         pgrp->OSFlagFlags    = flags;               /* Set to desired initial value                    */
 496  00f1 18028343      	movw	OFST+0,s,3,y
 497                     ; 262         pgrp->OSFlagWaitList = (void *)0;           /* Clear list of tasks waiting on flags            */
 499  00f5 87            	clra	
 500  00f6 c7            	clrb	
 501  00f7 6c41          	std	1,y
 502                     ; 264         pgrp->OSFlagName     = (INT8U *)(void *)"?";
 504  00f9 cc0000        	ldd	#L112
 505  00fc 6c45          	std	5,y
 506                     ; 267         OS_EXIT_CRITICAL();
 509  00fe e682          	ldab	OFST-1,s
 510  0100 87            	clra	
 511  0101 160000        	jsr	_OS_CPU_SR_Restore
 513                     ; 268         *perr                = OS_ERR_NONE;
 515  0104 69f30007      	clr	[OFST+4,s]
 517  0108 200a          	bra	L312
 518  010a               L702:
 519                     ; 270         OS_EXIT_CRITICAL();
 521  010a 87            	clra	
 522  010b 160000        	jsr	_OS_CPU_SR_Restore
 524                     ; 271         *perr                = OS_ERR_FLAG_GRP_DEPLETED;
 526  010e c672          	ldab	#114
 527  0110 6bf30007      	stab	[OFST+4,s]
 528  0114               L312:
 529                     ; 273     return (pgrp);                                  /* Return pointer to event flag group              */
 531  0114 ec80          	ldd	OFST-3,s
 533  0116               L21:
 535  0116 1b85          	leas	5,s
 536  0118 3d            	rts	
 697                     ; 318 _NEAR OS_FLAG_GRP  *OSFlagDel (OS_FLAG_GRP  *pgrp,
 697                     ; 319                               INT8U         opt,
 697                     ; 320                               INT8U        *perr)
 697                     ; 321 {
 698                     	switch	.text
 699  0119               _OSFlagDel:
 701  0119 3b            	pshd	
 702  011a 1b9c          	leas	-4,s
 703       00000004      OFST:	set	4
 706                     ; 326     OS_CPU_SR     cpu_sr = 0u;
 708                     ; 346     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
 710  011c 046404        	tbne	d,L323
 711                     ; 347         *perr = OS_ERR_FLAG_INVALID_PGRP;
 713  011f c66e          	ldab	#110
 714                     ; 348         return (pgrp);
 717  0121 2007          	bra	L61
 718  0123               L323:
 719                     ; 354     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 722  0123 f60000        	ldab	_OSIntNesting
 723  0126 270b          	beq	L523
 724                     ; 355         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
 726  0128 c60f          	ldab	#15
 727                     ; 357         return (pgrp);
 731  012a               L61:
 732  012a 6bf3000a      	stab	[OFST+6,s]
 733  012e ec84          	ldd	OFST+0,s
 735  0130 1b86          	leas	6,s
 736  0132 3d            	rts	
 737  0133               L523:
 738                     ; 359     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event group type                */
 740  0133 e6f30004      	ldab	[OFST+0,s]
 741  0137 c105          	cmpb	#5
 742  0139 2704          	beq	L723
 743                     ; 360         *perr = OS_ERR_EVENT_TYPE;
 745  013b c601          	ldab	#1
 746                     ; 362         return (pgrp);
 750  013d 20eb          	bra	L61
 751  013f               L723:
 752                     ; 364     OS_ENTER_CRITICAL();
 754  013f 160000        	jsr	_OS_CPU_SR_Save
 756  0142 6b82          	stab	OFST-2,s
 757                     ; 365     if (pgrp->OSFlagWaitList != (void *)0) {               /* See if any tasks waiting on event flags  */
 759  0144 ed84          	ldy	OFST+0,s
 760  0146 ec41          	ldd	1,y
 761  0148 2706          	beq	L133
 762                     ; 366         tasks_waiting = OS_TRUE;                           /* Yes                                      */
 764  014a c601          	ldab	#1
 765  014c 6b83          	stab	OFST-1,s
 767  014e 2002          	bra	L333
 768  0150               L133:
 769                     ; 368         tasks_waiting = OS_FALSE;                          /* No                                       */
 771  0150 6983          	clr	OFST-1,s
 772  0152               L333:
 773                     ; 370     switch (opt) {
 775  0152 e689          	ldab	OFST+5,s
 777  0154 270d          	beq	L512
 778  0156 040142        	dbeq	b,L712
 779                     ; 411         default:
 779                     ; 412              OS_EXIT_CRITICAL();
 781  0159 e682          	ldab	OFST-2,s
 782  015b 87            	clra	
 783  015c 160000        	jsr	_OS_CPU_SR_Restore
 785                     ; 413              *perr                = OS_ERR_INVALID_OPT;
 787  015f c607          	ldab	#7
 788                     ; 414              pgrp_return          = pgrp;
 790                     ; 415              break;
 792  0161 202e          	bra	LC007
 793  0163               L512:
 794                     ; 371         case OS_DEL_NO_PEND:                               /* Delete group if no task waiting          */
 794                     ; 372              if (tasks_waiting == OS_FALSE) {
 796  0163 e683          	ldab	OFST-1,s
 797  0165 2622          	bne	L143
 798                     ; 374                  pgrp->OSFlagName     = (INT8U *)(void *)"?";
 800  0167 cc0000        	ldd	#L112
 801  016a 6c45          	std	5,y
 802                     ; 376                  pgrp->OSFlagType     = OS_EVENT_TYPE_UNUSED;
 804  016c 87            	clra	
 805  016d 6a40          	staa	0,y
 806                     ; 377                  pgrp->OSFlagWaitList = (void *)OSFlagFreeList; /* Return group to free list           */
 808  016f 1801410000    	movw	_OSFlagFreeList,1,y
 809                     ; 378                  pgrp->OSFlagFlags    = (OS_FLAGS)0;
 811  0174 c7            	clrb	
 812  0175 6c43          	std	3,y
 813                     ; 379                  OSFlagFreeList       = pgrp;
 815  0177 1805840000    	movw	OFST+0,s,_OSFlagFreeList
 816                     ; 380                  OS_EXIT_CRITICAL();
 818  017c e682          	ldab	OFST-2,s
 819  017e 160000        	jsr	_OS_CPU_SR_Restore
 821                     ; 381                  *perr                = OS_ERR_NONE;
 823  0181 87            	clra	
 824  0182 6af3000a      	staa	[OFST+6,s]
 825                     ; 382                  pgrp_return          = (OS_FLAG_GRP *)0;  /* Event Flag Group has been deleted        */
 827  0186 c7            	clrb	
 829  0187 200e          	bra	LC006
 830  0189               L143:
 831                     ; 384                  OS_EXIT_CRITICAL();
 833  0189 e682          	ldab	OFST-2,s
 834  018b 87            	clra	
 835  018c 160000        	jsr	_OS_CPU_SR_Restore
 837                     ; 385                  *perr                = OS_ERR_TASK_WAITING;
 839  018f c649          	ldab	#73
 840                     ; 386                  pgrp_return          = pgrp;
 842  0191               LC007:
 843  0191 6bf3000a      	stab	[OFST+6,s]
 844  0195 ec84          	ldd	OFST+0,s
 845  0197               LC006:
 846  0197 6c80          	std	OFST-4,s
 847  0199 2041          	bra	L733
 848  019b               L712:
 849                     ; 390         case OS_DEL_ALWAYS:                                /* Always delete the event flag group       */
 849                     ; 391              pnode = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
 851  019b ec41          	ldd	1,y
 853  019d 2011          	bra	L153
 854  019f               L543:
 855                     ; 393                  (void)OS_FlagTaskRdy(pnode, (OS_FLAGS)0, OS_STAT_PEND_ABORT);
 857  019f cc0002        	ldd	#2
 858  01a2 3b            	pshd	
 859  01a3 c7            	clrb	
 860  01a4 3b            	pshd	
 861  01a5 ec84          	ldd	OFST+0,s
 862  01a7 160611        	jsr	L5_OS_FlagTaskRdy
 864  01aa 1b84          	leas	4,s
 865                     ; 394                  pnode = (OS_FLAG_NODE *)pnode->OSFlagNodeNext;
 867  01ac ecf30000      	ldd	[OFST-4,s]
 868  01b0               L153:
 869  01b0 6c80          	std	OFST-4,s
 870                     ; 392              while (pnode != (OS_FLAG_NODE *)0) {          /* Ready ALL tasks waiting for flags        */
 872  01b2 26eb          	bne	L543
 873                     ; 397              pgrp->OSFlagName     = (INT8U *)(void *)"?";
 875  01b4 cc0000        	ldd	#L112
 876  01b7 ed84          	ldy	OFST+0,s
 877  01b9 6c45          	std	5,y
 878                     ; 399              pgrp->OSFlagType     = OS_EVENT_TYPE_UNUSED;
 880  01bb 87            	clra	
 881  01bc 6a40          	staa	0,y
 882                     ; 400              pgrp->OSFlagWaitList = (void *)OSFlagFreeList;/* Return group to free list                */
 884  01be 1801410000    	movw	_OSFlagFreeList,1,y
 885                     ; 401              pgrp->OSFlagFlags    = (OS_FLAGS)0;
 887  01c3 c7            	clrb	
 888  01c4 6c43          	std	3,y
 889                     ; 402              OSFlagFreeList       = pgrp;
 891  01c6 7d0000        	sty	_OSFlagFreeList
 892                     ; 403              OS_EXIT_CRITICAL();
 894  01c9 e682          	ldab	OFST-2,s
 895  01cb 160000        	jsr	_OS_CPU_SR_Restore
 897                     ; 404              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
 899  01ce e683          	ldab	OFST-1,s
 900  01d0 042103        	dbne	b,L553
 901                     ; 405                  OS_Sched();                               /* Find highest priority task ready to run  */
 903  01d3 160000        	jsr	_OS_Sched
 905  01d6               L553:
 906                     ; 407              *perr = OS_ERR_NONE;
 908  01d6 87            	clra	
 909  01d7 6af3000a      	staa	[OFST+6,s]
 910                     ; 408              pgrp_return          = (OS_FLAG_GRP *)0;      /* Event Flag Group has been deleted        */
 912  01db c7            	clrb	
 913                     ; 409              break;
 915  01dc               L733:
 916                     ; 420     return (pgrp_return);
 921  01dc 1b86          	leas	6,s
 922  01de 3d            	rts	
 997                     ; 449 _NEAR INT8U  OSFlagNameGet (OS_FLAG_GRP   *pgrp,
 997                     ; 450                            INT8U        **pname,
 997                     ; 451                            INT8U         *perr)
 997                     ; 452 {
 998                     	switch	.text
 999  01df               _OSFlagNameGet:
1001  01df 3b            	pshd	
1002       00000002      OFST:	set	2
1005                     ; 455     OS_CPU_SR  cpu_sr = 0u;
1007                     ; 468     if (pgrp == (OS_FLAG_GRP *)0) {              /* Is 'pgrp' a NULL pointer?                          */
1009  01e0 6cae          	std	2,-s
1010  01e2 2604          	bne	L314
1011                     ; 469         *perr = OS_ERR_FLAG_INVALID_PGRP;
1013  01e4 c66e          	ldab	#110
1014                     ; 470         return (0u);
1017  01e6 2006          	bra	LC008
1018  01e8               L314:
1019                     ; 472     if (pname == (INT8U **)0) {                   /* Is 'pname' a NULL pointer?                         */
1021  01e8 ec86          	ldd	OFST+4,s
1022  01ea 260a          	bne	L514
1023                     ; 473         *perr = OS_ERR_PNAME_NULL;
1025  01ec c60c          	ldab	#12
1026                     ; 474         return (0u);
1028  01ee               LC008:
1029  01ee 6bf30008      	stab	[OFST+6,s]
1030  01f2 c7            	clrb	
1032  01f3               L22:
1034  01f3 1b84          	leas	4,s
1035  01f5 3d            	rts	
1036  01f6               L514:
1037                     ; 477     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
1039  01f6 f60000        	ldab	_OSIntNesting
1040  01f9 2704          	beq	L714
1041                     ; 478         *perr = OS_ERR_NAME_GET_ISR;
1043  01fb c611          	ldab	#17
1044                     ; 479         return (0u);
1047  01fd 20ef          	bra	LC008
1048  01ff               L714:
1049                     ; 481     OS_ENTER_CRITICAL();
1051  01ff 160000        	jsr	_OS_CPU_SR_Save
1053  0202 6b80          	stab	OFST-2,s
1054                     ; 482     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {
1056  0204 ed82          	ldy	OFST+0,s
1057  0206 e640          	ldab	0,y
1058  0208 c105          	cmpb	#5
1059  020a 270a          	beq	L124
1060                     ; 483         OS_EXIT_CRITICAL();
1062  020c e680          	ldab	OFST-2,s
1063  020e 87            	clra	
1064  020f 160000        	jsr	_OS_CPU_SR_Restore
1066                     ; 484         *perr = OS_ERR_EVENT_TYPE;
1068  0212 c601          	ldab	#1
1069                     ; 485         return (0u);
1072  0214 20d8          	bra	LC008
1073  0216               L124:
1074                     ; 487     *pname = pgrp->OSFlagName;
1076  0216 ec45          	ldd	5,y
1077  0218 ee86          	ldx	OFST+4,s
1078  021a 6c00          	std	0,x
1079                     ; 488     len    = OS_StrLen(*pname);
1081  021c 160000        	jsr	_OS_StrLen
1083  021f 6b81          	stab	OFST-1,s
1084                     ; 489     OS_EXIT_CRITICAL();
1086  0221 e680          	ldab	OFST-2,s
1087  0223 87            	clra	
1088  0224 160000        	jsr	_OS_CPU_SR_Restore
1090                     ; 490     *perr  = OS_ERR_NONE;
1092  0227 69f30008      	clr	[OFST+6,s]
1093                     ; 491     return (len);
1095  022b e681          	ldab	OFST-1,s
1097  022d 20c4          	bra	L22
1163                     ; 520 _NEAR void  OSFlagNameSet (OS_FLAG_GRP  *pgrp,
1163                     ; 521                           INT8U        *pname,
1163                     ; 522                           INT8U        *perr)
1163                     ; 523 {
1164                     	switch	.text
1165  022f               _OSFlagNameSet:
1167  022f 3b            	pshd	
1168  0230 37            	pshb	
1169       00000001      OFST:	set	1
1172                     ; 525     OS_CPU_SR  cpu_sr = 0u;
1174                     ; 538     if (pgrp == (OS_FLAG_GRP *)0) {              /* Is 'pgrp' a NULL pointer?                          */
1176  0231 046404        	tbne	d,L554
1177                     ; 539         *perr = OS_ERR_FLAG_INVALID_PGRP;
1179  0234 c66e          	ldab	#110
1180                     ; 540         return;
1182  0236 2006          	bra	LC009
1183  0238               L554:
1184                     ; 542     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
1186  0238 ec85          	ldd	OFST+4,s
1187  023a 2609          	bne	L754
1188                     ; 543         *perr = OS_ERR_PNAME_NULL;
1190  023c c60c          	ldab	#12
1191  023e               LC009:
1192  023e 6bf30007      	stab	[OFST+6,s]
1193                     ; 544         return;
1194  0242               L62:
1197  0242 1b83          	leas	3,s
1198  0244 3d            	rts	
1199  0245               L754:
1200                     ; 547     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
1202  0245 f60000        	ldab	_OSIntNesting
1203  0248 2704          	beq	L164
1204                     ; 548         *perr = OS_ERR_NAME_SET_ISR;
1206  024a c612          	ldab	#18
1207                     ; 549         return;
1209  024c 20f0          	bra	LC009
1210  024e               L164:
1211                     ; 551     OS_ENTER_CRITICAL();
1213  024e 160000        	jsr	_OS_CPU_SR_Save
1215  0251 6b80          	stab	OFST-1,s
1216                     ; 552     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {
1218  0253 ed81          	ldy	OFST+0,s
1219  0255 e640          	ldab	0,y
1220  0257 c105          	cmpb	#5
1221  0259 270a          	beq	L364
1222                     ; 553         OS_EXIT_CRITICAL();
1224  025b e680          	ldab	OFST-1,s
1225  025d 87            	clra	
1226  025e 160000        	jsr	_OS_CPU_SR_Restore
1228                     ; 554         *perr = OS_ERR_EVENT_TYPE;
1230  0261 c601          	ldab	#1
1231                     ; 555         return;
1233  0263 20d9          	bra	LC009
1234  0265               L364:
1235                     ; 557     pgrp->OSFlagName = pname;
1237  0265 18028545      	movw	OFST+4,s,5,y
1238                     ; 558     OS_EXIT_CRITICAL();
1240  0269 e680          	ldab	OFST-1,s
1241  026b 87            	clra	
1242  026c 160000        	jsr	_OS_CPU_SR_Restore
1244                     ; 560     *perr            = OS_ERR_NONE;
1247  026f 69f30007      	clr	[OFST+6,s]
1248                     ; 561     return;
1250  0273 20cd          	bra	L62
1370                     ; 620 _NEAR OS_FLAGS  OSFlagPend (OS_FLAG_GRP  *pgrp,
1370                     ; 621                            OS_FLAGS      flags,
1370                     ; 622                            INT8U         wait_type,
1370                     ; 623                            INT32U        timeout,
1370                     ; 624                            INT8U        *perr)
1370                     ; 625 {
1371                     	switch	.text
1372  0275               _OSFlagPend:
1374  0275 3b            	pshd	
1375  0276 1b91          	leas	-15,s
1376       0000000f      OFST:	set	15
1379                     ; 632     OS_CPU_SR     cpu_sr = 0u;
1381                     ; 644     if (pgrp == (OS_FLAG_GRP *)0) {                        /* Validate 'pgrp'                          */
1383  0278 046404        	tbne	d,L165
1384                     ; 645         *perr = OS_ERR_FLAG_INVALID_PGRP;
1386  027b c66e          	ldab	#110
1387                     ; 646         return ((OS_FLAGS)0);
1390  027d 2007          	bra	LC010
1391  027f               L165:
1392                     ; 652     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
1395  027f f60000        	ldab	_OSIntNesting
1396  0282 270c          	beq	L365
1397                     ; 653         *perr = OS_ERR_PEND_ISR;                           /* ... can't PEND from an ISR               */
1399  0284 c602          	ldab	#2
1400                     ; 655         return ((OS_FLAGS)0);
1403  0286               LC010:
1404  0286 6bf3001b      	stab	[OFST+12,s]
1405  028a 87            	clra	
1406  028b c7            	clrb	
1408  028c               L23:
1410  028c 1bf011        	leas	17,s
1411  028f 3d            	rts	
1412  0290               L365:
1413                     ; 657     if (OSLockNesting > 0u) {                              /* See if called with scheduler locked ...  */
1415  0290 f60000        	ldab	_OSLockNesting
1416  0293 2704          	beq	L565
1417                     ; 658         *perr = OS_ERR_PEND_LOCKED;                        /* ... can't PEND when locked               */
1419  0295 c60d          	ldab	#13
1420                     ; 660         return ((OS_FLAGS)0);
1424  0297 20ed          	bra	LC010
1425  0299               L565:
1426                     ; 662     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {          /* Validate event block type                */
1428  0299 e6f3000f      	ldab	[OFST+0,s]
1429  029d c105          	cmpb	#5
1430  029f 2704          	beq	L765
1431                     ; 663         *perr = OS_ERR_EVENT_TYPE;
1433  02a1 c601          	ldab	#1
1434                     ; 665         return ((OS_FLAGS)0);
1438  02a3 20e1          	bra	LC010
1439  02a5               L765:
1440                     ; 667     result = (INT8U)(wait_type & OS_FLAG_CONSUME);
1442  02a5 e6f016        	ldab	OFST+7,s
1443  02a8 c480          	andb	#128
1444  02aa 6b83          	stab	OFST-12,s
1445                     ; 668     if (result != (INT8U)0) {                              /* See if we need to consume the flags      */
1447  02ac 270a          	beq	L175
1448                     ; 669         wait_type &= (INT8U)~(INT8U)OS_FLAG_CONSUME;
1450  02ae 0df01680      	bclr	OFST+7,s,128
1451                     ; 670         consume    = OS_TRUE;
1453  02b2 c601          	ldab	#1
1454  02b4 6b83          	stab	OFST-12,s
1456  02b6 2002          	bra	L375
1457  02b8               L175:
1458                     ; 672         consume    = OS_FALSE;
1460  02b8 6983          	clr	OFST-12,s
1461  02ba               L375:
1462                     ; 675     OS_ENTER_CRITICAL();
1464  02ba 160000        	jsr	_OS_CPU_SR_Save
1466  02bd 6b82          	stab	OFST-13,s
1467                     ; 676     switch (wait_type) {
1469  02bf e6f016        	ldab	OFST+7,s
1471  02c2 275f          	beq	L174
1472  02c4 53            	decb	
1473  02c5 277c          	beq	L374
1474  02c7 04010d        	dbeq	b,L564
1475  02ca 040122        	dbeq	b,L764
1476                     ; 747         default:
1476                     ; 748              OS_EXIT_CRITICAL();
1479                     ; 749              flags_rdy = (OS_FLAGS)0;
1481                     ; 750              *perr      = OS_ERR_FLAG_WAIT_TYPE;
1483  02cd               LC011:
1484  02cd e682          	ldab	OFST-13,s
1485  02cf 87            	clra	
1486  02d0 160000        	jsr	_OS_CPU_SR_Restore
1487  02d3 c66f          	ldab	#111
1488                     ; 752              return (flags_rdy);
1492  02d5 20af          	bra	LC010
1493  02d7               L564:
1494                     ; 677         case OS_FLAG_WAIT_SET_ALL:                         /* See if all required flags are set        */
1494                     ; 678              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);   /* Extract only the bits we want     */
1496  02d7 ed8f          	ldy	OFST+0,s
1497  02d9 ec43          	ldd	3,y
1498  02db e4f014        	andb	OFST+5,s
1499  02de a4f013        	anda	OFST+4,s
1500  02e1 6c80          	std	OFST-15,s
1501                     ; 679              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
1503  02e3 acf013        	cpd	OFST+4,s
1504  02e6 266b          	bne	L326
1505                     ; 680                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
1507  02e8 e683          	ldab	OFST-12,s
1508  02ea 53            	decb	
1509  02eb 261f          	bne	L116
1510                     ; 681                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;   /* Clear ONLY the flags we wanted    */
1512                     ; 683                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
1514                     ; 684                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
1517                     ; 685                  *perr                   = OS_ERR_NONE;
1519                     ; 687                  return (flags_rdy);
1523  02ed 2013          	bra	LC017
1524                     ; 689                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
1527                     ; 690                  OS_EXIT_CRITICAL();
1530  02ef               L764:
1531                     ; 694         case OS_FLAG_WAIT_SET_ANY:
1531                     ; 695              flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & flags);    /* Extract only the bits we want    */
1533  02ef ed8f          	ldy	OFST+0,s
1534  02f1 ec43          	ldd	3,y
1535  02f3 e4f014        	andb	OFST+5,s
1536  02f6 a4f013        	anda	OFST+4,s
1537  02f9 6c80          	std	OFST-15,s
1538                     ; 696              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag set                      */
1540  02fb 2756          	beq	L326
1541                     ; 697                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
1543  02fd e683          	ldab	OFST-12,s
1544  02ff 04210a        	dbne	b,L116
1545                     ; 698                      pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;    /* Clear ONLY the flags that we got */
1547  0302               LC017:
1548  0302 ec80          	ldd	OFST-15,s
1549  0304 51            	comb	
1550  0305 41            	coma	
1551  0306 e444          	andb	4,y
1552  0308 a443          	anda	3,y
1553  030a               LC016:
1554  030a 6c43          	std	3,y
1555  030c               L116:
1556                     ; 700                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
1558  030c ec80          	ldd	OFST-15,s
1559  030e fd0000        	ldy	_OSTCBCur
1560  0311 6ce81c        	std	28,y
1561                     ; 701                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
1564                     ; 702                  *perr                   = OS_ERR_NONE;
1566  0314               LC013:
1567  0314 e682          	ldab	OFST-13,s
1568  0316 87            	clra	
1569  0317 160000        	jsr	_OS_CPU_SR_Restore
1570  031a 69f3001b      	clr	[OFST+12,s]
1571                     ; 704                  return (flags_rdy);
1574  031e               LC012:
1575  031e ec80          	ldd	OFST-15,s
1577  0320 06028c        	bra	L23
1578                     ; 706                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
1581                     ; 707                  OS_EXIT_CRITICAL();
1584  0323               L174:
1585                     ; 712         case OS_FLAG_WAIT_CLR_ALL:                         /* See if all required flags are cleared    */
1585                     ; 713              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;    /* Extract only the bits we want     */
1587  0323 ed8f          	ldy	OFST+0,s
1588  0325 ec43          	ldd	3,y
1589  0327 51            	comb	
1590  0328 41            	coma	
1591  0329 e4f014        	andb	OFST+5,s
1592  032c a4f013        	anda	OFST+4,s
1593  032f 6c80          	std	OFST-15,s
1594                     ; 714              if (flags_rdy == flags) {                     /* Must match ALL the bits that we want     */
1596  0331 acf013        	cpd	OFST+4,s
1597  0334 261d          	bne	L326
1598                     ; 715                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
1600                     ; 716                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we wanted        */
1602  0336               LC018:
1603  0336 e683          	ldab	OFST-12,s
1604  0338 53            	decb	
1605  0339 26d1          	bne	L116
1606  033b ec43          	ldd	3,y
1607  033d ea81          	orab	OFST-14,s
1608  033f aa80          	oraa	OFST-15,s
1609                     ; 718                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
1611                     ; 719                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
1614                     ; 720                  *perr                   = OS_ERR_NONE;
1616                     ; 722                  return (flags_rdy);
1620  0341 20c7          	bra	LC016
1621                     ; 724                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
1624                     ; 725                  OS_EXIT_CRITICAL();
1627  0343               L374:
1628                     ; 729         case OS_FLAG_WAIT_CLR_ANY:
1628                     ; 730              flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & flags;   /* Extract only the bits we want      */
1630  0343 ed8f          	ldy	OFST+0,s
1631  0345 ec43          	ldd	3,y
1632  0347 51            	comb	
1633  0348 41            	coma	
1634  0349 e4f014        	andb	OFST+5,s
1635  034c a4f013        	anda	OFST+4,s
1636  034f 6c80          	std	OFST-15,s
1637                     ; 731              if (flags_rdy != (OS_FLAGS)0) {               /* See if any flag cleared                  */
1639                     ; 732                  if (consume == OS_TRUE) {                 /* See if we need to consume the flags      */
1641                     ; 733                      pgrp->OSFlagFlags |= flags_rdy;       /* Set ONLY the flags that we got           */
1643                     ; 735                  OSTCBCur->OSTCBFlagsRdy = flags_rdy;      /* Save flags that were ready               */
1645                     ; 736                  OS_EXIT_CRITICAL();                       /* Yes, condition met, return to caller     */
1648                     ; 737                  *perr                   = OS_ERR_NONE;
1650                     ; 739                  return (flags_rdy);
1654  0351 26e3          	bne	LC018
1655  0353               L326:
1656                     ; 741                  OS_FlagBlock(pgrp, &node, flags, wait_type, timeout);
1659                     ; 742                  OS_EXIT_CRITICAL();
1662  0353 ecf019        	ldd	OFST+10,s
1663  0356 3b            	pshd	
1664  0357 ecf019        	ldd	OFST+10,s
1665  035a 3b            	pshd	
1666  035b e6f01a        	ldab	OFST+11,s
1667  035e 87            	clra	
1668  035f 3b            	pshd	
1669  0360 ecf019        	ldd	OFST+10,s
1670  0363 3b            	pshd	
1671  0364 1a8c          	leax	OFST-3,s
1672  0366 34            	pshx	
1673  0367 ecf019        	ldd	OFST+10,s
1674  036a 16053b        	jsr	L3_OS_FlagBlock
1675  036d 1b8a          	leas	10,s
1676  036f e682          	ldab	OFST-13,s
1677  0371 87            	clra	
1678  0372 160000        	jsr	_OS_CPU_SR_Restore
1679                     ; 755     OS_Sched();                                            /* Find next HPT ready to run               */
1681  0375 160000        	jsr	_OS_Sched
1683                     ; 756     OS_ENTER_CRITICAL();
1685  0378 160000        	jsr	_OS_CPU_SR_Save
1687  037b 6b82          	stab	OFST-13,s
1688                     ; 757     if (OSTCBCur->OSTCBStatPend != OS_STAT_PEND_OK) {      /* Have we timed-out or aborted?            */
1690  037d fd0000        	ldy	_OSTCBCur
1691  0380 e6e823        	ldab	35,y
1692  0383 2732          	beq	L136
1693                     ; 758         pend_stat                = OSTCBCur->OSTCBStatPend;
1695  0385 6b83          	stab	OFST-12,s
1696                     ; 759         OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
1698  0387 69e823        	clr	35,y
1699                     ; 760         OS_FlagUnlink(&node);
1701  038a b774          	tfr	s,d
1702  038c c30004        	addd	#-11+OFST
1703  038f 160661        	jsr	_OS_FlagUnlink
1705                     ; 761         OSTCBCur->OSTCBStat      = OS_STAT_RDY;            /* Yes, make task ready-to-run              */
1707  0392 fd0000        	ldy	_OSTCBCur
1708  0395 87            	clra	
1709  0396 6ae822        	staa	34,y
1710                     ; 762         OS_EXIT_CRITICAL();
1712  0399 e682          	ldab	OFST-13,s
1713  039b 160000        	jsr	_OS_CPU_SR_Restore
1715                     ; 763         flags_rdy                = (OS_FLAGS)0;
1717  039e 87            	clra	
1718  039f c7            	clrb	
1719  03a0 6c80          	std	OFST-15,s
1720                     ; 764         switch (pend_stat) {
1722  03a2 e683          	ldab	OFST-12,s
1724  03a4 040107        	dbeq	b,L105
1725  03a7 042104        	dbne	b,L105
1726                     ; 765             case OS_STAT_PEND_ABORT:
1726                     ; 766                  *perr = OS_ERR_PEND_ABORT;                /* Indicate that we aborted   waiting       */
1728  03aa c60e          	ldab	#14
1729                     ; 767                  break;
1731  03ac 2002          	bra	L536
1732  03ae               L105:
1733                     ; 769             case OS_STAT_PEND_TO:
1733                     ; 770             default:
1733                     ; 771                  *perr = OS_ERR_TIMEOUT;                   /* Indicate that we timed-out waiting       */
1735  03ae c60a          	ldab	#10
1736                     ; 772                  break;
1738  03b0               L536:
1739  03b0 6bf3001b      	stab	[OFST+12,s]
1740                     ; 775         return (flags_rdy);
1744  03b4 06031e        	bra	LC012
1745  03b7               L136:
1746                     ; 777     flags_rdy = OSTCBCur->OSTCBFlagsRdy;
1748  03b7 ece81c        	ldd	28,y
1749  03ba 6c80          	std	OFST-15,s
1750                     ; 778     if (consume == OS_TRUE) {                              /* See if we need to consume the flags      */
1752  03bc e683          	ldab	OFST-12,s
1753  03be 53            	decb	
1754  03bf 1826ff51      	bne	LC013
1755                     ; 779         switch (wait_type) {
1757  03c3 e6f016        	ldab	OFST+7,s
1759  03c6 2718          	beq	L505
1760  03c8 040115        	dbeq	b,L505
1761  03cb 040106        	dbeq	b,L305
1762  03ce 040103        	dbeq	b,L305
1763                     ; 791             default:
1763                     ; 792                  OS_EXIT_CRITICAL();
1766                     ; 793                  *perr = OS_ERR_FLAG_WAIT_TYPE;
1768                     ; 795                  return ((OS_FLAGS)0);
1772  03d1 0602cd        	bra	LC011
1773  03d4               L305:
1774                     ; 780             case OS_FLAG_WAIT_SET_ALL:
1774                     ; 781             case OS_FLAG_WAIT_SET_ANY:                     /* Clear ONLY the flags we got              */
1774                     ; 782                  pgrp->OSFlagFlags &= (OS_FLAGS)~flags_rdy;
1776  03d4 ed8f          	ldy	OFST+0,s
1777  03d6 ec80          	ldd	OFST-15,s
1778  03d8 51            	comb	
1779  03d9 41            	coma	
1780  03da e444          	andb	4,y
1781  03dc a443          	anda	3,y
1782                     ; 783                  break;
1784  03de 2008          	bra	LC015
1785  03e0               L505:
1786                     ; 786             case OS_FLAG_WAIT_CLR_ALL:
1786                     ; 787             case OS_FLAG_WAIT_CLR_ANY:                     /* Set   ONLY the flags we got              */
1786                     ; 788                  pgrp->OSFlagFlags |=  flags_rdy;
1788  03e0 ed8f          	ldy	OFST+0,s
1789  03e2 ec43          	ldd	3,y
1790  03e4 ea81          	orab	OFST-14,s
1791  03e6 aa80          	oraa	OFST-15,s
1792  03e8               LC015:
1793  03e8 6c43          	std	3,y
1794                     ; 789                  break;
1796                     ; 798     OS_EXIT_CRITICAL();
1799                     ; 799     *perr = OS_ERR_NONE;                                   /* Event(s) must have occurred              */
1801                     ; 801     return (flags_rdy);
1805  03ea 060314        	bra	LC013
1847                     ; 820 _NEAR OS_FLAGS  OSFlagPendGetFlagsRdy (void)
1847                     ; 821 {
1848                     	switch	.text
1849  03ed               _OSFlagPendGetFlagsRdy:
1851  03ed 1b9d          	leas	-3,s
1852       00000003      OFST:	set	3
1855                     ; 824     OS_CPU_SR     cpu_sr = 0u;
1857                     ; 829     OS_ENTER_CRITICAL();
1859  03ef 160000        	jsr	_OS_CPU_SR_Save
1861  03f2 6b80          	stab	OFST-3,s
1862                     ; 830     flags = OSTCBCur->OSTCBFlagsRdy;
1864  03f4 fd0000        	ldy	_OSTCBCur
1865  03f7 ece81c        	ldd	28,y
1866  03fa 6c81          	std	OFST-2,s
1867                     ; 831     OS_EXIT_CRITICAL();
1869  03fc e680          	ldab	OFST-3,s
1870  03fe 87            	clra	
1871  03ff 160000        	jsr	_OS_CPU_SR_Restore
1873                     ; 832     return (flags);
1875  0402 ec81          	ldd	OFST-2,s
1878  0404 1b83          	leas	3,s
1879  0406 3d            	rts	
1990                     ; 877 _NEAR OS_FLAGS  OSFlagPost (OS_FLAG_GRP  *pgrp,
1990                     ; 878                            OS_FLAGS      flags,
1990                     ; 879                            INT8U         opt,
1990                     ; 880                            INT8U        *perr)
1990                     ; 881 {
1991                     	switch	.text
1992  0407               _OSFlagPost:
1994  0407 3b            	pshd	
1995  0408 1b99          	leas	-7,s
1996       00000007      OFST:	set	7
1999                     ; 888     OS_CPU_SR     cpu_sr = 0u;
2001                     ; 900     if (pgrp == (OS_FLAG_GRP *)0) {                  /* Validate 'pgrp'                                */
2003  040a 046404        	tbne	d,L357
2004                     ; 901         *perr = OS_ERR_FLAG_INVALID_PGRP;
2006  040d c66e          	ldab	#110
2007                     ; 902         return ((OS_FLAGS)0);
2010  040f 200a          	bra	L04
2011  0411               L357:
2012                     ; 908     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) {    /* Make sure we are pointing to an event flag grp */
2015  0411 e6f30007      	ldab	[OFST+0,s]
2016  0415 c105          	cmpb	#5
2017  0417 270b          	beq	L557
2018                     ; 909         *perr = OS_ERR_EVENT_TYPE;
2020  0419 c601          	ldab	#1
2021                     ; 911         return ((OS_FLAGS)0);
2025  041b               L04:
2026  041b 6bf3000f      	stab	[OFST+8,s]
2027  041f 87            	clra	
2028  0420 c7            	clrb	
2030  0421 1b89          	leas	9,s
2031  0423 3d            	rts	
2032  0424               L557:
2033                     ; 914     OS_ENTER_CRITICAL();
2035  0424 160000        	jsr	_OS_CPU_SR_Save
2037  0427 6b86          	stab	OFST-1,s
2038                     ; 915     switch (opt) {
2040  0429 e68e          	ldab	OFST+7,s
2042  042b 270d          	beq	L366
2043  042d 040116        	dbeq	b,L566
2044                     ; 924         default:
2044                     ; 925              OS_EXIT_CRITICAL();                     /* INVALID option                                 */
2046  0430 e686          	ldab	OFST-1,s
2047  0432 87            	clra	
2048  0433 160000        	jsr	_OS_CPU_SR_Restore
2050                     ; 926              *perr = OS_ERR_FLAG_INVALID_OPT;
2052  0436 c671          	ldab	#113
2053                     ; 928              return ((OS_FLAGS)0);
2057  0438 20e1          	bra	L04
2058  043a               L366:
2059                     ; 916         case OS_FLAG_CLR:
2059                     ; 917              pgrp->OSFlagFlags &= (OS_FLAGS)~flags;  /* Clear the flags specified in the group         */
2061  043a ed87          	ldy	OFST+0,s
2062  043c ec8b          	ldd	OFST+4,s
2063  043e 51            	comb	
2064  043f 41            	coma	
2065  0440 e444          	andb	4,y
2066  0442 a443          	anda	3,y
2067                     ; 918              break;
2069  0444 2008          	bra	L167
2070  0446               L566:
2071                     ; 920         case OS_FLAG_SET:
2071                     ; 921              pgrp->OSFlagFlags |=  flags;            /* Set   the flags specified in the group         */
2073  0446 ed87          	ldy	OFST+0,s
2074  0448 ec43          	ldd	3,y
2075  044a ea8c          	orab	OFST+5,s
2076  044c aa8b          	oraa	OFST+4,s
2077                     ; 922              break;
2079  044e               L167:
2080  044e 6c43          	std	3,y
2081                     ; 930     sched = OS_FALSE;                                /* Indicate that we don't need rescheduling       */
2083  0450 6985          	clr	OFST-2,s
2084                     ; 931     pnode = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
2086  0452 ec41          	ldd	1,y
2088  0454 0604dc        	bra	L567
2089  0457               L367:
2090                     ; 933         switch (pnode->OSFlagNodeWaitType) {
2092  0457 b746          	tfr	d,y
2093  0459 e64a          	ldab	10,y
2095  045b 2741          	beq	L576
2096  045d 53            	decb	
2097  045e 2752          	beq	L776
2098  0460 04010d        	dbeq	b,L176
2099  0463 04012e        	dbeq	b,L376
2100                     ; 975             default:
2100                     ; 976                  OS_EXIT_CRITICAL();
2102  0466 e686          	ldab	OFST-1,s
2103  0468 87            	clra	
2104  0469 160000        	jsr	_OS_CPU_SR_Restore
2106                     ; 977                  *perr = OS_ERR_FLAG_WAIT_TYPE;
2108  046c c66f          	ldab	#111
2109                     ; 979                  return ((OS_FLAGS)0);
2113  046e 20ab          	bra	L04
2114  0470               L176:
2115                     ; 934             case OS_FLAG_WAIT_SET_ALL:               /* See if all req. flags are set for current node */
2115                     ; 935                  flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
2117  0470 ec48          	ldd	8,y
2118  0472 ed87          	ldy	OFST+0,s
2119  0474 e444          	andb	4,y
2120  0476 a443          	anda	3,y
2121  0478 6c82          	std	OFST-5,s
2122                     ; 936                  if (flags_rdy == pnode->OSFlagNodeFlags) {   /* Make task RTR, event(s) Rx'd          */
2124  047a ed80          	ldy	OFST-7,s
2125  047c ac48          	cpd	8,y
2126  047e 2658          	bne	L377
2127                     ; 937                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
2129  0480 87            	clra	
2130  0481 c7            	clrb	
2131  0482 3b            	pshd	
2132  0483 ec84          	ldd	OFST-3,s
2133  0485 3b            	pshd	
2134  0486 b764          	tfr	y,d
2135  0488 160611        	jsr	L5_OS_FlagTaskRdy
2137  048b 1b84          	leas	4,s
2138  048d 6b84          	stab	OFST-3,s
2139                     ; 938                      if (rdy == OS_TRUE) {
2141  048f 53            	decb	
2142  0490 2646          	bne	L377
2143                     ; 939                          sched = OS_TRUE;                     /* When done we will reschedule          */
2145  0492 2040          	bra	LC019
2146  0494               L376:
2147                     ; 944             case OS_FLAG_WAIT_SET_ANY:               /* See if any flag set                            */
2147                     ; 945                  flags_rdy = (OS_FLAGS)(pgrp->OSFlagFlags & pnode->OSFlagNodeFlags);
2149  0494 ec48          	ldd	8,y
2150  0496 ed87          	ldy	OFST+0,s
2151  0498 e444          	andb	4,y
2152  049a a443          	anda	3,y
2153                     ; 946                  if (flags_rdy != (OS_FLAGS)0) {              /* Make task RTR, event(s) Rx'd          */
2155                     ; 947                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
2158                     ; 948                      if (rdy == OS_TRUE) {
2160                     ; 949                          sched = OS_TRUE;                     /* When done we will reschedule          */
2162  049c 2020          	bra	LC021
2163  049e               L576:
2164                     ; 955             case OS_FLAG_WAIT_CLR_ALL:               /* See if all req. flags are set for current node */
2164                     ; 956                  flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & pnode->OSFlagNodeFlags;
2166  049e ed87          	ldy	OFST+0,s
2167  04a0 ec43          	ldd	3,y
2168  04a2 51            	comb	
2169  04a3 41            	coma	
2170  04a4 ed80          	ldy	OFST-7,s
2171  04a6 e449          	andb	9,y
2172  04a8 a448          	anda	8,y
2173  04aa 6c82          	std	OFST-5,s
2174                     ; 957                  if (flags_rdy == pnode->OSFlagNodeFlags) {   /* Make task RTR, event(s) Rx'd          */
2176  04ac ac48          	cpd	8,y
2177  04ae 2628          	bne	L377
2178                     ; 958                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
2181                     ; 959                      if (rdy == OS_TRUE) {
2183                     ; 960                          sched = OS_TRUE;                     /* When done we will reschedule          */
2185  04b0 2010          	bra	LC020
2186  04b2               L776:
2187                     ; 965             case OS_FLAG_WAIT_CLR_ANY:               /* See if any flag set                            */
2187                     ; 966                  flags_rdy = (OS_FLAGS)~pgrp->OSFlagFlags & pnode->OSFlagNodeFlags;
2189  04b2 ed87          	ldy	OFST+0,s
2190  04b4 ec43          	ldd	3,y
2191  04b6 51            	comb	
2192  04b7 41            	coma	
2193  04b8 ed80          	ldy	OFST-7,s
2194  04ba e449          	andb	9,y
2195  04bc a448          	anda	8,y
2196                     ; 967                  if (flags_rdy != (OS_FLAGS)0) {              /* Make task RTR, event(s) Rx'd          */
2198  04be               LC021:
2199  04be 6c82          	std	OFST-5,s
2200  04c0 2716          	beq	L377
2201                     ; 968                      rdy = OS_FlagTaskRdy(pnode, flags_rdy, OS_STAT_PEND_OK);
2204                     ; 969                      if (rdy == OS_TRUE) {
2206  04c2               LC020:
2207  04c2 87            	clra	
2208  04c3 c7            	clrb	
2209  04c4 3b            	pshd	
2210  04c5 ec84          	ldd	OFST-3,s
2211  04c7 3b            	pshd	
2212  04c8 ec84          	ldd	OFST-3,s
2213  04ca 160611        	jsr	L5_OS_FlagTaskRdy
2214  04cd 1b84          	leas	4,s
2215  04cf 6b84          	stab	OFST-3,s
2216  04d1 042104        	dbne	b,L377
2217                     ; 970                          sched = OS_TRUE;                     /* When done we will reschedule          */
2219  04d4               LC019:
2220  04d4 c601          	ldab	#1
2221  04d6 6b85          	stab	OFST-2,s
2222  04d8               L377:
2223                     ; 981         pnode = (OS_FLAG_NODE *)pnode->OSFlagNodeNext; /* Point to next task waiting for event flag(s) */
2225  04d8 ecf30000      	ldd	[OFST-7,s]
2226  04dc               L567:
2227  04dc 6c80          	std	OFST-7,s
2228                     ; 932     while (pnode != (OS_FLAG_NODE *)0) {             /* Go through all tasks waiting on event flag(s)  */
2230  04de 1826ff75      	bne	L367
2231                     ; 983     OS_EXIT_CRITICAL();
2233  04e2 e686          	ldab	OFST-1,s
2234  04e4 160000        	jsr	_OS_CPU_SR_Restore
2236                     ; 984     if (sched == OS_TRUE) {
2238  04e7 e685          	ldab	OFST-2,s
2239  04e9 042103        	dbne	b,L5101
2240                     ; 985         OS_Sched();
2242  04ec 160000        	jsr	_OS_Sched
2244  04ef               L5101:
2245                     ; 987     OS_ENTER_CRITICAL();
2247  04ef 160000        	jsr	_OS_CPU_SR_Save
2249  04f2 6b86          	stab	OFST-1,s
2250                     ; 988     flags_cur = pgrp->OSFlagFlags;
2252  04f4 ed87          	ldy	OFST+0,s
2253  04f6 18024382      	movw	3,y,OFST-5,s
2254                     ; 989     OS_EXIT_CRITICAL();
2256  04fa 87            	clra	
2257  04fb 160000        	jsr	_OS_CPU_SR_Restore
2259                     ; 990     *perr     = OS_ERR_NONE;
2261  04fe 69f3000f      	clr	[OFST+8,s]
2262                     ; 993     return (flags_cur);
2265  0502 ec82          	ldd	OFST-5,s
2268  0504 1b89          	leas	9,s
2269  0506 3d            	rts	
2331                     ; 1017 _NEAR OS_FLAGS  OSFlagQuery (OS_FLAG_GRP  *pgrp,
2331                     ; 1018                             INT8U        *perr)
2331                     ; 1019 {
2332                     	switch	.text
2333  0507               _OSFlagQuery:
2335  0507 3b            	pshd	
2336  0508 1b9d          	leas	-3,s
2337       00000003      OFST:	set	3
2340                     ; 1022     OS_CPU_SR  cpu_sr = 0u;
2342                     ; 1035     if (pgrp == (OS_FLAG_GRP *)0) {               /* Validate 'pgrp'                                   */
2344  050a 046404        	tbne	d,L7401
2345                     ; 1036         *perr = OS_ERR_FLAG_INVALID_PGRP;
2347  050d c66e          	ldab	#110
2348                     ; 1037         return ((OS_FLAGS)0);
2351  050f 200a          	bra	LC022
2352  0511               L7401:
2353                     ; 1040     if (pgrp->OSFlagType != OS_EVENT_TYPE_FLAG) { /* Validate event block type                         */
2355  0511 e6f30003      	ldab	[OFST+0,s]
2356  0515 c105          	cmpb	#5
2357  0517 270b          	beq	L1501
2358                     ; 1041         *perr = OS_ERR_EVENT_TYPE;
2360  0519 c601          	ldab	#1
2361                     ; 1042         return ((OS_FLAGS)0);
2363  051b               LC022:
2364  051b 6bf30007      	stab	[OFST+4,s]
2365  051f 87            	clra	
2366  0520 c7            	clrb	
2368  0521               L44:
2370  0521 1b85          	leas	5,s
2371  0523 3d            	rts	
2372  0524               L1501:
2373                     ; 1044     OS_ENTER_CRITICAL();
2375  0524 160000        	jsr	_OS_CPU_SR_Save
2377  0527 6b80          	stab	OFST-3,s
2378                     ; 1045     flags = pgrp->OSFlagFlags;
2380  0529 ed83          	ldy	OFST+0,s
2381  052b 18024381      	movw	3,y,OFST-2,s
2382                     ; 1046     OS_EXIT_CRITICAL();
2384  052f 87            	clra	
2385  0530 160000        	jsr	_OS_CPU_SR_Restore
2387                     ; 1047     *perr = OS_ERR_NONE;
2389  0533 69f30007      	clr	[OFST+4,s]
2390                     ; 1048     return (flags);                               /* Return the current value of the event flags       */
2392  0537 ec81          	ldd	OFST-2,s
2394  0539 20e6          	bra	L44
2485                     ; 1090 static  void  OS_FlagBlock (OS_FLAG_GRP  *pgrp,
2485                     ; 1091                             OS_FLAG_NODE *pnode,
2485                     ; 1092                             OS_FLAGS      flags,
2485                     ; 1093                             INT8U         wait_type,
2485                     ; 1094                             INT32U        timeout)
2485                     ; 1095 {
2486                     	switch	.text
2487  053b               L3_OS_FlagBlock:
2489  053b 3b            	pshd	
2490  053c 1b9d          	leas	-3,s
2491       00000003      OFST:	set	3
2494                     ; 1100     OSTCBCur->OSTCBStat      |= OS_STAT_FLAG;
2496  053e fd0000        	ldy	_OSTCBCur
2497  0541 0ce82220      	bset	34,y,32
2498                     ; 1101     OSTCBCur->OSTCBStatPend   = OS_STAT_PEND_OK;
2500  0545 69e823        	clr	35,y
2501                     ; 1102     OSTCBCur->OSTCBDly        = timeout;              /* Store timeout in task's TCB                   */
2503  0548 ec8f          	ldd	OFST+12,s
2504  054a 6ce820        	std	32,y
2505  054d ec8d          	ldd	OFST+10,s
2506  054f 6ce81e        	std	30,y
2507                     ; 1104     OSTCBCur->OSTCBFlagNode   = pnode;                /* TCB to link to node                           */
2509  0552 ec87          	ldd	OFST+4,s
2510  0554 6ce81a        	std	26,y
2511                     ; 1106     pnode->OSFlagNodeFlags    = flags;                /* Save the flags that we need to wait for       */
2513  0557 b746          	tfr	d,y
2514  0559 18028948      	movw	OFST+6,s,8,y
2515                     ; 1107     pnode->OSFlagNodeWaitType = wait_type;            /* Save the type of wait we are doing            */
2517  055d 180a8c4a      	movb	OFST+9,s,10,y
2518                     ; 1108     pnode->OSFlagNodeTCB      = (void *)OSTCBCur;     /* Link to task's TCB                            */
2520  0561 1801440000    	movw	_OSTCBCur,4,y
2521                     ; 1109     pnode->OSFlagNodeNext     = pgrp->OSFlagWaitList; /* Add node at beginning of event flag wait list */
2523  0566 ee83          	ldx	OFST+0,s
2524  0568 ed87          	ldy	OFST+4,s
2525  056a 18020140      	movw	1,x,0,y
2526                     ; 1110     pnode->OSFlagNodePrev     = (void *)0;
2528  056e 87            	clra	
2529  056f c7            	clrb	
2530  0570 6c42          	std	2,y
2531                     ; 1111     pnode->OSFlagNodeFlagGrp  = (void *)pgrp;         /* Link to Event Flag Group                      */
2533  0572 18028346      	movw	OFST+0,s,6,y
2534                     ; 1112     pnode_next                = (OS_FLAG_NODE *)pgrp->OSFlagWaitList;
2536  0576 ed83          	ldy	OFST+0,s
2537  0578 ed41          	ldy	1,y
2538  057a 6d80          	sty	OFST-3,s
2539                     ; 1113     if (pnode_next != (void *)0) {                    /* Is this the first NODE to insert?             */
2541  057c 2704          	beq	L7111
2542                     ; 1114         pnode_next->OSFlagNodePrev = pnode;           /* No, link in doubly linked list                */
2544  057e 18028742      	movw	OFST+4,s,2,y
2545  0582               L7111:
2546                     ; 1116     pgrp->OSFlagWaitList = (void *)pnode;
2548  0582 ed83          	ldy	OFST+0,s
2549  0584 18028741      	movw	OFST+4,s,1,y
2550                     ; 1118     y            =  OSTCBCur->OSTCBY;                 /* Suspend current task until flag(s) received   */
2552  0588 fd0000        	ldy	_OSTCBCur
2553  058b e6e826        	ldab	38,y
2554                     ; 1119     OSRdyTbl[y] &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
2556  058e b796          	exg	b,y
2557  0590 fe0000        	ldx	_OSTCBCur
2558  0593 e6e027        	ldab	39,x
2559  0596 51            	comb	
2560  0597 e4ea0000      	andb	_OSRdyTbl,y
2561  059b 6bea0000      	stab	_OSRdyTbl,y
2562                     ; 1121     if (OSRdyTbl[y] == 0x00u) {
2565  059f 260c          	bne	L1211
2566                     ; 1122         OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
2568  05a1 b756          	tfr	x,y
2569  05a3 e6e828        	ldab	40,y
2570  05a6 51            	comb	
2571  05a7 f40000        	andb	_OSRdyGrp
2572  05aa 7b0000        	stab	_OSRdyGrp
2573  05ad               L1211:
2574                     ; 1124 }
2577  05ad 1b85          	leas	5,s
2578  05af 3d            	rts	
2643                     ; 1142 _NEAR void  OS_FlagInit (void)
2643                     ; 1143 {
2644                     	switch	.text
2645  05b0               _OS_FlagInit:
2647  05b0 1b9a          	leas	-6,s
2648       00000006      OFST:	set	6
2651                     ; 1161     OS_MemClr((INT8U *)&OSFlagTbl[0], sizeof(OSFlagTbl));           /* Clear the flag group table      */
2653  05b2 cc0023        	ldd	#35
2654  05b5 3b            	pshd	
2655  05b6 cc0000        	ldd	#_OSFlagTbl
2656  05b9 160000        	jsr	_OS_MemClr
2658  05bc 1b82          	leas	2,s
2659                     ; 1162     for (ix = 0u; ix < (OS_MAX_FLAGS - 1u); ix++) {                 /* Init. list of free EVENT FLAGS  */
2661  05be 87            	clra	
2662  05bf c7            	clrb	
2663  05c0 b746          	tfr	d,y
2664  05c2 6d82          	sty	OFST-4,s
2665  05c4               L5511:
2666                     ; 1163         ix_next = ix + 1u;
2668  05c4 02            	iny	
2669  05c5 6d84          	sty	OFST-2,s
2670                     ; 1164         pgrp1 = &OSFlagTbl[ix];
2672  05c7 cd0007        	ldy	#7
2673  05ca 13            	emul	
2674  05cb c30000        	addd	#_OSFlagTbl
2675  05ce 6c80          	std	OFST-6,s
2676                     ; 1165         pgrp2 = &OSFlagTbl[ix_next];
2678  05d0 ec84          	ldd	OFST-2,s
2679  05d2 cd0007        	ldy	#7
2680  05d5 13            	emul	
2681  05d6 c30000        	addd	#_OSFlagTbl
2682  05d9 6c84          	std	OFST-2,s
2683                     ; 1166         pgrp1->OSFlagType     = OS_EVENT_TYPE_UNUSED;
2685  05db ed80          	ldy	OFST-6,s
2686  05dd 6940          	clr	0,y
2687                     ; 1167         pgrp1->OSFlagWaitList = (void *)pgrp2;
2689  05df 6c41          	std	1,y
2690                     ; 1169         pgrp1->OSFlagName     = (INT8U *)(void *)"?";               /* Unknown name                    */
2692  05e1 cc0000        	ldd	#L112
2693  05e4 6c45          	std	5,y
2694                     ; 1162     for (ix = 0u; ix < (OS_MAX_FLAGS - 1u); ix++) {                 /* Init. list of free EVENT FLAGS  */
2696  05e6 ed82          	ldy	OFST-4,s
2697  05e8 02            	iny	
2700  05e9 b764          	tfr	y,d
2701  05eb 6c82          	std	OFST-4,s
2702  05ed 8c0004        	cpd	#4
2703  05f0 25d2          	blo	L5511
2704                     ; 1172     pgrp1                 = &OSFlagTbl[ix];
2706  05f2 cd0007        	ldy	#7
2707  05f5 13            	emul	
2708  05f6 c30000        	addd	#_OSFlagTbl
2709  05f9 6c80          	std	OFST-6,s
2710                     ; 1173     pgrp1->OSFlagType     = OS_EVENT_TYPE_UNUSED;
2712  05fb 87            	clra	
2713  05fc ed80          	ldy	OFST-6,s
2714  05fe 6a40          	staa	0,y
2715                     ; 1174     pgrp1->OSFlagWaitList = (void *)0;
2717  0600 c7            	clrb	
2718  0601 6c41          	std	1,y
2719                     ; 1176     pgrp1->OSFlagName     = (INT8U *)(void *)"?";                   /* Unknown name                    */
2721  0603 cc0000        	ldd	#L112
2722  0606 6c45          	std	5,y
2723                     ; 1178     OSFlagFreeList        = &OSFlagTbl[0];
2725  0608 cc0000        	ldd	#_OSFlagTbl
2726  060b 7c0000        	std	_OSFlagFreeList
2727                     ; 1180 }
2730  060e 1b86          	leas	6,s
2731  0610 3d            	rts	
3120                     ; 1209 static  BOOLEAN  OS_FlagTaskRdy (OS_FLAG_NODE *pnode,
3120                     ; 1210                                  OS_FLAGS      flags_rdy,
3120                     ; 1211                                  INT8U         pend_stat)
3120                     ; 1212 {
3121                     	switch	.text
3122  0611               L5_OS_FlagTaskRdy:
3124  0611 3b            	pshd	
3125  0612 1b9d          	leas	-3,s
3126       00000003      OFST:	set	3
3129                     ; 1217     ptcb                 = (OS_TCB *)pnode->OSFlagNodeTCB; /* Point to TCB of waiting task             */
3131  0614 b746          	tfr	d,y
3132  0616 ed44          	ldy	4,y
3133  0618 6d80          	sty	OFST-3,s
3134                     ; 1218     ptcb->OSTCBDly       = 0u;
3136  061a 87            	clra	
3137  061b c7            	clrb	
3138  061c 6ce820        	std	32,y
3139  061f 6ce81e        	std	30,y
3140                     ; 1219     ptcb->OSTCBFlagsRdy  = flags_rdy;
3142  0622 ec87          	ldd	OFST+4,s
3143  0624 6ce81c        	std	28,y
3144                     ; 1220     ptcb->OSTCBStat     &= (INT8U)~(INT8U)OS_STAT_FLAG;
3146  0627 0de82220      	bclr	34,y,32
3147                     ; 1221     ptcb->OSTCBStatPend  = pend_stat;
3149  062b e68a          	ldab	OFST+7,s
3150  062d 6be823        	stab	35,y
3151                     ; 1222     if (ptcb->OSTCBStat == OS_STAT_RDY) {                  /* Task now ready?                          */
3153  0630 e6e822        	ldab	34,y
3154  0633 2621          	bne	L7041
3155                     ; 1223         OSRdyGrp               |= ptcb->OSTCBBitY;         /* Put task into ready list                 */
3157  0635 e6e828        	ldab	40,y
3158  0638 fa0000        	orab	_OSRdyGrp
3159  063b 7b0000        	stab	_OSRdyGrp
3160                     ; 1224         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
3162  063e e6e826        	ldab	38,y
3163  0641 b796          	exg	b,y
3164  0643 ee80          	ldx	OFST-3,s
3165  0645 e6e027        	ldab	39,x
3166  0648 eaea0000      	orab	_OSRdyTbl,y
3167  064c 6bea0000      	stab	_OSRdyTbl,y
3168                     ; 1226         sched                   = OS_TRUE;
3171  0650 c601          	ldab	#1
3172  0652 6b82          	stab	OFST-1,s
3174  0654 2002          	bra	L1141
3175  0656               L7041:
3176                     ; 1228         sched                   = OS_FALSE;
3178  0656 6982          	clr	OFST-1,s
3179  0658               L1141:
3180                     ; 1230     OS_FlagUnlink(pnode);
3182  0658 ec83          	ldd	OFST+0,s
3183  065a 0705          	jsr	_OS_FlagUnlink
3185                     ; 1231     return (sched);
3187  065c e682          	ldab	OFST-1,s
3190  065e 1b85          	leas	5,s
3191  0660 3d            	rts	
3275                     ; 1256 _NEAR void  OS_FlagUnlink (OS_FLAG_NODE *pnode)
3275                     ; 1257 {
3276                     	switch	.text
3277  0661               _OS_FlagUnlink:
3279  0661 3b            	pshd	
3280  0662 1b9c          	leas	-4,s
3281       00000004      OFST:	set	4
3284                     ; 1266     pnode_prev = (OS_FLAG_NODE *)pnode->OSFlagNodePrev;
3286  0664 b746          	tfr	d,y
3287  0666 18024280      	movw	2,y,OFST-4,s
3288                     ; 1267     pnode_next = (OS_FLAG_NODE *)pnode->OSFlagNodeNext;
3290  066a ed84          	ldy	OFST+0,s
3291  066c ec40          	ldd	0,y
3292  066e 6c82          	std	OFST-2,s
3293                     ; 1268     if (pnode_prev == (OS_FLAG_NODE *)0) {                      /* Is it first node in wait list?      */
3295  0670 ee80          	ldx	OFST-4,s
3296  0672 260e          	bne	L3641
3297                     ; 1269         pgrp                 = (OS_FLAG_GRP *)pnode->OSFlagNodeFlagGrp;
3299  0674 ed46          	ldy	6,y
3300  0676 6d80          	sty	OFST-4,s
3301                     ; 1270         pgrp->OSFlagWaitList = (void *)pnode_next;              /*      Update list for new 1st node   */
3303  0678 6c41          	std	1,y
3304                     ; 1271         if (pnode_next != (OS_FLAG_NODE *)0) {
3306  067a 2710          	beq	L7641
3307                     ; 1272             pnode_next->OSFlagNodePrev = (OS_FLAG_NODE *)0;     /*      Link new 1st node PREV to NULL */
3309  067c 87            	clra	
3310  067d c7            	clrb	
3311  067e ed82          	ldy	OFST-2,s
3312  0680 2008          	bra	LC023
3313  0682               L3641:
3314                     ; 1275         pnode_prev->OSFlagNodeNext = pnode_next;                /*      Link around the node to unlink */
3316  0682 b746          	tfr	d,y
3317  0684 6d00          	sty	0,x
3318                     ; 1276         if (pnode_next != (OS_FLAG_NODE *)0) {                  /*      Was this the LAST node?        */
3320  0686 2704          	beq	L7641
3321                     ; 1277             pnode_next->OSFlagNodePrev = pnode_prev;            /*      No, Link around current node   */
3323  0688 b754          	tfr	x,d
3324  068a               LC023:
3325  068a 6c42          	std	2,y
3326  068c               L7641:
3327                     ; 1281     ptcb                = (OS_TCB *)pnode->OSFlagNodeTCB;
3329  068c ed84          	ldy	OFST+0,s
3330  068e ed44          	ldy	4,y
3331                     ; 1282     ptcb->OSTCBFlagNode = (OS_FLAG_NODE *)0;
3333  0690 87            	clra	
3334  0691 c7            	clrb	
3335  0692 6ce81a        	std	26,y
3336                     ; 1284 }
3339  0695 1b86          	leas	6,s
3340  0697 3d            	rts	
3352                     	xref	_OS_StrLen
3353                     	xref	_OS_Sched
3354                     	xref	_OS_MemClr
3355                     	xdef	_OS_FlagUnlink
3356                     	xdef	_OS_FlagInit
3357                     	xdef	_OSFlagQuery
3358                     	xdef	_OSFlagPost
3359                     	xdef	_OSFlagPendGetFlagsRdy
3360                     	xdef	_OSFlagPend
3361                     	xdef	_OSFlagNameSet
3362                     	xdef	_OSFlagNameGet
3363                     	xdef	_OSFlagDel
3364                     	xdef	_OSFlagCreate
3365                     	xdef	_OSFlagAccept
3366                     	xref	_OSTCBCur
3367                     	xref	_OSRdyTbl
3368                     	xref	_OSRdyGrp
3369                     	xref	_OSLockNesting
3370                     	xref	_OSIntNesting
3371                     	xref	_OSFlagFreeList
3372                     	xref	_OSFlagTbl
3373                     	xref	_OS_CPU_SR_Restore
3374                     	xref	_OS_CPU_SR_Save
3375                     .const:	section	.data
3376  0000               L112:
3377  0000 3f00          	dc.b	"?",0
3398                     	end

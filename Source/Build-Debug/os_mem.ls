   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 196                     .const:	section	.data
 197                     	even
 198  0000               L6:
 199  0000 00000001      	dc.l	1
 200                     ; 70 _NEAR OS_MEM  *OSMemCreate (void   *addr,
 200                     ; 71                            INT32U  nblks,
 200                     ; 72                            INT32U  blksize,
 200                     ; 73                            INT8U  *perr)
 200                     ; 74 {
 201                     	switch	.text
 202  0000               _OSMemCreate:
 204  0000 3b            	pshd	
 205  0001 1b91          	leas	-15,s
 206       0000000f      OFST:	set	15
 209                     ; 81     OS_CPU_SR  cpu_sr = 0u;
 211                     ; 102     if (addr == (void *)0) {                          /* Must pass a valid address for the memory part.*/
 213  0003 046402        	tbne	d,L311
 214                     ; 103         *perr = OS_ERR_MEM_INVALID_ADDR;
 216                     ; 104         return ((OS_MEM *)0);
 219  0006 2005          	bra	LC002
 220  0008               L311:
 221                     ; 106     if (((INT32U)addr & (sizeof(void *) - 1u)) != 0u){  /* Must be pointer size aligned                */
 223  0008 0ff010010c    	brclr	OFST+1,s,1,L511
 224                     ; 107         *perr = OS_ERR_MEM_INVALID_ADDR;
 226  000d               LC002:
 227  000d c662          	ldab	#98
 228                     ; 108         return ((OS_MEM *)0);
 230  000f               LC001:
 231  000f 6bf3001b      	stab	[OFST+12,s]
 232  0013 87            	clra	
 233  0014 c7            	clrb	
 235  0015               L21:
 237  0015 1bf011        	leas	17,s
 238  0018 3d            	rts	
 239  0019               L511:
 240                     ; 110     if (nblks < 2u) {                                 /* Must have at least 2 blocks per partition     */
 242  0019 ecf015        	ldd	OFST+6,s
 243  001c 8c0002        	cpd	#2
 244  001f ecf013        	ldd	OFST+4,s
 245  0022 c200          	sbcb	#0
 246  0024 8200          	sbca	#0
 247  0026 2404          	bhs	L711
 248                     ; 111         *perr = OS_ERR_MEM_INVALID_BLKS;
 250  0028 c65b          	ldab	#91
 251                     ; 112         return ((OS_MEM *)0);
 254  002a 20e3          	bra	LC001
 255  002c               L711:
 256                     ; 114     if (blksize < sizeof(void *)) {                   /* Must contain space for at least a pointer     */
 258  002c ecf019        	ldd	OFST+10,s
 259  002f 8c0002        	cpd	#2
 260  0032 ecf017        	ldd	OFST+8,s
 261  0035 c200          	sbcb	#0
 262  0037 8200          	sbca	#0
 263  0039 2404          	bhs	L121
 264                     ; 115         *perr = OS_ERR_MEM_INVALID_SIZE;
 266  003b c65c          	ldab	#92
 267                     ; 116         return ((OS_MEM *)0);
 270  003d 20d0          	bra	LC001
 271  003f               L121:
 272                     ; 119     OS_ENTER_CRITICAL();
 274  003f 160000        	jsr	_OS_CPU_SR_Save
 276  0042 6b8e          	stab	OFST-1,s
 277                     ; 120     pmem = OSMemFreeList;                             /* Get next free memory partition                */
 279  0044 fd0000        	ldy	_OSMemFreeList
 280  0047 6d82          	sty	OFST-13,s
 281                     ; 121     if (OSMemFreeList != (OS_MEM *)0) {               /* See if pool of free partitions was empty      */
 283  0049 2705          	beq	L321
 284                     ; 122         OSMemFreeList = (OS_MEM *)OSMemFreeList->OSMemFreeList;
 286  004b 1805420000    	movw	2,y,_OSMemFreeList
 287  0050               L321:
 288                     ; 124     OS_EXIT_CRITICAL();
 290  0050 87            	clra	
 291  0051 160000        	jsr	_OS_CPU_SR_Restore
 293                     ; 125     if (pmem == (OS_MEM *)0) {                        /* See if we have a memory partition             */
 295  0054 ec82          	ldd	OFST-13,s
 296  0056 2604          	bne	L521
 297                     ; 126         *perr = OS_ERR_MEM_INVALID_PART;
 299  0058 c65a          	ldab	#90
 300                     ; 127         return ((OS_MEM *)0);
 303  005a 20b3          	bra	LC001
 304  005c               L521:
 305                     ; 129     plink = (void **)addr;                            /* Create linked list of free memory blocks      */
 307  005c ec8f          	ldd	OFST+0,s
 308  005e 6c84          	std	OFST-11,s
 309                     ; 130     pblk  = (INT8U *)addr;
 311  0060 6c80          	std	OFST-15,s
 312                     ; 131     loops  = nblks - 1u;
 314  0062 ecf015        	ldd	OFST+6,s
 315  0065 eef013        	ldx	OFST+4,s
 316  0068 cd0000        	ldy	#L6
 317  006b 160000        	jsr	c_lsub
 319  006e 6c8c          	std	OFST-3,s
 320  0070 6e8a          	stx	OFST-5,s
 321                     ; 132     for (i = 0u; i < loops; i++) {
 323  0072 87            	clra	
 324  0073 c7            	clrb	
 325  0074 6c88          	std	OFST-7,s
 326  0076 6c86          	std	OFST-9,s
 328  0078 2022          	bra	L01
 329  007a               L721:
 330                     ; 133         pblk +=  blksize;                             /* Point to the FOLLOWING block                  */
 332  007a ec80          	ldd	OFST-15,s
 333  007c ce0000        	ldx	#0
 334  007f 19f017        	leay	OFST+8,s
 335  0082 160000        	jsr	c_ladd
 337  0085 6c80          	std	OFST-15,s
 338                     ; 134        *plink = (void  *)pblk;                        /* Save pointer to NEXT block in CURRENT block   */
 340  0087 6cf30004      	std	[OFST-11,s]
 341                     ; 135         plink = (void **)pblk;                        /* Position to  NEXT      block                  */
 343  008b 6c84          	std	OFST-11,s
 344                     ; 132     for (i = 0u; i < loops; i++) {
 346  008d ec88          	ldd	OFST-7,s
 347  008f c30001        	addd	#1
 348  0092 6c88          	std	OFST-7,s
 349  0094 2406          	bcc	L01
 350  0096 6287          	inc	OFST-8,s
 351  0098 2602          	bne	L01
 352  009a 6286          	inc	OFST-9,s
 353  009c               L01:
 356  009c ac8c          	cpd	OFST-3,s
 357  009e ec86          	ldd	OFST-9,s
 358  00a0 e28b          	sbcb	OFST-4,s
 359  00a2 a28a          	sbca	OFST-5,s
 360  00a4 25d4          	blo	L721
 361                     ; 137     *plink              = (void *)0;                  /* Last memory block points to NULL              */
 363  00a6 87            	clra	
 364  00a7 c7            	clrb	
 365  00a8 6cf30004      	std	[OFST-11,s]
 366                     ; 138     pmem->OSMemAddr     = addr;                       /* Store start address of memory partition       */
 368  00ac ec8f          	ldd	OFST+0,s
 369  00ae ed82          	ldy	OFST-13,s
 370  00b0 6c40          	std	0,y
 371                     ; 139     pmem->OSMemFreeList = addr;                       /* Initialize pointer to pool of free blocks     */
 373  00b2 6c42          	std	2,y
 374                     ; 140     pmem->OSMemNFree    = nblks;                      /* Store number of free blocks in MCB            */
 376  00b4 ecf015        	ldd	OFST+6,s
 377  00b7 6c4e          	std	14,y
 378  00b9 ecf013        	ldd	OFST+4,s
 379  00bc 6c4c          	std	12,y
 380                     ; 141     pmem->OSMemNBlks    = nblks;
 382  00be ecf015        	ldd	OFST+6,s
 383  00c1 6c4a          	std	10,y
 384  00c3 ecf013        	ldd	OFST+4,s
 385  00c6 6c48          	std	8,y
 386                     ; 142     pmem->OSMemBlkSize  = blksize;                    /* Store block size of each memory blocks        */
 388  00c8 ecf019        	ldd	OFST+10,s
 389  00cb 6c46          	std	6,y
 390  00cd ecf017        	ldd	OFST+8,s
 391  00d0 6c44          	std	4,y
 392                     ; 146     *perr               = OS_ERR_NONE;
 395  00d2 69f3001b      	clr	[OFST+12,s]
 396                     ; 147     return (pmem);
 398  00d6 b764          	tfr	y,d
 400  00d8 060015        	bra	L21
 466                     ; 171 _NEAR void  *OSMemGet (OS_MEM  *pmem,
 466                     ; 172                       INT8U   *perr)
 466                     ; 173 {
 467                     	switch	.text
 468  00db               _OSMemGet:
 470  00db 3b            	pshd	
 471  00dc 1b9d          	leas	-3,s
 472       00000003      OFST:	set	3
 475                     ; 176     OS_CPU_SR  cpu_sr = 0u;
 477                     ; 188     if (pmem == (OS_MEM *)0) {                        /* Must point to a valid memory partition        */
 479  00de 046404        	tbne	d,L171
 480                     ; 189         *perr = OS_ERR_MEM_INVALID_PMEM;
 482  00e1 c660          	ldab	#96
 483                     ; 190         return ((void *)0);
 486  00e3 203c          	bra	LC004
 487  00e5               L171:
 488                     ; 196     OS_ENTER_CRITICAL();
 491  00e5 160000        	jsr	_OS_CPU_SR_Save
 493  00e8 6b80          	stab	OFST-3,s
 494                     ; 197     if (pmem->OSMemNFree > 0u) {                      /* See if there are any free memory blocks       */
 496  00ea ed83          	ldy	OFST+0,s
 497  00ec ec4c          	ldd	12,y
 498  00ee 2604          	bne	LC003
 499  00f0 ec4e          	ldd	14,y
 500  00f2 2726          	beq	L371
 501  00f4               LC003:
 502                     ; 198         pblk                = pmem->OSMemFreeList;    /* Yes, point to next free memory block          */
 504  00f4 ee42          	ldx	2,y
 505  00f6 6e81          	stx	OFST-2,s
 506                     ; 199         pmem->OSMemFreeList = *(void **)pblk;         /*      Adjust pointer to new free list          */
 508  00f8 18020042      	movw	0,x,2,y
 509                     ; 200         pmem->OSMemNFree--;                           /*      One less memory block in this partition  */
 511  00fc ec4e          	ldd	14,y
 512  00fe 830001        	subd	#1
 513  0101 6c4e          	std	14,y
 514  0103 ec4c          	ldd	12,y
 515  0105 c200          	sbcb	#0
 516  0107 8200          	sbca	#0
 517  0109 6c4c          	std	12,y
 518                     ; 201         OS_EXIT_CRITICAL();
 520  010b e680          	ldab	OFST-3,s
 521  010d 87            	clra	
 522  010e 160000        	jsr	_OS_CPU_SR_Restore
 524                     ; 202         *perr = OS_ERR_NONE;                          /*      No error                                 */
 526  0111 69f30007      	clr	[OFST+4,s]
 527                     ; 204         return (pblk);                                /*      Return memory block to caller            */
 530  0115 ec81          	ldd	OFST-2,s
 532  0117               L02:
 534  0117 1b85          	leas	5,s
 535  0119 3d            	rts	
 536  011a               L371:
 537                     ; 206     OS_EXIT_CRITICAL();
 539  011a e680          	ldab	OFST-3,s
 540  011c 160000        	jsr	_OS_CPU_SR_Restore
 542                     ; 207     *perr = OS_ERR_MEM_NO_FREE_BLKS;                  /* No,  Notify caller of empty memory partition  */
 544  011f c65d          	ldab	#93
 545                     ; 209     return ((void *)0);                               /*      Return NULL pointer to caller            */
 548  0121               LC004:
 549  0121 6bf30007      	stab	[OFST+4,s]
 550  0125 87            	clra	
 551  0126 c7            	clrb	
 553  0127 20ee          	bra	L02
 628                     ; 235 _NEAR INT8U  OSMemNameGet (OS_MEM   *pmem,
 628                     ; 236                           INT8U   **pname,
 628                     ; 237                           INT8U    *perr)
 628                     ; 238 {
 629                     	switch	.text
 630  0129               _OSMemNameGet:
 632  0129 3b            	pshd	
 633       00000002      OFST:	set	2
 636                     ; 241     OS_CPU_SR  cpu_sr = 0u;
 638                     ; 254     if (pmem == (OS_MEM *)0) {                   /* Is 'pmem' a NULL pointer?                          */
 640  012a 6cae          	std	2,-s
 641  012c 2604          	bne	L132
 642                     ; 255         *perr = OS_ERR_MEM_INVALID_PMEM;
 644  012e c660          	ldab	#96
 645                     ; 256         return (0u);
 648  0130 2006          	bra	LC005
 649  0132               L132:
 650                     ; 258     if (pname == (INT8U **)0) {                  /* Is 'pname' a NULL pointer?                         */
 652  0132 ec86          	ldd	OFST+4,s
 653  0134 260a          	bne	L332
 654                     ; 259         *perr = OS_ERR_PNAME_NULL;
 656  0136 c60c          	ldab	#12
 657                     ; 260         return (0u);
 659  0138               LC005:
 660  0138 6bf30008      	stab	[OFST+6,s]
 661  013c c7            	clrb	
 663  013d               L42:
 665  013d 1b84          	leas	4,s
 666  013f 3d            	rts	
 667  0140               L332:
 668                     ; 263     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
 670  0140 f60000        	ldab	_OSIntNesting
 671  0143 2704          	beq	L532
 672                     ; 264         *perr = OS_ERR_NAME_GET_ISR;
 674  0145 c611          	ldab	#17
 675                     ; 265         return (0u);
 678  0147 20ef          	bra	LC005
 679  0149               L532:
 680                     ; 267     OS_ENTER_CRITICAL();
 682  0149 160000        	jsr	_OS_CPU_SR_Save
 684  014c 6b80          	stab	OFST-2,s
 685                     ; 268     *pname = pmem->OSMemName;
 687  014e ed82          	ldy	OFST+0,s
 688  0150 ece810        	ldd	16,y
 689  0153 ee86          	ldx	OFST+4,s
 690  0155 6c00          	std	0,x
 691                     ; 269     len    = OS_StrLen(*pname);
 693  0157 160000        	jsr	_OS_StrLen
 695  015a 6b81          	stab	OFST-1,s
 696                     ; 270     OS_EXIT_CRITICAL();
 698  015c e680          	ldab	OFST-2,s
 699  015e 87            	clra	
 700  015f 160000        	jsr	_OS_CPU_SR_Restore
 702                     ; 271     *perr  = OS_ERR_NONE;
 704  0162 69f30008      	clr	[OFST+6,s]
 705                     ; 272     return (len);
 707  0166 e681          	ldab	OFST-1,s
 709  0168 20d3          	bra	L42
 775                     ; 300 _NEAR void  OSMemNameSet (OS_MEM  *pmem,
 775                     ; 301                          INT8U   *pname,
 775                     ; 302                          INT8U   *perr)
 775                     ; 303 {
 776                     	switch	.text
 777  016a               _OSMemNameSet:
 779  016a 3b            	pshd	
 780  016b 37            	pshb	
 781       00000001      OFST:	set	1
 784                     ; 305     OS_CPU_SR  cpu_sr = 0u;
 786                     ; 318     if (pmem == (OS_MEM *)0) {                   /* Is 'pmem' a NULL pointer?                          */
 788  016c 046404        	tbne	d,L172
 789                     ; 319         *perr = OS_ERR_MEM_INVALID_PMEM;
 791  016f c660          	ldab	#96
 792                     ; 320         return;
 794  0171 2006          	bra	LC006
 795  0173               L172:
 796                     ; 322     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
 798  0173 ec85          	ldd	OFST+4,s
 799  0175 2609          	bne	L372
 800                     ; 323         *perr = OS_ERR_PNAME_NULL;
 802  0177 c60c          	ldab	#12
 803  0179               LC006:
 804  0179 6bf30007      	stab	[OFST+6,s]
 805                     ; 324         return;
 806  017d               L03:
 809  017d 1b83          	leas	3,s
 810  017f 3d            	rts	
 811  0180               L372:
 812                     ; 327     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
 814  0180 f60000        	ldab	_OSIntNesting
 815  0183 2704          	beq	L572
 816                     ; 328         *perr = OS_ERR_NAME_SET_ISR;
 818  0185 c612          	ldab	#18
 819                     ; 329         return;
 821  0187 20f0          	bra	LC006
 822  0189               L572:
 823                     ; 331     OS_ENTER_CRITICAL();
 825  0189 160000        	jsr	_OS_CPU_SR_Save
 827  018c 6b80          	stab	OFST-1,s
 828                     ; 332     pmem->OSMemName = pname;
 830  018e ec85          	ldd	OFST+4,s
 831  0190 ee81          	ldx	OFST+0,s
 832  0192 6ce010        	std	16,x
 833                     ; 333     OS_EXIT_CRITICAL();
 835  0195 e680          	ldab	OFST-1,s
 836  0197 87            	clra	
 837  0198 160000        	jsr	_OS_CPU_SR_Restore
 839                     ; 335     *perr           = OS_ERR_NONE;
 842  019b 69f30007      	clr	[OFST+6,s]
 843                     ; 336 }
 845  019f 20dc          	bra	L03
 900                     ; 358 _NEAR INT8U  OSMemPut (OS_MEM  *pmem,
 900                     ; 359                       void    *pblk)
 900                     ; 360 {
 901                     	switch	.text
 902  01a1               _OSMemPut:
 904  01a1 3b            	pshd	
 905  01a2 37            	pshb	
 906       00000001      OFST:	set	1
 909                     ; 362     OS_CPU_SR  cpu_sr = 0u;
 911                     ; 367     if (pmem == (OS_MEM *)0) {                   /* Must point to a valid memory partition             */
 913  01a3 046404        	tbne	d,L523
 914                     ; 368         return (OS_ERR_MEM_INVALID_PMEM);
 916  01a6 c660          	ldab	#96
 918  01a8 2006          	bra	L63
 919  01aa               L523:
 920                     ; 370     if (pblk == (void *)0) {                     /* Must release a valid block                         */
 922  01aa ec85          	ldd	OFST+4,s
 923  01ac 2605          	bne	L723
 924                     ; 371         return (OS_ERR_MEM_INVALID_PBLK);
 926  01ae c65f          	ldab	#95
 928  01b0               L63:
 930  01b0 1b83          	leas	3,s
 931  01b2 3d            	rts	
 932  01b3               L723:
 933                     ; 377     OS_ENTER_CRITICAL();
 936  01b3 160000        	jsr	_OS_CPU_SR_Save
 938  01b6 6b80          	stab	OFST-1,s
 939                     ; 378     if (pmem->OSMemNFree >= pmem->OSMemNBlks) {  /* Make sure all blocks not already returned          */
 941  01b8 ed81          	ldy	OFST+0,s
 942  01ba ec4e          	ldd	14,y
 943  01bc ac4a          	cpd	10,y
 944  01be ec4c          	ldd	12,y
 945  01c0 e249          	sbcb	9,y
 946  01c2 a248          	sbca	8,y
 947  01c4 250a          	blo	L133
 948                     ; 379         OS_EXIT_CRITICAL();
 950  01c6 e680          	ldab	OFST-1,s
 951  01c8 87            	clra	
 952  01c9 160000        	jsr	_OS_CPU_SR_Restore
 954                     ; 381         return (OS_ERR_MEM_FULL);
 957  01cc c65e          	ldab	#94
 959  01ce 20e0          	bra	L63
 960  01d0               L133:
 961                     ; 383     *(void **)pblk      = pmem->OSMemFreeList;   /* Insert released block into free block list         */
 963  01d0 ec42          	ldd	2,y
 964  01d2 6cf30005      	std	[OFST+4,s]
 965                     ; 384     pmem->OSMemFreeList = pblk;
 967  01d6 18028542      	movw	OFST+4,s,2,y
 968                     ; 385     pmem->OSMemNFree++;                          /* One more memory block in this partition            */
 970  01da ec4e          	ldd	14,y
 971  01dc c30001        	addd	#1
 972  01df 6c4e          	std	14,y
 973  01e1 2406          	bcc	L43
 974  01e3 624d          	inc	13,y
 975  01e5 2602          	bne	L43
 976  01e7 624c          	inc	12,y
 977  01e9               L43:
 978                     ; 386     OS_EXIT_CRITICAL();
 980  01e9 e680          	ldab	OFST-1,s
 981  01eb 87            	clra	
 982  01ec 160000        	jsr	_OS_CPU_SR_Restore
 984                     ; 388     return (OS_ERR_NONE);                        /* Notify caller that memory block was released       */
 987  01ef c7            	clrb	
 989  01f0 20be          	bra	L63
1101                     ; 411 _NEAR INT8U  OSMemQuery (OS_MEM       *pmem,
1101                     ; 412                         OS_MEM_DATA  *p_mem_data)
1101                     ; 413 {
1102                     	switch	.text
1103  01f2               _OSMemQuery:
1105  01f2 3b            	pshd	
1106  01f3 37            	pshb	
1107       00000001      OFST:	set	1
1110                     ; 415     OS_CPU_SR  cpu_sr = 0u;
1112                     ; 421     if (pmem == (OS_MEM *)0) {                   /* Must point to a valid memory partition             */
1114  01f4 046404        	tbne	d,L704
1115                     ; 422         return (OS_ERR_MEM_INVALID_PMEM);
1117  01f7 c660          	ldab	#96
1119  01f9 2006          	bra	L24
1120  01fb               L704:
1121                     ; 424     if (p_mem_data == (OS_MEM_DATA *)0) {        /* Must release a valid storage area for the data     */
1123  01fb ec85          	ldd	OFST+4,s
1124  01fd 2605          	bne	L114
1125                     ; 425         return (OS_ERR_MEM_INVALID_PDATA);
1127  01ff c661          	ldab	#97
1129  0201               L24:
1131  0201 1b83          	leas	3,s
1132  0203 3d            	rts	
1133  0204               L114:
1134                     ; 428     OS_ENTER_CRITICAL();
1136  0204 160000        	jsr	_OS_CPU_SR_Save
1138  0207 6b80          	stab	OFST-1,s
1139                     ; 429     p_mem_data->OSAddr     = pmem->OSMemAddr;
1141  0209 ee81          	ldx	OFST+0,s
1142  020b ed85          	ldy	OFST+4,s
1143  020d 18020040      	movw	0,x,0,y
1144                     ; 430     p_mem_data->OSFreeList = pmem->OSMemFreeList;
1146  0211 18020242      	movw	2,x,2,y
1147                     ; 431     p_mem_data->OSBlkSize  = pmem->OSMemBlkSize;
1149  0215 18020444      	movw	4,x,4,y
1150  0219 18020646      	movw	6,x,6,y
1151                     ; 432     p_mem_data->OSNBlks    = pmem->OSMemNBlks;
1153  021d 18020848      	movw	8,x,8,y
1154  0221 18020a4a      	movw	10,x,10,y
1155                     ; 433     p_mem_data->OSNFree    = pmem->OSMemNFree;
1157  0225 18020c4c      	movw	12,x,12,y
1158  0229 18020e4e      	movw	14,x,14,y
1159                     ; 434     OS_EXIT_CRITICAL();
1161  022d 87            	clra	
1162  022e 160000        	jsr	_OS_CPU_SR_Restore
1164                     ; 435     p_mem_data->OSNUsed    = p_mem_data->OSNBlks - p_mem_data->OSNFree;
1166  0231 ed85          	ldy	OFST+4,s
1167  0233 ec4a          	ldd	10,y
1168  0235 ee48          	ldx	8,y
1169  0237 194c          	leay	12,y
1170  0239 160000        	jsr	c_lsub
1172  023c ed85          	ldy	OFST+4,s
1173  023e 6ce812        	std	18,y
1174  0241 6ee810        	stx	16,y
1175                     ; 436     return (OS_ERR_NONE);
1177  0244 c7            	clrb	
1179  0245 20ba          	bra	L24
1225                     ; 456 _NEAR void  OS_MemInit (void)
1225                     ; 457 {
1226                     	switch	.text
1227  0247               _OS_MemInit:
1229  0247 1b9c          	leas	-4,s
1230       00000004      OFST:	set	4
1233                     ; 471     OS_MemClr((INT8U *)&OSMemTbl[0], sizeof(OSMemTbl));   /* Clear the memory partition table          */
1235  0249 cc005a        	ldd	#90
1236  024c 3b            	pshd	
1237  024d cc0000        	ldd	#_OSMemTbl
1238  0250 160000        	jsr	_OS_MemClr
1240  0253 1b82          	leas	2,s
1241                     ; 472     for (i = 0u; i < (OS_MAX_MEM_PART - 1u); i++) {       /* Init. list of free memory partitions      */
1243  0255 87            	clra	
1244  0256 c7            	clrb	
1245  0257 6c80          	std	OFST-4,s
1246  0259               L534:
1247                     ; 473         pmem                = &OSMemTbl[i];               /* Point to memory control block (MCB)       */
1249  0259 cd0012        	ldy	#18
1250  025c 13            	emul	
1251  025d c30000        	addd	#_OSMemTbl
1252  0260 6c82          	std	OFST-2,s
1253                     ; 474         pmem->OSMemFreeList = (void *)&OSMemTbl[i + 1u];  /* Chain list of free partitions             */
1255  0262 ec80          	ldd	OFST-4,s
1256  0264 cd0012        	ldy	#18
1257  0267 13            	emul	
1258  0268 c30012        	addd	#_OSMemTbl+18
1259  026b ed82          	ldy	OFST-2,s
1260  026d 6c42          	std	2,y
1261                     ; 476         pmem->OSMemName  = (INT8U *)(void *)"?";
1263  026f cc0004        	ldd	#L344
1264  0272 6ce810        	std	16,y
1265                     ; 472     for (i = 0u; i < (OS_MAX_MEM_PART - 1u); i++) {       /* Init. list of free memory partitions      */
1267  0275 ec80          	ldd	OFST-4,s
1268  0277 c30001        	addd	#1
1269  027a 6c80          	std	OFST-4,s
1272  027c 8c0004        	cpd	#4
1273  027f 25d8          	blo	L534
1274                     ; 479     pmem                = &OSMemTbl[i];
1276  0281 cd0012        	ldy	#18
1277  0284 13            	emul	
1278  0285 c30000        	addd	#_OSMemTbl
1279  0288 6c82          	std	OFST-2,s
1280                     ; 480     pmem->OSMemFreeList = (void *)0;                      /* Initialize last node                      */
1282  028a 87            	clra	
1283  028b c7            	clrb	
1284  028c ed82          	ldy	OFST-2,s
1285  028e 6c42          	std	2,y
1286                     ; 482     pmem->OSMemName = (INT8U *)(void *)"?";
1288  0290 cc0004        	ldd	#L344
1289  0293 6ce810        	std	16,y
1290                     ; 485     OSMemFreeList   = &OSMemTbl[0];                       /* Point to beginning of free list           */
1292  0296 cc0000        	ldd	#_OSMemTbl
1293  0299 7c0000        	std	_OSMemFreeList
1294                     ; 487 }
1297  029c 1b84          	leas	4,s
1298  029e 3d            	rts	
1310                     	xref	_OS_StrLen
1311                     	xdef	_OS_MemInit
1312                     	xref	_OS_MemClr
1313                     	xdef	_OSMemQuery
1314                     	xdef	_OSMemPut
1315                     	xdef	_OSMemNameSet
1316                     	xdef	_OSMemNameGet
1317                     	xdef	_OSMemGet
1318                     	xdef	_OSMemCreate
1319                     	xref	_OSMemTbl
1320                     	xref	_OSMemFreeList
1321                     	xref	_OSIntNesting
1322                     	xref	_OS_CPU_SR_Restore
1323                     	xref	_OS_CPU_SR_Save
1324                     	switch	.const
1325  0004               L344:
1326  0004 3f00          	dc.b	"?",0
1347                     	xref	c_ladd
1348                     	xref	c_lsub
1349                     	end

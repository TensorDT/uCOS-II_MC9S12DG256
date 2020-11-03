   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 205                     ; 121 _NEAR OS_TMR  *OSTmrCreate (INT32U           dly,
 205                     ; 122                            INT32U           period,
 205                     ; 123                            INT8U            opt,
 205                     ; 124                            OS_TMR_CALLBACK  callback,
 205                     ; 125                            void            *callback_arg,
 205                     ; 126                            INT8U           *pname,
 205                     ; 127                            INT8U           *perr)
 205                     ; 128 {
 206                     	switch	.text
 207  0000               _OSTmrCreate:
 209  0000 3b            	pshd	
 210  0001 34            	pshx	
 211  0002 3b            	pshd	
 212       00000002      OFST:	set	2
 215                     ; 148     switch (opt) {                                          /* Validate arguments                                     */
 217  0003 e68d          	ldab	OFST+11,s
 219  0005 04011a        	dbeq	b,L12
 220  0008 040104        	dbeq	b,L71
 221                     ; 163         default:
 221                     ; 164              *perr = OS_ERR_TMR_INVALID_OPT;
 223  000b c684          	ldab	#132
 224                     ; 165              return ((OS_TMR *)0);
 227  000d 200a          	bra	LC001
 228  000f               L71:
 229                     ; 149         case OS_TMR_OPT_PERIODIC:
 229                     ; 150              if (period == 0u) {
 231  000f ec88          	ldd	OFST+6,s
 232  0011 261b          	bne	L141
 233  0013 ec8a          	ldd	OFST+8,s
 234  0015 2617          	bne	L141
 235                     ; 151                  *perr = OS_ERR_TMR_INVALID_PERIOD;
 237  0017 c683          	ldab	#131
 238                     ; 152                  return ((OS_TMR *)0);
 240  0019               LC001:
 241  0019 6bf30014      	stab	[OFST+18,s]
 242  001d 87            	clra	
 243  001e c7            	clrb	
 245  001f               L21:
 247  001f 1b86          	leas	6,s
 248  0021 3d            	rts	
 249  0022               L12:
 250                     ; 156         case OS_TMR_OPT_ONE_SHOT:
 250                     ; 157              if (dly == 0u) {
 252  0022 ec82          	ldd	OFST+0,s
 253  0024 2608          	bne	L141
 254  0026 ec84          	ldd	OFST+2,s
 255  0028 2604          	bne	L141
 256                     ; 158                  *perr = OS_ERR_TMR_INVALID_DLY;
 258  002a c682          	ldab	#130
 259                     ; 159                  return ((OS_TMR *)0);
 262  002c 20eb          	bra	LC001
 263  002e               L141:
 264                     ; 168     if (OSIntNesting > 0u) {                                /* See if trying to call from an ISR                      */
 266  002e f60000        	ldab	_OSIntNesting
 267  0031 2704          	beq	L741
 268                     ; 169         *perr  = OS_ERR_TMR_ISR;
 270  0033 c68b          	ldab	#139
 271                     ; 170         return ((OS_TMR *)0);
 274  0035 20e2          	bra	LC001
 275  0037               L741:
 276                     ; 172     OSSchedLock();
 278  0037 160000        	jsr	_OSSchedLock
 280                     ; 173     ptmr = OSTmr_Alloc();                                   /* Obtain a timer from the free pool                      */
 282  003a 16031a        	jsr	L3_OSTmr_Alloc
 284  003d 6c80          	std	OFST-2,s
 285                     ; 174     if (ptmr == (OS_TMR *)0) {
 287  003f 2607          	bne	L151
 288                     ; 175         OSSchedUnlock();
 290  0041 160000        	jsr	_OSSchedUnlock
 292                     ; 176         *perr = OS_ERR_TMR_NON_AVAIL;
 294  0044 c686          	ldab	#134
 295                     ; 177         return ((OS_TMR *)0);
 298  0046 20d1          	bra	LC001
 299  0048               L151:
 300                     ; 179     ptmr->OSTmrState       = OS_TMR_STATE_STOPPED;          /* Indicate that timer is not running yet                 */
 302  0048 c601          	ldab	#1
 303  004a ed80          	ldy	OFST-2,s
 304  004c 6be816        	stab	22,y
 305                     ; 180     ptmr->OSTmrDly         = dly;
 307  004f 1802844f      	movw	OFST+2,s,15,y
 308  0053 1802824d      	movw	OFST+0,s,13,y
 309                     ; 181     ptmr->OSTmrPeriod      = period;
 311  0057 ec8a          	ldd	OFST+8,s
 312  0059 6ce813        	std	19,y
 313  005c ec88          	ldd	OFST+6,s
 314  005e 6ce811        	std	17,y
 315                     ; 182     ptmr->OSTmrOpt         = opt;
 317  0061 e68d          	ldab	OFST+11,s
 318  0063 6be815        	stab	21,y
 319                     ; 183     ptmr->OSTmrCallback    = callback;
 321  0066 18028e41      	movw	OFST+12,s,1,y
 322                     ; 184     ptmr->OSTmrCallbackArg = callback_arg;
 324  006a ecf010        	ldd	OFST+14,s
 325  006d 6c43          	std	3,y
 326                     ; 192     OSSchedUnlock();
 328  006f 160000        	jsr	_OSSchedUnlock
 330                     ; 194     *perr = OS_ERR_NONE;
 333  0072 69f30014      	clr	[OFST+18,s]
 334                     ; 195     return (ptmr);
 336  0076 ec80          	ldd	OFST-2,s
 338  0078 20a5          	bra	L21
 389                     ; 225 _NEAR BOOLEAN  OSTmrDel (OS_TMR  *ptmr,
 389                     ; 226                         INT8U   *perr)
 389                     ; 227 {
 390                     	switch	.text
 391  007a               _OSTmrDel:
 393       00000000      OFST:	set	0
 396                     ; 244     if (ptmr == (OS_TMR *)0) {
 398  007a 6cae          	std	2,-s
 399  007c 2609          	bne	L702
 400                     ; 245         *perr = OS_ERR_TMR_INVALID;
 402  007e c68a          	ldab	#138
 403  0080 6bf30004      	stab	[OFST+4,s]
 404                     ; 246         return (OS_FALSE);
 406  0084 c7            	clrb	
 409  0085 31            	puly	
 410  0086 3d            	rts	
 411  0087               L702:
 412                     ; 252     if (ptmr->OSTmrType != OS_TMR_TYPE) {                   /* Validate timer structure                               */
 415  0087 e6f30000      	ldab	[OFST+0,s]
 416  008b c164          	cmpb	#100
 417  008d 2709          	beq	L112
 418                     ; 253         *perr = OS_ERR_TMR_INVALID_TYPE;
 420  008f c689          	ldab	#137
 421  0091 6bf30004      	stab	[OFST+4,s]
 422                     ; 255         return (OS_FALSE);
 425  0095 c7            	clrb	
 428  0096 31            	puly	
 429  0097 3d            	rts	
 430  0098               L112:
 431                     ; 257     if (OSIntNesting > 0u) {                                /* See if trying to call from an ISR                      */
 433  0098 f60000        	ldab	_OSIntNesting
 434  009b 2709          	beq	L312
 435                     ; 258         *perr  = OS_ERR_TMR_ISR;
 437  009d c68b          	ldab	#139
 438  009f 6bf30004      	stab	[OFST+4,s]
 439                     ; 260         return (OS_FALSE);
 442  00a3 c7            	clrb	
 445  00a4 31            	puly	
 446  00a5 3d            	rts	
 447  00a6               L312:
 448                     ; 262     OSSchedLock();
 450  00a6 160000        	jsr	_OSSchedLock
 452                     ; 263     switch (ptmr->OSTmrState) {
 454  00a9 ed80          	ldy	OFST+0,s
 455  00ab e6e816        	ldab	22,y
 457  00ae 273a          	beq	L751
 458  00b0 040127        	dbeq	b,L551
 459  00b3 040124        	dbeq	b,L551
 460  00b6 04010c        	dbeq	b,L351
 461                     ; 286         default:
 461                     ; 287              OSSchedUnlock();
 463  00b9 160000        	jsr	_OSSchedUnlock
 465                     ; 288              *perr = OS_ERR_TMR_INVALID_STATE;
 467  00bc c68d          	ldab	#141
 468  00be 6bf30004      	stab	[OFST+4,s]
 469                     ; 290              return (OS_FALSE);
 472  00c2 c7            	clrb	
 475  00c3 31            	puly	
 476  00c4 3d            	rts	
 477  00c5               L351:
 478                     ; 264         case OS_TMR_STATE_RUNNING:
 478                     ; 265              OSTmr_Unlink(ptmr);                            /* Remove from current wheel spoke                        */
 480  00c5 b764          	tfr	y,d
 481  00c7 1604c2        	jsr	L31_OSTmr_Unlink
 483                     ; 266              OSTmr_Free(ptmr);                              /* Return timer to free list of timers                    */
 485  00ca ec80          	ldd	OFST+0,s
 486  00cc 160343        	jsr	L5_OSTmr_Free
 488                     ; 267              OSSchedUnlock();
 490  00cf 160000        	jsr	_OSSchedUnlock
 492                     ; 268              *perr = OS_ERR_NONE;
 494  00d2 69f30004      	clr	[OFST+4,s]
 495                     ; 270              return (OS_TRUE);
 498  00d6 c601          	ldab	#1
 501  00d8 31            	puly	
 502  00d9 3d            	rts	
 503  00da               L551:
 504                     ; 272         case OS_TMR_STATE_STOPPED:                          /* Timer has not started or ...                           */
 504                     ; 273         case OS_TMR_STATE_COMPLETED:                        /* ... timer has completed the ONE-SHOT time              */
 504                     ; 274              OSTmr_Free(ptmr);                              /* Return timer to free list of timers                    */
 506  00da b764          	tfr	y,d
 507  00dc 160343        	jsr	L5_OSTmr_Free
 509                     ; 275              OSSchedUnlock();
 511  00df 160000        	jsr	_OSSchedUnlock
 513                     ; 276              *perr = OS_ERR_NONE;
 515  00e2 69f30004      	clr	[OFST+4,s]
 516                     ; 278              return (OS_TRUE);
 519  00e6 c601          	ldab	#1
 522  00e8 31            	puly	
 523  00e9 3d            	rts	
 524  00ea               L751:
 525                     ; 280         case OS_TMR_STATE_UNUSED:                           /* Already deleted                                        */
 525                     ; 281              OSSchedUnlock();
 527  00ea 160000        	jsr	_OSSchedUnlock
 529                     ; 282              *perr = OS_ERR_TMR_INACTIVE;
 531  00ed c687          	ldab	#135
 532  00ef 6bf30004      	stab	[OFST+4,s]
 533                     ; 284              return (OS_FALSE);
 536  00f3 c7            	clrb	
 539  00f4 31            	puly	
 540  00f5 3d            	rts	
 597                     ; 400 _NEAR INT32U  OSTmrRemainGet (OS_TMR  *ptmr,
 597                     ; 401                              INT8U   *perr)
 597                     ; 402 {
 598                     	switch	.text
 599  00f6               _OSTmrRemainGet:
 601  00f6 3b            	pshd	
 602  00f7 1b9c          	leas	-4,s
 603       00000004      OFST:	set	4
 606                     ; 414     if (ptmr == (OS_TMR *)0) {
 608  00f9 046404        	tbne	d,L562
 609                     ; 415         *perr = OS_ERR_TMR_INVALID;
 611  00fc c68a          	ldab	#138
 612                     ; 416         return (0u);
 615  00fe 200a          	bra	LC002
 616  0100               L562:
 617                     ; 419     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
 619  0100 e6f30004      	ldab	[OFST+0,s]
 620  0104 c164          	cmpb	#100
 621  0106 270d          	beq	L762
 622                     ; 420         *perr = OS_ERR_TMR_INVALID_TYPE;
 624  0108 c689          	ldab	#137
 625                     ; 421         return (0u);
 627  010a               LC002:
 628  010a 6bf30008      	stab	[OFST+4,s]
 629  010e 87            	clra	
 630  010f c7            	clrb	
 631  0110 b745          	tfr	d,x
 633  0112               L22:
 635  0112 1b86          	leas	6,s
 636  0114 3d            	rts	
 637  0115               L762:
 638                     ; 423     if (OSIntNesting > 0u) {                           /* See if trying to call from an ISR                           */
 640  0115 f60000        	ldab	_OSIntNesting
 641  0118 2704          	beq	L172
 642                     ; 424         *perr = OS_ERR_TMR_ISR;
 644  011a c68b          	ldab	#139
 645                     ; 425         return (0u);
 648  011c 20ec          	bra	LC002
 649  011e               L172:
 650                     ; 427     OSSchedLock();
 652  011e 160000        	jsr	_OSSchedLock
 654                     ; 428     switch (ptmr->OSTmrState) {
 656  0121 ed84          	ldy	OFST+0,s
 657  0123 e6e816        	ldab	22,y
 659  0126 276b          	beq	L332
 660  0128 040128        	dbeq	b,L322
 661  012b 040157        	dbeq	b,L132
 662  012e 040107        	dbeq	b,L122
 663                     ; 466         default:
 663                     ; 467              OSSchedUnlock();
 665  0131 160000        	jsr	_OSSchedUnlock
 667                     ; 468              *perr = OS_ERR_TMR_INVALID_STATE;
 669  0134 c68d          	ldab	#141
 670                     ; 469              return (0u);
 673  0136 20d2          	bra	LC002
 674  0138               L122:
 675                     ; 429         case OS_TMR_STATE_RUNNING:
 675                     ; 430              remain = ptmr->OSTmrMatch - OSTmrTime;    /* Determine how much time is left to timeout                  */
 677  0138 ec4b          	ldd	11,y
 678  013a ee49          	ldx	9,y
 679  013c cd0000        	ldy	#_OSTmrTime
 680  013f 160000        	jsr	c_lsub
 682  0142 6c82          	std	OFST-2,s
 683  0144 6e80          	stx	OFST-4,s
 684                     ; 431              OSSchedUnlock();
 686  0146 160000        	jsr	_OSSchedUnlock
 688                     ; 432              *perr  = OS_ERR_NONE;
 690  0149 69f30008      	clr	[OFST+4,s]
 691                     ; 433              return (remain);
 693  014d ec82          	ldd	OFST-2,s
 694  014f ee80          	ldx	OFST-4,s
 696  0151 20bf          	bra	L22
 697  0153               L322:
 698                     ; 435         case OS_TMR_STATE_STOPPED:                     /* It's assumed that the timer has not started yet             */
 698                     ; 436              switch (ptmr->OSTmrOpt) {
 700  0153 e6e815        	ldab	21,y
 702  0156 040117        	dbeq	b,L722
 703  0159 042114        	dbne	b,L722
 704                     ; 437                  case OS_TMR_OPT_PERIODIC:
 704                     ; 438                       if (ptmr->OSTmrDly == 0u) {
 706  015c ec4d          	ldd	13,y
 707  015e 260e          	bne	L303
 708  0160 ec4f          	ldd	15,y
 709  0162 260a          	bne	L303
 710                     ; 439                           remain = ptmr->OSTmrPeriod;
 712  0164 ece813        	ldd	19,y
 713  0167 6c82          	std	OFST-2,s
 714  0169 ece811        	ldd	17,y
 716  016c 2008          	bra	L103
 717  016e               L303:
 718                     ; 441                           remain = ptmr->OSTmrDly;
 720  016e ed84          	ldy	OFST+0,s
 721                     ; 443                       OSSchedUnlock();
 724                     ; 444                       *perr  = OS_ERR_NONE;
 726                     ; 445                       break;
 728  0170               L722:
 729                     ; 447                  case OS_TMR_OPT_ONE_SHOT:
 729                     ; 448                  default:
 729                     ; 449                       remain = ptmr->OSTmrDly;
 731  0170 18024f82      	movw	15,y,OFST-2,s
 732  0174 ec4d          	ldd	13,y
 733                     ; 450                       OSSchedUnlock();
 736                     ; 451                       *perr  = OS_ERR_NONE;
 738                     ; 452                       break;
 740  0176               L103:
 741  0176 6c80          	std	OFST-4,s
 742  0178 160000        	jsr	_OSSchedUnlock
 743  017b 69f30008      	clr	[OFST+4,s]
 744                     ; 454              return (remain);
 746  017f ec82          	ldd	OFST-2,s
 747  0181 ee80          	ldx	OFST-4,s
 749  0183 200b          	bra	L42
 750  0185               L132:
 751                     ; 456         case OS_TMR_STATE_COMPLETED:                   /* Only ONE-SHOT that timed out can be in this state           */
 751                     ; 457              OSSchedUnlock();
 753  0185 160000        	jsr	_OSSchedUnlock
 755                     ; 458              *perr = OS_ERR_NONE;
 757  0188 c7            	clrb	
 758  0189 6bf30008      	stab	[OFST+4,s]
 759                     ; 459              return (0u);
 761  018d 87            	clra	
 762  018e               LC003:
 763  018e b745          	tfr	d,x
 765  0190               L42:
 767  0190 1b86          	leas	6,s
 768  0192 3d            	rts	
 769  0193               L332:
 770                     ; 461         case OS_TMR_STATE_UNUSED:
 770                     ; 462              OSSchedUnlock();
 772  0193 160000        	jsr	_OSSchedUnlock
 774                     ; 463              *perr = OS_ERR_TMR_INACTIVE;
 776  0196 c687          	ldab	#135
 777  0198 6bf30008      	stab	[OFST+4,s]
 778                     ; 464              return (0u);
 780  019c 87            	clra	
 781  019d c7            	clrb	
 783  019e 20ee          	bra	LC003
 839                     ; 501 _NEAR INT8U  OSTmrStateGet (OS_TMR  *ptmr,
 839                     ; 502                            INT8U   *perr)
 839                     ; 503 {
 840                     	switch	.text
 841  01a0               _OSTmrStateGet:
 843  01a0 3b            	pshd	
 844  01a1 37            	pshb	
 845       00000001      OFST:	set	1
 848                     ; 515     if (ptmr == (OS_TMR *)0) {
 850  01a2 046404        	tbne	d,L143
 851                     ; 516         *perr = OS_ERR_TMR_INVALID;
 853  01a5 c68a          	ldab	#138
 854                     ; 517         return (0u);
 857  01a7 200a          	bra	LC005
 858  01a9               L143:
 859                     ; 520     if (ptmr->OSTmrType != OS_TMR_TYPE) {              /* Validate timer structure                                    */
 861  01a9 e6f30001      	ldab	[OFST+0,s]
 862  01ad c164          	cmpb	#100
 863  01af 270a          	beq	L343
 864                     ; 521         *perr = OS_ERR_TMR_INVALID_TYPE;
 866  01b1 c689          	ldab	#137
 867                     ; 522         return (0u);
 869  01b3               LC005:
 870  01b3 6bf30005      	stab	[OFST+4,s]
 871  01b7 c7            	clrb	
 873  01b8               L03:
 875  01b8 1b83          	leas	3,s
 876  01ba 3d            	rts	
 877  01bb               L343:
 878                     ; 524     if (OSIntNesting > 0u) {                           /* See if trying to call from an ISR                           */
 880  01bb f60000        	ldab	_OSIntNesting
 881  01be 2704          	beq	L543
 882                     ; 525         *perr = OS_ERR_TMR_ISR;
 884  01c0 c68b          	ldab	#139
 885                     ; 526         return (0u);
 888  01c2 20ef          	bra	LC005
 889  01c4               L543:
 890                     ; 528     OSSchedLock();
 892  01c4 160000        	jsr	_OSSchedLock
 894                     ; 529     state = ptmr->OSTmrState;
 896  01c7 ed81          	ldy	OFST+0,s
 897  01c9 e6e816        	ldab	22,y
 898  01cc 6b80          	stab	OFST-1,s
 899                     ; 530     switch (state) {
 902  01ce 2711          	beq	L703
 903  01d0 04010e        	dbeq	b,L703
 904  01d3 04010b        	dbeq	b,L703
 905  01d6 040108        	dbeq	b,L703
 906                     ; 538         default:
 906                     ; 539              *perr = OS_ERR_TMR_INVALID_STATE;
 908  01d9 c68d          	ldab	#141
 909  01db 6bf30005      	stab	[OFST+4,s]
 910                     ; 540              break;
 912  01df 2004          	bra	L153
 913  01e1               L703:
 914                     ; 531         case OS_TMR_STATE_UNUSED:
 914                     ; 532         case OS_TMR_STATE_STOPPED:
 914                     ; 533         case OS_TMR_STATE_COMPLETED:
 914                     ; 534         case OS_TMR_STATE_RUNNING:
 914                     ; 535              *perr = OS_ERR_NONE;
 916  01e1 69f30005      	clr	[OFST+4,s]
 917                     ; 536              break;
 919  01e5               L153:
 920                     ; 542     OSSchedUnlock();
 922  01e5 160000        	jsr	_OSSchedUnlock
 924                     ; 543     return (state);
 926  01e8 e680          	ldab	OFST-1,s
 928  01ea 20cc          	bra	L03
 979                     ; 570 _NEAR BOOLEAN  OSTmrStart (OS_TMR   *ptmr,
 979                     ; 571                           INT8U    *perr)
 979                     ; 572 {
 980                     	switch	.text
 981  01ec               _OSTmrStart:
 983       00000000      OFST:	set	0
 986                     ; 581     if (ptmr == (OS_TMR *)0) {
 988  01ec 6cae          	std	2,-s
 989  01ee 2609          	bne	L704
 990                     ; 582         *perr = OS_ERR_TMR_INVALID;
 992  01f0 c68a          	ldab	#138
 993  01f2 6bf30004      	stab	[OFST+4,s]
 994                     ; 583         return (OS_FALSE);
 996  01f6 c7            	clrb	
 999  01f7 31            	puly	
1000  01f8 3d            	rts	
1001  01f9               L704:
1002                     ; 589     if (ptmr->OSTmrType != OS_TMR_TYPE) {                   /* Validate timer structure                               */
1005  01f9 e6f30000      	ldab	[OFST+0,s]
1006  01fd c164          	cmpb	#100
1007  01ff 2709          	beq	L114
1008                     ; 590         *perr = OS_ERR_TMR_INVALID_TYPE;
1010  0201 c689          	ldab	#137
1011  0203 6bf30004      	stab	[OFST+4,s]
1012                     ; 592         return (OS_FALSE);
1015  0207 c7            	clrb	
1018  0208 31            	puly	
1019  0209 3d            	rts	
1020  020a               L114:
1021                     ; 594     if (OSIntNesting > 0u) {                                /* See if trying to call from an ISR                      */
1023  020a f60000        	ldab	_OSIntNesting
1024  020d 2709          	beq	L314
1025                     ; 595         *perr  = OS_ERR_TMR_ISR;
1027  020f c68b          	ldab	#139
1028  0211 6bf30004      	stab	[OFST+4,s]
1029                     ; 597         return (OS_FALSE);
1032  0215 c7            	clrb	
1035  0216 31            	puly	
1036  0217 3d            	rts	
1037  0218               L314:
1038                     ; 599     OSSchedLock();
1040  0218 160000        	jsr	_OSSchedLock
1042                     ; 600     switch (ptmr->OSTmrState) {
1044  021b ed80          	ldy	OFST+0,s
1045  021d e6e816        	ldab	22,y
1047  0220 2744          	beq	L753
1048  0222 04012c        	dbeq	b,L553
1049  0225 040129        	dbeq	b,L553
1050  0228 04010c        	dbeq	b,L353
1051                     ; 623         default:
1051                     ; 624              OSSchedUnlock();
1053  022b 160000        	jsr	_OSSchedUnlock
1055                     ; 625              *perr = OS_ERR_TMR_INVALID_STATE;
1057  022e c68d          	ldab	#141
1058  0230 6bf30004      	stab	[OFST+4,s]
1059                     ; 627              return (OS_FALSE);
1062  0234 c7            	clrb	
1065  0235 31            	puly	
1066  0236 3d            	rts	
1067  0237               L353:
1068                     ; 601         case OS_TMR_STATE_RUNNING:                          /* Restart the timer                                      */
1068                     ; 602              OSTmr_Unlink(ptmr);                            /* ... Stop the timer                                     */
1070  0237 b764          	tfr	y,d
1071  0239 1604c2        	jsr	L31_OSTmr_Unlink
1073                     ; 603              OSTmr_Link(ptmr, OS_TMR_LINK_DLY);             /* ... Link timer to timer wheel                          */
1075  023c 87            	clra	
1076  023d c7            	clrb	
1077  023e 3b            	pshd	
1078  023f ec82          	ldd	OFST+2,s
1079  0241 16045a        	jsr	L11_OSTmr_Link
1081  0244 1b82          	leas	2,s
1082                     ; 604              OSSchedUnlock();
1084  0246 160000        	jsr	_OSSchedUnlock
1086                     ; 605              *perr = OS_ERR_NONE;
1088  0249 69f30004      	clr	[OFST+4,s]
1089                     ; 607              return (OS_TRUE);
1092  024d c601          	ldab	#1
1095  024f 31            	puly	
1096  0250 3d            	rts	
1097  0251               L553:
1098                     ; 609         case OS_TMR_STATE_STOPPED:                          /* Start the timer                                        */
1098                     ; 610         case OS_TMR_STATE_COMPLETED:
1098                     ; 611              OSTmr_Link(ptmr, OS_TMR_LINK_DLY);             /* ... Link timer to timer wheel                          */
1100  0251 87            	clra	
1101  0252 c7            	clrb	
1102  0253 3b            	pshd	
1103  0254 b764          	tfr	y,d
1104  0256 16045a        	jsr	L11_OSTmr_Link
1106  0259 1b82          	leas	2,s
1107                     ; 612              OSSchedUnlock();
1109  025b 160000        	jsr	_OSSchedUnlock
1111                     ; 613              *perr = OS_ERR_NONE;
1113  025e 69f30004      	clr	[OFST+4,s]
1114                     ; 615              return (OS_TRUE);
1117  0262 c601          	ldab	#1
1120  0264 31            	puly	
1121  0265 3d            	rts	
1122  0266               L753:
1123                     ; 617         case OS_TMR_STATE_UNUSED:                           /* Timer not created                                      */
1123                     ; 618              OSSchedUnlock();
1125  0266 160000        	jsr	_OSSchedUnlock
1127                     ; 619              *perr = OS_ERR_TMR_INACTIVE;
1129  0269 c687          	ldab	#135
1130  026b 6bf30004      	stab	[OFST+4,s]
1131                     ; 621              return (OS_FALSE);
1134  026f c7            	clrb	
1137  0270 31            	puly	
1138  0271 3d            	rts	
1216                     ; 671 _NEAR BOOLEAN  OSTmrStop (OS_TMR  *ptmr,
1216                     ; 672                          INT8U    opt,
1216                     ; 673                          void    *callback_arg,
1216                     ; 674                          INT8U   *perr)
1216                     ; 675 {
1217                     	switch	.text
1218  0272               _OSTmrStop:
1220  0272 3b            	pshd	
1221       00000002      OFST:	set	2
1224                     ; 687     if (ptmr == (OS_TMR *)0) {
1226  0273 6cae          	std	2,-s
1227  0275 2604          	bne	L774
1228                     ; 688         *perr = OS_ERR_TMR_INVALID;
1230  0277 c68a          	ldab	#138
1231                     ; 689         return (OS_FALSE);
1234  0279 200a          	bra	L63
1235  027b               L774:
1236                     ; 695     if (ptmr->OSTmrType != OS_TMR_TYPE) {                         /* Validate timer structure                         */
1239  027b e6f30002      	ldab	[OFST+0,s]
1240  027f c164          	cmpb	#100
1241  0281 270a          	beq	L105
1242                     ; 696         *perr = OS_ERR_TMR_INVALID_TYPE;
1244  0283 c689          	ldab	#137
1245                     ; 698         return (OS_FALSE);
1249  0285               L63:
1250  0285 6bf3000a      	stab	[OFST+8,s]
1251  0289 c7            	clrb	
1253  028a 1b84          	leas	4,s
1254  028c 3d            	rts	
1255  028d               L105:
1256                     ; 700     if (OSIntNesting > 0u) {                                      /* See if trying to call from an ISR                */
1258  028d f60000        	ldab	_OSIntNesting
1259  0290 2704          	beq	L305
1260                     ; 701         *perr  = OS_ERR_TMR_ISR;
1262  0292 c68b          	ldab	#139
1263                     ; 703         return (OS_FALSE);
1267  0294 20ef          	bra	L63
1268  0296               L305:
1269                     ; 705     OSSchedLock();
1271  0296 160000        	jsr	_OSSchedLock
1273                     ; 706     switch (ptmr->OSTmrState) {
1275  0299 ed82          	ldy	OFST+0,s
1276  029b e6e816        	ldab	22,y
1278  029e 2764          	beq	L534
1279  02a0 040153        	dbeq	b,L334
1280  02a3 040150        	dbeq	b,L334
1281  02a6 040107        	dbeq	b,L124
1282                     ; 753         default:
1282                     ; 754              OSSchedUnlock();
1284  02a9 160000        	jsr	_OSSchedUnlock
1286                     ; 755              *perr = OS_ERR_TMR_INVALID_STATE;
1288  02ac c68d          	ldab	#141
1289                     ; 757              return (OS_FALSE);
1293  02ae 20d5          	bra	L63
1294  02b0               L124:
1295                     ; 707         case OS_TMR_STATE_RUNNING:
1295                     ; 708              OSTmr_Unlink(ptmr);                                  /* Remove from current wheel spoke                  */
1297  02b0 b764          	tfr	y,d
1298  02b2 1604c2        	jsr	L31_OSTmr_Unlink
1300                     ; 709              *perr = OS_ERR_NONE;
1302  02b5 ed8a          	ldy	OFST+8,s
1303  02b7 6940          	clr	0,y
1304                     ; 710              switch (opt) {
1306  02b9 e687          	ldab	OFST+5,s
1308  02bb 2734          	beq	L315
1309  02bd c003          	subb	#3
1310  02bf 2709          	beq	L324
1311  02c1 040112        	dbeq	b,L524
1312                     ; 732                  default:
1312                     ; 733                      *perr = OS_ERR_TMR_INVALID_OPT;
1314  02c4 c684          	ldab	#132
1315  02c6 6b40          	stab	0,y
1316                     ; 734                      break;
1318  02c8 2027          	bra	L315
1319  02ca               L324:
1320                     ; 711                  case OS_TMR_OPT_CALLBACK:
1320                     ; 712                       pfnct = ptmr->OSTmrCallback;                /* Execute callback function if available ...       */
1322  02ca ed82          	ldy	OFST+0,s
1323  02cc ec41          	ldd	1,y
1324  02ce 6c80          	std	OFST-2,s
1325                     ; 713                       if (pfnct != (OS_TMR_CALLBACK)0) {
1327  02d0 2719          	beq	L125
1328                     ; 714                           (*pfnct)((void *)ptmr, ptmr->OSTmrCallbackArg);  /* Use callback arg when timer was created */
1330  02d2 ec43          	ldd	3,y
1333  02d4 200a          	bra	LC007
1334                     ; 716                           *perr = OS_ERR_TMR_NO_CALLBACK;
1336  02d6               L524:
1337                     ; 720                  case OS_TMR_OPT_CALLBACK_ARG:
1337                     ; 721                       pfnct = ptmr->OSTmrCallback;                /* Execute callback function if available ...       */
1339  02d6 ed82          	ldy	OFST+0,s
1340  02d8 ec41          	ldd	1,y
1341  02da 6c80          	std	OFST-2,s
1342                     ; 722                       if (pfnct != (OS_TMR_CALLBACK)0) {
1344  02dc 270d          	beq	L125
1345                     ; 723                           (*pfnct)((void *)ptmr, callback_arg);   /* ... using the 'callback_arg' provided in call    */
1347  02de ec88          	ldd	OFST+6,s
1349  02e0               LC007:
1350  02e0 3b            	pshd	
1351  02e1 ec84          	ldd	OFST+2,s
1352  02e3 15f30002      	jsr	[OFST+0,s]
1353  02e7 1b82          	leas	2,s
1355  02e9 2006          	bra	L315
1356  02eb               L125:
1357                     ; 725                           *perr = OS_ERR_TMR_NO_CALLBACK;
1359  02eb c68f          	ldab	#143
1360  02ed 6bf3000a      	stab	[OFST+8,s]
1361  02f1               L315:
1362                     ; 736              OSSchedUnlock();
1364  02f1 160000        	jsr	_OSSchedUnlock
1366                     ; 738              return (OS_TRUE);
1370  02f4 2009          	bra	LC008
1371  02f6               L334:
1372                     ; 740         case OS_TMR_STATE_COMPLETED:                              /* Timer has already completed the ONE-SHOT or ...  */
1372                     ; 741         case OS_TMR_STATE_STOPPED:                                /* ... timer has not started yet.                   */
1372                     ; 742              OSSchedUnlock();
1374  02f6 160000        	jsr	_OSSchedUnlock
1376                     ; 743              *perr = OS_ERR_TMR_STOPPED;
1378  02f9 c68e          	ldab	#142
1379  02fb 6bf3000a      	stab	[OFST+8,s]
1380                     ; 745              return (OS_TRUE);
1383  02ff               LC008:
1384  02ff c601          	ldab	#1
1386  0301               L04:
1388  0301 1b84          	leas	4,s
1389  0303 3d            	rts	
1390  0304               L534:
1391                     ; 747         case OS_TMR_STATE_UNUSED:                                 /* Timer was not created                            */
1391                     ; 748              OSSchedUnlock();
1393  0304 160000        	jsr	_OSSchedUnlock
1395                     ; 749              *perr = OS_ERR_TMR_INACTIVE;
1397  0307 c687          	ldab	#135
1398  0309 6bf3000a      	stab	[OFST+8,s]
1399                     ; 751              return (OS_FALSE);
1402  030d c7            	clrb	
1404  030e 20f1          	bra	L04
1437                     ; 783 _NEAR INT8U  OSTmrSignal (void)
1437                     ; 784 {
1438                     	switch	.text
1439  0310               _OSTmrSignal:
1441  0310 37            	pshb	
1442       00000001      OFST:	set	1
1445                     ; 788     err = OSSemPost(OSTmrSemSignal);
1447  0311 fc0000        	ldd	_OSTmrSemSignal
1448  0314 160000        	jsr	_OSSemPost
1450                     ; 789     return (err);
1454  0317 1b81          	leas	1,s
1455  0319 3d            	rts	
1497                     ; 807 static  OS_TMR  *OSTmr_Alloc (void)
1497                     ; 808 {
1498                     	switch	.text
1499  031a               L3_OSTmr_Alloc:
1501  031a 3b            	pshd	
1502       00000002      OFST:	set	2
1505                     ; 812     if (OSTmrFreeList == (OS_TMR *)0) {
1507  031b fd0000        	ldy	_OSTmrFreeList
1508  031e 2604          	bne	L365
1509                     ; 813         return ((OS_TMR *)0);
1511  0320 87            	clra	
1512  0321 c7            	clrb	
1515  0322 31            	puly	
1516  0323 3d            	rts	
1517  0324               L365:
1518                     ; 815     ptmr            = (OS_TMR *)OSTmrFreeList;
1520  0324 6d80          	sty	OFST-2,s
1521                     ; 816     OSTmrFreeList   = (OS_TMR *)ptmr->OSTmrNext;
1523  0326 1805450000    	movw	5,y,_OSTmrFreeList
1524                     ; 817     ptmr->OSTmrNext = (OS_TCB *)0;
1526  032b 87            	clra	
1527  032c c7            	clrb	
1528  032d 6c45          	std	5,y
1529                     ; 818     ptmr->OSTmrPrev = (OS_TCB *)0;
1531  032f 6c47          	std	7,y
1532                     ; 819     OSTmrUsed++;
1534  0331 fd0000        	ldy	_OSTmrUsed
1535  0334 02            	iny	
1536  0335 7d0000        	sty	_OSTmrUsed
1537                     ; 820     OSTmrFree--;
1539  0338 fd0000        	ldy	_OSTmrFree
1540  033b 03            	dey	
1541  033c 7d0000        	sty	_OSTmrFree
1542                     ; 821     return (ptmr);
1544  033f ec80          	ldd	OFST-2,s
1547  0341 31            	puly	
1548  0342 3d            	rts	
1587                     ; 839 static  void  OSTmr_Free (OS_TMR *ptmr)
1587                     ; 840 {
1588                     	switch	.text
1589  0343               L5_OSTmr_Free:
1591  0343 3b            	pshd	
1592       00000000      OFST:	set	0
1595                     ; 841     ptmr->OSTmrState       = OS_TMR_STATE_UNUSED;      /* Clear timer object fields                                   */
1597  0344 b746          	tfr	d,y
1598                     ; 842     ptmr->OSTmrOpt         = OS_TMR_OPT_NONE;
1600  0346 87            	clra	
1601  0347 c7            	clrb	
1602  0348 6ce815        	std	21,y
1603                     ; 843     ptmr->OSTmrPeriod      = 0u;
1605  034b 6ce813        	std	19,y
1606  034e 6ce811        	std	17,y
1607                     ; 844     ptmr->OSTmrMatch       = 0u;
1609  0351 ed80          	ldy	OFST+0,s
1610  0353 6c4b          	std	11,y
1611  0355 6c49          	std	9,y
1612                     ; 845     ptmr->OSTmrCallback    = (OS_TMR_CALLBACK)0;
1614  0357 6c41          	std	1,y
1615                     ; 846     ptmr->OSTmrCallbackArg = (void *)0;
1617  0359 6c43          	std	3,y
1618                     ; 851     ptmr->OSTmrPrev        = (OS_TCB *)0;              /* Chain timer to free list                                    */
1620  035b 6c47          	std	7,y
1621                     ; 852     ptmr->OSTmrNext        = OSTmrFreeList;
1623  035d 1801450000    	movw	_OSTmrFreeList,5,y
1624                     ; 853     OSTmrFreeList          = ptmr;
1626  0362 7d0000        	sty	_OSTmrFreeList
1627                     ; 855     OSTmrUsed--;                                       /* Update timer object statistics                              */
1629  0365 fd0000        	ldy	_OSTmrUsed
1630  0368 03            	dey	
1631  0369 7d0000        	sty	_OSTmrUsed
1632                     ; 856     OSTmrFree++;
1634  036c fd0000        	ldy	_OSTmrFree
1635  036f 02            	iny	
1636  0370 7d0000        	sty	_OSTmrFree
1637                     ; 857 }
1640  0373 31            	puly	
1641  0374 3d            	rts	
1722                     ; 875 _NEAR void  OSTmr_Init (void)
1722                     ; 876 {
1723                     	switch	.text
1724  0375               _OSTmr_Init:
1726  0375 1b99          	leas	-7,s
1727       00000007      OFST:	set	7
1730                     ; 886     OS_MemClr((INT8U *)&OSTmrTbl[0],      sizeof(OSTmrTbl));            /* Clear all the TMRs                         */
1732  0377 cc0170        	ldd	#368
1733  037a 3b            	pshd	
1734  037b cc0000        	ldd	#_OSTmrTbl
1735  037e 160000        	jsr	_OS_MemClr
1737                     ; 887     OS_MemClr((INT8U *)&OSTmrWheelTbl[0], sizeof(OSTmrWheelTbl));       /* Clear the timer wheel                      */
1739  0381 cc0020        	ldd	#32
1740  0384 6c80          	std	0,s
1741  0386 cc0000        	ldd	#_OSTmrWheelTbl
1742  0389 160000        	jsr	_OS_MemClr
1744  038c 1b82          	leas	2,s
1745                     ; 889     for (ix = 0u; ix < (OS_TMR_CFG_MAX - 1u); ix++) {                   /* Init. list of free TMRs                    */
1747  038e 87            	clra	
1748  038f c7            	clrb	
1749  0390 b746          	tfr	d,y
1750  0392 6d82          	sty	OFST-5,s
1751  0394               L146:
1752                     ; 890         ix_next = ix + 1u;
1754  0394 02            	iny	
1755  0395 6d84          	sty	OFST-3,s
1756                     ; 891         ptmr1 = &OSTmrTbl[ix];
1758  0397 cd0017        	ldy	#23
1759  039a 13            	emul	
1760  039b c30000        	addd	#_OSTmrTbl
1761  039e 6c80          	std	OFST-7,s
1762                     ; 892         ptmr2 = &OSTmrTbl[ix_next];
1764  03a0 ec84          	ldd	OFST-3,s
1765  03a2 cd0017        	ldy	#23
1766  03a5 13            	emul	
1767  03a6 c30000        	addd	#_OSTmrTbl
1768  03a9 6c84          	std	OFST-3,s
1769                     ; 893         ptmr1->OSTmrType    = OS_TMR_TYPE;
1771  03ab c664          	ldab	#100
1772  03ad ed80          	ldy	OFST-7,s
1773  03af 6b40          	stab	0,y
1774                     ; 894         ptmr1->OSTmrState   = OS_TMR_STATE_UNUSED;                      /* Indicate that timer is inactive            */
1776  03b1 69e816        	clr	22,y
1777                     ; 895         ptmr1->OSTmrNext    = (void *)ptmr2;                            /* Link to next timer                         */
1779  03b4 18028445      	movw	OFST-3,s,5,y
1780                     ; 889     for (ix = 0u; ix < (OS_TMR_CFG_MAX - 1u); ix++) {                   /* Init. list of free TMRs                    */
1782  03b8 ed82          	ldy	OFST-5,s
1783  03ba 02            	iny	
1786  03bb b764          	tfr	y,d
1787  03bd 6c82          	std	OFST-5,s
1788  03bf 8c000f        	cpd	#15
1789  03c2 25d0          	blo	L146
1790                     ; 900     ptmr1               = &OSTmrTbl[ix];
1792  03c4 cd0017        	ldy	#23
1793  03c7 13            	emul	
1794  03c8 c30000        	addd	#_OSTmrTbl
1795  03cb 6c80          	std	OFST-7,s
1796                     ; 901     ptmr1->OSTmrType    = OS_TMR_TYPE;
1798  03cd c664          	ldab	#100
1799  03cf ed80          	ldy	OFST-7,s
1800  03d1 6b40          	stab	0,y
1801                     ; 902     ptmr1->OSTmrState   = OS_TMR_STATE_UNUSED;                          /* Indicate that timer is inactive            */
1803  03d3 87            	clra	
1804  03d4 6ae816        	staa	22,y
1805                     ; 903     ptmr1->OSTmrNext    = (void *)0;                                    /* Last OS_TMR                                */
1807  03d7 c7            	clrb	
1808  03d8 6c45          	std	5,y
1809                     ; 907     OSTmrTime           = 0u;
1811  03da 7c0002        	std	_OSTmrTime+2
1812  03dd 7c0000        	std	_OSTmrTime
1813                     ; 908     OSTmrUsed           = 0u;
1815  03e0 7c0000        	std	_OSTmrUsed
1816                     ; 909     OSTmrFree           = OS_TMR_CFG_MAX;
1818  03e3 c610          	ldab	#16
1819  03e5 7c0000        	std	_OSTmrFree
1820                     ; 910     OSTmrFreeList       = &OSTmrTbl[0];
1822  03e8 cc0000        	ldd	#_OSTmrTbl
1823  03eb 7c0000        	std	_OSTmrFreeList
1824                     ; 911     OSTmrSem            = OSSemCreate(1u);
1826  03ee cc0001        	ldd	#1
1827  03f1 160000        	jsr	_OSSemCreate
1829  03f4 7c0000        	std	_OSTmrSem
1830                     ; 912     OSTmrSemSignal      = OSSemCreate(0u);
1832  03f7 87            	clra	
1833  03f8 c7            	clrb	
1834  03f9 160000        	jsr	_OSSemCreate
1836  03fc 7c0000        	std	_OSTmrSemSignal
1837                     ; 915     OSEventNameSet(OSTmrSem,       (INT8U *)(void *)"uC/OS-II TmrLock",   &err);
1839  03ff 1a86          	leax	OFST-1,s
1840  0401 34            	pshx	
1841  0402 cc0020        	ldd	#L746
1842  0405 3b            	pshd	
1843  0406 fc0000        	ldd	_OSTmrSem
1844  0409 160000        	jsr	_OSEventNameSet
1846  040c 1b84          	leas	4,s
1847                     ; 916     OSEventNameSet(OSTmrSemSignal, (INT8U *)(void *)"uC/OS-II TmrSignal", &err);
1849  040e 1a86          	leax	OFST-1,s
1850  0410 34            	pshx	
1851  0411 cc000d        	ldd	#L156
1852  0414 3b            	pshd	
1853  0415 fc0000        	ldd	_OSTmrSemSignal
1854  0418 160000        	jsr	_OSEventNameSet
1856  041b 1b84          	leas	4,s
1857                     ; 919     OSTmr_InitTask();
1859  041d 0703          	jsr	L7_OSTmr_InitTask
1861                     ; 920 }
1864  041f 1b87          	leas	7,s
1865  0421 3d            	rts	
1901                     ; 936 static  void  OSTmr_InitTask (void)
1901                     ; 937 {
1902                     	switch	.text
1903  0422               L7_OSTmr_InitTask:
1905  0422 37            	pshb	
1906       00000001      OFST:	set	1
1909                     ; 945     (void)OSTaskCreateExt(OSTmr_Task,
1909                     ; 946                           (void *)0,                                       /* No arguments passed to OSTmrTask()      */
1909                     ; 947                           &OSTmrTaskStk[OS_TASK_TMR_STK_SIZE - 1u],        /* Set Top-Of-Stack                        */
1909                     ; 948                           OS_TASK_TMR_PRIO,
1909                     ; 949                           OS_TASK_TMR_ID,
1909                     ; 950                           &OSTmrTaskStk[0],                                /* Set Bottom-Of-Stack                     */
1909                     ; 951                           OS_TASK_TMR_STK_SIZE,
1909                     ; 952                           (void *)0,                                       /* No TCB extension                        */
1909                     ; 953                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);      /* Enable stack checking + clear stack     */
1911  0423 cc0003        	ldd	#3
1912  0426 3b            	pshd	
1913  0427 c7            	clrb	
1914  0428 3b            	pshd	
1915  0429 c6a0          	ldab	#160
1916  042b 3b            	pshd	
1917  042c c7            	clrb	
1918  042d 3b            	pshd	
1919  042e cc0000        	ldd	#_OSTmrTaskStk
1920  0431 3b            	pshd	
1921  0432 ccfffd        	ldd	#-3
1922  0435 3b            	pshd	
1923  0436 cc003d        	ldd	#61
1924  0439 3b            	pshd	
1925  043a cc009f        	ldd	#_OSTmrTaskStk+159
1926  043d 3b            	pshd	
1927  043e 87            	clra	
1928  043f c7            	clrb	
1929  0440 3b            	pshd	
1930  0441 cc0518        	ldd	#L51_OSTmr_Task
1931  0444 160000        	jsr	_OSTaskCreateExt
1933  0447 1bf012        	leas	18,s
1934                     ; 980     OSTaskNameSet(OS_TASK_TMR_PRIO, (INT8U *)(void *)"uC/OS-II Tmr", &err);
1936  044a 1a80          	leax	OFST-1,s
1937  044c 34            	pshx	
1938  044d cc0000        	ldd	#L766
1939  0450 3b            	pshd	
1940  0451 cc003d        	ldd	#61
1941  0454 160000        	jsr	_OSTaskNameSet
1943                     ; 982 }
1946  0457 1b85          	leas	5,s
1947  0459 3d            	rts	
2049                     ; 1004 static  void  OSTmr_Link (OS_TMR  *ptmr,
2049                     ; 1005                           INT8U    type)
2049                     ; 1006 {
2050                     	switch	.text
2051  045a               L11_OSTmr_Link:
2053  045a 3b            	pshd	
2054  045b 1b9c          	leas	-4,s
2055       00000004      OFST:	set	4
2058                     ; 1012     ptmr->OSTmrState = OS_TMR_STATE_RUNNING;
2060  045d c603          	ldab	#3
2061  045f ed84          	ldy	OFST+0,s
2062  0461 6be816        	stab	22,y
2063                     ; 1013     if (type == OS_TMR_LINK_PERIODIC) {                            /* Determine when timer will expire                */
2065  0464 e689          	ldab	OFST+5,s
2066  0466 53            	decb	
2067                     ; 1014         ptmr->OSTmrMatch = ptmr->OSTmrPeriod + OSTmrTime;
2071  0467 2708          	beq	LC009
2072                     ; 1016         if (ptmr->OSTmrDly == 0u) {
2074  0469 ec4d          	ldd	13,y
2075  046b 260c          	bne	L157
2076  046d ec4f          	ldd	15,y
2077  046f 2608          	bne	L157
2078                     ; 1017             ptmr->OSTmrMatch = ptmr->OSTmrPeriod + OSTmrTime;
2080  0471               LC009:
2081  0471 ece813        	ldd	19,y
2082  0474 eee811        	ldx	17,y
2085  0477 2004          	bra	L747
2086  0479               L157:
2087                     ; 1019             ptmr->OSTmrMatch = ptmr->OSTmrDly    + OSTmrTime;
2089  0479 ec4f          	ldd	15,y
2090  047b ee4d          	ldx	13,y
2092  047d               L747:
2093  047d cd0000        	ldy	#_OSTmrTime
2094  0480 160000        	jsr	c_ladd
2095  0483 ed84          	ldy	OFST+0,s
2096  0485 6c4b          	std	11,y
2097  0487 6e49          	stx	9,y
2098                     ; 1022     spoke  = (INT16U)(ptmr->OSTmrMatch % OS_TMR_CFG_WHEEL_SIZE);
2100  0489 c407          	andb	#7
2101  048b 87            	clra	
2102  048c 6c82          	std	OFST-2,s
2103                     ; 1023     pspoke = &OSTmrWheelTbl[spoke];
2105  048e 59            	lsld	
2106  048f 59            	lsld	
2107  0490 c30000        	addd	#_OSTmrWheelTbl
2108                     ; 1025     if (pspoke->OSTmrFirst == (OS_TMR *)0) {                       /* Link into timer wheel                           */
2110  0493 b745          	tfr	d,x
2111  0495 6e80          	stx	OFST-4,s
2112  0497 ec00          	ldd	0,x
2113  0499 2609          	bne	L557
2114                     ; 1026         pspoke->OSTmrFirst   = ptmr;
2116  049b 6d00          	sty	0,x
2117                     ; 1027         ptmr->OSTmrNext      = (OS_TMR *)0;
2119  049d 6c45          	std	5,y
2120                     ; 1028         pspoke->OSTmrEntries = 1u;
2122  049f 52            	incb	
2123  04a0 b756          	tfr	x,y
2125  04a2 2013          	bra	L757
2126  04a4               L557:
2127                     ; 1030         ptmr1                = pspoke->OSTmrFirst;                 /* Point to first timer in the spoke               */
2129  04a4 6c82          	std	OFST-2,s
2130                     ; 1031         pspoke->OSTmrFirst   = ptmr;
2132  04a6 6d00          	sty	0,x
2133                     ; 1032         ptmr->OSTmrNext      = (void *)ptmr1;
2135  04a8 6c45          	std	5,y
2136                     ; 1033         ptmr1->OSTmrPrev     = (void *)ptmr;
2138  04aa b764          	tfr	y,d
2139  04ac ed82          	ldy	OFST-2,s
2140  04ae 6c47          	std	7,y
2141                     ; 1034         pspoke->OSTmrEntries++;
2143  04b0 b756          	tfr	x,y
2144  04b2 ec42          	ldd	2,y
2145  04b4 c30001        	addd	#1
2146  04b7               L757:
2147  04b7 6c42          	std	2,y
2148                     ; 1036     ptmr->OSTmrPrev = (void *)0;                                   /* Timer always inserted as first node in list     */
2150  04b9 87            	clra	
2151  04ba c7            	clrb	
2152  04bb ee84          	ldx	OFST+0,s
2153  04bd 6c07          	std	7,x
2154                     ; 1037 }
2157  04bf 1b86          	leas	6,s
2158  04c1 3d            	rts	
2238                     ; 1054 static  void  OSTmr_Unlink (OS_TMR *ptmr)
2238                     ; 1055 {
2239                     	switch	.text
2240  04c2               L31_OSTmr_Unlink:
2242  04c2 3b            	pshd	
2243  04c3 1b9a          	leas	-6,s
2244       00000006      OFST:	set	6
2247                     ; 1062     spoke  = (INT16U)(ptmr->OSTmrMatch % OS_TMR_CFG_WHEEL_SIZE);
2249  04c5 b746          	tfr	d,y
2250  04c7 e64c          	ldab	12,y
2251  04c9 c407          	andb	#7
2252  04cb 87            	clra	
2253  04cc 6c82          	std	OFST-4,s
2254                     ; 1063     pspoke = &OSTmrWheelTbl[spoke];
2256  04ce 59            	lsld	
2257  04cf 59            	lsld	
2258  04d0 c30000        	addd	#_OSTmrWheelTbl
2259                     ; 1065     if (pspoke->OSTmrFirst == ptmr) {                       /* See if timer to remove is at the beginning of list     */
2261  04d3 b745          	tfr	d,x
2262  04d5 6e84          	stx	OFST-2,s
2263  04d7 ec00          	ldd	0,x
2264  04d9 ac86          	cpd	OFST+0,s
2265  04db 260e          	bne	L5201
2266                     ; 1066         ptmr1              = (OS_TMR *)ptmr->OSTmrNext;
2268  04dd ed86          	ldy	OFST+0,s
2269  04df ed45          	ldy	5,y
2270  04e1 6d80          	sty	OFST-6,s
2271                     ; 1067         pspoke->OSTmrFirst = (OS_TMR *)ptmr1;
2273  04e3 6d00          	sty	0,x
2274                     ; 1068         if (ptmr1 != (OS_TMR *)0) {
2276  04e5 271a          	beq	L1301
2277                     ; 1069             ptmr1->OSTmrPrev = (void *)0;
2279  04e7 87            	clra	
2280  04e8 c7            	clrb	
2281  04e9 2014          	bra	LC010
2282  04eb               L5201:
2283                     ; 1072         ptmr1            = (OS_TMR *)ptmr->OSTmrPrev;       /* Remove timer from somewhere in the list                */
2285  04eb ed86          	ldy	OFST+0,s
2286  04ed 18024780      	movw	7,y,OFST-6,s
2287                     ; 1073         ptmr2            = (OS_TMR *)ptmr->OSTmrNext;
2289  04f1 ec45          	ldd	5,y
2290  04f3 6c82          	std	OFST-4,s
2291                     ; 1074         ptmr1->OSTmrNext = ptmr2;
2293  04f5 ed80          	ldy	OFST-6,s
2294  04f7 6c45          	std	5,y
2295                     ; 1075         if (ptmr2 != (OS_TMR *)0) {
2297  04f9 2706          	beq	L1301
2298                     ; 1076             ptmr2->OSTmrPrev = (void *)ptmr1;
2300  04fb b764          	tfr	y,d
2301  04fd ed82          	ldy	OFST-4,s
2302  04ff               LC010:
2303  04ff 6c47          	std	7,y
2304  0501               L1301:
2305                     ; 1079     ptmr->OSTmrState = OS_TMR_STATE_STOPPED;
2307  0501 c601          	ldab	#1
2308  0503 ed86          	ldy	OFST+0,s
2309  0505 6be816        	stab	22,y
2310                     ; 1080     ptmr->OSTmrNext  = (void *)0;
2312  0508 87            	clra	
2313  0509 c7            	clrb	
2314  050a 6c45          	std	5,y
2315                     ; 1081     ptmr->OSTmrPrev  = (void *)0;
2317  050c 6c47          	std	7,y
2318                     ; 1082     pspoke->OSTmrEntries--;
2320  050e b756          	tfr	x,y
2321  0510 ee42          	ldx	2,y
2322  0512 09            	dex	
2323  0513 6e42          	stx	2,y
2324                     ; 1083 }
2327  0515 1b88          	leas	8,s
2328  0517 3d            	rts	
2431                     ; 1100 static  void  OSTmr_Task (void *p_arg)
2431                     ; 1101 {
2432                     	switch	.text
2433  0518               L51_OSTmr_Task:
2435  0518 3b            	pshd	
2436  0519 1b99          	leas	-7,s
2437       00000007      OFST:	set	7
2440                     ; 1110     p_arg = p_arg;                                               /* Prevent compiler warning for not using 'p_arg'    */
2442  051b               L5011:
2443                     ; 1112         OSSemPend(OSTmrSemSignal, 0u, &err);                     /* Wait for signal indicating time to update timers  */
2445  051b 1a86          	leax	OFST-1,s
2446  051d 34            	pshx	
2447  051e 87            	clra	
2448  051f c7            	clrb	
2449  0520 3b            	pshd	
2450  0521 3b            	pshd	
2451  0522 fc0000        	ldd	_OSTmrSemSignal
2452  0525 160000        	jsr	_OSSemPend
2454  0528 1b86          	leas	6,s
2455                     ; 1113         OSSchedLock();
2457  052a 160000        	jsr	_OSSchedLock
2459                     ; 1114         OSTmrTime++;                                             /* Increment the current time                        */
2461  052d fc0002        	ldd	_OSTmrTime+2
2462  0530 c30001        	addd	#1
2463  0533 7c0002        	std	_OSTmrTime+2
2464  0536 2408          	bcc	L46
2465  0538 720001        	inc	_OSTmrTime+1
2466  053b 2603          	bne	L46
2467  053d 720000        	inc	_OSTmrTime
2468  0540               L46:
2469                     ; 1115         spoke  = (INT16U)(OSTmrTime % OS_TMR_CFG_WHEEL_SIZE);    /* Position on current timer wheel entry             */
2471  0540 c407          	andb	#7
2472  0542 87            	clra	
2473                     ; 1116         pspoke = &OSTmrWheelTbl[spoke];
2475  0543 59            	lsld	
2476  0544 59            	lsld	
2477  0545 c30000        	addd	#_OSTmrWheelTbl
2478  0548 6c82          	std	OFST-5,s
2479                     ; 1117         ptmr   = pspoke->OSTmrFirst;
2481  054a ecf30002      	ldd	[OFST-5,s]
2483  054e 2049          	bra	L5111
2484  0550               L1111:
2485                     ; 1119             ptmr_next = (OS_TMR *)ptmr->OSTmrNext;               /* Point to next timer to update because current ... */
2487  0550 b746          	tfr	d,y
2488  0552 18024582      	movw	5,y,OFST-5,s
2489                     ; 1121             if (OSTmrTime == ptmr->OSTmrMatch) {                 /* Process each timer that expires                   */
2491  0556 fc0000        	ldd	_OSTmrTime
2492  0559 ac49          	cpd	9,y
2493  055b 263a          	bne	L1211
2494  055d fc0002        	ldd	_OSTmrTime+2
2495  0560 ac4b          	cpd	11,y
2496  0562 2633          	bne	L1211
2497                     ; 1123                 OSTmr_Unlink(ptmr);                              /* Remove from current wheel spoke                   */
2500  0564 ec80          	ldd	OFST-7,s
2501  0566 1604c2        	jsr	L31_OSTmr_Unlink
2503                     ; 1124                 if (ptmr->OSTmrOpt == OS_TMR_OPT_PERIODIC) {
2505  0569 ed80          	ldy	OFST-7,s
2506  056b e6e815        	ldab	21,y
2507  056e c102          	cmpb	#2
2508  0570 260f          	bne	L3211
2509                     ; 1125                     OSTmr_Link(ptmr, OS_TMR_LINK_PERIODIC);      /* Recalculate new position of timer in wheel        */
2511  0572 cc0001        	ldd	#1
2512  0575 3b            	pshd	
2513  0576 b764          	tfr	y,d
2514  0578 16045a        	jsr	L11_OSTmr_Link
2516  057b 1b82          	leas	2,s
2518  057d ed80          	ldy	OFST-7,s
2519  057f 2005          	bra	L5211
2520  0581               L3211:
2521                     ; 1127                     ptmr->OSTmrState = OS_TMR_STATE_COMPLETED;   /* Indicate that the timer has completed             */
2523  0581 c602          	ldab	#2
2524  0583 6be816        	stab	22,y
2525  0586               L5211:
2526                     ; 1129                 pfnct = ptmr->OSTmrCallback;                     /* Execute callback function if available            */
2528  0586 ec41          	ldd	1,y
2529  0588 6c84          	std	OFST-3,s
2530                     ; 1130                 if (pfnct != (OS_TMR_CALLBACK)0) {
2532  058a 270b          	beq	L1211
2533                     ; 1131                     (*pfnct)((void *)ptmr, ptmr->OSTmrCallbackArg);
2535  058c ec43          	ldd	3,y
2536  058e 3b            	pshd	
2537  058f ec82          	ldd	OFST-5,s
2538  0591 15f30006      	jsr	[OFST-1,s]
2540  0595 1b82          	leas	2,s
2541  0597               L1211:
2542                     ; 1134             ptmr = ptmr_next;
2544  0597 ec82          	ldd	OFST-5,s
2545  0599               L5111:
2546  0599 6c80          	std	OFST-7,s
2547                     ; 1118         while (ptmr != (OS_TMR *)0) {
2549  059b 26b3          	bne	L1111
2550                     ; 1136         OSSchedUnlock();
2552  059d 160000        	jsr	_OSSchedUnlock
2555  05a0 06051b        	bra	L5011
2567                     	xdef	_OSTmr_Init
2568                     	xref	_OS_MemClr
2569                     	xref	_OSSchedUnlock
2570                     	xref	_OSSchedLock
2571                     	xdef	_OSTmrSignal
2572                     	xdef	_OSTmrStop
2573                     	xdef	_OSTmrStart
2574                     	xdef	_OSTmrStateGet
2575                     	xdef	_OSTmrRemainGet
2576                     	xdef	_OSTmrDel
2577                     	xdef	_OSTmrCreate
2578                     	xref	_OSTaskNameSet
2579                     	xref	_OSTaskCreateExt
2580                     	xref	_OSSemPost
2581                     	xref	_OSSemPend
2582                     	xref	_OSSemCreate
2583                     	xref	_OSEventNameSet
2584                     	xref	_OSTmrWheelTbl
2585                     	xref	_OSTmrTaskStk
2586                     	xref	_OSTmrFreeList
2587                     	xref	_OSTmrTbl
2588                     	xref	_OSTmrSemSignal
2589                     	xref	_OSTmrSem
2590                     	xref	_OSTmrTime
2591                     	xref	_OSTmrUsed
2592                     	xref	_OSTmrFree
2593                     	xref	_OSIntNesting
2594                     .const:	section	.data
2595  0000               L766:
2596  0000 75432f4f532d  	dc.b	"uC/OS-II Tmr",0
2597  000d               L156:
2598  000d 75432f4f532d  	dc.b	"uC/OS-II TmrSignal",0
2599  0020               L746:
2600  0020 75432f4f532d  	dc.b	"uC/OS-II TmrLock",0
2621                     	xref	c_ladd
2622                     	xref	c_lsub
2623                     	end

   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 134                     ; 56 _NEAR void  *OSMboxAccept (OS_EVENT *pevent)
 134                     ; 57 {
 135                     	switch	.text
 136  0000               _OSMboxAccept:
 138  0000 3b            	pshd	
 139  0001 1b9d          	leas	-3,s
 140       00000003      OFST:	set	3
 143                     ; 60     OS_CPU_SR  cpu_sr = 0u;
 145                     ; 66     if (pevent == (OS_EVENT *)0) {                        /* Validate 'pevent'                         */
 147  0003 046402        	tbne	d,L56
 148                     ; 67         return ((void *)0);
 151  0006 2007          	bra	LC001
 152  0008               L56:
 153                     ; 70     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {      /* Validate event block type                 */
 155  0008 e6f30003      	ldab	[OFST+0,s]
 156  000c 040105        	dbeq	b,L76
 157                     ; 71         return ((void *)0);
 159  000f               LC001:
 160  000f 87            	clra	
 161  0010 c7            	clrb	
 163  0011               L6:
 165  0011 1b85          	leas	5,s
 166  0013 3d            	rts	
 167  0014               L76:
 168                     ; 73     OS_ENTER_CRITICAL();
 170  0014 160000        	jsr	_OS_CPU_SR_Save
 172  0017 6b80          	stab	OFST-3,s
 173                     ; 74     pmsg               = pevent->OSEventPtr;
 175  0019 ed83          	ldy	OFST+0,s
 176  001b 18024181      	movw	1,y,OFST-2,s
 177                     ; 75     pevent->OSEventPtr = (void *)0;                       /* Clear the mailbox                         */
 179  001f 87            	clra	
 180  0020 c7            	clrb	
 181  0021 6c41          	std	1,y
 182                     ; 76     OS_EXIT_CRITICAL();
 184  0023 e680          	ldab	OFST-3,s
 185  0025 160000        	jsr	_OS_CPU_SR_Restore
 187                     ; 77     return (pmsg);                                        /* Return the message received (or NULL)     */
 189  0028 ec81          	ldd	OFST-2,s
 191  002a 20e5          	bra	L6
 252                     ; 98 _NEAR OS_EVENT  *OSMboxCreate (void *pmsg)
 252                     ; 99 {
 253                     	switch	.text
 254  002c               _OSMboxCreate:
 256  002c 3b            	pshd	
 257  002d 1b9d          	leas	-3,s
 258       00000003      OFST:	set	3
 261                     ; 102     OS_CPU_SR  cpu_sr = 0u;
 263                     ; 114     if (OSIntNesting > 0u) {                     /* See if called from ISR ...                         */
 265  002f f60000        	ldab	_OSIntNesting
 266  0032 2704          	beq	L121
 267                     ; 115         return ((OS_EVENT *)0);                  /* ... can't CREATE from an ISR                       */
 269  0034 87            	clra	
 270  0035 c7            	clrb	
 272  0036 2031          	bra	L21
 273  0038               L121:
 274                     ; 117     OS_ENTER_CRITICAL();
 276  0038 160000        	jsr	_OS_CPU_SR_Save
 278  003b 6b82          	stab	OFST-1,s
 279                     ; 118     pevent = OSEventFreeList;                    /* Get next free event control block                  */
 281  003d fd0000        	ldy	_OSEventFreeList
 282  0040 6d80          	sty	OFST-3,s
 283                     ; 119     if (OSEventFreeList != (OS_EVENT *)0) {      /* See if pool of free ECB pool was empty             */
 285  0042 2705          	beq	L321
 286                     ; 120         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
 288  0044 1805410000    	movw	1,y,_OSEventFreeList
 289  0049               L321:
 290                     ; 122     OS_EXIT_CRITICAL();
 292  0049 87            	clra	
 293  004a 160000        	jsr	_OS_CPU_SR_Restore
 295                     ; 123     if (pevent != (OS_EVENT *)0) {
 297  004d ed80          	ldy	OFST-3,s
 298  004f 2716          	beq	L521
 299                     ; 124         pevent->OSEventType    = OS_EVENT_TYPE_MBOX;
 301  0051 c601          	ldab	#1
 302  0053 6b40          	stab	0,y
 303                     ; 125         pevent->OSEventCnt     = 0u;
 305  0055 87            	clra	
 306  0056 c7            	clrb	
 307  0057 6c43          	std	3,y
 308                     ; 126         pevent->OSEventPtr     = pmsg;           /* Deposit message in event control block             */
 310  0059 18028341      	movw	OFST+0,s,1,y
 311                     ; 128         pevent->OSEventName    = (INT8U *)(void *)"?";
 313  005d cc0000        	ldd	#L721
 314  0060 6c4e          	std	14,y
 315                     ; 130         OS_EventWaitListInit(pevent);
 317  0062 b764          	tfr	y,d
 318  0064 160000        	jsr	_OS_EventWaitListInit
 321  0067               L521:
 322                     ; 134     return (pevent);                             /* Return pointer to event control block              */
 324  0067 ec80          	ldd	OFST-3,s
 326  0069               L21:
 328  0069 1b85          	leas	5,s
 329  006b 3d            	rts	
 417                     ; 179 _NEAR OS_EVENT  *OSMboxDel (OS_EVENT  *pevent,
 417                     ; 180                            INT8U      opt,
 417                     ; 181                            INT8U     *perr)
 417                     ; 182 {
 418                     	switch	.text
 419  006c               _OSMboxDel:
 421  006c 3b            	pshd	
 422  006d 1b9c          	leas	-4,s
 423       00000004      OFST:	set	4
 426                     ; 186     OS_CPU_SR  cpu_sr = 0u;
 428                     ; 207     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
 430  006f 046404        	tbne	d,L102
 431                     ; 208         *perr = OS_ERR_PEVENT_NULL;
 433  0072 c604          	ldab	#4
 434                     ; 209         return (pevent);
 437  0074 2009          	bra	L61
 438  0076               L102:
 439                     ; 215     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
 442  0076 e6f30004      	ldab	[OFST+0,s]
 443  007a 04010b        	dbeq	b,L302
 444                     ; 216         *perr = OS_ERR_EVENT_TYPE;
 446  007d c601          	ldab	#1
 447                     ; 218         return (pevent);
 451  007f               L61:
 452  007f 6bf3000a      	stab	[OFST+6,s]
 453  0083 ec84          	ldd	OFST+0,s
 455  0085 1b86          	leas	6,s
 456  0087 3d            	rts	
 457  0088               L302:
 458                     ; 220     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 460  0088 f60000        	ldab	_OSIntNesting
 461  008b 2704          	beq	L502
 462                     ; 221         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
 464  008d c60f          	ldab	#15
 465                     ; 223         return (pevent);
 469  008f 20ee          	bra	L61
 470  0091               L502:
 471                     ; 225     OS_ENTER_CRITICAL();
 473  0091 160000        	jsr	_OS_CPU_SR_Save
 475  0094 6b80          	stab	OFST-4,s
 476                     ; 226     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on mailbox      */
 478  0096 ed84          	ldy	OFST+0,s
 479  0098 e645          	ldab	5,y
 480  009a 2706          	beq	L702
 481                     ; 227         tasks_waiting = OS_TRUE;                           /* Yes                                      */
 483  009c c601          	ldab	#1
 484  009e 6b83          	stab	OFST-1,s
 486  00a0 2002          	bra	L112
 487  00a2               L702:
 488                     ; 229         tasks_waiting = OS_FALSE;                          /* No                                       */
 490  00a2 6983          	clr	OFST-1,s
 491  00a4               L112:
 492                     ; 231     switch (opt) {
 494  00a4 e689          	ldab	OFST+5,s
 496  00a6 270d          	beq	L131
 497  00a8 040152        	dbeq	b,L522
 498                     ; 270         default:
 498                     ; 271              OS_EXIT_CRITICAL();
 500  00ab e680          	ldab	OFST-4,s
 501  00ad 87            	clra	
 502  00ae 160000        	jsr	_OS_CPU_SR_Restore
 504                     ; 272              *perr         = OS_ERR_INVALID_OPT;
 506  00b1 c607          	ldab	#7
 507                     ; 273              pevent_return = pevent;
 509                     ; 274              break;
 511  00b3 202e          	bra	LC003
 512  00b5               L131:
 513                     ; 232         case OS_DEL_NO_PEND:                               /* Delete mailbox only if no task waiting   */
 513                     ; 233              if (tasks_waiting == OS_FALSE) {
 515  00b5 e683          	ldab	OFST-1,s
 516  00b7 2622          	bne	L712
 517                     ; 235                  pevent->OSEventName = (INT8U *)(void *)"?";
 519  00b9 cc0000        	ldd	#L721
 520  00bc 6c4e          	std	14,y
 521                     ; 237                  pevent->OSEventType = OS_EVENT_TYPE_UNUSED;
 523  00be 87            	clra	
 524  00bf 6a40          	staa	0,y
 525                     ; 238                  pevent->OSEventPtr  = OSEventFreeList;    /* Return Event Control Block to free list  */
 527  00c1 1801410000    	movw	_OSEventFreeList,1,y
 528                     ; 239                  pevent->OSEventCnt  = 0u;
 530  00c6 c7            	clrb	
 531  00c7 6c43          	std	3,y
 532                     ; 240                  OSEventFreeList     = pevent;             /* Get next free event control block        */
 534  00c9 1805840000    	movw	OFST+0,s,_OSEventFreeList
 535                     ; 241                  OS_EXIT_CRITICAL();
 537  00ce e680          	ldab	OFST-4,s
 538  00d0 160000        	jsr	_OS_CPU_SR_Restore
 540                     ; 242                  *perr               = OS_ERR_NONE;
 542  00d3 87            	clra	
 543  00d4 6af3000a      	staa	[OFST+6,s]
 544                     ; 243                  pevent_return       = (OS_EVENT *)0;      /* Mailbox has been deleted                 */
 546  00d8 c7            	clrb	
 548  00d9 200e          	bra	LC002
 549  00db               L712:
 550                     ; 245                  OS_EXIT_CRITICAL();
 552  00db e680          	ldab	OFST-4,s
 553  00dd 87            	clra	
 554  00de 160000        	jsr	_OS_CPU_SR_Restore
 556                     ; 246                  *perr               = OS_ERR_TASK_WAITING;
 558  00e1 c649          	ldab	#73
 559                     ; 247                  pevent_return       = pevent;
 561  00e3               LC003:
 562  00e3 6bf3000a      	stab	[OFST+6,s]
 563  00e7 ec84          	ldd	OFST+0,s
 564  00e9               LC002:
 565  00e9 6c81          	std	OFST-3,s
 566  00eb 203c          	bra	L512
 567  00ed               L322:
 568                     ; 253                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
 570  00ed cc0002        	ldd	#2
 571  00f0 3b            	pshd	
 572  00f1 3b            	pshd	
 573  00f2 c7            	clrb	
 574  00f3 3b            	pshd	
 575  00f4 ec8a          	ldd	OFST+6,s
 576  00f6 160000        	jsr	_OS_EventTaskRdy
 578  00f9 1b86          	leas	6,s
 579  00fb ed84          	ldy	OFST+0,s
 580  00fd               L522:
 581                     ; 251         case OS_DEL_ALWAYS:                                /* Always delete the mailbox                */
 581                     ; 252              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for mailbox      */
 583  00fd e645          	ldab	5,y
 584  00ff 26ec          	bne	L322
 585                     ; 256              pevent->OSEventName    = (INT8U *)(void *)"?";
 587  0101 cc0000        	ldd	#L721
 588  0104 6c4e          	std	14,y
 589                     ; 258              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
 591  0106 87            	clra	
 592  0107 6a40          	staa	0,y
 593                     ; 259              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
 595  0109 1801410000    	movw	_OSEventFreeList,1,y
 596                     ; 260              pevent->OSEventCnt     = 0u;
 598  010e c7            	clrb	
 599  010f 6c43          	std	3,y
 600                     ; 261              OSEventFreeList        = pevent;              /* Get next free event control block        */
 602  0111 1805840000    	movw	OFST+0,s,_OSEventFreeList
 603                     ; 262              OS_EXIT_CRITICAL();
 605  0116 e680          	ldab	OFST-4,s
 606  0118 160000        	jsr	_OS_CPU_SR_Restore
 608                     ; 263              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
 610  011b e683          	ldab	OFST-1,s
 611  011d 042103        	dbne	b,L132
 612                     ; 264                  OS_Sched();                               /* Find highest priority task ready to run  */
 614  0120 160000        	jsr	_OS_Sched
 616  0123               L132:
 617                     ; 266              *perr         = OS_ERR_NONE;
 619  0123 87            	clra	
 620  0124 6af3000a      	staa	[OFST+6,s]
 621                     ; 267              pevent_return = (OS_EVENT *)0;                /* Mailbox has been deleted                 */
 623  0128 c7            	clrb	
 624                     ; 268              break;
 626  0129               L512:
 627                     ; 279     return (pevent_return);
 632  0129 1b86          	leas	6,s
 633  012b 3d            	rts	
 712                     ; 317 _NEAR void  *OSMboxPend (OS_EVENT  *pevent,
 712                     ; 318                         INT32U     timeout,
 712                     ; 319                         INT8U     *perr)
 712                     ; 320 {
 713                     	switch	.text
 714  012c               _OSMboxPend:
 716  012c 3b            	pshd	
 717  012d 1b9d          	leas	-3,s
 718       00000003      OFST:	set	3
 721                     ; 323     OS_CPU_SR  cpu_sr = 0u;
 723                     ; 335     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
 725  012f 046404        	tbne	d,L572
 726                     ; 336         *perr = OS_ERR_PEVENT_NULL;
 728  0132 c604          	ldab	#4
 729                     ; 337         return ((void *)0);
 732  0134 2009          	bra	LC004
 733  0136               L572:
 734                     ; 343     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
 737  0136 e6f30003      	ldab	[OFST+0,s]
 738  013a 04010b        	dbeq	b,L772
 739                     ; 344         *perr = OS_ERR_EVENT_TYPE;
 741  013d c601          	ldab	#1
 742                     ; 346         return ((void *)0);
 745  013f               LC004:
 746  013f 6bf3000b      	stab	[OFST+8,s]
 747  0143 87            	clra	
 748  0144 c7            	clrb	
 750  0145               L22:
 752  0145 1b85          	leas	5,s
 753  0147 3d            	rts	
 754  0148               L772:
 755                     ; 348     if (OSIntNesting > 0u) {                          /* See if called from ISR ...                    */
 757  0148 f60000        	ldab	_OSIntNesting
 758  014b 2704          	beq	L103
 759                     ; 349         *perr = OS_ERR_PEND_ISR;                      /* ... can't PEND from an ISR                    */
 761  014d c602          	ldab	#2
 762                     ; 351         return ((void *)0);
 766  014f 20ee          	bra	LC004
 767  0151               L103:
 768                     ; 353     if (OSLockNesting > 0u) {                         /* See if called with scheduler locked ...       */
 770  0151 f60000        	ldab	_OSLockNesting
 771  0154 2704          	beq	L303
 772                     ; 354         *perr = OS_ERR_PEND_LOCKED;                   /* ... can't PEND when locked                    */
 774  0156 c60d          	ldab	#13
 775                     ; 356         return ((void *)0);
 779  0158 20e5          	bra	LC004
 780  015a               L303:
 781                     ; 358     OS_ENTER_CRITICAL();
 783  015a 160000        	jsr	_OS_CPU_SR_Save
 785  015d 6b82          	stab	OFST-1,s
 786                     ; 359     pmsg = pevent->OSEventPtr;
 788  015f ed83          	ldy	OFST+0,s
 789  0161 ec41          	ldd	1,y
 790  0163 6c80          	std	OFST-3,s
 791                     ; 360     if (pmsg != (void *)0) {                          /* See if there is already a message             */
 793  0165 2711          	beq	L503
 794                     ; 361         pevent->OSEventPtr = (void *)0;               /* Clear the mailbox                             */
 796  0167 87            	clra	
 797  0168 c7            	clrb	
 798  0169 6c41          	std	1,y
 799                     ; 362         OS_EXIT_CRITICAL();
 801  016b e682          	ldab	OFST-1,s
 802  016d 160000        	jsr	_OS_CPU_SR_Restore
 804                     ; 363         *perr = OS_ERR_NONE;
 806  0170 69f3000b      	clr	[OFST+8,s]
 807                     ; 365         return (pmsg);                                /* Return the message received (or NULL)         */
 810  0174 ec80          	ldd	OFST-3,s
 812  0176 20cd          	bra	L22
 813  0178               L503:
 814                     ; 367     OSTCBCur->OSTCBStat     |= OS_STAT_MBOX;          /* Message not available, task will pend         */
 816  0178 fd0000        	ldy	_OSTCBCur
 817  017b 0ce82202      	bset	34,y,2
 818                     ; 368     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
 820  017f 69e823        	clr	35,y
 821                     ; 369     OSTCBCur->OSTCBDly       = timeout;               /* Load timeout in TCB                           */
 823  0182 ec89          	ldd	OFST+6,s
 824  0184 6ce820        	std	32,y
 825  0187 ec87          	ldd	OFST+4,s
 826  0189 6ce81e        	std	30,y
 827                     ; 370     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
 829  018c ec83          	ldd	OFST+0,s
 830  018e 160000        	jsr	_OS_EventTaskWait
 832                     ; 371     OS_EXIT_CRITICAL();
 834  0191 e682          	ldab	OFST-1,s
 835  0193 87            	clra	
 836  0194 160000        	jsr	_OS_CPU_SR_Restore
 838                     ; 372     OS_Sched();                                       /* Find next highest priority task ready to run  */
 840  0197 160000        	jsr	_OS_Sched
 842                     ; 373     OS_ENTER_CRITICAL();
 844  019a 160000        	jsr	_OS_CPU_SR_Save
 846  019d 6b82          	stab	OFST-1,s
 847                     ; 374     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
 849  019f fd0000        	ldy	_OSTCBCur
 850  01a2 e6e823        	ldab	35,y
 852  01a5 2708          	beq	L332
 853  01a7 040117        	dbeq	b,L732
 854  01aa 04010d        	dbeq	b,L532
 855  01ad 2012          	bra	L732
 856  01af               L332:
 857                     ; 375         case OS_STAT_PEND_OK:
 857                     ; 376              pmsg =  OSTCBCur->OSTCBMsg;
 859  01af ece818        	ldd	24,y
 860  01b2 6c80          	std	OFST-3,s
 861                     ; 377             *perr =  OS_ERR_NONE;
 863  01b4 69f3000b      	clr	[OFST+8,s]
 864                     ; 378              break;
 866  01b8 201e          	bra	L113
 867  01ba               L532:
 868                     ; 380         case OS_STAT_PEND_ABORT:
 868                     ; 381              pmsg = (void *)0;
 870  01ba 87            	clra	
 871  01bb 6c80          	std	OFST-3,s
 872                     ; 382             *perr =  OS_ERR_PEND_ABORT;               /* Indicate that we aborted                      */
 874  01bd c60e          	ldab	#14
 875                     ; 383              break;
 877  01bf 2010          	bra	LC005
 878  01c1               L732:
 879                     ; 385         case OS_STAT_PEND_TO:
 879                     ; 386         default:
 879                     ; 387              OS_EventTaskRemove(OSTCBCur, pevent);
 881  01c1 ec83          	ldd	OFST+0,s
 882  01c3 3b            	pshd	
 883  01c4 b764          	tfr	y,d
 884  01c6 160000        	jsr	_OS_EventTaskRemove
 886  01c9 1b82          	leas	2,s
 887                     ; 388              pmsg = (void *)0;
 889  01cb 87            	clra	
 890  01cc c7            	clrb	
 891  01cd 6c80          	std	OFST-3,s
 892                     ; 389             *perr =  OS_ERR_TIMEOUT;                  /* Indicate that we didn't get event within TO   */
 894  01cf c60a          	ldab	#10
 895  01d1               LC005:
 896  01d1 6bf3000b      	stab	[OFST+8,s]
 897                     ; 390              break;
 899  01d5 fd0000        	ldy	_OSTCBCur
 900  01d8               L113:
 901                     ; 392     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
 903  01d8 c7            	clrb	
 904  01d9 6be822        	stab	34,y
 905                     ; 393     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
 907  01dc 87            	clra	
 908  01dd 6ae823        	staa	35,y
 909                     ; 394     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
 911  01e0 6ce812        	std	18,y
 912                     ; 396     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
 914  01e3 6ce814        	std	20,y
 915                     ; 397     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
 917  01e6 6ce816        	std	22,y
 918                     ; 399     OSTCBCur->OSTCBMsg           = (void      *)0;    /* Clear  received message                       */
 920  01e9 6ce818        	std	24,y
 921                     ; 400     OS_EXIT_CRITICAL();
 923  01ec e682          	ldab	OFST-1,s
 924  01ee 160000        	jsr	_OS_CPU_SR_Restore
 926                     ; 403     return (pmsg);                                    /* Return received message                       */
 929  01f1 ec80          	ldd	OFST-3,s
 932  01f3 1b85          	leas	5,s
 933  01f5 3d            	rts	
1004                     ; 440 _NEAR INT8U  OSMboxPendAbort (OS_EVENT  *pevent,
1004                     ; 441                              INT8U      opt,
1004                     ; 442                              INT8U     *perr)
1004                     ; 443 {
1005                     	switch	.text
1006  01f6               _OSMboxPendAbort:
1008  01f6 3b            	pshd	
1009       00000002      OFST:	set	2
1012                     ; 446     OS_CPU_SR  cpu_sr = 0u;
1014                     ; 459     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
1016  01f7 6cae          	std	2,-s
1017  01f9 2604          	bne	L153
1018                     ; 460         *perr = OS_ERR_PEVENT_NULL;
1020  01fb c604          	ldab	#4
1021                     ; 461         return (0u);
1024  01fd 2009          	bra	LC006
1025  01ff               L153:
1026                     ; 464     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
1028  01ff e6f30002      	ldab	[OFST+0,s]
1029  0203 04010a        	dbeq	b,L353
1030                     ; 465         *perr = OS_ERR_EVENT_TYPE;
1032  0206 c601          	ldab	#1
1033                     ; 466         return (0u);
1035  0208               LC006:
1036  0208 6bf30008      	stab	[OFST+6,s]
1037  020c c7            	clrb	
1039  020d               L62:
1041  020d 1b84          	leas	4,s
1042  020f 3d            	rts	
1043  0210               L353:
1044                     ; 468     OS_ENTER_CRITICAL();
1046  0210 160000        	jsr	_OS_CPU_SR_Save
1048  0213 6b81          	stab	OFST-1,s
1049                     ; 469     if (pevent->OSEventGrp != 0u) {                        /* See if any task waiting on mailbox?      */
1051  0215 ed82          	ldy	OFST+0,s
1052  0217 e745          	tst	5,y
1053  0219 2746          	beq	L553
1054                     ; 470         nbr_tasks = 0u;
1056  021b 6980          	clr	OFST-2,s
1057                     ; 471         switch (opt) {
1059  021d e687          	ldab	OFST+5,s
1061  021f 271d          	beq	L513
1062  0221 040114        	dbeq	b,L563
1063  0224 2018          	bra	L513
1064  0226               L363:
1065                     ; 474                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
1067  0226 cc0002        	ldd	#2
1068  0229 3b            	pshd	
1069  022a 3b            	pshd	
1070  022b c7            	clrb	
1071  022c 3b            	pshd	
1072  022d ec88          	ldd	OFST+6,s
1073  022f 160000        	jsr	_OS_EventTaskRdy
1075  0232 1b86          	leas	6,s
1076                     ; 475                      nbr_tasks++;
1078  0234 6280          	inc	OFST-2,s
1079  0236 ed82          	ldy	OFST+0,s
1080  0238               L563:
1081                     ; 472             case OS_PEND_OPT_BROADCAST:                    /* Do we need to abort ALL waiting tasks?   */
1081                     ; 473                  while (pevent->OSEventGrp != 0u) {        /* Yes, ready ALL tasks waiting on mailbox  */
1083  0238 e645          	ldab	5,y
1084  023a 26ea          	bne	L363
1085                     ; 477                  break;
1087  023c 2010          	bra	L163
1088  023e               L513:
1089                     ; 479             case OS_PEND_OPT_NONE:
1089                     ; 480             default:                                       /* No,  ready HPT       waiting on mailbox  */
1089                     ; 481                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MBOX, OS_STAT_PEND_ABORT);
1091  023e cc0002        	ldd	#2
1092  0241 3b            	pshd	
1093  0242 3b            	pshd	
1094  0243 c7            	clrb	
1095  0244 3b            	pshd	
1096  0245 b764          	tfr	y,d
1097  0247 160000        	jsr	_OS_EventTaskRdy
1099  024a 1b86          	leas	6,s
1100                     ; 482                  nbr_tasks++;
1102  024c 6280          	inc	OFST-2,s
1103                     ; 483                  break;
1105  024e               L163:
1106                     ; 485         OS_EXIT_CRITICAL();
1108  024e e681          	ldab	OFST-1,s
1109  0250 87            	clra	
1110  0251 160000        	jsr	_OS_CPU_SR_Restore
1112                     ; 486         OS_Sched();                                        /* Find HPT ready to run                    */
1114  0254 160000        	jsr	_OS_Sched
1116                     ; 487         *perr = OS_ERR_PEND_ABORT;
1118  0257 c60e          	ldab	#14
1119  0259 6bf30008      	stab	[OFST+6,s]
1120                     ; 488         return (nbr_tasks);
1122  025d e680          	ldab	OFST-2,s
1124  025f 20ac          	bra	L62
1125  0261               L553:
1126                     ; 490     OS_EXIT_CRITICAL();
1128  0261 87            	clra	
1129  0262 160000        	jsr	_OS_CPU_SR_Restore
1131                     ; 491     *perr = OS_ERR_NONE;
1133  0265 c7            	clrb	
1134  0266 6bf30008      	stab	[OFST+6,s]
1135                     ; 492     return (0u);                                           /* No tasks waiting on mailbox              */
1138  026a 20a1          	bra	L62
1195                     ; 520 _NEAR INT8U  OSMboxPost (OS_EVENT  *pevent,
1195                     ; 521                         void      *pmsg)
1195                     ; 522 {
1196                     	switch	.text
1197  026c               _OSMboxPost:
1199  026c 3b            	pshd	
1200  026d 37            	pshb	
1201       00000001      OFST:	set	1
1204                     ; 524     OS_CPU_SR  cpu_sr = 0u;
1206                     ; 530     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
1208  026e 046404        	tbne	d,L714
1209                     ; 531         return (OS_ERR_PEVENT_NULL);
1211  0271 c604          	ldab	#4
1213  0273 2006          	bra	L23
1214  0275               L714:
1215                     ; 533     if (pmsg == (void *)0) {                          /* Make sure we are not posting a NULL pointer   */
1217  0275 ec85          	ldd	OFST+4,s
1218  0277 2605          	bne	L124
1219                     ; 534         return (OS_ERR_POST_NULL_PTR);
1221  0279 c603          	ldab	#3
1223  027b               L23:
1225  027b 1b83          	leas	3,s
1226  027d 3d            	rts	
1227  027e               L124:
1228                     ; 540     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
1231  027e e6f30001      	ldab	[OFST+0,s]
1232  0282 040104        	dbeq	b,L324
1233                     ; 542         return (OS_ERR_EVENT_TYPE);
1236  0285 c601          	ldab	#1
1238  0287 20f2          	bra	L23
1239  0289               L324:
1240                     ; 544     OS_ENTER_CRITICAL();
1242  0289 160000        	jsr	_OS_CPU_SR_Save
1244  028c 6b80          	stab	OFST-1,s
1245                     ; 545     if (pevent->OSEventGrp != 0u) {                   /* See if any task pending on mailbox            */
1247  028e ed81          	ldy	OFST+0,s
1248  0290 e645          	ldab	5,y
1249  0292 271b          	beq	L524
1250                     ; 547         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
1252  0294 87            	clra	
1253  0295 c7            	clrb	
1254  0296 3b            	pshd	
1255  0297 c602          	ldab	#2
1256  0299 3b            	pshd	
1257  029a ec89          	ldd	OFST+8,s
1258  029c 3b            	pshd	
1259  029d b764          	tfr	y,d
1260  029f 160000        	jsr	_OS_EventTaskRdy
1262  02a2 1b86          	leas	6,s
1263                     ; 548         OS_EXIT_CRITICAL();
1265  02a4 e680          	ldab	OFST-1,s
1266  02a6 87            	clra	
1267  02a7 160000        	jsr	_OS_CPU_SR_Restore
1269                     ; 549         OS_Sched();                                   /* Find highest priority task ready to run       */
1271  02aa 160000        	jsr	_OS_Sched
1273                     ; 551         return (OS_ERR_NONE);
1277  02ad 2017          	bra	LC007
1278  02af               L524:
1279                     ; 553     if (pevent->OSEventPtr != (void *)0) {            /* Make sure mailbox doesn't already have a msg  */
1281  02af ec41          	ldd	1,y
1282  02b1 270a          	beq	L724
1283                     ; 554         OS_EXIT_CRITICAL();
1285  02b3 e680          	ldab	OFST-1,s
1286  02b5 87            	clra	
1287  02b6 160000        	jsr	_OS_CPU_SR_Restore
1289                     ; 556         return (OS_ERR_MBOX_FULL);
1292  02b9 c614          	ldab	#20
1294  02bb 20be          	bra	L23
1295  02bd               L724:
1296                     ; 558     pevent->OSEventPtr = pmsg;                        /* Place message in mailbox                      */
1298  02bd 18028541      	movw	OFST+4,s,1,y
1299                     ; 559     OS_EXIT_CRITICAL();
1301  02c1 e680          	ldab	OFST-1,s
1302  02c3 160000        	jsr	_OS_CPU_SR_Restore
1304                     ; 561     return (OS_ERR_NONE);
1307  02c6               LC007:
1308  02c6 c7            	clrb	
1310  02c7 20b2          	bra	L23
1374                     ; 599 _NEAR INT8U  OSMboxPostOpt (OS_EVENT  *pevent,
1374                     ; 600                            void      *pmsg,
1374                     ; 601                            INT8U      opt)
1374                     ; 602 {
1375                     	switch	.text
1376  02c9               _OSMboxPostOpt:
1378  02c9 3b            	pshd	
1379  02ca 37            	pshb	
1380       00000001      OFST:	set	1
1383                     ; 604     OS_CPU_SR  cpu_sr = 0u;
1385                     ; 610     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
1387  02cb 046404        	tbne	d,L164
1388                     ; 611         return (OS_ERR_PEVENT_NULL);
1390  02ce c604          	ldab	#4
1392  02d0 2006          	bra	L63
1393  02d2               L164:
1394                     ; 613     if (pmsg == (void *)0) {                          /* Make sure we are not posting a NULL pointer   */
1396  02d2 ec85          	ldd	OFST+4,s
1397  02d4 2605          	bne	L364
1398                     ; 614         return (OS_ERR_POST_NULL_PTR);
1400  02d6 c603          	ldab	#3
1402  02d8               L63:
1404  02d8 1b83          	leas	3,s
1405  02da 3d            	rts	
1406  02db               L364:
1407                     ; 620     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {  /* Validate event block type                     */
1410  02db e6f30001      	ldab	[OFST+0,s]
1411  02df 040104        	dbeq	b,L564
1412                     ; 622         return (OS_ERR_EVENT_TYPE);
1415  02e2 c601          	ldab	#1
1417  02e4 20f2          	bra	L63
1418  02e6               L564:
1419                     ; 624     OS_ENTER_CRITICAL();
1421  02e6 160000        	jsr	_OS_CPU_SR_Save
1423  02e9 6b80          	stab	OFST-1,s
1424                     ; 625     if (pevent->OSEventGrp != 0u) {                   /* See if any task pending on mailbox            */
1426  02eb ed81          	ldy	OFST+0,s
1427  02ed e645          	ldab	5,y
1428  02ef 273e          	beq	L764
1429                     ; 626         if ((opt & OS_POST_OPT_BROADCAST) != 0x00u) { /* Do we need to post msg to ALL waiting tasks ? */
1431  02f1 0f88011a      	brclr	OFST+7,s,1,L174
1433  02f5 2014          	bra	L574
1434  02f7               L374:
1435                     ; 628                 (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
1437  02f7 87            	clra	
1438  02f8 c7            	clrb	
1439  02f9 3b            	pshd	
1440  02fa c602          	ldab	#2
1441  02fc 3b            	pshd	
1442  02fd ec89          	ldd	OFST+8,s
1443  02ff 3b            	pshd	
1444  0300 ec87          	ldd	OFST+6,s
1445  0302 160000        	jsr	_OS_EventTaskRdy
1447  0305 1b86          	leas	6,s
1448  0307 ed81          	ldy	OFST+0,s
1449  0309 e645          	ldab	5,y
1450  030b               L574:
1451                     ; 627             while (pevent->OSEventGrp != 0u) {        /* Yes, Post to ALL tasks waiting on mailbox     */
1453  030b 26ea          	bne	L374
1455  030d 2010          	bra	L105
1456  030f               L174:
1457                     ; 631             (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_MBOX, OS_STAT_PEND_OK);
1459  030f 87            	clra	
1460  0310 c7            	clrb	
1461  0311 3b            	pshd	
1462  0312 c602          	ldab	#2
1463  0314 3b            	pshd	
1464  0315 ec89          	ldd	OFST+8,s
1465  0317 3b            	pshd	
1466  0318 b764          	tfr	y,d
1467  031a 160000        	jsr	_OS_EventTaskRdy
1469  031d 1b86          	leas	6,s
1470  031f               L105:
1471                     ; 633         OS_EXIT_CRITICAL();
1473  031f e680          	ldab	OFST-1,s
1474  0321 87            	clra	
1475  0322 160000        	jsr	_OS_CPU_SR_Restore
1477                     ; 634         if ((opt & OS_POST_OPT_NO_SCHED) == 0u) {     /* See if scheduler needs to be invoked          */
1479  0325 0e880403      	brset	OFST+7,s,4,L305
1480                     ; 635             OS_Sched();                               /* Find HPT ready to run                         */
1482  0329 160000        	jsr	_OS_Sched
1484  032c               L305:
1485                     ; 638         return (OS_ERR_NONE);
1488  032c c7            	clrb	
1490  032d 20a9          	bra	L63
1491  032f               L764:
1492                     ; 640     if (pevent->OSEventPtr != (void *)0) {            /* Make sure mailbox doesn't already have a msg  */
1494  032f ec41          	ldd	1,y
1495  0331 270a          	beq	L505
1496                     ; 641         OS_EXIT_CRITICAL();
1498  0333 e680          	ldab	OFST-1,s
1499  0335 87            	clra	
1500  0336 160000        	jsr	_OS_CPU_SR_Restore
1502                     ; 643         return (OS_ERR_MBOX_FULL);
1505  0339 c614          	ldab	#20
1507  033b 200a          	bra	L04
1508  033d               L505:
1509                     ; 645     pevent->OSEventPtr = pmsg;                        /* Place message in mailbox                      */
1511  033d 18028541      	movw	OFST+4,s,1,y
1512                     ; 646     OS_EXIT_CRITICAL();
1514  0341 e680          	ldab	OFST-1,s
1515  0343 160000        	jsr	_OS_CPU_SR_Restore
1517                     ; 648     return (OS_ERR_NONE);
1520  0346 c7            	clrb	
1522  0347               L04:
1524  0347 1b83          	leas	3,s
1525  0349 3d            	rts	
1643                     ; 672 _NEAR INT8U  OSMboxQuery (OS_EVENT      *pevent,
1643                     ; 673                          OS_MBOX_DATA  *p_mbox_data)
1643                     ; 674 {
1644                     	switch	.text
1645  034a               _OSMboxQuery:
1647  034a 3b            	pshd	
1648  034b 1b9a          	leas	-6,s
1649       00000006      OFST:	set	6
1652                     ; 679     OS_CPU_SR   cpu_sr = 0u;
1654                     ; 685     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
1656  034d 046404        	tbne	d,L765
1657                     ; 686         return (OS_ERR_PEVENT_NULL);
1659  0350 c604          	ldab	#4
1661  0352 2006          	bra	L44
1662  0354               L765:
1663                     ; 688     if (p_mbox_data == (OS_MBOX_DATA *)0) {                /* Validate 'p_mbox_data'                   */
1665  0354 ec8a          	ldd	OFST+4,s
1666  0356 2605          	bne	L175
1667                     ; 689         return (OS_ERR_PDATA_NULL);
1669  0358 c609          	ldab	#9
1671  035a               L44:
1673  035a 1b88          	leas	8,s
1674  035c 3d            	rts	
1675  035d               L175:
1676                     ; 692     if (pevent->OSEventType != OS_EVENT_TYPE_MBOX) {       /* Validate event block type                */
1678  035d e6f30006      	ldab	[OFST+0,s]
1679  0361 040104        	dbeq	b,L375
1680                     ; 693         return (OS_ERR_EVENT_TYPE);
1682  0364 c601          	ldab	#1
1684  0366 20f2          	bra	L44
1685  0368               L375:
1686                     ; 695     OS_ENTER_CRITICAL();
1688  0368 160000        	jsr	_OS_CPU_SR_Save
1690  036b 6b85          	stab	OFST-1,s
1691                     ; 696     p_mbox_data->OSEventGrp = pevent->OSEventGrp;          /* Copy message mailbox wait list           */
1693  036d ed8a          	ldy	OFST+4,s
1694  036f ee86          	ldx	OFST+0,s
1695  0371 180a054a      	movb	5,x,10,y
1696                     ; 697     psrc                    = &pevent->OSEventTbl[0];
1698  0375 ed86          	ldy	OFST+0,s
1699  0377 1946          	leay	6,y
1700  0379 6d81          	sty	OFST-5,s
1701                     ; 698     pdest                   = &p_mbox_data->OSEventTbl[0];
1703  037b ed8a          	ldy	OFST+4,s
1704  037d 1942          	leay	2,y
1705  037f 6d83          	sty	OFST-3,s
1706                     ; 699     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
1708  0381 6980          	clr	OFST-6,s
1709  0383 ee81          	ldx	OFST-5,s
1710  0385               L575:
1711                     ; 700         *pdest++ = *psrc++;
1713  0385 180a3070      	movb	1,x+,1,y+
1714                     ; 699     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
1716  0389 6280          	inc	OFST-6,s
1719  038b e680          	ldab	OFST-6,s
1720  038d c108          	cmpb	#8
1721  038f 25f4          	blo	L575
1722  0391 6e81          	stx	OFST-5,s
1723  0393 6d83          	sty	OFST-3,s
1724                     ; 702     p_mbox_data->OSMsg = pevent->OSEventPtr;               /* Get message from mailbox                 */
1726  0395 ed86          	ldy	OFST+0,s
1727  0397 ec41          	ldd	1,y
1728  0399 6cf3000a      	std	[OFST+4,s]
1729                     ; 703     OS_EXIT_CRITICAL();
1731  039d e685          	ldab	OFST-1,s
1732  039f 87            	clra	
1733  03a0 160000        	jsr	_OS_CPU_SR_Restore
1735                     ; 704     return (OS_ERR_NONE);
1737  03a3 c7            	clrb	
1739  03a4 20b4          	bra	L44
1751                     	xref	_OS_Sched
1752                     	xref	_OS_EventWaitListInit
1753                     	xref	_OS_EventTaskRemove
1754                     	xref	_OS_EventTaskWait
1755                     	xref	_OS_EventTaskRdy
1756                     	xdef	_OSMboxQuery
1757                     	xdef	_OSMboxPostOpt
1758                     	xdef	_OSMboxPost
1759                     	xdef	_OSMboxPendAbort
1760                     	xdef	_OSMboxPend
1761                     	xdef	_OSMboxDel
1762                     	xdef	_OSMboxCreate
1763                     	xdef	_OSMboxAccept
1764                     	xref	_OSTCBCur
1765                     	xref	_OSLockNesting
1766                     	xref	_OSIntNesting
1767                     	xref	_OSEventFreeList
1768                     	xref	_OS_CPU_SR_Restore
1769                     	xref	_OS_CPU_SR_Save
1770                     .const:	section	.data
1771  0000               L721:
1772  0000 3f00          	dc.b	"?",0
1793                     	end

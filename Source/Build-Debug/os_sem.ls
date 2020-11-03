   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 130                     ; 57 _NEAR INT16U  OSSemAccept (OS_EVENT *pevent)
 130                     ; 58 {
 131                     	switch	.text
 132  0000               _OSSemAccept:
 134  0000 3b            	pshd	
 135  0001 1b9d          	leas	-3,s
 136       00000003      OFST:	set	3
 139                     ; 61     OS_CPU_SR  cpu_sr = 0u;
 141                     ; 67     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
 143  0003 046402        	tbne	d,L36
 144                     ; 68         return (0u);
 147  0006 2008          	bra	LC001
 148  0008               L36:
 149                     ; 71     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
 151  0008 e6f30003      	ldab	[OFST+0,s]
 152  000c c103          	cmpb	#3
 153  000e 2705          	beq	L56
 154                     ; 72         return (0u);
 156  0010               LC001:
 157  0010 87            	clra	
 158  0011 c7            	clrb	
 160  0012               L6:
 162  0012 1b85          	leas	5,s
 163  0014 3d            	rts	
 164  0015               L56:
 165                     ; 74     OS_ENTER_CRITICAL();
 167  0015 160000        	jsr	_OS_CPU_SR_Save
 169  0018 6b82          	stab	OFST-1,s
 170                     ; 75     cnt = pevent->OSEventCnt;
 172  001a ed83          	ldy	OFST+0,s
 173  001c ee43          	ldx	3,y
 174  001e 6e80          	stx	OFST-3,s
 175                     ; 76     if (cnt > 0u) {                                   /* See if resource is available                  */
 177  0020 2703          	beq	L76
 178                     ; 77         pevent->OSEventCnt--;                         /* Yes, decrement semaphore and notify caller    */
 180  0022 09            	dex	
 181  0023 6e43          	stx	3,y
 182  0025               L76:
 183                     ; 79     OS_EXIT_CRITICAL();
 185  0025 87            	clra	
 186  0026 160000        	jsr	_OS_CPU_SR_Restore
 188                     ; 80     return (cnt);                                     /* Return semaphore count                        */
 190  0029 ec80          	ldd	OFST-3,s
 192  002b 20e5          	bra	L6
 250                     ; 102 _NEAR OS_EVENT  *OSSemCreate (INT16U cnt)
 250                     ; 103 {
 251                     	switch	.text
 252  002d               _OSSemCreate:
 254  002d 3b            	pshd	
 255  002e 1b9d          	leas	-3,s
 256       00000003      OFST:	set	3
 259                     ; 106     OS_CPU_SR  cpu_sr = 0u;
 261                     ; 117     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 263  0030 f60000        	ldab	_OSIntNesting
 264  0033 2704          	beq	L711
 265                     ; 118         return ((OS_EVENT *)0);                            /* ... can't CREATE from an ISR             */
 267  0035 87            	clra	
 268  0036 c7            	clrb	
 270  0037 2031          	bra	L21
 271  0039               L711:
 272                     ; 120     OS_ENTER_CRITICAL();
 274  0039 160000        	jsr	_OS_CPU_SR_Save
 276  003c 6b82          	stab	OFST-1,s
 277                     ; 121     pevent = OSEventFreeList;                              /* Get next free event control block        */
 279  003e fd0000        	ldy	_OSEventFreeList
 280  0041 6d80          	sty	OFST-3,s
 281                     ; 122     if (OSEventFreeList != (OS_EVENT *)0) {                /* See if pool of free ECB pool was empty   */
 283  0043 2705          	beq	L121
 284                     ; 123         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
 286  0045 1805410000    	movw	1,y,_OSEventFreeList
 287  004a               L121:
 288                     ; 125     OS_EXIT_CRITICAL();
 290  004a 87            	clra	
 291  004b 160000        	jsr	_OS_CPU_SR_Restore
 293                     ; 126     if (pevent != (OS_EVENT *)0) {                         /* Get an event control block               */
 295  004e ed80          	ldy	OFST-3,s
 296  0050 2716          	beq	L321
 297                     ; 127         pevent->OSEventType    = OS_EVENT_TYPE_SEM;
 299  0052 c603          	ldab	#3
 300  0054 6b40          	stab	0,y
 301                     ; 128         pevent->OSEventCnt     = cnt;                      /* Set semaphore value                      */
 303  0056 18028343      	movw	OFST+0,s,3,y
 304                     ; 129         pevent->OSEventPtr     = (void *)0;                /* Unlink from ECB free list                */
 306  005a 87            	clra	
 307  005b c7            	clrb	
 308  005c 6c41          	std	1,y
 309                     ; 131         pevent->OSEventName    = (INT8U *)(void *)"?";
 311  005e cc0000        	ldd	#L521
 312  0061 6c4e          	std	14,y
 313                     ; 133         OS_EventWaitListInit(pevent);                      /* Initialize to 'nobody waiting' on sem.   */
 315  0063 b764          	tfr	y,d
 316  0065 160000        	jsr	_OS_EventWaitListInit
 319  0068               L321:
 320                     ; 137     return (pevent);
 322  0068 ec80          	ldd	OFST-3,s
 324  006a               L21:
 326  006a 1b85          	leas	5,s
 327  006c 3d            	rts	
 415                     ; 185 _NEAR OS_EVENT  *OSSemDel (OS_EVENT  *pevent,
 415                     ; 186                           INT8U      opt,
 415                     ; 187                           INT8U     *perr)
 415                     ; 188 {
 416                     	switch	.text
 417  006d               _OSSemDel:
 419  006d 3b            	pshd	
 420  006e 1b9c          	leas	-4,s
 421       00000004      OFST:	set	4
 424                     ; 192     OS_CPU_SR  cpu_sr = 0u;
 426                     ; 212     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
 428  0070 046404        	tbne	d,L771
 429                     ; 213         *perr = OS_ERR_PEVENT_NULL;
 431  0073 c604          	ldab	#4
 432                     ; 214         return (pevent);
 435  0075 200a          	bra	L61
 436  0077               L771:
 437                     ; 220     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {        /* Validate event block type                */
 440  0077 e6f30004      	ldab	[OFST+0,s]
 441  007b c103          	cmpb	#3
 442  007d 270b          	beq	L102
 443                     ; 221         *perr = OS_ERR_EVENT_TYPE;
 445  007f c601          	ldab	#1
 446                     ; 223         return (pevent);
 450  0081               L61:
 451  0081 6bf3000a      	stab	[OFST+6,s]
 452  0085 ec84          	ldd	OFST+0,s
 454  0087 1b86          	leas	6,s
 455  0089 3d            	rts	
 456  008a               L102:
 457                     ; 225     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 459  008a f60000        	ldab	_OSIntNesting
 460  008d 2704          	beq	L302
 461                     ; 226         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
 463  008f c60f          	ldab	#15
 464                     ; 228         return (pevent);
 468  0091 20ee          	bra	L61
 469  0093               L302:
 470                     ; 230     OS_ENTER_CRITICAL();
 472  0093 160000        	jsr	_OS_CPU_SR_Save
 474  0096 6b80          	stab	OFST-4,s
 475                     ; 231     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on semaphore    */
 477  0098 ed84          	ldy	OFST+0,s
 478  009a e645          	ldab	5,y
 479  009c 2706          	beq	L502
 480                     ; 232         tasks_waiting = OS_TRUE;                           /* Yes                                      */
 482  009e c601          	ldab	#1
 483  00a0 6b83          	stab	OFST-1,s
 485  00a2 2002          	bra	L702
 486  00a4               L502:
 487                     ; 234         tasks_waiting = OS_FALSE;                          /* No                                       */
 489  00a4 6983          	clr	OFST-1,s
 490  00a6               L702:
 491                     ; 236     switch (opt) {
 493  00a6 e689          	ldab	OFST+5,s
 495  00a8 270d          	beq	L721
 496  00aa 040153        	dbeq	b,L322
 497                     ; 275         default:
 497                     ; 276              OS_EXIT_CRITICAL();
 499  00ad e680          	ldab	OFST-4,s
 500  00af 87            	clra	
 501  00b0 160000        	jsr	_OS_CPU_SR_Restore
 503                     ; 277              *perr                  = OS_ERR_INVALID_OPT;
 505  00b3 c607          	ldab	#7
 506                     ; 278              pevent_return          = pevent;
 508                     ; 279              break;
 510  00b5 202e          	bra	LC003
 511  00b7               L721:
 512                     ; 237         case OS_DEL_NO_PEND:                               /* Delete semaphore only if no task waiting */
 512                     ; 238              if (tasks_waiting == OS_FALSE) {
 514  00b7 e683          	ldab	OFST-1,s
 515  00b9 2622          	bne	L512
 516                     ; 240                  pevent->OSEventName    = (INT8U *)(void *)"?";
 518  00bb cc0000        	ldd	#L521
 519  00be 6c4e          	std	14,y
 520                     ; 242                  pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
 522  00c0 87            	clra	
 523  00c1 6a40          	staa	0,y
 524                     ; 243                  pevent->OSEventPtr     = OSEventFreeList; /* Return Event Control Block to free list  */
 526  00c3 1801410000    	movw	_OSEventFreeList,1,y
 527                     ; 244                  pevent->OSEventCnt     = 0u;
 529  00c8 c7            	clrb	
 530  00c9 6c43          	std	3,y
 531                     ; 245                  OSEventFreeList        = pevent;          /* Get next free event control block        */
 533  00cb 1805840000    	movw	OFST+0,s,_OSEventFreeList
 534                     ; 246                  OS_EXIT_CRITICAL();
 536  00d0 e680          	ldab	OFST-4,s
 537  00d2 160000        	jsr	_OS_CPU_SR_Restore
 539                     ; 247                  *perr                  = OS_ERR_NONE;
 541  00d5 87            	clra	
 542  00d6 6af3000a      	staa	[OFST+6,s]
 543                     ; 248                  pevent_return          = (OS_EVENT *)0;   /* Semaphore has been deleted               */
 545  00da c7            	clrb	
 547  00db 200e          	bra	LC002
 548  00dd               L512:
 549                     ; 250                  OS_EXIT_CRITICAL();
 551  00dd e680          	ldab	OFST-4,s
 552  00df 87            	clra	
 553  00e0 160000        	jsr	_OS_CPU_SR_Restore
 555                     ; 251                  *perr                  = OS_ERR_TASK_WAITING;
 557  00e3 c649          	ldab	#73
 558                     ; 252                  pevent_return          = pevent;
 560  00e5               LC003:
 561  00e5 6bf3000a      	stab	[OFST+6,s]
 562  00e9 ec84          	ldd	OFST+0,s
 563  00eb               LC002:
 564  00eb 6c81          	std	OFST-3,s
 565  00ed 203d          	bra	L312
 566  00ef               L122:
 567                     ; 258                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
 569  00ef cc0002        	ldd	#2
 570  00f2 3b            	pshd	
 571  00f3 53            	decb	
 572  00f4 3b            	pshd	
 573  00f5 c7            	clrb	
 574  00f6 3b            	pshd	
 575  00f7 ec8a          	ldd	OFST+6,s
 576  00f9 160000        	jsr	_OS_EventTaskRdy
 578  00fc 1b86          	leas	6,s
 579  00fe ed84          	ldy	OFST+0,s
 580  0100               L322:
 581                     ; 256         case OS_DEL_ALWAYS:                                /* Always delete the semaphore              */
 581                     ; 257              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for semaphore    */
 583  0100 e645          	ldab	5,y
 584  0102 26eb          	bne	L122
 585                     ; 261              pevent->OSEventName    = (INT8U *)(void *)"?";
 587  0104 cc0000        	ldd	#L521
 588  0107 6c4e          	std	14,y
 589                     ; 263              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
 591  0109 87            	clra	
 592  010a 6a40          	staa	0,y
 593                     ; 264              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
 595  010c 1801410000    	movw	_OSEventFreeList,1,y
 596                     ; 265              pevent->OSEventCnt     = 0u;
 598  0111 c7            	clrb	
 599  0112 6c43          	std	3,y
 600                     ; 266              OSEventFreeList        = pevent;              /* Get next free event control block        */
 602  0114 1805840000    	movw	OFST+0,s,_OSEventFreeList
 603                     ; 267              OS_EXIT_CRITICAL();
 605  0119 e680          	ldab	OFST-4,s
 606  011b 160000        	jsr	_OS_CPU_SR_Restore
 608                     ; 268              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
 610  011e e683          	ldab	OFST-1,s
 611  0120 042103        	dbne	b,L722
 612                     ; 269                  OS_Sched();                               /* Find highest priority task ready to run  */
 614  0123 160000        	jsr	_OS_Sched
 616  0126               L722:
 617                     ; 271              *perr                  = OS_ERR_NONE;
 619  0126 87            	clra	
 620  0127 6af3000a      	staa	[OFST+6,s]
 621                     ; 272              pevent_return          = (OS_EVENT *)0;       /* Semaphore has been deleted               */
 623  012b c7            	clrb	
 624                     ; 273              break;
 626  012c               L312:
 627                     ; 284     return (pevent_return);
 632  012c 1b86          	leas	6,s
 633  012e 3d            	rts	
 701                     ; 321 _NEAR void  OSSemPend (OS_EVENT  *pevent,
 701                     ; 322                       INT32U     timeout,
 701                     ; 323                       INT8U     *perr)
 701                     ; 324 {
 702                     	switch	.text
 703  012f               _OSSemPend:
 705  012f 3b            	pshd	
 706  0130 37            	pshb	
 707       00000001      OFST:	set	1
 710                     ; 326     OS_CPU_SR  cpu_sr = 0u;
 712                     ; 338     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
 714  0131 046404        	tbne	d,L762
 715                     ; 339         *perr = OS_ERR_PEVENT_NULL;
 717  0134 c604          	ldab	#4
 718                     ; 340         return;
 720  0136 200a          	bra	LC004
 721  0138               L762:
 722                     ; 346     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
 725  0138 e6f30001      	ldab	[OFST+0,s]
 726  013c c103          	cmpb	#3
 727  013e 2709          	beq	L172
 728                     ; 347         *perr = OS_ERR_EVENT_TYPE;
 730  0140 c601          	ldab	#1
 731  0142               LC004:
 732  0142 6bf30009      	stab	[OFST+8,s]
 733                     ; 349         return;
 734  0146               L22:
 738  0146 1b83          	leas	3,s
 739  0148 3d            	rts	
 740  0149               L172:
 741                     ; 351     if (OSIntNesting > 0u) {                          /* See if called from ISR ...                    */
 743  0149 f60000        	ldab	_OSIntNesting
 744  014c 2704          	beq	L372
 745                     ; 352         *perr = OS_ERR_PEND_ISR;                      /* ... can't PEND from an ISR                    */
 747  014e c602          	ldab	#2
 748                     ; 354         return;
 751  0150 20f0          	bra	LC004
 752  0152               L372:
 753                     ; 356     if (OSLockNesting > 0u) {                         /* See if called with scheduler locked ...       */
 755  0152 f60000        	ldab	_OSLockNesting
 756  0155 2704          	beq	L572
 757                     ; 357         *perr = OS_ERR_PEND_LOCKED;                   /* ... can't PEND when locked                    */
 759  0157 c60d          	ldab	#13
 760                     ; 359         return;
 763  0159 20e7          	bra	LC004
 764  015b               L572:
 765                     ; 361     OS_ENTER_CRITICAL();
 767  015b 160000        	jsr	_OS_CPU_SR_Save
 769  015e 6b80          	stab	OFST-1,s
 770                     ; 362     if (pevent->OSEventCnt > 0u) {                    /* If sem. is positive, resource available ...   */
 772  0160 ed81          	ldy	OFST+0,s
 773  0162 ee43          	ldx	3,y
 774  0164 270d          	beq	L772
 775                     ; 363         pevent->OSEventCnt--;                         /* ... decrement semaphore only if positive.     */
 777  0166 09            	dex	
 778  0167 6e43          	stx	3,y
 779                     ; 364         OS_EXIT_CRITICAL();
 781  0169 87            	clra	
 782  016a 160000        	jsr	_OS_CPU_SR_Restore
 784                     ; 365         *perr = OS_ERR_NONE;
 786  016d 69f30009      	clr	[OFST+8,s]
 787                     ; 367         return;
 790  0171 20d3          	bra	L22
 791  0173               L772:
 792                     ; 370     OSTCBCur->OSTCBStat     |= OS_STAT_SEM;           /* Resource not available, pend on semaphore     */
 794  0173 fd0000        	ldy	_OSTCBCur
 795  0176 0ce82201      	bset	34,y,1
 796                     ; 371     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
 798  017a 69e823        	clr	35,y
 799                     ; 372     OSTCBCur->OSTCBDly       = timeout;               /* Store pend timeout in TCB                     */
 801  017d ec87          	ldd	OFST+6,s
 802  017f 6ce820        	std	32,y
 803  0182 ec85          	ldd	OFST+4,s
 804  0184 6ce81e        	std	30,y
 805                     ; 373     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
 807  0187 ec81          	ldd	OFST+0,s
 808  0189 160000        	jsr	_OS_EventTaskWait
 810                     ; 374     OS_EXIT_CRITICAL();
 812  018c e680          	ldab	OFST-1,s
 813  018e 87            	clra	
 814  018f 160000        	jsr	_OS_CPU_SR_Restore
 816                     ; 375     OS_Sched();                                       /* Find next highest priority task ready         */
 818  0192 160000        	jsr	_OS_Sched
 820                     ; 376     OS_ENTER_CRITICAL();
 822  0195 160000        	jsr	_OS_CPU_SR_Save
 824  0198 6b80          	stab	OFST-1,s
 825                     ; 377     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
 827  019a fd0000        	ldy	_OSTCBCur
 828  019d e6e823        	ldab	35,y
 830  01a0 2708          	beq	L132
 831  01a2 04010f        	dbeq	b,L532
 832  01a5 040108        	dbeq	b,L332
 833  01a8 200a          	bra	L532
 834  01aa               L132:
 835                     ; 378         case OS_STAT_PEND_OK:
 835                     ; 379              *perr = OS_ERR_NONE;
 837  01aa 69f30009      	clr	[OFST+8,s]
 838                     ; 380              break;
 840  01ae 2017          	bra	L303
 841  01b0               L332:
 842                     ; 382         case OS_STAT_PEND_ABORT:
 842                     ; 383              *perr = OS_ERR_PEND_ABORT;               /* Indicate that we aborted                      */
 844  01b0 c60e          	ldab	#14
 845                     ; 384              break;
 847  01b2 200c          	bra	LC005
 848  01b4               L532:
 849                     ; 386         case OS_STAT_PEND_TO:
 849                     ; 387         default:
 849                     ; 388              OS_EventTaskRemove(OSTCBCur, pevent);
 851  01b4 ec81          	ldd	OFST+0,s
 852  01b6 3b            	pshd	
 853  01b7 b764          	tfr	y,d
 854  01b9 160000        	jsr	_OS_EventTaskRemove
 856  01bc 1b82          	leas	2,s
 857                     ; 389              *perr = OS_ERR_TIMEOUT;                  /* Indicate that we didn't get event within TO   */
 859  01be c60a          	ldab	#10
 860  01c0               LC005:
 861  01c0 6bf30009      	stab	[OFST+8,s]
 862                     ; 390              break;
 864  01c4 fd0000        	ldy	_OSTCBCur
 865  01c7               L303:
 866                     ; 392     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
 868  01c7 c7            	clrb	
 869  01c8 6be822        	stab	34,y
 870                     ; 393     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
 872  01cb 87            	clra	
 873  01cc 6ae823        	staa	35,y
 874                     ; 394     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
 876  01cf 6ce812        	std	18,y
 877                     ; 396     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
 879  01d2 6ce814        	std	20,y
 880                     ; 397     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
 882  01d5 6ce816        	std	22,y
 883                     ; 399     OS_EXIT_CRITICAL();
 885  01d8 e680          	ldab	OFST-1,s
 886  01da 160000        	jsr	_OS_CPU_SR_Restore
 888                     ; 402 }
 892  01dd 1b83          	leas	3,s
 893  01df 3d            	rts	
 964                     ; 439 _NEAR INT8U  OSSemPendAbort (OS_EVENT  *pevent,
 964                     ; 440                             INT8U      opt,
 964                     ; 441                             INT8U     *perr)
 964                     ; 442 {
 965                     	switch	.text
 966  01e0               _OSSemPendAbort:
 968  01e0 3b            	pshd	
 969       00000002      OFST:	set	2
 972                     ; 445     OS_CPU_SR  cpu_sr = 0u;
 974                     ; 457     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
 976  01e1 6cae          	std	2,-s
 977  01e3 2604          	bne	L343
 978                     ; 458         *perr = OS_ERR_PEVENT_NULL;
 980  01e5 c604          	ldab	#4
 981                     ; 459         return (0u);
 984  01e7 200a          	bra	LC006
 985  01e9               L343:
 986                     ; 462     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
 988  01e9 e6f30002      	ldab	[OFST+0,s]
 989  01ed c103          	cmpb	#3
 990  01ef 270a          	beq	L543
 991                     ; 463         *perr = OS_ERR_EVENT_TYPE;
 993  01f1 c601          	ldab	#1
 994                     ; 464         return (0u);
 996  01f3               LC006:
 997  01f3 6bf30008      	stab	[OFST+6,s]
 998  01f7 c7            	clrb	
1000  01f8               L62:
1002  01f8 1b84          	leas	4,s
1003  01fa 3d            	rts	
1004  01fb               L543:
1005                     ; 466     OS_ENTER_CRITICAL();
1007  01fb 160000        	jsr	_OS_CPU_SR_Save
1009  01fe 6b81          	stab	OFST-1,s
1010                     ; 467     if (pevent->OSEventGrp != 0u) {                   /* See if any task waiting on semaphore?         */
1012  0200 ed82          	ldy	OFST+0,s
1013  0202 e745          	tst	5,y
1014  0204 2748          	beq	L743
1015                     ; 468         nbr_tasks = 0u;
1017  0206 6980          	clr	OFST-2,s
1018                     ; 469         switch (opt) {
1020  0208 e687          	ldab	OFST+5,s
1022  020a 271e          	beq	L703
1023  020c 040115        	dbeq	b,L753
1024  020f 2019          	bra	L703
1025  0211               L553:
1026                     ; 472                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
1028  0211 cc0002        	ldd	#2
1029  0214 3b            	pshd	
1030  0215 53            	decb	
1031  0216 3b            	pshd	
1032  0217 c7            	clrb	
1033  0218 3b            	pshd	
1034  0219 ec88          	ldd	OFST+6,s
1035  021b 160000        	jsr	_OS_EventTaskRdy
1037  021e 1b86          	leas	6,s
1038                     ; 473                      nbr_tasks++;
1040  0220 6280          	inc	OFST-2,s
1041  0222 ed82          	ldy	OFST+0,s
1042  0224               L753:
1043                     ; 470             case OS_PEND_OPT_BROADCAST:               /* Do we need to abort ALL waiting tasks?        */
1043                     ; 471                  while (pevent->OSEventGrp != 0u) {   /* Yes, ready ALL tasks waiting on semaphore     */
1045  0224 e645          	ldab	5,y
1046  0226 26e9          	bne	L553
1047                     ; 475                  break;
1049  0228 2011          	bra	L353
1050  022a               L703:
1051                     ; 477             case OS_PEND_OPT_NONE:
1051                     ; 478             default:                                  /* No,  ready HPT       waiting on semaphore     */
1051                     ; 479                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_ABORT);
1053  022a cc0002        	ldd	#2
1054  022d 3b            	pshd	
1055  022e 53            	decb	
1056  022f 3b            	pshd	
1057  0230 c7            	clrb	
1058  0231 3b            	pshd	
1059  0232 b764          	tfr	y,d
1060  0234 160000        	jsr	_OS_EventTaskRdy
1062  0237 1b86          	leas	6,s
1063                     ; 480                  nbr_tasks++;
1065  0239 6280          	inc	OFST-2,s
1066                     ; 481                  break;
1068  023b               L353:
1069                     ; 483         OS_EXIT_CRITICAL();
1071  023b e681          	ldab	OFST-1,s
1072  023d 87            	clra	
1073  023e 160000        	jsr	_OS_CPU_SR_Restore
1075                     ; 484         OS_Sched();                                   /* Find HPT ready to run                         */
1077  0241 160000        	jsr	_OS_Sched
1079                     ; 485         *perr = OS_ERR_PEND_ABORT;
1081  0244 c60e          	ldab	#14
1082  0246 6bf30008      	stab	[OFST+6,s]
1083                     ; 486         return (nbr_tasks);
1085  024a e680          	ldab	OFST-2,s
1087  024c 20aa          	bra	L62
1088  024e               L743:
1089                     ; 488     OS_EXIT_CRITICAL();
1091  024e 87            	clra	
1092  024f 160000        	jsr	_OS_CPU_SR_Restore
1094                     ; 489     *perr = OS_ERR_NONE;
1096  0252 c7            	clrb	
1097  0253 6bf30008      	stab	[OFST+6,s]
1098                     ; 490     return (0u);                                      /* No tasks waiting on semaphore                 */
1101  0257 209f          	bra	L62
1148                     ; 513 _NEAR INT8U  OSSemPost (OS_EVENT *pevent)
1148                     ; 514 {
1149                     	switch	.text
1150  0259               _OSSemPost:
1152  0259 3b            	pshd	
1153  025a 37            	pshb	
1154       00000001      OFST:	set	1
1157                     ; 516     OS_CPU_SR  cpu_sr = 0u;
1159                     ; 521     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
1161  025b 046404        	tbne	d,L504
1162                     ; 522         return (OS_ERR_PEVENT_NULL);
1164  025e c604          	ldab	#4
1166  0260 200a          	bra	L23
1167  0262               L504:
1168                     ; 528     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
1171  0262 e6f30001      	ldab	[OFST+0,s]
1172  0266 c103          	cmpb	#3
1173  0268 2705          	beq	L704
1174                     ; 530         return (OS_ERR_EVENT_TYPE);
1177  026a c601          	ldab	#1
1179  026c               L23:
1181  026c 1b83          	leas	3,s
1182  026e 3d            	rts	
1183  026f               L704:
1184                     ; 532     OS_ENTER_CRITICAL();
1186  026f 160000        	jsr	_OS_CPU_SR_Save
1188  0272 6b80          	stab	OFST-1,s
1189                     ; 533     if (pevent->OSEventGrp != 0u) {                   /* See if any task waiting for semaphore         */
1191  0274 ed81          	ldy	OFST+0,s
1192  0276 e745          	tst	5,y
1193  0278 271a          	beq	L114
1194                     ; 535         (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_SEM, OS_STAT_PEND_OK);
1196  027a 87            	clra	
1197  027b c7            	clrb	
1198  027c 3b            	pshd	
1199  027d 52            	incb	
1200  027e 3b            	pshd	
1201  027f c7            	clrb	
1202  0280 3b            	pshd	
1203  0281 b764          	tfr	y,d
1204  0283 160000        	jsr	_OS_EventTaskRdy
1206  0286 1b86          	leas	6,s
1207                     ; 536         OS_EXIT_CRITICAL();
1209  0288 e680          	ldab	OFST-1,s
1210  028a 87            	clra	
1211  028b 160000        	jsr	_OS_CPU_SR_Restore
1213                     ; 537         OS_Sched();                                   /* Find HPT ready to run                         */
1215  028e 160000        	jsr	_OS_Sched
1217                     ; 539         return (OS_ERR_NONE);
1220  0291 c7            	clrb	
1222  0292 20d8          	bra	L23
1223  0294               L114:
1224                     ; 541     if (pevent->OSEventCnt < 65535u) {                /* Make sure semaphore will not overflow         */
1226  0294 ee43          	ldx	3,y
1227  0296 8effff        	cpx	#-1
1228  0299 240a          	bhs	L314
1229                     ; 542         pevent->OSEventCnt++;                         /* Increment semaphore count to register event   */
1231  029b 08            	inx	
1232  029c 6e43          	stx	3,y
1233                     ; 543         OS_EXIT_CRITICAL();
1235  029e 87            	clra	
1236  029f 160000        	jsr	_OS_CPU_SR_Restore
1238                     ; 545         return (OS_ERR_NONE);
1241  02a2 c7            	clrb	
1243  02a3 20c7          	bra	L23
1244  02a5               L314:
1245                     ; 547     OS_EXIT_CRITICAL();                               /* Semaphore value has reached its maximum       */
1247  02a5 87            	clra	
1248  02a6 160000        	jsr	_OS_CPU_SR_Restore
1250                     ; 550     return (OS_ERR_SEM_OVF);
1253  02a9 c633          	ldab	#51
1255  02ab 20bf          	bra	L23
1370                     ; 574 _NEAR INT8U  OSSemQuery (OS_EVENT     *pevent,
1370                     ; 575                         OS_SEM_DATA  *p_sem_data)
1370                     ; 576 {
1371                     	switch	.text
1372  02ad               _OSSemQuery:
1374  02ad 3b            	pshd	
1375  02ae 1b9a          	leas	-6,s
1376       00000006      OFST:	set	6
1379                     ; 581     OS_CPU_SR   cpu_sr = 0u;
1381                     ; 587     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
1383  02b0 046404        	tbne	d,L374
1384                     ; 588         return (OS_ERR_PEVENT_NULL);
1386  02b3 c604          	ldab	#4
1388  02b5 2006          	bra	L63
1389  02b7               L374:
1390                     ; 590     if (p_sem_data == (OS_SEM_DATA *)0) {                  /* Validate 'p_sem_data'                    */
1392  02b7 ec8a          	ldd	OFST+4,s
1393  02b9 2605          	bne	L574
1394                     ; 591         return (OS_ERR_PDATA_NULL);
1396  02bb c609          	ldab	#9
1398  02bd               L63:
1400  02bd 1b88          	leas	8,s
1401  02bf 3d            	rts	
1402  02c0               L574:
1403                     ; 594     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {        /* Validate event block type                */
1405  02c0 e6f30006      	ldab	[OFST+0,s]
1406  02c4 c103          	cmpb	#3
1407  02c6 2704          	beq	L774
1408                     ; 595         return (OS_ERR_EVENT_TYPE);
1410  02c8 c601          	ldab	#1
1412  02ca 20f1          	bra	L63
1413  02cc               L774:
1414                     ; 597     OS_ENTER_CRITICAL();
1416  02cc 160000        	jsr	_OS_CPU_SR_Save
1418  02cf 6b85          	stab	OFST-1,s
1419                     ; 598     p_sem_data->OSEventGrp = pevent->OSEventGrp;           /* Copy message mailbox wait list           */
1421  02d1 ed8a          	ldy	OFST+4,s
1422  02d3 ee86          	ldx	OFST+0,s
1423  02d5 180a054a      	movb	5,x,10,y
1424                     ; 599     psrc                   = &pevent->OSEventTbl[0];
1426  02d9 ed86          	ldy	OFST+0,s
1427  02db 1946          	leay	6,y
1428  02dd 6d81          	sty	OFST-5,s
1429                     ; 600     pdest                  = &p_sem_data->OSEventTbl[0];
1431  02df ed8a          	ldy	OFST+4,s
1432  02e1 1942          	leay	2,y
1433  02e3 6d83          	sty	OFST-3,s
1434                     ; 601     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
1436  02e5 6980          	clr	OFST-6,s
1437  02e7 ee81          	ldx	OFST-5,s
1438  02e9               L105:
1439                     ; 602         *pdest++ = *psrc++;
1441  02e9 180a3070      	movb	1,x+,1,y+
1442                     ; 601     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
1444  02ed 6280          	inc	OFST-6,s
1447  02ef e680          	ldab	OFST-6,s
1448  02f1 c108          	cmpb	#8
1449  02f3 25f4          	blo	L105
1450  02f5 6e81          	stx	OFST-5,s
1451  02f7 6d83          	sty	OFST-3,s
1452                     ; 604     p_sem_data->OSCnt = pevent->OSEventCnt;                /* Get semaphore count                      */
1454  02f9 ed86          	ldy	OFST+0,s
1455  02fb ec43          	ldd	3,y
1456  02fd 6cf3000a      	std	[OFST+4,s]
1457                     ; 605     OS_EXIT_CRITICAL();
1459  0301 e685          	ldab	OFST-1,s
1460  0303 87            	clra	
1461  0304 160000        	jsr	_OS_CPU_SR_Restore
1463                     ; 606     return (OS_ERR_NONE);
1465  0307 c7            	clrb	
1467  0308 20b3          	bra	L63
1529                     ; 636 _NEAR void  OSSemSet (OS_EVENT  *pevent,
1529                     ; 637                      INT16U     cnt,
1529                     ; 638                      INT8U     *perr)
1529                     ; 639 {
1530                     	switch	.text
1531  030a               _OSSemSet:
1533  030a 3b            	pshd	
1534  030b 37            	pshb	
1535       00000001      OFST:	set	1
1538                     ; 641     OS_CPU_SR  cpu_sr = 0u;
1540                     ; 654     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
1542  030c 046404        	tbne	d,L735
1543                     ; 655         *perr = OS_ERR_PEVENT_NULL;
1545  030f c604          	ldab	#4
1546                     ; 656         return;
1548  0311 200a          	bra	LC007
1549  0313               L735:
1550                     ; 659     if (pevent->OSEventType != OS_EVENT_TYPE_SEM) {   /* Validate event block type                     */
1552  0313 e6f30001      	ldab	[OFST+0,s]
1553  0317 c103          	cmpb	#3
1554  0319 2709          	beq	L145
1555                     ; 660         *perr = OS_ERR_EVENT_TYPE;
1557  031b c601          	ldab	#1
1558  031d               LC007:
1559  031d 6bf30007      	stab	[OFST+6,s]
1560                     ; 661         return;
1561  0321               L24:
1564  0321 1b83          	leas	3,s
1565  0323 3d            	rts	
1566  0324               L145:
1567                     ; 663     OS_ENTER_CRITICAL();
1569  0324 160000        	jsr	_OS_CPU_SR_Save
1571  0327 6b80          	stab	OFST-1,s
1572                     ; 664     *perr = OS_ERR_NONE;
1574  0329 69f30007      	clr	[OFST+6,s]
1575                     ; 665     if (pevent->OSEventCnt > 0u) {                    /* See if semaphore already has a count          */
1577  032d ed81          	ldy	OFST+0,s
1578  032f ec43          	ldd	3,y
1579                     ; 666         pevent->OSEventCnt = cnt;                     /* Yes, set it to the new value specified.       */
1582  0331 2604          	bne	LC008
1583                     ; 668         if (pevent->OSEventGrp == 0u) {               /*      See if task(s) waiting?                  */
1585  0333 e645          	ldab	5,y
1586  0335 2606          	bne	L745
1587                     ; 669             pevent->OSEventCnt = cnt;                 /*      No, OK to set the value                  */
1589  0337               LC008:
1590  0337 18028543      	movw	OFST+4,s,3,y
1592  033b 2006          	bra	L545
1593  033d               L745:
1594                     ; 671             *perr              = OS_ERR_TASK_WAITING;
1596  033d c649          	ldab	#73
1597  033f 6bf30007      	stab	[OFST+6,s]
1598  0343               L545:
1599                     ; 674     OS_EXIT_CRITICAL();
1601  0343 e680          	ldab	OFST-1,s
1602  0345 87            	clra	
1603  0346 160000        	jsr	_OS_CPU_SR_Restore
1605                     ; 675 }
1607  0349 20d6          	bra	L24
1619                     	xref	_OS_Sched
1620                     	xref	_OS_EventWaitListInit
1621                     	xref	_OS_EventTaskRemove
1622                     	xref	_OS_EventTaskWait
1623                     	xref	_OS_EventTaskRdy
1624                     	xdef	_OSSemSet
1625                     	xdef	_OSSemQuery
1626                     	xdef	_OSSemPost
1627                     	xdef	_OSSemPendAbort
1628                     	xdef	_OSSemPend
1629                     	xdef	_OSSemDel
1630                     	xdef	_OSSemCreate
1631                     	xdef	_OSSemAccept
1632                     	xref	_OSTCBCur
1633                     	xref	_OSLockNesting
1634                     	xref	_OSIntNesting
1635                     	xref	_OSEventFreeList
1636                     	xref	_OS_CPU_SR_Restore
1637                     	xref	_OS_CPU_SR_Save
1638                     .const:	section	.data
1639  0000               L521:
1640  0000 3f00          	dc.b	"?",0
1661                     	end

   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 233                     ; 70 _NEAR void  *OSQAccept (OS_EVENT  *pevent,
 233                     ; 71                        INT8U     *perr)
 233                     ; 72 {
 234                     	switch	.text
 235  0000               _OSQAccept:
 237  0000 3b            	pshd	
 238  0001 1b9b          	leas	-5,s
 239       00000005      OFST:	set	5
 242                     ; 76     OS_CPU_SR  cpu_sr = 0u;
 244                     ; 89     if (pevent == (OS_EVENT *)0) {               /* Validate 'pevent'                                  */
 246  0003 046404        	tbne	d,L531
 247                     ; 90         *perr = OS_ERR_PEVENT_NULL;
 249  0006 c604          	ldab	#4
 250                     ; 91         return ((void *)0);
 253  0008 200a          	bra	LC001
 254  000a               L531:
 255                     ; 94     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {/* Validate event block type                          */
 257  000a e6f30005      	ldab	[OFST+0,s]
 258  000e c102          	cmpb	#2
 259  0010 270b          	beq	L731
 260                     ; 95         *perr = OS_ERR_EVENT_TYPE;
 262  0012 c601          	ldab	#1
 263                     ; 96         return ((void *)0);
 265  0014               LC001:
 266  0014 6bf30009      	stab	[OFST+4,s]
 267  0018 87            	clra	
 268  0019 c7            	clrb	
 270  001a               L6:
 272  001a 1b87          	leas	7,s
 273  001c 3d            	rts	
 274  001d               L731:
 275                     ; 98     OS_ENTER_CRITICAL();
 277  001d 160000        	jsr	_OS_CPU_SR_Save
 279  0020 6b84          	stab	OFST-1,s
 280                     ; 99     pq = (OS_Q *)pevent->OSEventPtr;             /* Point at queue control block                       */
 282  0022 ed85          	ldy	OFST+0,s
 283  0024 ed41          	ldy	1,y
 284  0026 6d80          	sty	OFST-5,s
 285                     ; 100     if (pq->OSQEntries > 0u) {                   /* See if any messages in the queue                   */
 287  0028 ec4c          	ldd	12,y
 288  002a 271d          	beq	L141
 289                     ; 101         pmsg = *pq->OSQOut++;                    /* Yes, extract oldest message from the queue         */
 291  002c ee48          	ldx	8,y
 292  002e 18023182      	movw	2,x+,OFST-3,s
 293  0032 6e48          	stx	8,y
 294                     ; 102         pq->OSQEntries--;                        /* Update the number of entries in the queue          */
 296  0034 ee4c          	ldx	12,y
 297  0036 09            	dex	
 298  0037 6e4c          	stx	12,y
 299                     ; 103         if (pq->OSQOut == pq->OSQEnd) {          /* Wrap OUT pointer if we are at the end of the queue */
 301  0039 ec48          	ldd	8,y
 302  003b ac44          	cpd	4,y
 303  003d 2604          	bne	L341
 304                     ; 104             pq->OSQOut = pq->OSQStart;
 306  003f 18024248      	movw	2,y,8,y
 307  0043               L341:
 308                     ; 106         *perr = OS_ERR_NONE;
 310  0043 69f30009      	clr	[OFST+4,s]
 312  0047 2009          	bra	L541
 313  0049               L141:
 314                     ; 108         *perr = OS_ERR_Q_EMPTY;
 316  0049 c61f          	ldab	#31
 317  004b 6bf30009      	stab	[OFST+4,s]
 318                     ; 109         pmsg  = (void *)0;                       /* Queue is empty                                     */
 320  004f c7            	clrb	
 321  0050 6c82          	std	OFST-3,s
 322  0052               L541:
 323                     ; 111     OS_EXIT_CRITICAL();
 325  0052 e684          	ldab	OFST-1,s
 326  0054 87            	clra	
 327  0055 160000        	jsr	_OS_CPU_SR_Restore
 329                     ; 112     return (pmsg);                               /* Return message received (or NULL)                  */
 331  0058 ec82          	ldd	OFST-3,s
 333  005a 20be          	bra	L6
 415                     ; 136 _NEAR OS_EVENT  *OSQCreate (void    **start,
 415                     ; 137                            INT16U    size)
 415                     ; 138 {
 416                     	switch	.text
 417  005c               _OSQCreate:
 419  005c 3b            	pshd	
 420  005d 1b9b          	leas	-5,s
 421       00000005      OFST:	set	5
 424                     ; 142     OS_CPU_SR  cpu_sr = 0u;
 426                     ; 154     if (OSIntNesting > 0u) {                     /* See if called from ISR ...                         */
 428  005f f60000        	ldab	_OSIntNesting
 429  0062 2705          	beq	L702
 430                     ; 155         return ((OS_EVENT *)0);                  /* ... can't CREATE from an ISR                       */
 432  0064 87            	clra	
 433  0065 c7            	clrb	
 436  0066 1b87          	leas	7,s
 437  0068 3d            	rts	
 438  0069               L702:
 439                     ; 157     OS_ENTER_CRITICAL();
 441  0069 160000        	jsr	_OS_CPU_SR_Save
 443  006c 6b84          	stab	OFST-1,s
 444                     ; 158     pevent = OSEventFreeList;                    /* Get next free event control block                  */
 446  006e fd0000        	ldy	_OSEventFreeList
 447  0071 6d80          	sty	OFST-5,s
 448                     ; 159     if (OSEventFreeList != (OS_EVENT *)0) {      /* See if pool of free ECB pool was empty             */
 450  0073 2705          	beq	L112
 451                     ; 160         OSEventFreeList = (OS_EVENT *)OSEventFreeList->OSEventPtr;
 453  0075 1805410000    	movw	1,y,_OSEventFreeList
 454  007a               L112:
 455                     ; 162     OS_EXIT_CRITICAL();
 457  007a 87            	clra	
 458  007b 160000        	jsr	_OS_CPU_SR_Restore
 460                     ; 163     if (pevent != (OS_EVENT *)0) {               /* See if we have an event control block              */
 462  007e ec80          	ldd	OFST-5,s
 463  0080 275b          	beq	L312
 464                     ; 164         OS_ENTER_CRITICAL();
 466  0082 160000        	jsr	_OS_CPU_SR_Save
 468  0085 6b84          	stab	OFST-1,s
 469                     ; 165         pq = OSQFreeList;                        /* Get a free queue control block                     */
 471  0087 fd0000        	ldy	_OSQFreeList
 472  008a 6d82          	sty	OFST-3,s
 473                     ; 166         if (pq != (OS_Q *)0) {                   /* Were we able to get a queue control block ?        */
 475  008c 273f          	beq	L512
 476                     ; 167             OSQFreeList            = OSQFreeList->OSQPtr; /* Yes, Adjust free list pointer to next free*/
 478  008e 1805400000    	movw	0,y,_OSQFreeList
 479                     ; 168             OS_EXIT_CRITICAL();
 481  0093 87            	clra	
 482  0094 160000        	jsr	_OS_CPU_SR_Restore
 484                     ; 169             pq->OSQStart           = start;               /*      Initialize the queue                 */
 486  0097 ed82          	ldy	OFST-3,s
 487  0099 18028542      	movw	OFST+0,s,2,y
 488                     ; 170             pq->OSQEnd             = &start[size];
 490  009d ec89          	ldd	OFST+4,s
 491  009f 59            	lsld	
 492  00a0 e385          	addd	OFST+0,s
 493  00a2 6c44          	std	4,y
 494                     ; 171             pq->OSQIn              = start;
 496  00a4 ec85          	ldd	OFST+0,s
 497  00a6 6c46          	std	6,y
 498                     ; 172             pq->OSQOut             = start;
 500  00a8 6c48          	std	8,y
 501                     ; 173             pq->OSQSize            = size;
 503  00aa 1802894a      	movw	OFST+4,s,10,y
 504                     ; 174             pq->OSQEntries         = 0u;
 506  00ae 87            	clra	
 507  00af c7            	clrb	
 508  00b0 6c4c          	std	12,y
 509                     ; 175             pevent->OSEventType    = OS_EVENT_TYPE_Q;
 511  00b2 c602          	ldab	#2
 512  00b4 ed80          	ldy	OFST-5,s
 513  00b6 6b40          	stab	0,y
 514                     ; 176             pevent->OSEventCnt     = 0u;
 516  00b8 c7            	clrb	
 517  00b9 6c43          	std	3,y
 518                     ; 177             pevent->OSEventPtr     = pq;
 520  00bb 18028241      	movw	OFST-3,s,1,y
 521                     ; 179             pevent->OSEventName    = (INT8U *)(void *)"?";
 523  00bf cc0000        	ldd	#L712
 524  00c2 6c4e          	std	14,y
 525                     ; 181             OS_EventWaitListInit(pevent);                 /*      Initialize the wait list             */
 527  00c4 b764          	tfr	y,d
 528  00c6 160000        	jsr	_OS_EventWaitListInit
 530                     ; 183             OS_TRACE_Q_CREATE(pevent, pevent->OSEventName);
 532  00c9 ec80          	ldd	OFST-5,s
 533  00cb 2010          	bra	L312
 534  00cd               L512:
 535                     ; 185             pevent->OSEventPtr = (void *)OSEventFreeList; /* No,  Return event control block on error  */
 537  00cd ed80          	ldy	OFST-5,s
 538  00cf 1801410000    	movw	_OSEventFreeList,1,y
 539                     ; 186             OSEventFreeList    = pevent;
 541  00d4 7d0000        	sty	_OSEventFreeList
 542                     ; 187             OS_EXIT_CRITICAL();
 544  00d7 87            	clra	
 545  00d8 160000        	jsr	_OS_CPU_SR_Restore
 547                     ; 188             pevent = (OS_EVENT *)0;
 549  00db 87            	clra	
 550  00dc c7            	clrb	
 551  00dd               L312:
 552                     ; 191     return (pevent);
 556  00dd 1b87          	leas	7,s
 557  00df 3d            	rts	
 658                     ; 241 _NEAR OS_EVENT  *OSQDel (OS_EVENT  *pevent,
 658                     ; 242                         INT8U      opt,
 658                     ; 243                         INT8U     *perr)
 658                     ; 244 {
 659                     	switch	.text
 660  00e0               _OSQDel:
 662  00e0 3b            	pshd	
 663  00e1 1b9c          	leas	-4,s
 664       00000004      OFST:	set	4
 667                     ; 249     OS_CPU_SR  cpu_sr = 0u;
 669                     ; 269     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
 671  00e3 046404        	tbne	d,L103
 672                     ; 270         *perr = OS_ERR_PEVENT_NULL;
 674  00e6 c604          	ldab	#4
 675                     ; 271         return (pevent);
 678  00e8 200a          	bra	L41
 679  00ea               L103:
 680                     ; 277     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {          /* Validate event block type                */
 683  00ea e6f30004      	ldab	[OFST+0,s]
 684  00ee c102          	cmpb	#2
 685  00f0 270b          	beq	L303
 686                     ; 278         *perr = OS_ERR_EVENT_TYPE;
 688  00f2 c601          	ldab	#1
 689                     ; 280         return (pevent);
 693  00f4               L41:
 694  00f4 6bf3000a      	stab	[OFST+6,s]
 695  00f8 ec84          	ldd	OFST+0,s
 697  00fa 1b86          	leas	6,s
 698  00fc 3d            	rts	
 699  00fd               L303:
 700                     ; 282     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 702  00fd f60000        	ldab	_OSIntNesting
 703  0100 2704          	beq	L503
 704                     ; 283         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
 706  0102 c60f          	ldab	#15
 707                     ; 285         return (pevent);
 711  0104 20ee          	bra	L41
 712  0106               L503:
 713                     ; 287     OS_ENTER_CRITICAL();
 715  0106 160000        	jsr	_OS_CPU_SR_Save
 717  0109 6b82          	stab	OFST-2,s
 718                     ; 288     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on queue        */
 720  010b ed84          	ldy	OFST+0,s
 721  010d e645          	ldab	5,y
 722  010f 2706          	beq	L703
 723                     ; 289         tasks_waiting = OS_TRUE;                           /* Yes                                      */
 725  0111 c601          	ldab	#1
 726  0113 6b83          	stab	OFST-1,s
 728  0115 2002          	bra	L113
 729  0117               L703:
 730                     ; 291         tasks_waiting = OS_FALSE;                          /* No                                       */
 732  0117 6983          	clr	OFST-1,s
 733  0119               L113:
 734                     ; 293     switch (opt) {
 736  0119 e689          	ldab	OFST+5,s
 738  011b 270d          	beq	L322
 739  011d 040160        	dbeq	b,L523
 740                     ; 338         default:
 740                     ; 339              OS_EXIT_CRITICAL();
 742  0120 e682          	ldab	OFST-2,s
 743  0122 87            	clra	
 744  0123 160000        	jsr	_OS_CPU_SR_Restore
 746                     ; 340              *perr                  = OS_ERR_INVALID_OPT;
 748  0126 c607          	ldab	#7
 749                     ; 341              pevent_return          = pevent;
 751                     ; 342              break;
 753  0128 203a          	bra	LC003
 754  012a               L322:
 755                     ; 294         case OS_DEL_NO_PEND:                               /* Delete queue only if no task waiting     */
 755                     ; 295              if (tasks_waiting == OS_FALSE) {
 757  012a e683          	ldab	OFST-1,s
 758  012c 262e          	bne	L713
 759                     ; 297                  pevent->OSEventName    = (INT8U *)(void *)"?";
 761  012e cc0000        	ldd	#L712
 762  0131 6c4e          	std	14,y
 763                     ; 299                  pq                     = (OS_Q *)pevent->OSEventPtr;  /* Return OS_Q to free list     */
 765  0133 ee41          	ldx	1,y
 766  0135 6e80          	stx	OFST-4,s
 767                     ; 300                  pq->OSQPtr             = OSQFreeList;
 769  0137 1801000000    	movw	_OSQFreeList,0,x
 770                     ; 301                  OSQFreeList            = pq;
 772  013c 7e0000        	stx	_OSQFreeList
 773                     ; 302                  pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
 775  013f 87            	clra	
 776  0140 6a40          	staa	0,y
 777                     ; 303                  pevent->OSEventPtr     = OSEventFreeList; /* Return Event Control Block to free list  */
 779  0142 1801410000    	movw	_OSEventFreeList,1,y
 780                     ; 304                  pevent->OSEventCnt     = 0u;
 782  0147 c7            	clrb	
 783  0148 6c43          	std	3,y
 784                     ; 305                  OSEventFreeList        = pevent;          /* Get next free event control block        */
 786  014a 1805840000    	movw	OFST+0,s,_OSEventFreeList
 787                     ; 306                  OS_EXIT_CRITICAL();
 789  014f e682          	ldab	OFST-2,s
 790  0151 160000        	jsr	_OS_CPU_SR_Restore
 792                     ; 307                  *perr                  = OS_ERR_NONE;
 794  0154 87            	clra	
 795  0155 6af3000a      	staa	[OFST+6,s]
 796                     ; 308                  pevent_return          = (OS_EVENT *)0;   /* Queue has been deleted                   */
 798  0159 c7            	clrb	
 800  015a 200e          	bra	LC002
 801  015c               L713:
 802                     ; 310                  OS_EXIT_CRITICAL();
 804  015c e682          	ldab	OFST-2,s
 805  015e 87            	clra	
 806  015f 160000        	jsr	_OS_CPU_SR_Restore
 808                     ; 311                  *perr                  = OS_ERR_TASK_WAITING;
 810  0162 c649          	ldab	#73
 811                     ; 312                  pevent_return          = pevent;
 813  0164               LC003:
 814  0164 6bf3000a      	stab	[OFST+6,s]
 815  0168 ec84          	ldd	OFST+0,s
 816  016a               LC002:
 817  016a 6c80          	std	OFST-4,s
 818  016c 204a          	bra	L513
 819  016e               L323:
 820                     ; 318                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
 822  016e cc0002        	ldd	#2
 823  0171 3b            	pshd	
 824  0172 c604          	ldab	#4
 825  0174 3b            	pshd	
 826  0175 c7            	clrb	
 827  0176 3b            	pshd	
 828  0177 ec8a          	ldd	OFST+6,s
 829  0179 160000        	jsr	_OS_EventTaskRdy
 831  017c 1b86          	leas	6,s
 832  017e ed84          	ldy	OFST+0,s
 833  0180               L523:
 834                     ; 316         case OS_DEL_ALWAYS:                                /* Always delete the queue                  */
 834                     ; 317              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for queue        */
 836  0180 e645          	ldab	5,y
 837  0182 26ea          	bne	L323
 838                     ; 321              pevent->OSEventName    = (INT8U *)(void *)"?";
 840  0184 cc0000        	ldd	#L712
 841  0187 6c4e          	std	14,y
 842                     ; 323              pq                     = (OS_Q *)pevent->OSEventPtr;   /* Return OS_Q to free list        */
 844  0189 ee41          	ldx	1,y
 845  018b 6e80          	stx	OFST-4,s
 846                     ; 324              pq->OSQPtr             = OSQFreeList;
 848  018d 1801000000    	movw	_OSQFreeList,0,x
 849                     ; 325              OSQFreeList            = pq;
 851  0192 7e0000        	stx	_OSQFreeList
 852                     ; 326              pevent->OSEventType    = OS_EVENT_TYPE_UNUSED;
 854  0195 87            	clra	
 855  0196 6a40          	staa	0,y
 856                     ; 327              pevent->OSEventPtr     = OSEventFreeList;     /* Return Event Control Block to free list  */
 858  0198 1801410000    	movw	_OSEventFreeList,1,y
 859                     ; 328              pevent->OSEventCnt     = 0u;
 861  019d c7            	clrb	
 862  019e 6c43          	std	3,y
 863                     ; 329              OSEventFreeList        = pevent;              /* Get next free event control block        */
 865  01a0 1805840000    	movw	OFST+0,s,_OSEventFreeList
 866                     ; 330              OS_EXIT_CRITICAL();
 868  01a5 e682          	ldab	OFST-2,s
 869  01a7 160000        	jsr	_OS_CPU_SR_Restore
 871                     ; 331              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
 873  01aa e683          	ldab	OFST-1,s
 874  01ac 042103        	dbne	b,L133
 875                     ; 332                  OS_Sched();                               /* Find highest priority task ready to run  */
 877  01af 160000        	jsr	_OS_Sched
 879  01b2               L133:
 880                     ; 334              *perr                  = OS_ERR_NONE;
 882  01b2 87            	clra	
 883  01b3 6af3000a      	staa	[OFST+6,s]
 884                     ; 335              pevent_return          = (OS_EVENT *)0;       /* Queue has been deleted                   */
 886  01b7 c7            	clrb	
 887                     ; 336              break;
 889  01b8               L513:
 890                     ; 347     return (pevent_return);
 895  01b8 1b86          	leas	6,s
 896  01ba 3d            	rts	
 953                     ; 372 _NEAR INT8U  OSQFlush (OS_EVENT *pevent)
 953                     ; 373 {
 954                     	switch	.text
 955  01bb               _OSQFlush:
 957  01bb 3b            	pshd	
 958  01bc 1b9d          	leas	-3,s
 959       00000003      OFST:	set	3
 962                     ; 376     OS_CPU_SR  cpu_sr = 0u;
 964                     ; 382     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
 966  01be 046404        	tbne	d,L363
 967                     ; 383         return (OS_ERR_PEVENT_NULL);
 969  01c1 c604          	ldab	#4
 971  01c3 200a          	bra	L02
 972  01c5               L363:
 973                     ; 385     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
 975  01c5 e6f30003      	ldab	[OFST+0,s]
 976  01c9 c102          	cmpb	#2
 977  01cb 2705          	beq	L563
 978                     ; 386         return (OS_ERR_EVENT_TYPE);
 980  01cd c601          	ldab	#1
 982  01cf               L02:
 984  01cf 1b85          	leas	5,s
 985  01d1 3d            	rts	
 986  01d2               L563:
 987                     ; 389     OS_ENTER_CRITICAL();
 989  01d2 160000        	jsr	_OS_CPU_SR_Save
 991  01d5 6b82          	stab	OFST-1,s
 992                     ; 390     pq             = (OS_Q *)pevent->OSEventPtr;      /* Point to queue storage structure              */
 994  01d7 ed83          	ldy	OFST+0,s
 995  01d9 ed41          	ldy	1,y
 996  01db 6d80          	sty	OFST-3,s
 997                     ; 391     pq->OSQIn      = pq->OSQStart;
 999  01dd ec42          	ldd	2,y
1000  01df 6c46          	std	6,y
1001                     ; 392     pq->OSQOut     = pq->OSQStart;
1003  01e1 6c48          	std	8,y
1004                     ; 393     pq->OSQEntries = 0u;
1006  01e3 87            	clra	
1007  01e4 c7            	clrb	
1008  01e5 6c4c          	std	12,y
1009                     ; 394     OS_EXIT_CRITICAL();
1011  01e7 e682          	ldab	OFST-1,s
1012  01e9 160000        	jsr	_OS_CPU_SR_Restore
1014                     ; 395     return (OS_ERR_NONE);
1016  01ec c7            	clrb	
1018  01ed 20e0          	bra	L02
1109                     ; 436 _NEAR void  *OSQPend (OS_EVENT  *pevent,
1109                     ; 437                 INT32U     timeout,
1109                     ; 438                 INT8U     *perr)
1109                     ; 439 {
1110                     	switch	.text
1111  01ef               _OSQPend:
1113  01ef 3b            	pshd	
1114  01f0 1b9b          	leas	-5,s
1115       00000005      OFST:	set	5
1118                     ; 443     OS_CPU_SR  cpu_sr = 0u;
1120                     ; 455     if (pevent == (OS_EVENT *)0) {               /* Validate 'pevent'                                  */
1122  01f2 046404        	tbne	d,L734
1123                     ; 456         *perr = OS_ERR_PEVENT_NULL;
1125  01f5 c604          	ldab	#4
1126                     ; 457         return ((void *)0);
1129  01f7 200a          	bra	LC004
1130  01f9               L734:
1131                     ; 463     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {/* Validate event block type                          */
1134  01f9 e6f30005      	ldab	[OFST+0,s]
1135  01fd c102          	cmpb	#2
1136  01ff 270b          	beq	L144
1137                     ; 464         *perr = OS_ERR_EVENT_TYPE;
1139  0201 c601          	ldab	#1
1140                     ; 466         return ((void *)0);
1143  0203               LC004:
1144  0203 6bf3000d      	stab	[OFST+8,s]
1145  0207 87            	clra	
1146  0208 c7            	clrb	
1148  0209               L42:
1150  0209 1b87          	leas	7,s
1151  020b 3d            	rts	
1152  020c               L144:
1153                     ; 468     if (OSIntNesting > 0u) {                     /* See if called from ISR ...                         */
1155  020c f60000        	ldab	_OSIntNesting
1156  020f 2704          	beq	L344
1157                     ; 469         *perr = OS_ERR_PEND_ISR;                 /* ... can't PEND from an ISR                         */
1159  0211 c602          	ldab	#2
1160                     ; 471         return ((void *)0);
1164  0213 20ee          	bra	LC004
1165  0215               L344:
1166                     ; 473     if (OSLockNesting > 0u) {                    /* See if called with scheduler locked ...            */
1168  0215 f60000        	ldab	_OSLockNesting
1169  0218 2704          	beq	L544
1170                     ; 474         *perr = OS_ERR_PEND_LOCKED;              /* ... can't PEND when locked                         */
1172  021a c60d          	ldab	#13
1173                     ; 476         return ((void *)0);
1177  021c 20e5          	bra	LC004
1178  021e               L544:
1179                     ; 478     OS_ENTER_CRITICAL();
1181  021e 160000        	jsr	_OS_CPU_SR_Save
1183  0221 6b84          	stab	OFST-1,s
1184                     ; 479     pq = (OS_Q *)pevent->OSEventPtr;             /* Point at queue control block                       */
1186  0223 ed85          	ldy	OFST+0,s
1187  0225 ed41          	ldy	1,y
1188  0227 6d80          	sty	OFST-5,s
1189                     ; 480     if (pq->OSQEntries > 0u) {                   /* See if any messages in the queue                   */
1191  0229 ec4c          	ldd	12,y
1192  022b 2725          	beq	L744
1193                     ; 481         pmsg = *pq->OSQOut++;                    /* Yes, extract oldest message from the queue         */
1195  022d ee48          	ldx	8,y
1196  022f 18023182      	movw	2,x+,OFST-3,s
1197  0233 6e48          	stx	8,y
1198                     ; 482         pq->OSQEntries--;                        /* Update the number of entries in the queue          */
1200  0235 ee4c          	ldx	12,y
1201  0237 09            	dex	
1202  0238 6e4c          	stx	12,y
1203                     ; 483         if (pq->OSQOut == pq->OSQEnd) {          /* Wrap OUT pointer if we are at the end of the queue */
1205  023a ec48          	ldd	8,y
1206  023c ac44          	cpd	4,y
1207  023e 2604          	bne	L154
1208                     ; 484             pq->OSQOut = pq->OSQStart;
1210  0240 18024248      	movw	2,y,8,y
1211  0244               L154:
1212                     ; 486         OS_EXIT_CRITICAL();
1214  0244 e684          	ldab	OFST-1,s
1215  0246 87            	clra	
1216  0247 160000        	jsr	_OS_CPU_SR_Restore
1218                     ; 487         *perr = OS_ERR_NONE;
1220  024a 69f3000d      	clr	[OFST+8,s]
1221                     ; 489         return (pmsg);                           /* Return message received                            */
1224  024e ec82          	ldd	OFST-3,s
1226  0250 20b7          	bra	L42
1227  0252               L744:
1228                     ; 491     OSTCBCur->OSTCBStat     |= OS_STAT_Q;        /* Task will have to pend for a message to be posted  */
1230  0252 fd0000        	ldy	_OSTCBCur
1231  0255 0ce82204      	bset	34,y,4
1232                     ; 492     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
1234  0259 69e823        	clr	35,y
1235                     ; 493     OSTCBCur->OSTCBDly       = timeout;          /* Load timeout into TCB                              */
1237  025c ec8b          	ldd	OFST+6,s
1238  025e 6ce820        	std	32,y
1239  0261 ec89          	ldd	OFST+4,s
1240  0263 6ce81e        	std	30,y
1241                     ; 494     OS_EventTaskWait(pevent);                    /* Suspend task until event or timeout occurs         */
1243  0266 ec85          	ldd	OFST+0,s
1244  0268 160000        	jsr	_OS_EventTaskWait
1246                     ; 495     OS_EXIT_CRITICAL();
1248  026b e684          	ldab	OFST-1,s
1249  026d 87            	clra	
1250  026e 160000        	jsr	_OS_CPU_SR_Restore
1252                     ; 496     OS_Sched();                                  /* Find next highest priority task ready to run       */
1254  0271 160000        	jsr	_OS_Sched
1256                     ; 497     OS_ENTER_CRITICAL();
1258  0274 160000        	jsr	_OS_CPU_SR_Save
1260  0277 6b84          	stab	OFST-1,s
1261                     ; 498     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
1263  0279 fd0000        	ldy	_OSTCBCur
1264  027c e6e823        	ldab	35,y
1266  027f 2708          	beq	L763
1267  0281 040117        	dbeq	b,L373
1268  0284 04010d        	dbeq	b,L173
1269  0287 2012          	bra	L373
1270  0289               L763:
1271                     ; 499         case OS_STAT_PEND_OK:                         /* Extract message from TCB (Put there by QPost) */
1271                     ; 500              pmsg =  OSTCBCur->OSTCBMsg;
1273  0289 ece818        	ldd	24,y
1274  028c 6c82          	std	OFST-3,s
1275                     ; 501             *perr =  OS_ERR_NONE;
1277  028e 69f3000d      	clr	[OFST+8,s]
1278                     ; 502              break;
1280  0292 201e          	bra	L554
1281  0294               L173:
1282                     ; 504         case OS_STAT_PEND_ABORT:
1282                     ; 505              pmsg = (void *)0;
1284  0294 87            	clra	
1285  0295 6c82          	std	OFST-3,s
1286                     ; 506             *perr =  OS_ERR_PEND_ABORT;               /* Indicate that we aborted                      */
1288  0297 c60e          	ldab	#14
1289                     ; 507              break;
1291  0299 2010          	bra	LC005
1292  029b               L373:
1293                     ; 509         case OS_STAT_PEND_TO:
1293                     ; 510         default:
1293                     ; 511              OS_EventTaskRemove(OSTCBCur, pevent);
1295  029b ec85          	ldd	OFST+0,s
1296  029d 3b            	pshd	
1297  029e b764          	tfr	y,d
1298  02a0 160000        	jsr	_OS_EventTaskRemove
1300  02a3 1b82          	leas	2,s
1301                     ; 512              pmsg = (void *)0;
1303  02a5 87            	clra	
1304  02a6 c7            	clrb	
1305  02a7 6c82          	std	OFST-3,s
1306                     ; 513             *perr =  OS_ERR_TIMEOUT;                  /* Indicate that we didn't get event within TO   */
1308  02a9 c60a          	ldab	#10
1309  02ab               LC005:
1310  02ab 6bf3000d      	stab	[OFST+8,s]
1311                     ; 514              break;
1313  02af fd0000        	ldy	_OSTCBCur
1314  02b2               L554:
1315                     ; 516     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
1317  02b2 c7            	clrb	
1318  02b3 6be822        	stab	34,y
1319                     ; 517     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
1321  02b6 87            	clra	
1322  02b7 6ae823        	staa	35,y
1323                     ; 518     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
1325  02ba 6ce812        	std	18,y
1326                     ; 520     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
1328  02bd 6ce814        	std	20,y
1329                     ; 521     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
1331  02c0 6ce816        	std	22,y
1332                     ; 523     OSTCBCur->OSTCBMsg           = (void      *)0;    /* Clear  received message                       */
1334  02c3 6ce818        	std	24,y
1335                     ; 524     OS_EXIT_CRITICAL();
1337  02c6 e684          	ldab	OFST-1,s
1338  02c8 160000        	jsr	_OS_CPU_SR_Restore
1340                     ; 527     return (pmsg);                                    /* Return received message                       */
1343  02cb ec82          	ldd	OFST-3,s
1346  02cd 1b87          	leas	7,s
1347  02cf 3d            	rts	
1418                     ; 564 _NEAR INT8U  OSQPendAbort (OS_EVENT  *pevent,
1418                     ; 565                           INT8U      opt,
1418                     ; 566                           INT8U     *perr)
1418                     ; 567 {
1419                     	switch	.text
1420  02d0               _OSQPendAbort:
1422  02d0 3b            	pshd	
1423       00000002      OFST:	set	2
1426                     ; 570     OS_CPU_SR  cpu_sr = 0u;
1428                     ; 583     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
1430  02d1 6cae          	std	2,-s
1431  02d3 2604          	bne	L515
1432                     ; 584         *perr = OS_ERR_PEVENT_NULL;
1434  02d5 c604          	ldab	#4
1435                     ; 585         return (0u);
1438  02d7 200a          	bra	LC006
1439  02d9               L515:
1440                     ; 588     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {          /* Validate event block type                */
1442  02d9 e6f30002      	ldab	[OFST+0,s]
1443  02dd c102          	cmpb	#2
1444  02df 270a          	beq	L715
1445                     ; 589         *perr = OS_ERR_EVENT_TYPE;
1447  02e1 c601          	ldab	#1
1448                     ; 590         return (0u);
1450  02e3               LC006:
1451  02e3 6bf30008      	stab	[OFST+6,s]
1452  02e7 c7            	clrb	
1454  02e8               L03:
1456  02e8 1b84          	leas	4,s
1457  02ea 3d            	rts	
1458  02eb               L715:
1459                     ; 592     OS_ENTER_CRITICAL();
1461  02eb 160000        	jsr	_OS_CPU_SR_Save
1463  02ee 6b81          	stab	OFST-1,s
1464                     ; 593     if (pevent->OSEventGrp != 0u) {                        /* See if any task waiting on queue?        */
1466  02f0 ed82          	ldy	OFST+0,s
1467  02f2 e745          	tst	5,y
1468  02f4 274a          	beq	L125
1469                     ; 594         nbr_tasks = 0u;
1471  02f6 6980          	clr	OFST-2,s
1472                     ; 595         switch (opt) {
1474  02f8 e687          	ldab	OFST+5,s
1476  02fa 271f          	beq	L164
1477  02fc 040116        	dbeq	b,L135
1478  02ff 201a          	bra	L164
1479  0301               L725:
1480                     ; 598                      (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
1482  0301 cc0002        	ldd	#2
1483  0304 3b            	pshd	
1484  0305 c604          	ldab	#4
1485  0307 3b            	pshd	
1486  0308 c7            	clrb	
1487  0309 3b            	pshd	
1488  030a ec88          	ldd	OFST+6,s
1489  030c 160000        	jsr	_OS_EventTaskRdy
1491  030f 1b86          	leas	6,s
1492                     ; 599                      nbr_tasks++;
1494  0311 6280          	inc	OFST-2,s
1495  0313 ed82          	ldy	OFST+0,s
1496  0315               L135:
1497                     ; 596             case OS_PEND_OPT_BROADCAST:                    /* Do we need to abort ALL waiting tasks?   */
1497                     ; 597                  while (pevent->OSEventGrp != 0u) {        /* Yes, ready ALL tasks waiting on queue    */
1499  0315 e645          	ldab	5,y
1500  0317 26e8          	bne	L725
1501                     ; 601                  break;
1503  0319 2012          	bra	L525
1504  031b               L164:
1505                     ; 603             case OS_PEND_OPT_NONE:
1505                     ; 604             default:                                       /* No,  ready HPT       waiting on queue    */
1505                     ; 605                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_Q, OS_STAT_PEND_ABORT);
1507  031b cc0002        	ldd	#2
1508  031e 3b            	pshd	
1509  031f c604          	ldab	#4
1510  0321 3b            	pshd	
1511  0322 c7            	clrb	
1512  0323 3b            	pshd	
1513  0324 b764          	tfr	y,d
1514  0326 160000        	jsr	_OS_EventTaskRdy
1516  0329 1b86          	leas	6,s
1517                     ; 606                  nbr_tasks++;
1519  032b 6280          	inc	OFST-2,s
1520                     ; 607                  break;
1522  032d               L525:
1523                     ; 609         OS_EXIT_CRITICAL();
1525  032d e681          	ldab	OFST-1,s
1526  032f 87            	clra	
1527  0330 160000        	jsr	_OS_CPU_SR_Restore
1529                     ; 610         OS_Sched();                                        /* Find HPT ready to run                    */
1531  0333 160000        	jsr	_OS_Sched
1533                     ; 611         *perr = OS_ERR_PEND_ABORT;
1535  0336 c60e          	ldab	#14
1536  0338 6bf30008      	stab	[OFST+6,s]
1537                     ; 612         return (nbr_tasks);
1539  033c e680          	ldab	OFST-2,s
1541  033e 20a8          	bra	L03
1542  0340               L125:
1543                     ; 614     OS_EXIT_CRITICAL();
1545  0340 87            	clra	
1546  0341 160000        	jsr	_OS_CPU_SR_Restore
1548                     ; 615     *perr = OS_ERR_NONE;
1550  0344 c7            	clrb	
1551  0345 6bf30008      	stab	[OFST+6,s]
1552                     ; 616     return (0u);                                           /* No tasks waiting on queue                */
1555  0349 209d          	bra	L03
1624                     ; 641 _NEAR INT8U  OSQPost (OS_EVENT  *pevent,
1624                     ; 642                      void      *pmsg)
1624                     ; 643 {
1625                     	switch	.text
1626  034b               _OSQPost:
1628  034b 3b            	pshd	
1629  034c 1b9d          	leas	-3,s
1630       00000003      OFST:	set	3
1633                     ; 646     OS_CPU_SR  cpu_sr = 0u;
1635                     ; 651     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
1637  034e 046404        	tbne	d,L175
1638                     ; 652         return (OS_ERR_PEVENT_NULL);
1640  0351 c604          	ldab	#4
1642  0353 200a          	bra	L43
1643  0355               L175:
1644                     ; 658     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {      /* Validate event block type                    */
1647  0355 e6f30003      	ldab	[OFST+0,s]
1648  0359 c102          	cmpb	#2
1649  035b 2705          	beq	L375
1650                     ; 660         return (OS_ERR_EVENT_TYPE);
1653  035d c601          	ldab	#1
1655  035f               L43:
1657  035f 1b85          	leas	5,s
1658  0361 3d            	rts	
1659  0362               L375:
1660                     ; 662     OS_ENTER_CRITICAL();
1662  0362 160000        	jsr	_OS_CPU_SR_Save
1664  0365 6b82          	stab	OFST-1,s
1665                     ; 663     if (pevent->OSEventGrp != 0u) {                    /* See if any task pending on queue             */
1667  0367 ed83          	ldy	OFST+0,s
1668  0369 e645          	ldab	5,y
1669  036b 271b          	beq	L575
1670                     ; 665         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
1672  036d 87            	clra	
1673  036e c7            	clrb	
1674  036f 3b            	pshd	
1675  0370 c604          	ldab	#4
1676  0372 3b            	pshd	
1677  0373 ec8b          	ldd	OFST+8,s
1678  0375 3b            	pshd	
1679  0376 b764          	tfr	y,d
1680  0378 160000        	jsr	_OS_EventTaskRdy
1682  037b 1b86          	leas	6,s
1683                     ; 666         OS_EXIT_CRITICAL();
1685  037d e682          	ldab	OFST-1,s
1686  037f 87            	clra	
1687  0380 160000        	jsr	_OS_CPU_SR_Restore
1689                     ; 667         OS_Sched();                                    /* Find highest priority task ready to run      */
1691  0383 160000        	jsr	_OS_Sched
1693                     ; 669         return (OS_ERR_NONE);
1697  0386 2031          	bra	LC007
1698  0388               L575:
1699                     ; 671     pq = (OS_Q *)pevent->OSEventPtr;                   /* Point to queue control block                 */
1701  0388 ed41          	ldy	1,y
1702  038a 6d80          	sty	OFST-3,s
1703                     ; 672     if (pq->OSQEntries >= pq->OSQSize) {               /* Make sure queue is not full                  */
1705  038c ec4c          	ldd	12,y
1706  038e ac4a          	cpd	10,y
1707  0390 250a          	blo	L775
1708                     ; 673         OS_EXIT_CRITICAL();
1710  0392 e682          	ldab	OFST-1,s
1711  0394 87            	clra	
1712  0395 160000        	jsr	_OS_CPU_SR_Restore
1714                     ; 675         return (OS_ERR_Q_FULL);
1717  0398 c61e          	ldab	#30
1719  039a 20c3          	bra	L43
1720  039c               L775:
1721                     ; 677     *pq->OSQIn++ = pmsg;                               /* Insert message into queue                    */
1723  039c ee46          	ldx	6,y
1724  039e 18028731      	movw	OFST+4,s,2,x+
1725  03a2 6e46          	stx	6,y
1726                     ; 678     pq->OSQEntries++;                                  /* Update the nbr of entries in the queue       */
1728  03a4 ee4c          	ldx	12,y
1729  03a6 08            	inx	
1730  03a7 6e4c          	stx	12,y
1731                     ; 679     if (pq->OSQIn == pq->OSQEnd) {                     /* Wrap IN ptr if we are at end of queue        */
1733  03a9 ec46          	ldd	6,y
1734  03ab ac44          	cpd	4,y
1735  03ad 2604          	bne	L106
1736                     ; 680         pq->OSQIn = pq->OSQStart;
1738  03af 18024246      	movw	2,y,6,y
1739  03b3               L106:
1740                     ; 682     OS_EXIT_CRITICAL();
1742  03b3 e682          	ldab	OFST-1,s
1743  03b5 87            	clra	
1744  03b6 160000        	jsr	_OS_CPU_SR_Restore
1746                     ; 685     return (OS_ERR_NONE);
1749  03b9               LC007:
1750  03b9 c7            	clrb	
1752  03ba 20a3          	bra	L43
1821                     ; 712 _NEAR INT8U  OSQPostFront (OS_EVENT  *pevent,
1821                     ; 713                           void      *pmsg)
1821                     ; 714 {
1822                     	switch	.text
1823  03bc               _OSQPostFront:
1825  03bc 3b            	pshd	
1826  03bd 1b9d          	leas	-3,s
1827       00000003      OFST:	set	3
1830                     ; 717     OS_CPU_SR  cpu_sr = 0u;
1832                     ; 723     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
1834  03bf 046404        	tbne	d,L736
1835                     ; 724         return (OS_ERR_PEVENT_NULL);
1837  03c2 c604          	ldab	#4
1839  03c4 200a          	bra	L04
1840  03c6               L736:
1841                     ; 730     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
1844  03c6 e6f30003      	ldab	[OFST+0,s]
1845  03ca c102          	cmpb	#2
1846  03cc 2705          	beq	L146
1847                     ; 732         return (OS_ERR_EVENT_TYPE);
1850  03ce c601          	ldab	#1
1852  03d0               L04:
1854  03d0 1b85          	leas	5,s
1855  03d2 3d            	rts	
1856  03d3               L146:
1857                     ; 734     OS_ENTER_CRITICAL();
1859  03d3 160000        	jsr	_OS_CPU_SR_Save
1861  03d6 6b82          	stab	OFST-1,s
1862                     ; 735     if (pevent->OSEventGrp != 0u) {                   /* See if any task pending on queue              */
1864  03d8 ed83          	ldy	OFST+0,s
1865  03da e645          	ldab	5,y
1866  03dc 271b          	beq	L346
1867                     ; 737         (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
1869  03de 87            	clra	
1870  03df c7            	clrb	
1871  03e0 3b            	pshd	
1872  03e1 c604          	ldab	#4
1873  03e3 3b            	pshd	
1874  03e4 ec8b          	ldd	OFST+8,s
1875  03e6 3b            	pshd	
1876  03e7 b764          	tfr	y,d
1877  03e9 160000        	jsr	_OS_EventTaskRdy
1879  03ec 1b86          	leas	6,s
1880                     ; 738         OS_EXIT_CRITICAL();
1882  03ee e682          	ldab	OFST-1,s
1883  03f0 87            	clra	
1884  03f1 160000        	jsr	_OS_CPU_SR_Restore
1886                     ; 739         OS_Sched();                                   /* Find highest priority task ready to run       */
1888  03f4 160000        	jsr	_OS_Sched
1890                     ; 741         return (OS_ERR_NONE);
1894  03f7 202f          	bra	LC008
1895  03f9               L346:
1896                     ; 743     pq = (OS_Q *)pevent->OSEventPtr;                  /* Point to queue control block                  */
1898  03f9 ed41          	ldy	1,y
1899  03fb 6d80          	sty	OFST-3,s
1900                     ; 744     if (pq->OSQEntries >= pq->OSQSize) {              /* Make sure queue is not full                   */
1902  03fd ec4c          	ldd	12,y
1903  03ff ac4a          	cpd	10,y
1904  0401 250a          	blo	L546
1905                     ; 745         OS_EXIT_CRITICAL();
1907  0403 e682          	ldab	OFST-1,s
1908  0405 87            	clra	
1909  0406 160000        	jsr	_OS_CPU_SR_Restore
1911                     ; 747         return (OS_ERR_Q_FULL);
1914  0409 c61e          	ldab	#30
1916  040b 20c3          	bra	L04
1917  040d               L546:
1918                     ; 749     if (pq->OSQOut == pq->OSQStart) {                 /* Wrap OUT ptr if we are at the 1st queue entry */
1920  040d ee48          	ldx	8,y
1921  040f ae42          	cpx	2,y
1922  0411 2604          	bne	L746
1923                     ; 750         pq->OSQOut = pq->OSQEnd;
1925  0413 ee44          	ldx	4,y
1926  0415 6e48          	stx	8,y
1927  0417               L746:
1928                     ; 752     pq->OSQOut--;
1930                     ; 753     *pq->OSQOut = pmsg;                               /* Insert message into queue                     */
1932  0417 1802872e      	movw	OFST+4,s,2,-x
1933  041b 6e48          	stx	8,y
1934                     ; 754     pq->OSQEntries++;                                 /* Update the nbr of entries in the queue        */
1936  041d ee4c          	ldx	12,y
1937  041f 08            	inx	
1938  0420 6e4c          	stx	12,y
1939                     ; 755     OS_EXIT_CRITICAL();
1941  0422 e682          	ldab	OFST-1,s
1942  0424 87            	clra	
1943  0425 160000        	jsr	_OS_CPU_SR_Restore
1945                     ; 757     return (OS_ERR_NONE);
1948  0428               LC008:
1949  0428 c7            	clrb	
1951  0429 20a5          	bra	L04
2027                     ; 792 _NEAR INT8U  OSQPostOpt (OS_EVENT  *pevent,
2027                     ; 793                         void      *pmsg,
2027                     ; 794                         INT8U      opt)
2027                     ; 795 {
2028                     	switch	.text
2029  042b               _OSQPostOpt:
2031  042b 3b            	pshd	
2032  042c 1b9d          	leas	-3,s
2033       00000003      OFST:	set	3
2036                     ; 798     OS_CPU_SR  cpu_sr = 0u;
2038                     ; 804     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
2040  042e 046404        	tbne	d,L707
2041                     ; 805         return (OS_ERR_PEVENT_NULL);
2043  0431 c604          	ldab	#4
2045  0433 200a          	bra	L44
2046  0435               L707:
2047                     ; 811     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {     /* Validate event block type                     */
2050  0435 e6f30003      	ldab	[OFST+0,s]
2051  0439 c102          	cmpb	#2
2052  043b 2705          	beq	L117
2053                     ; 813         return (OS_ERR_EVENT_TYPE);
2056  043d c601          	ldab	#1
2058  043f               L44:
2060  043f 1b85          	leas	5,s
2061  0441 3d            	rts	
2062  0442               L117:
2063                     ; 815     OS_ENTER_CRITICAL();
2065  0442 160000        	jsr	_OS_CPU_SR_Save
2067  0445 6b82          	stab	OFST-1,s
2068                     ; 816     if (pevent->OSEventGrp != 0x00u) {                /* See if any task pending on queue              */
2070  0447 ed83          	ldy	OFST+0,s
2071  0449 e645          	ldab	5,y
2072  044b 273e          	beq	L317
2073                     ; 817         if ((opt & OS_POST_OPT_BROADCAST) != 0x00u) { /* Do we need to post msg to ALL waiting tasks ? */
2075  044d 0f8a011a      	brclr	OFST+7,s,1,L517
2077  0451 2014          	bra	L127
2078  0453               L717:
2079                     ; 819                 (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
2081  0453 87            	clra	
2082  0454 c7            	clrb	
2083  0455 3b            	pshd	
2084  0456 c604          	ldab	#4
2085  0458 3b            	pshd	
2086  0459 ec8b          	ldd	OFST+8,s
2087  045b 3b            	pshd	
2088  045c ec89          	ldd	OFST+6,s
2089  045e 160000        	jsr	_OS_EventTaskRdy
2091  0461 1b86          	leas	6,s
2092  0463 ed83          	ldy	OFST+0,s
2093  0465 e645          	ldab	5,y
2094  0467               L127:
2095                     ; 818             while (pevent->OSEventGrp != 0u) {        /* Yes, Post to ALL tasks waiting on queue       */
2097  0467 26ea          	bne	L717
2099  0469 2010          	bra	L527
2100  046b               L517:
2101                     ; 822             (void)OS_EventTaskRdy(pevent, pmsg, OS_STAT_Q, OS_STAT_PEND_OK);
2103  046b 87            	clra	
2104  046c c7            	clrb	
2105  046d 3b            	pshd	
2106  046e c604          	ldab	#4
2107  0470 3b            	pshd	
2108  0471 ec8b          	ldd	OFST+8,s
2109  0473 3b            	pshd	
2110  0474 b764          	tfr	y,d
2111  0476 160000        	jsr	_OS_EventTaskRdy
2113  0479 1b86          	leas	6,s
2114  047b               L527:
2115                     ; 824         OS_EXIT_CRITICAL();
2117  047b e682          	ldab	OFST-1,s
2118  047d 87            	clra	
2119  047e 160000        	jsr	_OS_CPU_SR_Restore
2121                     ; 825         if ((opt & OS_POST_OPT_NO_SCHED) == 0u) {     /* See if scheduler needs to be invoked          */
2123  0481 0e8a0403      	brset	OFST+7,s,4,L727
2124                     ; 826             OS_Sched();                               /* Find highest priority task ready to run       */
2126  0485 160000        	jsr	_OS_Sched
2128  0488               L727:
2129                     ; 829         return (OS_ERR_NONE);
2132  0488 c7            	clrb	
2134  0489 20b4          	bra	L44
2135  048b               L317:
2136                     ; 831     pq = (OS_Q *)pevent->OSEventPtr;                  /* Point to queue control block                  */
2138  048b ed41          	ldy	1,y
2139  048d 6d80          	sty	OFST-3,s
2140                     ; 832     if (pq->OSQEntries >= pq->OSQSize) {              /* Make sure queue is not full                   */
2142  048f ec4c          	ldd	12,y
2143  0491 ac4a          	cpd	10,y
2144  0493 250a          	blo	L137
2145                     ; 833         OS_EXIT_CRITICAL();
2147  0495 e682          	ldab	OFST-1,s
2148  0497 87            	clra	
2149  0498 160000        	jsr	_OS_CPU_SR_Restore
2151                     ; 835         return (OS_ERR_Q_FULL);
2154  049b c61e          	ldab	#30
2156  049d 20a0          	bra	L44
2157  049f               L137:
2158                     ; 837     if ((opt & OS_POST_OPT_FRONT) != 0x00u) {         /* Do we post to the FRONT of the queue?         */
2160  049f 0f8a0212      	brclr	OFST+7,s,2,L337
2161                     ; 838         if (pq->OSQOut == pq->OSQStart) {             /* Yes, Post as LIFO, Wrap OUT pointer if we ... */
2163  04a3 ee48          	ldx	8,y
2164  04a5 ae42          	cpx	2,y
2165  04a7 2604          	bne	L537
2166                     ; 839             pq->OSQOut = pq->OSQEnd;                  /*      ... are at the 1st queue entry           */
2168  04a9 ee44          	ldx	4,y
2169  04ab 6e48          	stx	8,y
2170  04ad               L537:
2171                     ; 841         pq->OSQOut--;
2173                     ; 842         *pq->OSQOut = pmsg;                           /*      Insert message into queue                */
2175  04ad 1802872e      	movw	OFST+4,s,2,-x
2176  04b1 6e48          	stx	8,y
2178  04b3 2010          	bra	L737
2179  04b5               L337:
2180                     ; 844         *pq->OSQIn++ = pmsg;                          /*      Insert message into queue                */
2182  04b5 ee46          	ldx	6,y
2183  04b7 18028731      	movw	OFST+4,s,2,x+
2184  04bb 6e46          	stx	6,y
2185                     ; 845         if (pq->OSQIn == pq->OSQEnd) {                /*      Wrap IN ptr if we are at end of queue    */
2187  04bd ae44          	cpx	4,y
2188  04bf 2604          	bne	L737
2189                     ; 846             pq->OSQIn = pq->OSQStart;
2191  04c1 18024246      	movw	2,y,6,y
2192  04c5               L737:
2193                     ; 849     pq->OSQEntries++;                                 /* Update the nbr of entries in the queue        */
2195  04c5 ee4c          	ldx	12,y
2196  04c7 08            	inx	
2197  04c8 6e4c          	stx	12,y
2198                     ; 850     OS_EXIT_CRITICAL();
2200  04ca e682          	ldab	OFST-1,s
2201  04cc 87            	clra	
2202  04cd 160000        	jsr	_OS_CPU_SR_Restore
2204                     ; 852     return (OS_ERR_NONE);
2207  04d0 c7            	clrb	
2210  04d1 1b85          	leas	5,s
2211  04d3 3d            	rts	
2355                     ; 876 _NEAR INT8U  OSQQuery (OS_EVENT  *pevent,
2355                     ; 877                       OS_Q_DATA *p_q_data)
2355                     ; 878 {
2356                     	switch	.text
2357  04d4               _OSQQuery:
2359  04d4 3b            	pshd	
2360  04d5 1b9a          	leas	-6,s
2361       00000006      OFST:	set	6
2364                     ; 884     OS_CPU_SR   cpu_sr = 0u;
2366                     ; 890     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
2368  04d7 046404        	tbne	d,L5301
2369                     ; 891         return (OS_ERR_PEVENT_NULL);
2371  04da c604          	ldab	#4
2373  04dc 2006          	bra	L05
2374  04de               L5301:
2375                     ; 893     if (p_q_data == (OS_Q_DATA *)0) {                  /* Validate 'p_q_data'                          */
2377  04de ec8a          	ldd	OFST+4,s
2378  04e0 2605          	bne	L7301
2379                     ; 894         return (OS_ERR_PDATA_NULL);
2381  04e2 c609          	ldab	#9
2383  04e4               L05:
2385  04e4 1b88          	leas	8,s
2386  04e6 3d            	rts	
2387  04e7               L7301:
2388                     ; 897     if (pevent->OSEventType != OS_EVENT_TYPE_Q) {      /* Validate event block type                    */
2390  04e7 e6f30006      	ldab	[OFST+0,s]
2391  04eb c102          	cmpb	#2
2392  04ed 2704          	beq	L1401
2393                     ; 898         return (OS_ERR_EVENT_TYPE);
2395  04ef c601          	ldab	#1
2397  04f1 20f1          	bra	L05
2398  04f3               L1401:
2399                     ; 900     OS_ENTER_CRITICAL();
2401  04f3 160000        	jsr	_OS_CPU_SR_Save
2403  04f6 6b85          	stab	OFST-1,s
2404                     ; 901     p_q_data->OSEventGrp = pevent->OSEventGrp;         /* Copy message queue wait list                 */
2406  04f8 ed8a          	ldy	OFST+4,s
2407  04fa ee86          	ldx	OFST+0,s
2408  04fc 180a054e      	movb	5,x,14,y
2409                     ; 902     psrc                 = &pevent->OSEventTbl[0];
2411  0500 ed86          	ldy	OFST+0,s
2412  0502 1946          	leay	6,y
2413  0504 6d83          	sty	OFST-3,s
2414                     ; 903     pdest                = &p_q_data->OSEventTbl[0];
2416  0506 ed8a          	ldy	OFST+4,s
2417  0508 1946          	leay	6,y
2418  050a 6d80          	sty	OFST-6,s
2419                     ; 904     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
2421  050c 6982          	clr	OFST-4,s
2422  050e ee83          	ldx	OFST-3,s
2423  0510               L3401:
2424                     ; 905         *pdest++ = *psrc++;
2426  0510 180a3070      	movb	1,x+,1,y+
2427                     ; 904     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
2429  0514 6282          	inc	OFST-4,s
2432  0516 e682          	ldab	OFST-4,s
2433  0518 c108          	cmpb	#8
2434  051a 25f4          	blo	L3401
2435  051c 6e83          	stx	OFST-3,s
2436                     ; 907     pq = (OS_Q *)pevent->OSEventPtr;
2438  051e ed86          	ldy	OFST+0,s
2439  0520 ed41          	ldy	1,y
2440  0522 6d80          	sty	OFST-6,s
2441                     ; 908     if (pq->OSQEntries > 0u) {
2443  0524 ec4c          	ldd	12,y
2444  0526 2704          	beq	L1501
2445                     ; 909         p_q_data->OSMsg = *pq->OSQOut;                 /* Get next message to return if available      */
2447  0528 eceb0008      	ldd	[8,y]
2449  052c               L1501:
2450                     ; 911         p_q_data->OSMsg = (void *)0;
2452  052c ed8a          	ldy	OFST+4,s
2453  052e 6c40          	std	0,y
2454                     ; 913     p_q_data->OSNMsgs = pq->OSQEntries;
2456  0530 ee80          	ldx	OFST-6,s
2457  0532 18020c42      	movw	12,x,2,y
2458                     ; 914     p_q_data->OSQSize = pq->OSQSize;
2460  0536 18020a44      	movw	10,x,4,y
2461                     ; 915     OS_EXIT_CRITICAL();
2463  053a e685          	ldab	OFST-1,s
2464  053c 87            	clra	
2465  053d 160000        	jsr	_OS_CPU_SR_Restore
2467                     ; 916     return (OS_ERR_NONE);
2469  0540 c7            	clrb	
2471  0541 20a1          	bra	L05
2536                     ; 936 _NEAR void  OS_QInit (void)
2536                     ; 937 {
2537                     	switch	.text
2538  0543               _OS_QInit:
2540  0543 1b9a          	leas	-6,s
2541       00000006      OFST:	set	6
2544                     ; 951     OS_MemClr((INT8U *)&OSQTbl[0], sizeof(OSQTbl));  /* Clear the queue table                          */
2546  0545 cc0038        	ldd	#56
2547  0548 3b            	pshd	
2548  0549 cc0000        	ldd	#_OSQTbl
2549  054c 160000        	jsr	_OS_MemClr
2551  054f 1b82          	leas	2,s
2552                     ; 952     for (ix = 0u; ix < (OS_MAX_QS - 1u); ix++) {     /* Init. list of free QUEUE control blocks        */
2554  0551 87            	clra	
2555  0552 c7            	clrb	
2556  0553 b746          	tfr	d,y
2557  0555 6d80          	sty	OFST-6,s
2558  0557               L7011:
2559                     ; 953         ix_next = ix + 1u;
2561  0557 02            	iny	
2562  0558 6d82          	sty	OFST-4,s
2563                     ; 954         pq1 = &OSQTbl[ix];
2565  055a cd000e        	ldy	#14
2566  055d 13            	emul	
2567  055e c30000        	addd	#_OSQTbl
2568  0561 6c84          	std	OFST-2,s
2569                     ; 955         pq2 = &OSQTbl[ix_next];
2571  0563 ec82          	ldd	OFST-4,s
2572  0565 cd000e        	ldy	#14
2573  0568 13            	emul	
2574  0569 c30000        	addd	#_OSQTbl
2575  056c 6c82          	std	OFST-4,s
2576                     ; 956         pq1->OSQPtr = pq2;
2578  056e 6cf30004      	std	[OFST-2,s]
2579                     ; 952     for (ix = 0u; ix < (OS_MAX_QS - 1u); ix++) {     /* Init. list of free QUEUE control blocks        */
2581  0572 ed80          	ldy	OFST-6,s
2582  0574 02            	iny	
2585  0575 b764          	tfr	y,d
2586  0577 6c80          	std	OFST-6,s
2587  0579 8c0003        	cpd	#3
2588  057c 25d9          	blo	L7011
2589                     ; 958     pq1         = &OSQTbl[ix];
2591  057e cd000e        	ldy	#14
2592  0581 13            	emul	
2593  0582 c30000        	addd	#_OSQTbl
2594  0585 6c84          	std	OFST-2,s
2595                     ; 959     pq1->OSQPtr = (OS_Q *)0;
2597  0587 87            	clra	
2598  0588 c7            	clrb	
2599  0589 6cf30004      	std	[OFST-2,s]
2600                     ; 960     OSQFreeList = &OSQTbl[0];
2602  058d cc0000        	ldd	#_OSQTbl
2603  0590 7c0000        	std	_OSQFreeList
2604                     ; 962 }
2607  0593 1b86          	leas	6,s
2608  0595 3d            	rts	
2620                     	xref	_OS_Sched
2621                     	xdef	_OS_QInit
2622                     	xref	_OS_MemClr
2623                     	xref	_OS_EventWaitListInit
2624                     	xref	_OS_EventTaskRemove
2625                     	xref	_OS_EventTaskWait
2626                     	xref	_OS_EventTaskRdy
2627                     	xdef	_OSQQuery
2628                     	xdef	_OSQPostOpt
2629                     	xdef	_OSQPostFront
2630                     	xdef	_OSQPost
2631                     	xdef	_OSQPendAbort
2632                     	xdef	_OSQPend
2633                     	xdef	_OSQFlush
2634                     	xdef	_OSQDel
2635                     	xdef	_OSQCreate
2636                     	xdef	_OSQAccept
2637                     	xref	_OSQTbl
2638                     	xref	_OSQFreeList
2639                     	xref	_OSTCBCur
2640                     	xref	_OSLockNesting
2641                     	xref	_OSIntNesting
2642                     	xref	_OSEventFreeList
2643                     	xref	_OS_CPU_SR_Restore
2644                     	xref	_OS_CPU_SR_Save
2645                     .const:	section	.data
2646  0000               L712:
2647  0000 3f00          	dc.b	"?",0
2668                     	end

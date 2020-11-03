   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
 142                     ; 93 _NEAR BOOLEAN  OSMutexAccept (OS_EVENT  *pevent,
 142                     ; 94                              INT8U     *perr)
 142                     ; 95 {
 143                     	switch	.text
 144  0000               _OSMutexAccept:
 146  0000 3b            	pshd	
 147       00000002      OFST:	set	2
 150                     ; 98     OS_CPU_SR  cpu_sr = 0u;
 152                     ; 111     if (pevent == (OS_EVENT *)0) {                     /* Validate 'pevent'                            */
 154  0001 6cae          	std	2,-s
 155  0003 2604          	bne	L17
 156                     ; 112         *perr = OS_ERR_PEVENT_NULL;
 158  0005 c604          	ldab	#4
 159                     ; 113         return (OS_FALSE);
 162  0007 200a          	bra	LC001
 163  0009               L17:
 164                     ; 116     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {  /* Validate event block type                    */
 166  0009 e6f30002      	ldab	[OFST+0,s]
 167  000d c104          	cmpb	#4
 168  000f 270a          	beq	L37
 169                     ; 117         *perr = OS_ERR_EVENT_TYPE;
 171  0011 c601          	ldab	#1
 172                     ; 118         return (OS_FALSE);
 174  0013               LC001:
 175  0013 6bf30006      	stab	[OFST+4,s]
 176  0017 c7            	clrb	
 178  0018               L6:
 180  0018 1b84          	leas	4,s
 181  001a 3d            	rts	
 182  001b               L37:
 183                     ; 120     if (OSIntNesting > 0u) {                           /* Make sure it's not called from an ISR        */
 185  001b f60000        	ldab	_OSIntNesting
 186  001e 2704          	beq	L57
 187                     ; 121         *perr = OS_ERR_PEND_ISR;
 189  0020 c602          	ldab	#2
 190                     ; 122         return (OS_FALSE);
 193  0022 20ef          	bra	LC001
 194  0024               L57:
 195                     ; 124     OS_ENTER_CRITICAL();                               /* Get value (0 or 1) of Mutex                  */
 197  0024 160000        	jsr	_OS_CPU_SR_Save
 199  0027 6b80          	stab	OFST-2,s
 200                     ; 125     pcp = (INT8U)(pevent->OSEventCnt >> 8u);           /* Get PCP from mutex                           */
 202  0029 ed82          	ldy	OFST+0,s
 203  002b 180a4381      	movb	3,y,OFST-1,s
 204                     ; 126     if ((pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8) == OS_MUTEX_AVAILABLE) {
 206  002f e644          	ldab	4,y
 207  0031 87            	clra	
 208  0032 8c00ff        	cpd	#255
 209  0035 263a          	bne	L77
 210                     ; 127         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;   /*      Mask off LSByte (Acquire Mutex)         */
 212  0037 6a44          	staa	4,y
 213                     ; 128         pevent->OSEventCnt |= (INT16U)OSTCBCur->OSTCBPrio;  /* Save current task priority in LSByte    */
 215  0039 fe0000        	ldx	_OSTCBCur
 216  003c e6e024        	ldab	36,x
 217  003f ea44          	orab	4,y
 218  0041 aa43          	oraa	3,y
 219  0043 6c43          	std	3,y
 220                     ; 129         pevent->OSEventPtr  = (void *)OSTCBCur;        /*      Link TCB of task owning Mutex           */
 222  0045 6e41          	stx	1,y
 223                     ; 130         if ((pcp != OS_PRIO_MUTEX_CEIL_DIS) &&
 223                     ; 131             (OSTCBCur->OSTCBPrio <= pcp)) {            /*      PCP 'must' have a SMALLER prio ...      */
 225  0047 e681          	ldab	OFST-1,s
 226  0049 048117        	ibeq	b,L101
 228  004c b756          	tfr	x,y
 229  004e e6e824        	ldab	36,y
 230  0051 e181          	cmpb	OFST-1,s
 231  0053 220e          	bhi	L101
 232                     ; 132              OS_EXIT_CRITICAL();                       /*      ... than current task!                  */
 234  0055 e680          	ldab	OFST-2,s
 235  0057 87            	clra	
 236  0058 160000        	jsr	_OS_CPU_SR_Restore
 238                     ; 133             *perr = OS_ERR_PCP_LOWER;
 240  005b c678          	ldab	#120
 241  005d 6bf30006      	stab	[OFST+4,s]
 243  0061 200a          	bra	L301
 244  0063               L101:
 245                     ; 135              OS_EXIT_CRITICAL();
 247  0063 e680          	ldab	OFST-2,s
 248  0065 87            	clra	
 249  0066 160000        	jsr	_OS_CPU_SR_Restore
 251                     ; 136             *perr = OS_ERR_NONE;
 253  0069 69f30006      	clr	[OFST+4,s]
 254  006d               L301:
 255                     ; 138         return (OS_TRUE);
 257  006d c601          	ldab	#1
 259  006f 20a7          	bra	L6
 260  0071               L77:
 261                     ; 140     OS_EXIT_CRITICAL();
 263  0071 e680          	ldab	OFST-2,s
 264  0073 160000        	jsr	_OS_CPU_SR_Restore
 266                     ; 141     *perr = OS_ERR_NONE;
 268  0076 c7            	clrb	
 269  0077 6bf30006      	stab	[OFST+4,s]
 270                     ; 142     return (OS_FALSE);
 274  007b 1b84          	leas	4,s
 275  007d 3d            	rts	
 344                     ; 187 _NEAR OS_EVENT  *OSMutexCreate (INT8U   prio,
 344                     ; 188                                INT8U  *perr)
 344                     ; 189 {
 345                     	switch	.text
 346  007e               _OSMutexCreate:
 348  007e 3b            	pshd	
 349  007f 1b9d          	leas	-3,s
 350       00000003      OFST:	set	3
 353                     ; 192     OS_CPU_SR  cpu_sr = 0u;
 355                     ; 213     if (prio != OS_PRIO_MUTEX_CEIL_DIS) {
 357  0081 c1ff          	cmpb	#255
 358  0083 2708          	beq	L731
 359                     ; 214         if (prio >= OS_LOWEST_PRIO) {                      /* Validate PCP                             */
 361  0085 c13f          	cmpb	#63
 362  0087 2504          	blo	L731
 363                     ; 215            *perr = OS_ERR_PRIO_INVALID;
 365  0089 c62a          	ldab	#42
 366                     ; 216             return ((OS_EVENT *)0);
 369  008b 2007          	bra	LC002
 370  008d               L731:
 371                     ; 220     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 373  008d f60000        	ldab	_OSIntNesting
 374  0090 270b          	beq	L341
 375                     ; 221         *perr = OS_ERR_CREATE_ISR;                         /* ... can't CREATE mutex from an ISR       */
 377  0092 c610          	ldab	#16
 378                     ; 222         return ((OS_EVENT *)0);
 380  0094               LC002:
 381  0094 6bf30007      	stab	[OFST+4,s]
 382  0098 87            	clra	
 383  0099 c7            	clrb	
 385  009a               L21:
 387  009a 1b85          	leas	5,s
 388  009c 3d            	rts	
 389  009d               L341:
 390                     ; 224     OS_ENTER_CRITICAL();
 392  009d 160000        	jsr	_OS_CPU_SR_Save
 394  00a0 6b82          	stab	OFST-1,s
 395                     ; 225     if (prio != OS_PRIO_MUTEX_CEIL_DIS) {
 397  00a2 e684          	ldab	OFST+1,s
 398  00a4 c1ff          	cmpb	#255
 399  00a6 2720          	beq	L541
 400                     ; 226         if (OSTCBPrioTbl[prio] != (OS_TCB *)0) {           /* Mutex priority must not already exist    */
 402  00a8 87            	clra	
 403  00a9 59            	lsld	
 404  00aa b746          	tfr	d,y
 405  00ac ecea0000      	ldd	_OSTCBPrioTbl,y
 406  00b0 270a          	beq	L741
 407                     ; 227             OS_EXIT_CRITICAL();                            /* Task already exist at priority ...       */
 409  00b2 e682          	ldab	OFST-1,s
 410  00b4 87            	clra	
 411  00b5 160000        	jsr	_OS_CPU_SR_Restore
 413                     ; 228            *perr = OS_ERR_PRIO_EXIST;                      /* ... ceiling priority                     */
 415  00b8 c628          	ldab	#40
 416                     ; 229             return ((OS_EVENT *)0);
 419  00ba 20d8          	bra	LC002
 420  00bc               L741:
 421                     ; 231         OSTCBPrioTbl[prio] = OS_TCB_RESERVED;              /* Reserve the table entry                  */
 423  00bc e684          	ldab	OFST+1,s
 424  00be 59            	lsld	
 425  00bf b746          	tfr	d,y
 426  00c1 cc0001        	ldd	#1
 427  00c4 6cea0000      	std	_OSTCBPrioTbl,y
 428  00c8               L541:
 429                     ; 234     pevent = OSEventFreeList;                              /* Get next free event control block        */
 431  00c8 fc0000        	ldd	_OSEventFreeList
 432  00cb 6c80          	std	OFST-3,s
 433                     ; 235     if (pevent == (OS_EVENT *)0) {                         /* See if an ECB was available              */
 435  00cd 261f          	bne	L151
 436                     ; 236         if (prio != OS_PRIO_MUTEX_CEIL_DIS) {
 438  00cf e684          	ldab	OFST+1,s
 439  00d1 c1ff          	cmpb	#255
 440  00d3 2709          	beq	L351
 441                     ; 237             OSTCBPrioTbl[prio] = (OS_TCB *)0;              /* No, Release the table entry              */
 443  00d5 59            	lsld	
 444  00d6 b746          	tfr	d,y
 445  00d8 87            	clra	
 446  00d9 c7            	clrb	
 447  00da 6cea0000      	std	_OSTCBPrioTbl,y
 448  00de               L351:
 449                     ; 239         OS_EXIT_CRITICAL();
 451  00de e682          	ldab	OFST-1,s
 452  00e0 87            	clra	
 453  00e1 160000        	jsr	_OS_CPU_SR_Restore
 455                     ; 240        *perr = OS_ERR_PEVENT_NULL;                         /* No more event control blocks             */
 457  00e4 c604          	ldab	#4
 458  00e6 6bf30007      	stab	[OFST+4,s]
 459                     ; 241         return (pevent);
 461  00ea ec80          	ldd	OFST-3,s
 463  00ec 20ac          	bra	L21
 464  00ee               L151:
 465                     ; 243     OSEventFreeList     = (OS_EVENT *)OSEventFreeList->OSEventPtr; /* Adjust the free list             */
 467  00ee b746          	tfr	d,y
 468  00f0 1805410000    	movw	1,y,_OSEventFreeList
 469                     ; 244     OS_EXIT_CRITICAL();
 471  00f5 e682          	ldab	OFST-1,s
 472  00f7 87            	clra	
 473  00f8 160000        	jsr	_OS_CPU_SR_Restore
 475                     ; 245     pevent->OSEventType = OS_EVENT_TYPE_MUTEX;
 477  00fb c604          	ldab	#4
 478  00fd ed80          	ldy	OFST-3,s
 479  00ff 6b40          	stab	0,y
 480                     ; 246     pevent->OSEventCnt  = (INT16U)((INT16U)prio << 8u) | OS_MUTEX_AVAILABLE; /* Resource is avail.     */
 482  0101 cc00ff        	ldd	#255
 483  0104 aa84          	oraa	OFST+1,s
 484  0106 6c43          	std	3,y
 485                     ; 247     pevent->OSEventPtr  = (void *)0;                       /* No task owning the mutex                 */
 487  0108 87            	clra	
 488  0109 c7            	clrb	
 489  010a 6c41          	std	1,y
 490                     ; 249     pevent->OSEventName = (INT8U *)(void *)"?";
 492  010c cc0000        	ldd	#L551
 493  010f 6c4e          	std	14,y
 494                     ; 251     OS_EventWaitListInit(pevent);
 496  0111 b764          	tfr	y,d
 497  0113 160000        	jsr	_OS_EventWaitListInit
 499                     ; 253    *perr = OS_ERR_NONE;
 502  0116 69f30007      	clr	[OFST+4,s]
 503                     ; 254     return (pevent);
 505  011a ec80          	ldd	OFST-3,s
 508  011c 1b85          	leas	5,s
 509  011e 3d            	rts	
 945                     ; 301 _NEAR OS_EVENT  *OSMutexDel (OS_EVENT  *pevent,
 945                     ; 302                             INT8U      opt,
 945                     ; 303                             INT8U     *perr)
 945                     ; 304 {
 946                     	switch	.text
 947  011f               _OSMutexDel:
 949  011f 3b            	pshd	
 950  0120 1b9a          	leas	-6,s
 951       00000006      OFST:	set	6
 954                     ; 311     OS_CPU_SR  cpu_sr = 0u;
 956                     ; 331     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
 958  0122 046404        	tbne	d,L334
 959                     ; 332         *perr = OS_ERR_PEVENT_NULL;
 961  0125 c604          	ldab	#4
 962                     ; 333         return (pevent);
 965  0127 200a          	bra	L61
 966  0129               L334:
 967                     ; 339     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
 970  0129 e6f30006      	ldab	[OFST+0,s]
 971  012d c104          	cmpb	#4
 972  012f 270b          	beq	L534
 973                     ; 340         *perr = OS_ERR_EVENT_TYPE;
 975  0131 c601          	ldab	#1
 976                     ; 342         return (pevent);
 980  0133               L61:
 981  0133 6bf3000c      	stab	[OFST+6,s]
 982  0137 ec86          	ldd	OFST+0,s
 984  0139 1b88          	leas	8,s
 985  013b 3d            	rts	
 986  013c               L534:
 987                     ; 344     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
 989  013c f60000        	ldab	_OSIntNesting
 990  013f 2704          	beq	L734
 991                     ; 345         *perr = OS_ERR_DEL_ISR;                            /* ... can't DELETE from an ISR             */
 993  0141 c60f          	ldab	#15
 994                     ; 347         return (pevent);
 998  0143 20ee          	bra	L61
 999  0145               L734:
1000                     ; 349     OS_ENTER_CRITICAL();
1002  0145 160000        	jsr	_OS_CPU_SR_Save
1004  0148 6b83          	stab	OFST-3,s
1005                     ; 350     if (pevent->OSEventGrp != 0u) {                        /* See if any tasks waiting on mutex        */
1007  014a ed86          	ldy	OFST+0,s
1008  014c e645          	ldab	5,y
1009  014e 2706          	beq	L144
1010                     ; 351         tasks_waiting = OS_TRUE;                           /* Yes                                      */
1012  0150 c601          	ldab	#1
1013  0152 6b84          	stab	OFST-2,s
1015  0154 2002          	bra	L344
1016  0156               L144:
1017                     ; 353         tasks_waiting = OS_FALSE;                          /* No                                       */
1019  0156 6984          	clr	OFST-2,s
1020  0158               L344:
1021                     ; 355     switch (opt) {
1023  0158 e68b          	ldab	OFST+5,s
1025  015a 270d          	beq	L751
1026  015c 040154        	dbeq	b,L161
1027                     ; 413         default:
1027                     ; 414              OS_EXIT_CRITICAL();
1029  015f e683          	ldab	OFST-3,s
1030  0161 87            	clra	
1031  0162 160000        	jsr	_OS_CPU_SR_Restore
1033                     ; 415              *perr         = OS_ERR_INVALID_OPT;
1035  0165 c607          	ldab	#7
1036                     ; 416              pevent_return = pevent;
1038                     ; 417              break;
1040  0167 2040          	bra	LC004
1041  0169               L751:
1042                     ; 356         case OS_DEL_NO_PEND:                               /* DELETE MUTEX ONLY IF NO TASK WAITING --- */
1042                     ; 357              if (tasks_waiting == OS_FALSE) {
1044  0169 e684          	ldab	OFST-2,s
1045  016b 2634          	bne	L154
1046                     ; 359                  pevent->OSEventName   = (INT8U *)(void *)"?";
1048  016d cc0000        	ldd	#L551
1049  0170 6c4e          	std	14,y
1050                     ; 361                  pcp                   = (INT8U)(pevent->OSEventCnt >> 8u);
1052  0172 e643          	ldab	3,y
1053  0174 6b82          	stab	OFST-4,s
1054                     ; 362                  if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
1056  0176 c1ff          	cmpb	#255
1057  0178 270c          	beq	L354
1058                     ; 363                      OSTCBPrioTbl[pcp] = (OS_TCB *)0;      /* Free up the PCP                          */
1060  017a 87            	clra	
1061  017b 59            	lsld	
1062  017c b746          	tfr	d,y
1063  017e 87            	clra	
1064  017f c7            	clrb	
1065  0180 6cea0000      	std	_OSTCBPrioTbl,y
1066  0184 ed86          	ldy	OFST+0,s
1067  0186               L354:
1068                     ; 365                  pevent->OSEventType   = OS_EVENT_TYPE_UNUSED;
1070  0186 87            	clra	
1071  0187 6a40          	staa	0,y
1072                     ; 366                  pevent->OSEventPtr    = OSEventFreeList;  /* Return Event Control Block to free list  */
1074  0189 1801410000    	movw	_OSEventFreeList,1,y
1075                     ; 367                  pevent->OSEventCnt    = 0u;
1077  018e c7            	clrb	
1078  018f 6c43          	std	3,y
1079                     ; 368                  OSEventFreeList       = pevent;
1081  0191 7d0000        	sty	_OSEventFreeList
1082                     ; 369                  OS_EXIT_CRITICAL();
1084  0194 e683          	ldab	OFST-3,s
1085  0196 160000        	jsr	_OS_CPU_SR_Restore
1087                     ; 370                  *perr                 = OS_ERR_NONE;
1089  0199 87            	clra	
1090  019a 6af3000c      	staa	[OFST+6,s]
1091                     ; 371                  pevent_return         = (OS_EVENT *)0;    /* Mutex has been deleted                   */
1093  019e c7            	clrb	
1095  019f 200e          	bra	LC003
1096  01a1               L154:
1097                     ; 373                  OS_EXIT_CRITICAL();
1099  01a1 e683          	ldab	OFST-3,s
1100  01a3 87            	clra	
1101  01a4 160000        	jsr	_OS_CPU_SR_Restore
1103                     ; 374                  *perr                 = OS_ERR_TASK_WAITING;
1105  01a7 c649          	ldab	#73
1106                     ; 375                  pevent_return         = pevent;
1108  01a9               LC004:
1109  01a9 6bf3000c      	stab	[OFST+6,s]
1110  01ad ec86          	ldd	OFST+0,s
1111  01af               LC003:
1112  01af 6c80          	std	OFST-6,s
1113  01b1 2075          	bra	L744
1114  01b3               L161:
1115                     ; 379         case OS_DEL_ALWAYS:                                /* ALWAYS DELETE THE MUTEX ---------------- */
1115                     ; 380              pcp  = (INT8U)(pevent->OSEventCnt >> 8u);                       /* Get PCP of mutex       */
1117  01b3 e643          	ldab	3,y
1118  01b5 6b82          	stab	OFST-4,s
1119                     ; 381              if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
1121  01b7 04812e        	ibeq	b,L764
1122                     ; 382                  prio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8); /* Get owner's orig prio  */
1124  01ba 180a4485      	movb	4,y,OFST-1,s
1125                     ; 383                  ptcb = (OS_TCB *)pevent->OSEventPtr;
1127  01be ed41          	ldy	1,y
1128  01c0 6d80          	sty	OFST-6,s
1129                     ; 384                  if (ptcb != (OS_TCB *)0) {                /* See if any task owns the mutex           */
1131  01c2 2724          	beq	L764
1132                     ; 385                      if (ptcb->OSTCBPrio == pcp) {         /* See if original prio was changed         */
1134  01c4 e6e824        	ldab	36,y
1135  01c7 e182          	cmpb	OFST-4,s
1136  01c9 261d          	bne	L764
1137                     ; 387                          OSMutex_RdyAtPrio(ptcb, prio);    /* Yes, Restore the task's original prio    */
1140  01cb e685          	ldab	OFST-1,s
1141  01cd 87            	clra	
1142  01ce 3b            	pshd	
1143  01cf b764          	tfr	y,d
1144  01d1 160541        	jsr	L3_OSMutex_RdyAtPrio
1146  01d4 1b82          	leas	2,s
1147  01d6 2010          	bra	L764
1148  01d8               L564:
1149                     ; 392                  (void)OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MUTEX, OS_STAT_PEND_ABORT);
1151  01d8 cc0002        	ldd	#2
1152  01db 3b            	pshd	
1153  01dc c610          	ldab	#16
1154  01de 3b            	pshd	
1155  01df c7            	clrb	
1156  01e0 3b            	pshd	
1157  01e1 b764          	tfr	y,d
1158  01e3 160000        	jsr	_OS_EventTaskRdy
1160  01e6 1b86          	leas	6,s
1161  01e8               L764:
1162                     ; 391              while (pevent->OSEventGrp != 0u) {            /* Ready ALL tasks waiting for mutex        */
1164  01e8 ed86          	ldy	OFST+0,s
1165  01ea e645          	ldab	5,y
1166  01ec 26ea          	bne	L564
1167                     ; 395              pevent->OSEventName   = (INT8U *)(void *)"?";
1169  01ee cc0000        	ldd	#L551
1170  01f1 6c4e          	std	14,y
1171                     ; 397              pcp                   = (INT8U)(pevent->OSEventCnt >> 8u);
1173  01f3 e643          	ldab	3,y
1174  01f5 6b82          	stab	OFST-4,s
1175                     ; 398              if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
1177  01f7 c1ff          	cmpb	#255
1178  01f9 270c          	beq	L374
1179                     ; 399                  OSTCBPrioTbl[pcp] = (OS_TCB *)0;          /* Free up the PCP                          */
1181  01fb 87            	clra	
1182  01fc 59            	lsld	
1183  01fd b746          	tfr	d,y
1184  01ff 87            	clra	
1185  0200 c7            	clrb	
1186  0201 6cea0000      	std	_OSTCBPrioTbl,y
1187  0205 ed86          	ldy	OFST+0,s
1188  0207               L374:
1189                     ; 401              pevent->OSEventType   = OS_EVENT_TYPE_UNUSED;
1191  0207 87            	clra	
1192  0208 6a40          	staa	0,y
1193                     ; 402              pevent->OSEventPtr    = OSEventFreeList;      /* Return Event Control Block to free list  */
1195  020a 1801410000    	movw	_OSEventFreeList,1,y
1196                     ; 403              pevent->OSEventCnt    = 0u;
1198  020f c7            	clrb	
1199  0210 6c43          	std	3,y
1200                     ; 404              OSEventFreeList       = pevent;               /* Get next free event control block        */
1202  0212 7d0000        	sty	_OSEventFreeList
1203                     ; 405              OS_EXIT_CRITICAL();
1205  0215 e683          	ldab	OFST-3,s
1206  0217 160000        	jsr	_OS_CPU_SR_Restore
1208                     ; 406              if (tasks_waiting == OS_TRUE) {               /* Reschedule only if task(s) were waiting  */
1210  021a e684          	ldab	OFST-2,s
1211  021c 042103        	dbne	b,L574
1212                     ; 407                  OS_Sched();                               /* Find highest priority task ready to run  */
1214  021f 160000        	jsr	_OS_Sched
1216  0222               L574:
1217                     ; 409              *perr         = OS_ERR_NONE;
1219  0222 87            	clra	
1220  0223 6af3000c      	staa	[OFST+6,s]
1221                     ; 410              pevent_return = (OS_EVENT *)0;                /* Mutex has been deleted                   */
1223  0227 c7            	clrb	
1224                     ; 411              break;
1226  0228               L744:
1227                     ; 422     return (pevent_return);
1232  0228 1b88          	leas	8,s
1233  022a 3d            	rts	
1356                     ; 467 _NEAR void  OSMutexPend (OS_EVENT  *pevent,
1356                     ; 468                         INT32U     timeout,
1356                     ; 469                         INT8U     *perr)
1356                     ; 470 {
1357                     	switch	.text
1358  022b               _OSMutexPend:
1360  022b 3b            	pshd	
1361  022c 1b99          	leas	-7,s
1362       00000007      OFST:	set	7
1365                     ; 478     OS_CPU_SR  cpu_sr = 0u;
1367                     ; 490     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
1369  022e 046404        	tbne	d,L165
1370                     ; 491         *perr = OS_ERR_PEVENT_NULL;
1372  0231 c604          	ldab	#4
1373                     ; 492         return;
1375  0233 200a          	bra	LC005
1376  0235               L165:
1377                     ; 498     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
1380  0235 e6f30007      	ldab	[OFST+0,s]
1381  0239 c104          	cmpb	#4
1382  023b 2709          	beq	L365
1383                     ; 499         *perr = OS_ERR_EVENT_TYPE;
1385  023d c601          	ldab	#1
1386  023f               LC005:
1387  023f 6bf3000f      	stab	[OFST+8,s]
1388                     ; 501         return;
1389  0243               L23:
1393  0243 1b89          	leas	9,s
1394  0245 3d            	rts	
1395  0246               L365:
1396                     ; 503     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
1398  0246 f60000        	ldab	_OSIntNesting
1399  0249 2704          	beq	L565
1400                     ; 504         *perr = OS_ERR_PEND_ISR;                           /* ... can't PEND from an ISR               */
1402  024b c602          	ldab	#2
1403                     ; 506         return;
1406  024d 20f0          	bra	LC005
1407  024f               L565:
1408                     ; 508     if (OSLockNesting > 0u) {                              /* See if called with scheduler locked ...  */
1410  024f f60000        	ldab	_OSLockNesting
1411  0252 2704          	beq	L765
1412                     ; 509         *perr = OS_ERR_PEND_LOCKED;                        /* ... can't PEND when locked               */
1414  0254 c60d          	ldab	#13
1415                     ; 511         return;
1418  0256 20e7          	bra	LC005
1419  0258               L765:
1420                     ; 514     OS_ENTER_CRITICAL();
1422  0258 160000        	jsr	_OS_CPU_SR_Save
1424  025b 6b86          	stab	OFST-1,s
1425                     ; 515     pcp = (INT8U)(pevent->OSEventCnt >> 8u);               /* Get PCP from mutex                       */
1427  025d ed87          	ldy	OFST+0,s
1428  025f 180a4385      	movb	3,y,OFST-2,s
1429                     ; 517     if ((INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8) == OS_MUTEX_AVAILABLE) {
1431  0263 e644          	ldab	4,y
1432  0265 04a135        	ibne	b,L175
1433                     ; 518         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;       /* Yes, Acquire the resource                */
1435  0268 87            	clra	
1436  0269 6a44          	staa	4,y
1437                     ; 519         pevent->OSEventCnt |= (INT16U)OSTCBCur->OSTCBPrio; /*      Save priority of owning task        */
1439  026b fe0000        	ldx	_OSTCBCur
1440  026e e6e024        	ldab	36,x
1441  0271 ea44          	orab	4,y
1442  0273 aa43          	oraa	3,y
1443  0275 6c43          	std	3,y
1444                     ; 520         pevent->OSEventPtr  = (void *)OSTCBCur;            /*      Point to owning task's OS_TCB       */
1446  0277 6e41          	stx	1,y
1447                     ; 521         if ((pcp != OS_PRIO_MUTEX_CEIL_DIS) &&
1447                     ; 522             (OSTCBCur->OSTCBPrio <= pcp)) {                /*      PCP 'must' have a SMALLER prio ...  */
1449  0279 e685          	ldab	OFST-2,s
1450  027b 048113        	ibeq	b,L375
1452  027e b756          	tfr	x,y
1453  0280 e6e824        	ldab	36,y
1454  0283 e185          	cmpb	OFST-2,s
1455  0285 220a          	bhi	L375
1456                     ; 523              OS_EXIT_CRITICAL();                           /*      ... than current task!              */
1458  0287 e686          	ldab	OFST-1,s
1459  0289 87            	clra	
1460  028a 160000        	jsr	_OS_CPU_SR_Restore
1462                     ; 524             *perr = OS_ERR_PCP_LOWER;
1464  028d c678          	ldab	#120
1466  028f 20ae          	bra	LC005
1467  0291               L375:
1468                     ; 526              OS_EXIT_CRITICAL();
1470  0291 e686          	ldab	OFST-1,s
1471  0293 87            	clra	
1472  0294 160000        	jsr	_OS_CPU_SR_Restore
1474                     ; 527             *perr = OS_ERR_NONE;
1476  0297 69f3000f      	clr	[OFST+8,s]
1477                     ; 530         return;
1480  029b 20a6          	bra	L23
1481  029d               L175:
1482                     ; 532     if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
1484  029d e685          	ldab	OFST-2,s
1485  029f 52            	incb	
1486  02a0 182700f4      	beq	L775
1487                     ; 533         mprio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8); /*  Get priority of mutex owner   */
1489  02a4 180a4482      	movb	4,y,OFST-5,s
1490                     ; 534         ptcb  = (OS_TCB *)(pevent->OSEventPtr);                   /*     Point to TCB of mutex owner   */
1492  02a8 ed41          	ldy	1,y
1493  02aa 6d80          	sty	OFST-7,s
1494                     ; 535         if (ptcb->OSTCBPrio > pcp) {                              /*     Need to promote prio of owner?*/
1496  02ac e6e824        	ldab	36,y
1497  02af e185          	cmpb	OFST-2,s
1498  02b1 182300e3      	bls	L775
1499                     ; 536             if (mprio > OSTCBCur->OSTCBPrio) {
1501  02b5 e682          	ldab	OFST-5,s
1502  02b7 fd0000        	ldy	_OSTCBCur
1503  02ba e1e824        	cmpb	36,y
1504  02bd 182300d7      	bls	L775
1505                     ; 537                 y = ptcb->OSTCBY;
1507  02c1 ed80          	ldy	OFST-7,s
1508  02c3 e6e826        	ldab	38,y
1509  02c6 6b82          	stab	OFST-5,s
1510                     ; 538                 if ((OSRdyTbl[y] & ptcb->OSTCBBitX) != 0u) {      /*     See if mutex owner is ready   */
1512  02c8 b796          	exg	b,y
1513  02ca ee80          	ldx	OFST-7,s
1514  02cc e6e027        	ldab	39,x
1515  02cf e4ea0000      	andb	_OSRdyTbl,y
1516  02d3 2720          	beq	L506
1517                     ; 539                     OSRdyTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;     /*     Yes, Remove owner from Rdy ...*/
1519  02d5 e6e027        	ldab	39,x
1520  02d8 51            	comb	
1521  02d9 e4ea0000      	andb	_OSRdyTbl,y
1522  02dd 6bea0000      	stab	_OSRdyTbl,y
1523                     ; 540                     if (OSRdyTbl[y] == 0u) {                      /*          ... list at current prio */
1525  02e1 260c          	bne	L706
1526                     ; 541                         OSRdyGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
1528  02e3 b756          	tfr	x,y
1529  02e5 e6e828        	ldab	40,y
1530  02e8 51            	comb	
1531  02e9 f40000        	andb	_OSRdyGrp
1532  02ec 7b0000        	stab	_OSRdyGrp
1533  02ef               L706:
1534                     ; 543                     rdy = OS_TRUE;
1536  02ef c601          	ldab	#1
1537  02f1 6b82          	stab	OFST-5,s
1539  02f3 2028          	bra	L116
1540  02f5               L506:
1541                     ; 545                     pevent2 = ptcb->OSTCBEventPtr;
1543  02f5 b756          	tfr	x,y
1544  02f7 ece812        	ldd	18,y
1545  02fa 6c83          	std	OFST-4,s
1546                     ; 546                     if (pevent2 != (OS_EVENT *)0) {               /* Remove from event wait list       */
1548  02fc 271d          	beq	L316
1549                     ; 547                         y = ptcb->OSTCBY;
1551  02fe e6e826        	ldab	38,y
1552  0301 6b82          	stab	OFST-5,s
1553                     ; 548                         pevent2->OSEventTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;
1555  0303 ed83          	ldy	OFST-4,s
1556  0305 19ed          	leay	b,y
1557  0307 e6e027        	ldab	39,x
1558  030a 51            	comb	
1559  030b e446          	andb	6,y
1560  030d 6b46          	stab	6,y
1561                     ; 549                         if (pevent2->OSEventTbl[y] == 0u) {
1563  030f 260a          	bne	L316
1564                     ; 550                             pevent2->OSEventGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
1566  0311 ed83          	ldy	OFST-4,s
1567  0313 e6e028        	ldab	40,x
1568  0316 51            	comb	
1569  0317 e445          	andb	5,y
1570  0319 6b45          	stab	5,y
1571  031b               L316:
1572                     ; 553                     rdy = OS_FALSE;                        /* No                                       */
1574  031b 6982          	clr	OFST-5,s
1575  031d               L116:
1576                     ; 555                 ptcb->OSTCBPrio = pcp;                     /* Change owner task prio to PCP            */
1578  031d e685          	ldab	OFST-2,s
1579  031f ed80          	ldy	OFST-7,s
1580  0321 6be824        	stab	36,y
1581                     ; 560                 ptcb->OSTCBY    = (INT8U)( ptcb->OSTCBPrio >> 3u);
1584  0324 54            	lsrb	
1585  0325 54            	lsrb	
1586  0326 54            	lsrb	
1587  0327 6be826        	stab	38,y
1588                     ; 561                 ptcb->OSTCBX    = (INT8U)( ptcb->OSTCBPrio & 0x07u);
1590  032a e6e824        	ldab	36,y
1591  032d c407          	andb	#7
1592  032f 6be825        	stab	37,y
1593                     ; 566                 ptcb->OSTCBBitY = (OS_PRIO)(1uL << ptcb->OSTCBY);
1595  0332 c601          	ldab	#1
1596  0334 a6e826        	ldaa	38,y
1597  0337 2704          	beq	L22
1598  0339               L42:
1599  0339 58            	lslb	
1600  033a 0430fc        	dbne	a,L42
1601  033d               L22:
1602  033d 6be828        	stab	40,y
1603                     ; 567                 ptcb->OSTCBBitX = (OS_PRIO)(1uL << ptcb->OSTCBX);
1605  0340 c601          	ldab	#1
1606  0342 a6e825        	ldaa	37,y
1607  0345 2704          	beq	L62
1608  0347               L03:
1609  0347 58            	lslb	
1610  0348 0430fc        	dbne	a,L03
1611  034b               L62:
1612  034b 6be827        	stab	39,y
1613                     ; 569                 if (rdy == OS_TRUE) {                      /* If task was ready at owner's priority ...*/
1615  034e e682          	ldab	OFST-5,s
1616  0350 04211d        	dbne	b,L716
1617                     ; 570                     OSRdyGrp               |= ptcb->OSTCBBitY; /* ... make it ready at new priority.   */
1619  0353 e6e828        	ldab	40,y
1620  0356 fa0000        	orab	_OSRdyGrp
1621  0359 7b0000        	stab	_OSRdyGrp
1622                     ; 571                     OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
1624  035c e6e826        	ldab	38,y
1625  035f b796          	exg	b,y
1626  0361 ee80          	ldx	OFST-7,s
1627  0363 e6e027        	ldab	39,x
1628  0366 eaea0000      	orab	_OSRdyTbl,y
1629  036a 6bea0000      	stab	_OSRdyTbl,y
1631  036e 201c          	bra	L126
1632  0370               L716:
1633                     ; 573                     pevent2 = ptcb->OSTCBEventPtr;
1635  0370 ede812        	ldy	18,y
1636  0373 6d83          	sty	OFST-4,s
1637                     ; 574                     if (pevent2 != (OS_EVENT *)0) {        /* Add to event wait list                   */
1639  0375 2715          	beq	L126
1640                     ; 575                         pevent2->OSEventGrp               |= ptcb->OSTCBBitY;
1642  0377 ee80          	ldx	OFST-7,s
1643  0379 e6e028        	ldab	40,x
1644  037c ea45          	orab	5,y
1645  037e 6b45          	stab	5,y
1646                     ; 576                         pevent2->OSEventTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
1648  0380 e6e026        	ldab	38,x
1649  0383 19ed          	leay	b,y
1650  0385 e6e027        	ldab	39,x
1651  0388 ea46          	orab	6,y
1652  038a 6b46          	stab	6,y
1653  038c               L126:
1654                     ; 579                 OSTCBPrioTbl[pcp] = ptcb;
1656  038c e685          	ldab	OFST-2,s
1657  038e 87            	clra	
1658  038f 59            	lsld	
1659  0390 b746          	tfr	d,y
1660  0392 ec80          	ldd	OFST-7,s
1661  0394 6cea0000      	std	_OSTCBPrioTbl,y
1662  0398               L775:
1663                     ; 583     OSTCBCur->OSTCBStat     |= OS_STAT_MUTEX;         /* Mutex not available, pend current task        */
1665  0398 fd0000        	ldy	_OSTCBCur
1666  039b 0ce82210      	bset	34,y,16
1667                     ; 584     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
1669  039f 69e823        	clr	35,y
1670                     ; 585     OSTCBCur->OSTCBDly       = timeout;               /* Store timeout in current task's TCB           */
1672  03a2 ec8d          	ldd	OFST+6,s
1673  03a4 6ce820        	std	32,y
1674  03a7 ec8b          	ldd	OFST+4,s
1675  03a9 6ce81e        	std	30,y
1676                     ; 586     OS_EventTaskWait(pevent);                         /* Suspend task until event or timeout occurs    */
1678  03ac ec87          	ldd	OFST+0,s
1679  03ae 160000        	jsr	_OS_EventTaskWait
1681                     ; 587     OS_EXIT_CRITICAL();
1683  03b1 e686          	ldab	OFST-1,s
1684  03b3 87            	clra	
1685  03b4 160000        	jsr	_OS_CPU_SR_Restore
1687                     ; 588     OS_Sched();                                       /* Find next highest priority task ready         */
1689  03b7 160000        	jsr	_OS_Sched
1691                     ; 589     OS_ENTER_CRITICAL();
1693  03ba 160000        	jsr	_OS_CPU_SR_Save
1695  03bd 6b86          	stab	OFST-1,s
1696                     ; 590     switch (OSTCBCur->OSTCBStatPend) {                /* See if we timed-out or aborted                */
1698  03bf fd0000        	ldy	_OSTCBCur
1699  03c2 e6e823        	ldab	35,y
1701  03c5 2708          	beq	L774
1702  03c7 04010f        	dbeq	b,L305
1703  03ca 040108        	dbeq	b,L105
1704  03cd 200a          	bra	L305
1705  03cf               L774:
1706                     ; 591         case OS_STAT_PEND_OK:
1706                     ; 592              *perr = OS_ERR_NONE;
1708  03cf 69f3000f      	clr	[OFST+8,s]
1709                     ; 593              break;
1711  03d3 2017          	bra	L726
1712  03d5               L105:
1713                     ; 595         case OS_STAT_PEND_ABORT:
1713                     ; 596              *perr = OS_ERR_PEND_ABORT;               /* Indicate that we aborted getting mutex        */
1715  03d5 c60e          	ldab	#14
1716                     ; 597              break;
1718  03d7 200c          	bra	LC006
1719  03d9               L305:
1720                     ; 599         case OS_STAT_PEND_TO:
1720                     ; 600         default:
1720                     ; 601              OS_EventTaskRemove(OSTCBCur, pevent);
1722  03d9 ec87          	ldd	OFST+0,s
1723  03db 3b            	pshd	
1724  03dc b764          	tfr	y,d
1725  03de 160000        	jsr	_OS_EventTaskRemove
1727  03e1 1b82          	leas	2,s
1728                     ; 602              *perr = OS_ERR_TIMEOUT;                  /* Indicate that we didn't get mutex within TO   */
1730  03e3 c60a          	ldab	#10
1731  03e5               LC006:
1732  03e5 6bf3000f      	stab	[OFST+8,s]
1733                     ; 603              break;
1735  03e9 fd0000        	ldy	_OSTCBCur
1736  03ec               L726:
1737                     ; 605     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;      /* Set   task  status to ready                   */
1739  03ec c7            	clrb	
1740  03ed 6be822        	stab	34,y
1741                     ; 606     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;  /* Clear pend  status                            */
1743  03f0 87            	clra	
1744  03f1 6ae823        	staa	35,y
1745                     ; 607     OSTCBCur->OSTCBEventPtr      = (OS_EVENT  *)0;    /* Clear event pointers                          */
1747  03f4 6ce812        	std	18,y
1748                     ; 609     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;
1750  03f7 6ce814        	std	20,y
1751                     ; 610     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
1753  03fa 6ce816        	std	22,y
1754                     ; 612     OS_EXIT_CRITICAL();
1756  03fd e686          	ldab	OFST-1,s
1757  03ff 160000        	jsr	_OS_CPU_SR_Restore
1759                     ; 615 }
1763  0402 1b89          	leas	9,s
1764  0404 3d            	rts	
1829                     ; 642 _NEAR INT8U  OSMutexPost (OS_EVENT *pevent)
1829                     ; 643 {
1830                     	switch	.text
1831  0405               _OSMutexPost:
1833  0405 3b            	pshd	
1834  0406 1b9d          	leas	-3,s
1835       00000003      OFST:	set	3
1838                     ; 647     OS_CPU_SR  cpu_sr = 0u;
1840                     ; 651     if (OSIntNesting > 0u) {                          /* See if called from ISR ...                    */
1842  0408 f60000        	ldab	_OSIntNesting
1843  040b 2704          	beq	L756
1844                     ; 652         return (OS_ERR_POST_ISR);                     /* ... can't POST mutex from an ISR              */
1846  040d c605          	ldab	#5
1848  040f 2006          	bra	L63
1849  0411               L756:
1850                     ; 655     if (pevent == (OS_EVENT *)0) {                    /* Validate 'pevent'                             */
1852  0411 ec83          	ldd	OFST+0,s
1853  0413 2605          	bne	L166
1854                     ; 656         return (OS_ERR_PEVENT_NULL);
1856  0415 c604          	ldab	#4
1858  0417               L63:
1860  0417 1b85          	leas	5,s
1861  0419 3d            	rts	
1862  041a               L166:
1863                     ; 662     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) { /* Validate event block type                     */
1866  041a e6f30003      	ldab	[OFST+0,s]
1867  041e c104          	cmpb	#4
1868  0420 2704          	beq	L366
1869                     ; 664         return (OS_ERR_EVENT_TYPE);
1872  0422 c601          	ldab	#1
1874  0424 20f1          	bra	L63
1875  0426               L366:
1876                     ; 666     OS_ENTER_CRITICAL();
1878  0426 160000        	jsr	_OS_CPU_SR_Save
1880  0429 6b82          	stab	OFST-1,s
1881                     ; 667     pcp  = (INT8U)(pevent->OSEventCnt >> 8u);         /* Get priority ceiling priority of mutex        */
1883  042b ed83          	ldy	OFST+0,s
1884  042d 180a4380      	movb	3,y,OFST-3,s
1885                     ; 668     prio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);  /* Get owner's original priority      */
1887  0431 180a4481      	movb	4,y,OFST-2,s
1888                     ; 669     if (OSTCBCur != (OS_TCB *)pevent->OSEventPtr) {   /* See if posting task owns the MUTEX            */
1890  0435 fc0000        	ldd	_OSTCBCur
1891  0438 ac41          	cpd	1,y
1892  043a 270a          	beq	L566
1893                     ; 670         OS_EXIT_CRITICAL();
1895  043c e682          	ldab	OFST-1,s
1896  043e 87            	clra	
1897  043f 160000        	jsr	_OS_CPU_SR_Restore
1899                     ; 672         return (OS_ERR_NOT_MUTEX_OWNER);
1902  0442 c664          	ldab	#100
1904  0444 20d1          	bra	L63
1905  0446               L566:
1906                     ; 674     if (pcp != OS_PRIO_MUTEX_CEIL_DIS) {
1908  0446 e680          	ldab	OFST-3,s
1909  0448 048124        	ibeq	b,L766
1910                     ; 675         if (OSTCBCur->OSTCBPrio == pcp) {             /* Did we have to raise current task's priority? */
1912  044b fd0000        	ldy	_OSTCBCur
1913  044e e6e824        	ldab	36,y
1914  0451 e180          	cmpb	OFST-3,s
1915  0453 260b          	bne	L176
1916                     ; 677             OSMutex_RdyAtPrio(OSTCBCur, prio);        /* Restore the task's original priority          */
1919  0455 e681          	ldab	OFST-2,s
1920  0457 87            	clra	
1921  0458 3b            	pshd	
1922  0459 b764          	tfr	y,d
1923  045b 160541        	jsr	L3_OSMutex_RdyAtPrio
1925  045e 1b82          	leas	2,s
1926  0460               L176:
1927                     ; 679         OSTCBPrioTbl[pcp] = OS_TCB_RESERVED;          /* Reserve table entry                           */
1929  0460 e680          	ldab	OFST-3,s
1930  0462 87            	clra	
1931  0463 59            	lsld	
1932  0464 b746          	tfr	d,y
1933  0466 cc0001        	ldd	#1
1934  0469 6cea0000      	std	_OSTCBPrioTbl,y
1935  046d ed83          	ldy	OFST+0,s
1936  046f               L766:
1937                     ; 681     if (pevent->OSEventGrp != 0u) {                   /* Any task waiting for the mutex?               */
1939  046f e645          	ldab	5,y
1940  0471 274f          	beq	L376
1941                     ; 683         prio                = OS_EventTaskRdy(pevent, (void *)0, OS_STAT_MUTEX, OS_STAT_PEND_OK);
1943  0473 87            	clra	
1944  0474 c7            	clrb	
1945  0475 3b            	pshd	
1946  0476 c610          	ldab	#16
1947  0478 3b            	pshd	
1948  0479 c7            	clrb	
1949  047a 3b            	pshd	
1950  047b ec89          	ldd	OFST+6,s
1951  047d 160000        	jsr	_OS_EventTaskRdy
1953  0480 1b86          	leas	6,s
1954  0482 6b81          	stab	OFST-2,s
1955                     ; 684         pevent->OSEventCnt &= OS_MUTEX_KEEP_UPPER_8;  /*      Save priority of mutex's new owner       */
1957  0484 ed83          	ldy	OFST+0,s
1958  0486 87            	clra	
1959  0487 6a44          	staa	4,y
1960                     ; 685         pevent->OSEventCnt |= (INT16U)prio;
1962  0489 ea44          	orab	4,y
1963  048b aa43          	oraa	3,y
1964  048d 6c43          	std	3,y
1965                     ; 686         pevent->OSEventPtr  = OSTCBPrioTbl[prio];     /*      Link to new mutex owner's OS_TCB         */
1967  048f e681          	ldab	OFST-2,s
1968  0491 87            	clra	
1969  0492 59            	lsld	
1970  0493 b746          	tfr	d,y
1971  0495 ecea0000      	ldd	_OSTCBPrioTbl,y
1972  0499 ee83          	ldx	OFST+0,s
1973  049b 6c01          	std	1,x
1974                     ; 687         if ((pcp  != OS_PRIO_MUTEX_CEIL_DIS) &&
1974                     ; 688             (prio <= pcp)) {                          /*      PCP 'must' have a SMALLER prio ...       */
1976  049d e680          	ldab	OFST-3,s
1977  049f 048113        	ibeq	b,L576
1979  04a2 e681          	ldab	OFST-2,s
1980  04a4 e180          	cmpb	OFST-3,s
1981  04a6 220d          	bhi	L576
1982                     ; 689             OS_EXIT_CRITICAL();                       /*      ... than current task!                   */
1984  04a8 e682          	ldab	OFST-1,s
1985  04aa 87            	clra	
1986  04ab 160000        	jsr	_OS_CPU_SR_Restore
1988                     ; 690             OS_Sched();                               /*      Find highest priority task ready to run  */
1990  04ae 160000        	jsr	_OS_Sched
1992                     ; 692             return (OS_ERR_PCP_LOWER);
1995  04b1 c678          	ldab	#120
1997  04b3 200a          	bra	L04
1998  04b5               L576:
1999                     ; 694             OS_EXIT_CRITICAL();
2001  04b5 e682          	ldab	OFST-1,s
2002  04b7 87            	clra	
2003  04b8 160000        	jsr	_OS_CPU_SR_Restore
2005                     ; 695             OS_Sched();                               /*      Find highest priority task ready to run  */
2007  04bb 160000        	jsr	_OS_Sched
2009                     ; 697             return (OS_ERR_NONE);
2012  04be               LC007:
2013  04be c7            	clrb	
2015  04bf               L04:
2017  04bf 1b85          	leas	5,s
2018  04c1 3d            	rts	
2019  04c2               L376:
2020                     ; 700     pevent->OSEventCnt |= OS_MUTEX_AVAILABLE;         /* No,  Mutex is now available                   */
2022  04c2 0c44ff        	bset	4,y,255
2023                     ; 701     pevent->OSEventPtr  = (void *)0;
2025  04c5 87            	clra	
2026  04c6 6c41          	std	1,y
2027                     ; 702     OS_EXIT_CRITICAL();
2029  04c8 e682          	ldab	OFST-1,s
2030  04ca 160000        	jsr	_OS_CPU_SR_Restore
2032                     ; 704     return (OS_ERR_NONE);
2036  04cd 20ef          	bra	LC007
2166                     ; 727 _NEAR INT8U  OSMutexQuery (OS_EVENT       *pevent,
2166                     ; 728                           OS_MUTEX_DATA  *p_mutex_data)
2166                     ; 729 {
2167                     	switch	.text
2168  04cf               _OSMutexQuery:
2170  04cf 3b            	pshd	
2171  04d0 1b9a          	leas	-6,s
2172       00000006      OFST:	set	6
2175                     ; 734     OS_CPU_SR   cpu_sr = 0u;
2177                     ; 739     if (OSIntNesting > 0u) {                               /* See if called from ISR ...               */
2179  04d2 f60000        	ldab	_OSIntNesting
2180  04d5 2704          	beq	L367
2181                     ; 740         return (OS_ERR_QUERY_ISR);                         /* ... can't QUERY mutex from an ISR        */
2183  04d7 c606          	ldab	#6
2185  04d9 2006          	bra	L44
2186  04db               L367:
2187                     ; 743     if (pevent == (OS_EVENT *)0) {                         /* Validate 'pevent'                        */
2189  04db ec86          	ldd	OFST+0,s
2190  04dd 2605          	bne	L567
2191                     ; 744         return (OS_ERR_PEVENT_NULL);
2193  04df c604          	ldab	#4
2195  04e1               L44:
2197  04e1 1b88          	leas	8,s
2198  04e3 3d            	rts	
2199  04e4               L567:
2200                     ; 746     if (p_mutex_data == (OS_MUTEX_DATA *)0) {              /* Validate 'p_mutex_data'                  */
2202  04e4 ec8a          	ldd	OFST+4,s
2203  04e6 2604          	bne	L767
2204                     ; 747         return (OS_ERR_PDATA_NULL);
2206  04e8 c609          	ldab	#9
2208  04ea 20f5          	bra	L44
2209  04ec               L767:
2210                     ; 750     if (pevent->OSEventType != OS_EVENT_TYPE_MUTEX) {      /* Validate event block type                */
2212  04ec e6f30006      	ldab	[OFST+0,s]
2213  04f0 c104          	cmpb	#4
2214  04f2 2704          	beq	L177
2215                     ; 751         return (OS_ERR_EVENT_TYPE);
2217  04f4 c601          	ldab	#1
2219  04f6 20e9          	bra	L44
2220  04f8               L177:
2221                     ; 753     OS_ENTER_CRITICAL();
2223  04f8 160000        	jsr	_OS_CPU_SR_Save
2225  04fb 6b85          	stab	OFST-1,s
2226                     ; 754     p_mutex_data->OSMutexPCP  = (INT8U)(pevent->OSEventCnt >> 8u);
2228  04fd ee86          	ldx	OFST+0,s
2229  04ff ed8a          	ldy	OFST+4,s
2230  0501 180a034b      	movb	3,x,11,y
2231                     ; 755     p_mutex_data->OSOwnerPrio = (INT8U)(pevent->OSEventCnt & OS_MUTEX_KEEP_LOWER_8);
2233  0505 e604          	ldab	4,x
2234  0507 6b4a          	stab	10,y
2235                     ; 756     if (p_mutex_data->OSOwnerPrio == 0xFFu) {
2237  0509 04a106        	ibne	b,L377
2238                     ; 757         p_mutex_data->OSValue = OS_TRUE;
2240  050c c601          	ldab	#1
2241  050e 6b49          	stab	9,y
2243  0510 2002          	bra	L577
2244  0512               L377:
2245                     ; 759         p_mutex_data->OSValue = OS_FALSE;
2247  0512 6949          	clr	9,y
2248  0514               L577:
2249                     ; 761     p_mutex_data->OSEventGrp  = pevent->OSEventGrp;        /* Copy wait list                           */
2251  0514 180a0548      	movb	5,x,8,y
2252                     ; 762     psrc                      = &pevent->OSEventTbl[0];
2254  0518 ed86          	ldy	OFST+0,s
2255  051a 1946          	leay	6,y
2256  051c 6d81          	sty	OFST-5,s
2257                     ; 763     pdest                     = &p_mutex_data->OSEventTbl[0];
2259  051e 18028a83      	movw	OFST+4,s,OFST-3,s
2260                     ; 764     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
2262  0522 6980          	clr	OFST-6,s
2263  0524 ee81          	ldx	OFST-5,s
2264  0526 ed83          	ldy	OFST-3,s
2265  0528               L777:
2266                     ; 765         *pdest++ = *psrc++;
2268  0528 180a3070      	movb	1,x+,1,y+
2269                     ; 764     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
2271  052c 6280          	inc	OFST-6,s
2274  052e e680          	ldab	OFST-6,s
2275  0530 c108          	cmpb	#8
2276  0532 25f4          	blo	L777
2277  0534 6e81          	stx	OFST-5,s
2278  0536 6d83          	sty	OFST-3,s
2279                     ; 767     OS_EXIT_CRITICAL();
2281  0538 e685          	ldab	OFST-1,s
2282  053a 87            	clra	
2283  053b 160000        	jsr	_OS_CPU_SR_Restore
2285                     ; 768     return (OS_ERR_NONE);
2287  053e c7            	clrb	
2289  053f 20a0          	bra	L44
2343                     ; 787 static  void  OSMutex_RdyAtPrio (OS_TCB  *ptcb,
2343                     ; 788                                  INT8U    prio)
2343                     ; 789 {
2344                     	switch	.text
2345  0541               L3_OSMutex_RdyAtPrio:
2347  0541 3b            	pshd	
2348  0542 37            	pshb	
2349       00000001      OFST:	set	1
2352                     ; 793     y            =  ptcb->OSTCBY;                          /* Remove owner from ready list at 'pcp'    */
2354  0543 b746          	tfr	d,y
2355  0545 e6e826        	ldab	38,y
2356  0548 6b80          	stab	OFST-1,s
2357                     ; 794     OSRdyTbl[y] &= (OS_PRIO)~ptcb->OSTCBBitX;
2359  054a b796          	exg	b,y
2360  054c ee81          	ldx	OFST+0,s
2361  054e e6e027        	ldab	39,x
2362  0551 51            	comb	
2363  0552 e4ea0000      	andb	_OSRdyTbl,y
2364  0556 6bea0000      	stab	_OSRdyTbl,y
2365                     ; 796     if (OSRdyTbl[y] == 0u) {
2368  055a 260c          	bne	L1301
2369                     ; 797         OSRdyGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
2371  055c b756          	tfr	x,y
2372  055e e6e828        	ldab	40,y
2373  0561 51            	comb	
2374  0562 f40000        	andb	_OSRdyGrp
2375  0565 7b0000        	stab	_OSRdyGrp
2376  0568               L1301:
2377                     ; 799     ptcb->OSTCBPrio         = prio;
2379  0568 e686          	ldab	OFST+5,s
2380  056a b756          	tfr	x,y
2381  056c 6be824        	stab	36,y
2382                     ; 800     OSPrioCur               = prio;                        /* The current task is now at this priority */
2384  056f 7b0000        	stab	_OSPrioCur
2385                     ; 802     ptcb->OSTCBY            = (INT8U)((INT8U)(prio >> 3u) & 0x07u);
2387  0572 c438          	andb	#56
2388  0574 54            	lsrb	
2389  0575 54            	lsrb	
2390  0576 54            	lsrb	
2391  0577 6be826        	stab	38,y
2392                     ; 803     ptcb->OSTCBX            = (INT8U)(prio & 0x07u);
2394  057a e686          	ldab	OFST+5,s
2395  057c c407          	andb	#7
2396  057e 6be825        	stab	37,y
2397                     ; 808     ptcb->OSTCBBitY         = (OS_PRIO)(1uL << ptcb->OSTCBY);
2399  0581 c601          	ldab	#1
2400  0583 a6e826        	ldaa	38,y
2401  0586 2704          	beq	L05
2402  0588               L25:
2403  0588 58            	lslb	
2404  0589 0430fc        	dbne	a,L25
2405  058c               L05:
2406  058c 6be828        	stab	40,y
2407                     ; 809     ptcb->OSTCBBitX         = (OS_PRIO)(1uL << ptcb->OSTCBX);
2409  058f c601          	ldab	#1
2410  0591 a6e825        	ldaa	37,y
2411  0594 2704          	beq	L45
2412  0596               L65:
2413  0596 58            	lslb	
2414  0597 0430fc        	dbne	a,L65
2415  059a               L45:
2416  059a 6be827        	stab	39,y
2417                     ; 810     OSRdyGrp               |= ptcb->OSTCBBitY;             /* Make task ready at original priority     */
2419  059d e6e828        	ldab	40,y
2420  05a0 fa0000        	orab	_OSRdyGrp
2421  05a3 7b0000        	stab	_OSRdyGrp
2422                     ; 811     OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
2424  05a6 e6e826        	ldab	38,y
2425  05a9 87            	clra	
2426  05aa b746          	tfr	d,y
2427  05ac e6e027        	ldab	39,x
2428  05af eaea0000      	orab	_OSRdyTbl,y
2429  05b3 6bea0000      	stab	_OSRdyTbl,y
2430                     ; 812     OSTCBPrioTbl[prio]      = ptcb;
2432  05b7 e686          	ldab	OFST+5,s
2433  05b9 59            	lsld	
2434  05ba b746          	tfr	d,y
2435  05bc 6eea0000      	stx	_OSTCBPrioTbl,y
2436                     ; 814 }
2440  05c0 1b83          	leas	3,s
2441  05c2 3d            	rts	
2453                     	xref	_OS_Sched
2454                     	xref	_OS_EventWaitListInit
2455                     	xref	_OS_EventTaskRemove
2456                     	xref	_OS_EventTaskWait
2457                     	xref	_OS_EventTaskRdy
2458                     	xdef	_OSMutexQuery
2459                     	xdef	_OSMutexPost
2460                     	xdef	_OSMutexPend
2461                     	xdef	_OSMutexDel
2462                     	xdef	_OSMutexCreate
2463                     	xdef	_OSMutexAccept
2464                     	xref	_OSTCBPrioTbl
2465                     	xref	_OSTCBCur
2466                     	xref	_OSRdyTbl
2467                     	xref	_OSRdyGrp
2468                     	xref	_OSPrioCur
2469                     	xref	_OSLockNesting
2470                     	xref	_OSIntNesting
2471                     	xref	_OSEventFreeList
2472                     	xref	_OS_CPU_SR_Restore
2473                     	xref	_OS_CPU_SR_Save
2474                     .const:	section	.data
2475  0000               L551:
2476  0000 3f00          	dc.b	"?",0
2497                     	end

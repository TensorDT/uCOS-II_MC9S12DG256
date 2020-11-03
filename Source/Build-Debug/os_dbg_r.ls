   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
  14                     .const:	section	.data
  15  0000               _OSDebugEn:
  16  0000 0001          	dc.w	1
  17  0002               _OSEndiannessTest:
  18  0002 12345678      	dc.l	305419896
  19  0006               _OSEventEn:
  20  0006 0001          	dc.w	1
  21  0008               _OSEventMax:
  22  0008 000a          	dc.w	10
  23  000a               _OSEventNameEn:
  24  000a 0001          	dc.w	1
  25  000c               _OSEventSize:
  26  000c 0010          	dc.w	16
  27  000e               _OSEventTblSize:
  28  000e 00a0          	dc.w	160
  29  0010               _OSEventMultiEn:
  30  0010 0001          	dc.w	1
  31  0012               _OSFlagEn:
  32  0012 0001          	dc.w	1
  33  0014               _OSFlagGrpSize:
  34  0014 0007          	dc.w	7
  35  0016               _OSFlagNodeSize:
  36  0016 000b          	dc.w	11
  37  0018               _OSFlagWidth:
  38  0018 0002          	dc.w	2
  39  001a               _OSFlagMax:
  40  001a 0005          	dc.w	5
  41  001c               _OSFlagNameEn:
  42  001c 0001          	dc.w	1
  43  001e               _OSLowestPrio:
  44  001e 003f          	dc.w	63
  45  0020               _OSMboxEn:
  46  0020 0001          	dc.w	1
  47  0022               _OSMemEn:
  48  0022 0001          	dc.w	1
  49  0024               _OSMemMax:
  50  0024 0005          	dc.w	5
  51  0026               _OSMemNameEn:
  52  0026 0001          	dc.w	1
  53  0028               _OSMemSize:
  54  0028 0012          	dc.w	18
  55  002a               _OSMemTblSize:
  56  002a 005a          	dc.w	90
  57  002c               _OSMutexEn:
  58  002c 0001          	dc.w	1
  59  002e               _OSPtrSize:
  60  002e 0002          	dc.w	2
  61  0030               _OSQEn:
  62  0030 0001          	dc.w	1
  63  0032               _OSQMax:
  64  0032 0004          	dc.w	4
  65  0034               _OSQSize:
  66  0034 000e          	dc.w	14
  67  0036               _OSRdyTblSize:
  68  0036 0008          	dc.w	8
  69  0038               _OSSemEn:
  70  0038 0001          	dc.w	1
  71  003a               _OSStkWidth:
  72  003a 0001          	dc.w	1
  73  003c               _OSTaskCreateEn:
  74  003c 0001          	dc.w	1
  75  003e               _OSTaskCreateExtEn:
  76  003e 0001          	dc.w	1
  77  0040               _OSTaskDelEn:
  78  0040 0001          	dc.w	1
  79  0042               _OSTaskIdleStkSize:
  80  0042 00a0          	dc.w	160
  81  0044               _OSTaskProfileEn:
  82  0044 0001          	dc.w	1
  83  0046               _OSTaskMax:
  84  0046 0003          	dc.w	3
  85  0048               _OSTaskNameEn:
  86  0048 0001          	dc.w	1
  87  004a               _OSTaskStatEn:
  88  004a 0000          	dc.w	0
  89  004c               _OSTaskStatStkSize:
  90  004c 00a0          	dc.w	160
  91  004e               _OSTaskStatStkChkEn:
  92  004e 0001          	dc.w	1
  93  0050               _OSTaskSwHookEn:
  94  0050 0001          	dc.w	1
  95  0052               _OSTaskRegTblSize:
  96  0052 0000          	dc.w	0
  97  0054               _OSTCBPrioTblMax:
  98  0054 0040          	dc.w	64
  99  0056               _OSTCBSize:
 100  0056 003e          	dc.w	62
 101  0058               _OSTicksPerSec:
 102  0058 6000          	dc.w	24576
 103  005a               _OSTimeTickHookEn:
 104  005a 0001          	dc.w	1
 105  005c               _OSVersionNbr:
 106  005c 7274          	dc.w	29300
 107  005e               _OS_TLS_TblSize:
 108  005e 0000          	dc.w	0
 109  0060               _OSTmrEn:
 110  0060 0001          	dc.w	1
 111  0062               _OSTmrCfgMax:
 112  0062 0010          	dc.w	16
 113  0064               _OSTmrCfgNameEn:
 114  0064 0000          	dc.w	0
 115  0066               _OSTmrCfgWheelSize:
 116  0066 0008          	dc.w	8
 117  0068               _OSTmrCfgTicksPerSec:
 118  0068 000a          	dc.w	10
 119  006a               _OSTmrSize:
 120  006a 0017          	dc.w	23
 121  006c               _OSTmrTblSize:
 122  006c 0170          	dc.w	368
 123  006e               _OSTmrWheelSize:
 124  006e 0004          	dc.w	4
 125  0070               _OSTmrWheelTblSize:
 126  0070 0020          	dc.w	32
 127  0072               _OSDataSize:
 128  0072 0599          	dc.w	1433
 226                     ; 255 _NEAR void  OSDebugInit (void)
 226                     ; 256 {
 227                     	switch	.text
 228  0000               _OSDebugInit:
 230       00000002      OFST:	set	2
 233                     ; 260     ptemp = (void const *)&OSDebugEn;
 235                     ; 262     ptemp = (void const *)&OSEndiannessTest;
 237                     ; 264     ptemp = (void const *)&OSEventMax;
 239                     ; 265     ptemp = (void const *)&OSEventNameEn;
 241                     ; 266     ptemp = (void const *)&OSEventEn;
 243                     ; 267     ptemp = (void const *)&OSEventSize;
 245                     ; 268     ptemp = (void const *)&OSEventTblSize;
 247                     ; 269     ptemp = (void const *)&OSEventMultiEn;
 249                     ; 271     ptemp = (void const *)&OSFlagEn;
 251                     ; 272     ptemp = (void const *)&OSFlagGrpSize;
 253                     ; 273     ptemp = (void const *)&OSFlagNodeSize;
 255                     ; 274     ptemp = (void const *)&OSFlagWidth;
 257                     ; 275     ptemp = (void const *)&OSFlagMax;
 259                     ; 276     ptemp = (void const *)&OSFlagNameEn;
 261                     ; 278     ptemp = (void const *)&OSLowestPrio;
 263                     ; 280     ptemp = (void const *)&OSMboxEn;
 265                     ; 282     ptemp = (void const *)&OSMemEn;
 267                     ; 283     ptemp = (void const *)&OSMemMax;
 269                     ; 284     ptemp = (void const *)&OSMemNameEn;
 271                     ; 285     ptemp = (void const *)&OSMemSize;
 273                     ; 286     ptemp = (void const *)&OSMemTblSize;
 275                     ; 288     ptemp = (void const *)&OSMutexEn;
 277                     ; 290     ptemp = (void const *)&OSPtrSize;
 279                     ; 292     ptemp = (void const *)&OSQEn;
 281                     ; 293     ptemp = (void const *)&OSQMax;
 283                     ; 294     ptemp = (void const *)&OSQSize;
 285                     ; 296     ptemp = (void const *)&OSRdyTblSize;
 287                     ; 298     ptemp = (void const *)&OSSemEn;
 289                     ; 300     ptemp = (void const *)&OSStkWidth;
 291                     ; 302     ptemp = (void const *)&OSTaskCreateEn;
 293                     ; 303     ptemp = (void const *)&OSTaskCreateExtEn;
 295                     ; 304     ptemp = (void const *)&OSTaskDelEn;
 297                     ; 305     ptemp = (void const *)&OSTaskIdleStkSize;
 299                     ; 306     ptemp = (void const *)&OSTaskProfileEn;
 301                     ; 307     ptemp = (void const *)&OSTaskMax;
 303                     ; 308     ptemp = (void const *)&OSTaskNameEn;
 305                     ; 309     ptemp = (void const *)&OSTaskStatEn;
 307                     ; 310     ptemp = (void const *)&OSTaskStatStkSize;
 309                     ; 311     ptemp = (void const *)&OSTaskStatStkChkEn;
 311                     ; 312     ptemp = (void const *)&OSTaskSwHookEn;
 313                     ; 314     ptemp = (void const *)&OSTCBPrioTblMax;
 315                     ; 315     ptemp = (void const *)&OSTCBSize;
 317                     ; 317     ptemp = (void const *)&OSTicksPerSec;
 319                     ; 318     ptemp = (void const *)&OSTimeTickHookEn;
 321                     ; 321     ptemp = (void const *)&OSTmrTbl[0];
 323                     ; 322     ptemp = (void const *)&OSTmrWheelTbl[0];
 325                     ; 324     ptemp = (void const *)&OSTmrEn;
 327                     ; 325     ptemp = (void const *)&OSTmrCfgMax;
 329                     ; 326     ptemp = (void const *)&OSTmrCfgNameEn;
 331                     ; 327     ptemp = (void const *)&OSTmrCfgWheelSize;
 333                     ; 328     ptemp = (void const *)&OSTmrCfgTicksPerSec;
 335                     ; 329     ptemp = (void const *)&OSTmrSize;
 337                     ; 330     ptemp = (void const *)&OSTmrTblSize;
 339                     ; 332     ptemp = (void const *)&OSTmrWheelSize;
 341                     ; 333     ptemp = (void const *)&OSTmrWheelTblSize;
 343                     ; 336     ptemp = (void const *)&OSVersionNbr;
 345                     ; 338     ptemp = (void const *)&OSDataSize;
 347                     ; 340     ptemp = ptemp;                             /* Prevent compiler warning for 'ptemp' not being used! */
 349                     ; 341 }
 352  0000 3d            	rts	
 880                     	xdef	_OSDataSize
 881                     	xdef	_OSTmrWheelTblSize
 882                     	xdef	_OSTmrWheelSize
 883                     	xdef	_OSTmrTblSize
 884                     	xdef	_OSTmrSize
 885                     	xdef	_OSTmrCfgTicksPerSec
 886                     	xdef	_OSTmrCfgWheelSize
 887                     	xdef	_OSTmrCfgNameEn
 888                     	xdef	_OSTmrCfgMax
 889                     	xdef	_OSTmrEn
 890                     	xdef	_OS_TLS_TblSize
 891                     	xdef	_OSVersionNbr
 892                     	xdef	_OSTimeTickHookEn
 893                     	xdef	_OSTicksPerSec
 894                     	xdef	_OSTCBSize
 895                     	xdef	_OSTCBPrioTblMax
 896                     	xdef	_OSTaskRegTblSize
 897                     	xdef	_OSTaskSwHookEn
 898                     	xdef	_OSTaskStatStkChkEn
 899                     	xdef	_OSTaskStatStkSize
 900                     	xdef	_OSTaskStatEn
 901                     	xdef	_OSTaskNameEn
 902                     	xdef	_OSTaskMax
 903                     	xdef	_OSTaskProfileEn
 904                     	xdef	_OSTaskIdleStkSize
 905                     	xdef	_OSTaskDelEn
 906                     	xdef	_OSTaskCreateExtEn
 907                     	xdef	_OSTaskCreateEn
 908                     	xdef	_OSStkWidth
 909                     	xdef	_OSSemEn
 910                     	xdef	_OSRdyTblSize
 911                     	xdef	_OSQSize
 912                     	xdef	_OSQMax
 913                     	xdef	_OSQEn
 914                     	xdef	_OSPtrSize
 915                     	xdef	_OSMutexEn
 916                     	xdef	_OSMemTblSize
 917                     	xdef	_OSMemSize
 918                     	xdef	_OSMemNameEn
 919                     	xdef	_OSMemMax
 920                     	xdef	_OSMemEn
 921                     	xdef	_OSMboxEn
 922                     	xdef	_OSLowestPrio
 923                     	xdef	_OSFlagNameEn
 924                     	xdef	_OSFlagMax
 925                     	xdef	_OSFlagWidth
 926                     	xdef	_OSFlagNodeSize
 927                     	xdef	_OSFlagGrpSize
 928                     	xdef	_OSFlagEn
 929                     	xdef	_OSEventMultiEn
 930                     	xdef	_OSEventTblSize
 931                     	xdef	_OSEventSize
 932                     	xdef	_OSEventNameEn
 933                     	xdef	_OSEventMax
 934                     	xdef	_OSEventEn
 935                     	xdef	_OSEndiannessTest
 936                     	xdef	_OSDebugEn
 937                     	xdef	_OSDebugInit
 938                     	xref	_OSTmrWheelTbl
 939                     	xref	_OSTmrTaskStk
 940                     	xref	_OSTmrFreeList
 941                     	xref	_OSTmrTbl
 942                     	xref	_OSTmrSemSignal
 943                     	xref	_OSTmrSem
 944                     	xref	_OSTmrTime
 945                     	xref	_OSTmrUsed
 946                     	xref	_OSTmrFree
 947                     	xref	_OSTime
 948                     	xref	_OSQTbl
 949                     	xref	_OSQFreeList
 950                     	xref	_OSMemTbl
 951                     	xref	_OSMemFreeList
 952                     	xref	_OSTickStepState
 953                     	xref	_OSTCBTbl
 954                     	xref	_OSTCBPrioTbl
 955                     	xref	_OSTCBList
 956                     	xref	_OSTCBHighRdy
 957                     	xref	_OSTCBFreeList
 958                     	xref	_OSTCBCur
 959                     	xref	_OSTaskIdleStk
 960                     	xref	_OSIdleCtr
 961                     	xref	_OSTaskCtr
 962                     	xref	_OSRunning
 963                     	xref	_OSRdyTbl
 964                     	xref	_OSRdyGrp
 965                     	xref	_OSPrioHighRdy
 966                     	xref	_OSPrioCur
 967                     	xref	_OSLockNesting
 968                     	xref	_OSIntNesting
 969                     	xref	_OSFlagFreeList
 970                     	xref	_OSFlagTbl
 971                     	xref	_OSEventTbl
 972                     	xref	_OSEventFreeList
 973                     	xref	_OSCtxSwCtr
 993                     	end

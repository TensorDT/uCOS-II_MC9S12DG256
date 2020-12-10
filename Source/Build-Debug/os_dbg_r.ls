   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
3982                     .const:	section	.data
3983  0000               _OSDebugEn:
3984  0000 0001          	dc.w	1
3985  0002               _OSEndiannessTest:
3986  0002 12345678      	dc.l	305419896
3987  0006               _OSEventEn:
3988  0006 0001          	dc.w	1
3989  0008               _OSEventMax:
3990  0008 000a          	dc.w	10
3991  000a               _OSEventNameEn:
3992  000a 0001          	dc.w	1
3993  000c               _OSEventSize:
3994  000c 0010          	dc.w	16
3995  000e               _OSEventTblSize:
3996  000e 00a0          	dc.w	160
3997  0010               _OSEventMultiEn:
3998  0010 0001          	dc.w	1
3999  0012               _OSFlagEn:
4000  0012 0001          	dc.w	1
4001  0014               _OSFlagGrpSize:
4002  0014 0007          	dc.w	7
4003  0016               _OSFlagNodeSize:
4004  0016 000b          	dc.w	11
4005  0018               _OSFlagWidth:
4006  0018 0002          	dc.w	2
4007  001a               _OSFlagMax:
4008  001a 0005          	dc.w	5
4009  001c               _OSFlagNameEn:
4010  001c 0001          	dc.w	1
4011  001e               _OSLowestPrio:
4012  001e 003f          	dc.w	63
4013  0020               _OSMboxEn:
4014  0020 0001          	dc.w	1
4015  0022               _OSMemEn:
4016  0022 0001          	dc.w	1
4017  0024               _OSMemMax:
4018  0024 0005          	dc.w	5
4019  0026               _OSMemNameEn:
4020  0026 0001          	dc.w	1
4021  0028               _OSMemSize:
4022  0028 0012          	dc.w	18
4023  002a               _OSMemTblSize:
4024  002a 005a          	dc.w	90
4025  002c               _OSMutexEn:
4026  002c 0001          	dc.w	1
4027  002e               _OSPtrSize:
4028  002e 0002          	dc.w	2
4029  0030               _OSQEn:
4030  0030 0001          	dc.w	1
4031  0032               _OSQMax:
4032  0032 0004          	dc.w	4
4033  0034               _OSQSize:
4034  0034 000e          	dc.w	14
4035  0036               _OSRdyTblSize:
4036  0036 0008          	dc.w	8
4037  0038               _OSSemEn:
4038  0038 0001          	dc.w	1
4039  003a               _OSStkWidth:
4040  003a 0001          	dc.w	1
4041  003c               _OSTaskCreateEn:
4042  003c 0001          	dc.w	1
4043  003e               _OSTaskCreateExtEn:
4044  003e 0001          	dc.w	1
4045  0040               _OSTaskDelEn:
4046  0040 0001          	dc.w	1
4047  0042               _OSTaskIdleStkSize:
4048  0042 00a0          	dc.w	160
4049  0044               _OSTaskProfileEn:
4050  0044 0001          	dc.w	1
4051  0046               _OSTaskMax:
4052  0046 0003          	dc.w	3
4053  0048               _OSTaskNameEn:
4054  0048 0001          	dc.w	1
4055  004a               _OSTaskStatEn:
4056  004a 0000          	dc.w	0
4057  004c               _OSTaskStatStkSize:
4058  004c 00a0          	dc.w	160
4059  004e               _OSTaskStatStkChkEn:
4060  004e 0001          	dc.w	1
4061  0050               _OSTaskSwHookEn:
4062  0050 0001          	dc.w	1
4063  0052               _OSTaskRegTblSize:
4064  0052 0000          	dc.w	0
4065  0054               _OSTCBPrioTblMax:
4066  0054 0040          	dc.w	64
4067  0056               _OSTCBSize:
4068  0056 003e          	dc.w	62
4069  0058               _OSTicksPerSec:
4070  0058 c000          	dc.w	-16384
4071  005a               _OSTimeTickHookEn:
4072  005a 0001          	dc.w	1
4073  005c               _OSVersionNbr:
4074  005c 7274          	dc.w	29300
4075  005e               _OS_TLS_TblSize:
4076  005e 0000          	dc.w	0
4077  0060               _OSTmrEn:
4078  0060 0001          	dc.w	1
4079  0062               _OSTmrCfgMax:
4080  0062 0010          	dc.w	16
4081  0064               _OSTmrCfgNameEn:
4082  0064 0000          	dc.w	0
4083  0066               _OSTmrCfgWheelSize:
4084  0066 0008          	dc.w	8
4085  0068               _OSTmrCfgTicksPerSec:
4086  0068 000a          	dc.w	10
4087  006a               _OSTmrSize:
4088  006a 0017          	dc.w	23
4089  006c               _OSTmrTblSize:
4090  006c 0170          	dc.w	368
4091  006e               _OSTmrWheelSize:
4092  006e 0004          	dc.w	4
4093  0070               _OSTmrWheelTblSize:
4094  0070 0020          	dc.w	32
4095  0072               _OSDataSize:
4096  0072 0599          	dc.w	1433
4194                     ; 255 _NEAR void  OSDebugInit (void)
4194                     ; 256 {
4195                     	switch	.text
4196  0000               _OSDebugInit:
4198       00000002      OFST:	set	2
4201                     ; 260     ptemp = (void const *)&OSDebugEn;
4203                     ; 262     ptemp = (void const *)&OSEndiannessTest;
4205                     ; 264     ptemp = (void const *)&OSEventMax;
4207                     ; 265     ptemp = (void const *)&OSEventNameEn;
4209                     ; 266     ptemp = (void const *)&OSEventEn;
4211                     ; 267     ptemp = (void const *)&OSEventSize;
4213                     ; 268     ptemp = (void const *)&OSEventTblSize;
4215                     ; 269     ptemp = (void const *)&OSEventMultiEn;
4217                     ; 271     ptemp = (void const *)&OSFlagEn;
4219                     ; 272     ptemp = (void const *)&OSFlagGrpSize;
4221                     ; 273     ptemp = (void const *)&OSFlagNodeSize;
4223                     ; 274     ptemp = (void const *)&OSFlagWidth;
4225                     ; 275     ptemp = (void const *)&OSFlagMax;
4227                     ; 276     ptemp = (void const *)&OSFlagNameEn;
4229                     ; 278     ptemp = (void const *)&OSLowestPrio;
4231                     ; 280     ptemp = (void const *)&OSMboxEn;
4233                     ; 282     ptemp = (void const *)&OSMemEn;
4235                     ; 283     ptemp = (void const *)&OSMemMax;
4237                     ; 284     ptemp = (void const *)&OSMemNameEn;
4239                     ; 285     ptemp = (void const *)&OSMemSize;
4241                     ; 286     ptemp = (void const *)&OSMemTblSize;
4243                     ; 288     ptemp = (void const *)&OSMutexEn;
4245                     ; 290     ptemp = (void const *)&OSPtrSize;
4247                     ; 292     ptemp = (void const *)&OSQEn;
4249                     ; 293     ptemp = (void const *)&OSQMax;
4251                     ; 294     ptemp = (void const *)&OSQSize;
4253                     ; 296     ptemp = (void const *)&OSRdyTblSize;
4255                     ; 298     ptemp = (void const *)&OSSemEn;
4257                     ; 300     ptemp = (void const *)&OSStkWidth;
4259                     ; 302     ptemp = (void const *)&OSTaskCreateEn;
4261                     ; 303     ptemp = (void const *)&OSTaskCreateExtEn;
4263                     ; 304     ptemp = (void const *)&OSTaskDelEn;
4265                     ; 305     ptemp = (void const *)&OSTaskIdleStkSize;
4267                     ; 306     ptemp = (void const *)&OSTaskProfileEn;
4269                     ; 307     ptemp = (void const *)&OSTaskMax;
4271                     ; 308     ptemp = (void const *)&OSTaskNameEn;
4273                     ; 309     ptemp = (void const *)&OSTaskStatEn;
4275                     ; 310     ptemp = (void const *)&OSTaskStatStkSize;
4277                     ; 311     ptemp = (void const *)&OSTaskStatStkChkEn;
4279                     ; 312     ptemp = (void const *)&OSTaskSwHookEn;
4281                     ; 314     ptemp = (void const *)&OSTCBPrioTblMax;
4283                     ; 315     ptemp = (void const *)&OSTCBSize;
4285                     ; 317     ptemp = (void const *)&OSTicksPerSec;
4287                     ; 318     ptemp = (void const *)&OSTimeTickHookEn;
4289                     ; 321     ptemp = (void const *)&OSTmrTbl[0];
4291                     ; 322     ptemp = (void const *)&OSTmrWheelTbl[0];
4293                     ; 324     ptemp = (void const *)&OSTmrEn;
4295                     ; 325     ptemp = (void const *)&OSTmrCfgMax;
4297                     ; 326     ptemp = (void const *)&OSTmrCfgNameEn;
4299                     ; 327     ptemp = (void const *)&OSTmrCfgWheelSize;
4301                     ; 328     ptemp = (void const *)&OSTmrCfgTicksPerSec;
4303                     ; 329     ptemp = (void const *)&OSTmrSize;
4305                     ; 330     ptemp = (void const *)&OSTmrTblSize;
4307                     ; 332     ptemp = (void const *)&OSTmrWheelSize;
4309                     ; 333     ptemp = (void const *)&OSTmrWheelTblSize;
4311                     ; 336     ptemp = (void const *)&OSVersionNbr;
4313                     ; 338     ptemp = (void const *)&OSDataSize;
4315                     ; 340     ptemp = ptemp;                             /* Prevent compiler warning for 'ptemp' not being used! */
4317                     ; 341 }
4320  0000 3d            	rts	
4848                     	xdef	_OSDataSize
4849                     	xdef	_OSTmrWheelTblSize
4850                     	xdef	_OSTmrWheelSize
4851                     	xdef	_OSTmrTblSize
4852                     	xdef	_OSTmrSize
4853                     	xdef	_OSTmrCfgTicksPerSec
4854                     	xdef	_OSTmrCfgWheelSize
4855                     	xdef	_OSTmrCfgNameEn
4856                     	xdef	_OSTmrCfgMax
4857                     	xdef	_OSTmrEn
4858                     	xdef	_OS_TLS_TblSize
4859                     	xdef	_OSVersionNbr
4860                     	xdef	_OSTimeTickHookEn
4861                     	xdef	_OSTicksPerSec
4862                     	xdef	_OSTCBSize
4863                     	xdef	_OSTCBPrioTblMax
4864                     	xdef	_OSTaskRegTblSize
4865                     	xdef	_OSTaskSwHookEn
4866                     	xdef	_OSTaskStatStkChkEn
4867                     	xdef	_OSTaskStatStkSize
4868                     	xdef	_OSTaskStatEn
4869                     	xdef	_OSTaskNameEn
4870                     	xdef	_OSTaskMax
4871                     	xdef	_OSTaskProfileEn
4872                     	xdef	_OSTaskIdleStkSize
4873                     	xdef	_OSTaskDelEn
4874                     	xdef	_OSTaskCreateExtEn
4875                     	xdef	_OSTaskCreateEn
4876                     	xdef	_OSStkWidth
4877                     	xdef	_OSSemEn
4878                     	xdef	_OSRdyTblSize
4879                     	xdef	_OSQSize
4880                     	xdef	_OSQMax
4881                     	xdef	_OSQEn
4882                     	xdef	_OSPtrSize
4883                     	xdef	_OSMutexEn
4884                     	xdef	_OSMemTblSize
4885                     	xdef	_OSMemSize
4886                     	xdef	_OSMemNameEn
4887                     	xdef	_OSMemMax
4888                     	xdef	_OSMemEn
4889                     	xdef	_OSMboxEn
4890                     	xdef	_OSLowestPrio
4891                     	xdef	_OSFlagNameEn
4892                     	xdef	_OSFlagMax
4893                     	xdef	_OSFlagWidth
4894                     	xdef	_OSFlagNodeSize
4895                     	xdef	_OSFlagGrpSize
4896                     	xdef	_OSFlagEn
4897                     	xdef	_OSEventMultiEn
4898                     	xdef	_OSEventTblSize
4899                     	xdef	_OSEventSize
4900                     	xdef	_OSEventNameEn
4901                     	xdef	_OSEventMax
4902                     	xdef	_OSEventEn
4903                     	xdef	_OSEndiannessTest
4904                     	xdef	_OSDebugEn
4905                     	xdef	_OSDebugInit
4906                     	xref	_OSTmrWheelTbl
4907                     	xref	_OSTmrTaskStk
4908                     	xref	_OSTmrFreeList
4909                     	xref	_OSTmrTbl
4910                     	xref	_OSTmrSemSignal
4911                     	xref	_OSTmrSem
4912                     	xref	_OSTmrTime
4913                     	xref	_OSTmrUsed
4914                     	xref	_OSTmrFree
4915                     	xref	_OSTime
4916                     	xref	_OSQTbl
4917                     	xref	_OSQFreeList
4918                     	xref	_OSMemTbl
4919                     	xref	_OSMemFreeList
4920                     	xref	_OSTickStepState
4921                     	xref	_OSTCBTbl
4922                     	xref	_OSTCBPrioTbl
4923                     	xref	_OSTCBList
4924                     	xref	_OSTCBHighRdy
4925                     	xref	_OSTCBFreeList
4926                     	xref	_OSTCBCur
4927                     	xref	_OSTaskIdleStk
4928                     	xref	_OSIdleCtr
4929                     	xref	_OSTaskCtr
4930                     	xref	_OSRunning
4931                     	xref	_OSRdyTbl
4932                     	xref	_OSRdyGrp
4933                     	xref	_OSPrioHighRdy
4934                     	xref	_OSPrioCur
4935                     	xref	_OSLockNesting
4936                     	xref	_OSIntNesting
4937                     	xref	_OSFlagFreeList
4938                     	xref	_OSFlagTbl
4939                     	xref	_OSEventTbl
4940                     	xref	_OSEventFreeList
4941                     	xref	_OSCtxSwCtr
4961                     	end

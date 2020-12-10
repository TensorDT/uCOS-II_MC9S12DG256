   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
5032                     .const:	section	.data
5033  0000               _OSUnMapTbl:
5034  0000 00            	dc.b	0
5035  0001 00            	dc.b	0
5036  0002 01            	dc.b	1
5037  0003 00            	dc.b	0
5038  0004 02            	dc.b	2
5039  0005 00            	dc.b	0
5040  0006 01            	dc.b	1
5041  0007 00            	dc.b	0
5042  0008 03            	dc.b	3
5043  0009 00            	dc.b	0
5044  000a 01            	dc.b	1
5045  000b 00            	dc.b	0
5046  000c 02            	dc.b	2
5047  000d 00            	dc.b	0
5048  000e 01            	dc.b	1
5049  000f 00            	dc.b	0
5050  0010 04            	dc.b	4
5051  0011 00            	dc.b	0
5052  0012 01            	dc.b	1
5053  0013 00            	dc.b	0
5054  0014 02            	dc.b	2
5055  0015 00            	dc.b	0
5056  0016 01            	dc.b	1
5057  0017 00            	dc.b	0
5058  0018 03            	dc.b	3
5059  0019 00            	dc.b	0
5060  001a 01            	dc.b	1
5061  001b 00            	dc.b	0
5062  001c 02            	dc.b	2
5063  001d 00            	dc.b	0
5064  001e 01            	dc.b	1
5065  001f 00            	dc.b	0
5066  0020 05            	dc.b	5
5067  0021 00            	dc.b	0
5068  0022 01            	dc.b	1
5069  0023 00            	dc.b	0
5070  0024 02            	dc.b	2
5071  0025 00            	dc.b	0
5072  0026 01            	dc.b	1
5073  0027 00            	dc.b	0
5074  0028 03            	dc.b	3
5075  0029 00            	dc.b	0
5076  002a 01            	dc.b	1
5077  002b 00            	dc.b	0
5078  002c 02            	dc.b	2
5079  002d 00            	dc.b	0
5080  002e 01            	dc.b	1
5081  002f 00            	dc.b	0
5082  0030 04            	dc.b	4
5083  0031 00            	dc.b	0
5084  0032 01            	dc.b	1
5085  0033 00            	dc.b	0
5086  0034 02            	dc.b	2
5087  0035 00            	dc.b	0
5088  0036 01            	dc.b	1
5089  0037 00            	dc.b	0
5090  0038 03            	dc.b	3
5091  0039 00            	dc.b	0
5092  003a 01            	dc.b	1
5093  003b 00            	dc.b	0
5094  003c 02            	dc.b	2
5095  003d 00            	dc.b	0
5096  003e 01            	dc.b	1
5097  003f 00            	dc.b	0
5098  0040 06            	dc.b	6
5099  0041 00            	dc.b	0
5100  0042 01            	dc.b	1
5101  0043 00            	dc.b	0
5102  0044 02            	dc.b	2
5103  0045 00            	dc.b	0
5104  0046 01            	dc.b	1
5105  0047 00            	dc.b	0
5106  0048 03            	dc.b	3
5107  0049 00            	dc.b	0
5108  004a 01            	dc.b	1
5109  004b 00            	dc.b	0
5110  004c 02            	dc.b	2
5111  004d 00            	dc.b	0
5112  004e 01            	dc.b	1
5113  004f 00            	dc.b	0
5114  0050 04            	dc.b	4
5115  0051 00            	dc.b	0
5116  0052 01            	dc.b	1
5117  0053 00            	dc.b	0
5118  0054 02            	dc.b	2
5119  0055 00            	dc.b	0
5120  0056 01            	dc.b	1
5121  0057 00            	dc.b	0
5122  0058 03            	dc.b	3
5123  0059 00            	dc.b	0
5124  005a 01            	dc.b	1
5125  005b 00            	dc.b	0
5126  005c 02            	dc.b	2
5127  005d 00            	dc.b	0
5128  005e 01            	dc.b	1
5129  005f 00            	dc.b	0
5130  0060 05            	dc.b	5
5131  0061 00            	dc.b	0
5132  0062 01            	dc.b	1
5133  0063 00            	dc.b	0
5134  0064 02            	dc.b	2
5135  0065 00            	dc.b	0
5136  0066 01            	dc.b	1
5137  0067 00            	dc.b	0
5138  0068 03            	dc.b	3
5139  0069 00            	dc.b	0
5140  006a 01            	dc.b	1
5141  006b 00            	dc.b	0
5142  006c 02            	dc.b	2
5143  006d 00            	dc.b	0
5144  006e 01            	dc.b	1
5145  006f 00            	dc.b	0
5146  0070 04            	dc.b	4
5147  0071 00            	dc.b	0
5148  0072 01            	dc.b	1
5149  0073 00            	dc.b	0
5150  0074 02            	dc.b	2
5151  0075 00            	dc.b	0
5152  0076 01            	dc.b	1
5153  0077 00            	dc.b	0
5154  0078 03            	dc.b	3
5155  0079 00            	dc.b	0
5156  007a 01            	dc.b	1
5157  007b 00            	dc.b	0
5158  007c 02            	dc.b	2
5159  007d 00            	dc.b	0
5160  007e 01            	dc.b	1
5161  007f 00            	dc.b	0
5162  0080 07            	dc.b	7
5163  0081 00            	dc.b	0
5164  0082 01            	dc.b	1
5165  0083 00            	dc.b	0
5166  0084 02            	dc.b	2
5167  0085 00            	dc.b	0
5168  0086 01            	dc.b	1
5169  0087 00            	dc.b	0
5170  0088 03            	dc.b	3
5171  0089 00            	dc.b	0
5172  008a 01            	dc.b	1
5173  008b 00            	dc.b	0
5174  008c 02            	dc.b	2
5175  008d 00            	dc.b	0
5176  008e 01            	dc.b	1
5177  008f 00            	dc.b	0
5178  0090 04            	dc.b	4
5179  0091 00            	dc.b	0
5180  0092 01            	dc.b	1
5181  0093 00            	dc.b	0
5182  0094 02            	dc.b	2
5183  0095 00            	dc.b	0
5184  0096 01            	dc.b	1
5185  0097 00            	dc.b	0
5186  0098 03            	dc.b	3
5187  0099 00            	dc.b	0
5188  009a 01            	dc.b	1
5189  009b 00            	dc.b	0
5190  009c 02            	dc.b	2
5191  009d 00            	dc.b	0
5192  009e 01            	dc.b	1
5193  009f 00            	dc.b	0
5194  00a0 05            	dc.b	5
5195  00a1 00            	dc.b	0
5196  00a2 01            	dc.b	1
5197  00a3 00            	dc.b	0
5198  00a4 02            	dc.b	2
5199  00a5 00            	dc.b	0
5200  00a6 01            	dc.b	1
5201  00a7 00            	dc.b	0
5202  00a8 03            	dc.b	3
5203  00a9 00            	dc.b	0
5204  00aa 01            	dc.b	1
5205  00ab 00            	dc.b	0
5206  00ac 02            	dc.b	2
5207  00ad 00            	dc.b	0
5208  00ae 01            	dc.b	1
5209  00af 00            	dc.b	0
5210  00b0 04            	dc.b	4
5211  00b1 00            	dc.b	0
5212  00b2 01            	dc.b	1
5213  00b3 00            	dc.b	0
5214  00b4 02            	dc.b	2
5215  00b5 00            	dc.b	0
5216  00b6 01            	dc.b	1
5217  00b7 00            	dc.b	0
5218  00b8 03            	dc.b	3
5219  00b9 00            	dc.b	0
5220  00ba 01            	dc.b	1
5221  00bb 00            	dc.b	0
5222  00bc 02            	dc.b	2
5223  00bd 00            	dc.b	0
5224  00be 01            	dc.b	1
5225  00bf 00            	dc.b	0
5226  00c0 06            	dc.b	6
5227  00c1 00            	dc.b	0
5228  00c2 01            	dc.b	1
5229  00c3 00            	dc.b	0
5230  00c4 02            	dc.b	2
5231  00c5 00            	dc.b	0
5232  00c6 01            	dc.b	1
5233  00c7 00            	dc.b	0
5234  00c8 03            	dc.b	3
5235  00c9 00            	dc.b	0
5236  00ca 01            	dc.b	1
5237  00cb 00            	dc.b	0
5238  00cc 02            	dc.b	2
5239  00cd 00            	dc.b	0
5240  00ce 01            	dc.b	1
5241  00cf 00            	dc.b	0
5242  00d0 04            	dc.b	4
5243  00d1 00            	dc.b	0
5244  00d2 01            	dc.b	1
5245  00d3 00            	dc.b	0
5246  00d4 02            	dc.b	2
5247  00d5 00            	dc.b	0
5248  00d6 01            	dc.b	1
5249  00d7 00            	dc.b	0
5250  00d8 03            	dc.b	3
5251  00d9 00            	dc.b	0
5252  00da 01            	dc.b	1
5253  00db 00            	dc.b	0
5254  00dc 02            	dc.b	2
5255  00dd 00            	dc.b	0
5256  00de 01            	dc.b	1
5257  00df 00            	dc.b	0
5258  00e0 05            	dc.b	5
5259  00e1 00            	dc.b	0
5260  00e2 01            	dc.b	1
5261  00e3 00            	dc.b	0
5262  00e4 02            	dc.b	2
5263  00e5 00            	dc.b	0
5264  00e6 01            	dc.b	1
5265  00e7 00            	dc.b	0
5266  00e8 03            	dc.b	3
5267  00e9 00            	dc.b	0
5268  00ea 01            	dc.b	1
5269  00eb 00            	dc.b	0
5270  00ec 02            	dc.b	2
5271  00ed 00            	dc.b	0
5272  00ee 01            	dc.b	1
5273  00ef 00            	dc.b	0
5274  00f0 04            	dc.b	4
5275  00f1 00            	dc.b	0
5276  00f2 01            	dc.b	1
5277  00f3 00            	dc.b	0
5278  00f4 02            	dc.b	2
5279  00f5 00            	dc.b	0
5280  00f6 01            	dc.b	1
5281  00f7 00            	dc.b	0
5282  00f8 03            	dc.b	3
5283  00f9 00            	dc.b	0
5284  00fa 01            	dc.b	1
5285  00fb 00            	dc.b	0
5286  00fc 02            	dc.b	2
5287  00fd 00            	dc.b	0
5288  00fe 01            	dc.b	1
5289  00ff 00            	dc.b	0
5429                     ; 117 _NEAR INT8U  OSEventNameGet (OS_EVENT   *pevent,
5429                     ; 118                             INT8U     **pname,
5429                     ; 119                             INT8U      *perr)
5429                     ; 120 {
5430                     	switch	.text
5431  0000               _OSEventNameGet:
5433  0000 3b            	pshd	
5434       00000002      OFST:	set	2
5437                     ; 123     OS_CPU_SR  cpu_sr = 0u;
5439                     ; 136     if (pevent == (OS_EVENT *)0) {               /* Is 'pevent' a NULL pointer?                        */
5441  0001 6cae          	std	2,-s
5442  0003 2604          	bne	L1263
5443                     ; 137         *perr = OS_ERR_PEVENT_NULL;
5445  0005 c604          	ldab	#4
5446                     ; 138         return (0u);
5449  0007 2006          	bra	LC001
5450  0009               L1263:
5451                     ; 140     if (pname == (INT8U **)0) {                   /* Is 'pname' a NULL pointer?                         */
5453  0009 ec86          	ldd	OFST+4,s
5454  000b 260a          	bne	L3263
5455                     ; 141         *perr = OS_ERR_PNAME_NULL;
5457  000d c60c          	ldab	#12
5458                     ; 142         return (0u);
5460  000f               LC001:
5461  000f 6bf30008      	stab	[OFST+6,s]
5462  0013 c7            	clrb	
5464  0014               L6:
5466  0014 1b84          	leas	4,s
5467  0016 3d            	rts	
5468  0017               L3263:
5469                     ; 145     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
5471  0017 f604cd        	ldab	_OSIntNesting
5472  001a 2704          	beq	L5263
5473                     ; 146         *perr  = OS_ERR_NAME_GET_ISR;
5475  001c c611          	ldab	#17
5476                     ; 147         return (0u);
5479  001e 20ef          	bra	LC001
5480  0020               L5263:
5481                     ; 149     switch (pevent->OSEventType) {
5483  0020 e6f30002      	ldab	[OFST+0,s]
5485  0024 04010d        	dbeq	b,L1363
5486  0027 04010a        	dbeq	b,L1363
5487  002a 040107        	dbeq	b,L1363
5488  002d 040104        	dbeq	b,L1363
5489                     ; 156         default:
5489                     ; 157              *perr = OS_ERR_EVENT_TYPE;
5491  0030 c601          	ldab	#1
5492                     ; 158              return (0u);
5495  0032 20db          	bra	LC001
5496                     ; 150         case OS_EVENT_TYPE_SEM:
5496                     ; 151         case OS_EVENT_TYPE_MUTEX:
5496                     ; 152         case OS_EVENT_TYPE_MBOX:
5496                     ; 153         case OS_EVENT_TYPE_Q:
5496                     ; 154              break;
5498  0034               L1363:
5499                     ; 160     OS_ENTER_CRITICAL();
5501  0034 160000        	jsr	_OS_CPU_SR_Save
5503  0037 6b80          	stab	OFST-2,s
5504                     ; 161     *pname = pevent->OSEventName;
5506  0039 ee82          	ldx	OFST+0,s
5507  003b ec0e          	ldd	14,x
5508  003d ee86          	ldx	OFST+4,s
5509  003f 6c00          	std	0,x
5510                     ; 162     len    = OS_StrLen(*pname);
5512  0041 160888        	jsr	_OS_StrLen
5514  0044 6b81          	stab	OFST-1,s
5515                     ; 163     OS_EXIT_CRITICAL();
5517  0046 e680          	ldab	OFST-2,s
5518  0048 87            	clra	
5519  0049 160000        	jsr	_OS_CPU_SR_Restore
5521                     ; 164     *perr  = OS_ERR_NONE;
5523  004c 69f30008      	clr	[OFST+6,s]
5524                     ; 165     return (len);
5526  0050 e681          	ldab	OFST-1,s
5528  0052 20c0          	bra	L6
5594                     ; 197 _NEAR void  OSEventNameSet (OS_EVENT  *pevent,
5594                     ; 198                            INT8U     *pname,
5594                     ; 199                            INT8U     *perr)
5594                     ; 200 {
5595                     	switch	.text
5596  0054               _OSEventNameSet:
5598  0054 3b            	pshd	
5599  0055 37            	pshb	
5600       00000001      OFST:	set	1
5603                     ; 202     OS_CPU_SR  cpu_sr = 0u;
5605                     ; 215     if (pevent == (OS_EVENT *)0) {               /* Is 'pevent' a NULL pointer?                        */
5607  0056 046404        	tbne	d,L1763
5608                     ; 216         *perr = OS_ERR_PEVENT_NULL;
5610  0059 c604          	ldab	#4
5611                     ; 217         return;
5613  005b 2006          	bra	LC002
5614  005d               L1763:
5615                     ; 219     if (pname == (INT8U *)0) {                   /* Is 'pname' a NULL pointer?                         */
5617  005d ec85          	ldd	OFST+4,s
5618  005f 2609          	bne	L3763
5619                     ; 220         *perr = OS_ERR_PNAME_NULL;
5621  0061 c60c          	ldab	#12
5622  0063               LC002:
5623  0063 6bf30007      	stab	[OFST+6,s]
5624                     ; 221         return;
5625  0067               L21:
5628  0067 1b83          	leas	3,s
5629  0069 3d            	rts	
5630  006a               L3763:
5631                     ; 224     if (OSIntNesting > 0u) {                     /* See if trying to call from an ISR                  */
5633  006a f604cd        	ldab	_OSIntNesting
5634  006d 2704          	beq	L5763
5635                     ; 225         *perr = OS_ERR_NAME_SET_ISR;
5637  006f c612          	ldab	#18
5638                     ; 226         return;
5640  0071 20f0          	bra	LC002
5641  0073               L5763:
5642                     ; 228     switch (pevent->OSEventType) {
5644  0073 e6f30001      	ldab	[OFST+0,s]
5646  0077 04010d        	dbeq	b,L1073
5647  007a 04010a        	dbeq	b,L1073
5648  007d 040107        	dbeq	b,L1073
5649  0080 040104        	dbeq	b,L1073
5650                     ; 235         default:
5650                     ; 236              *perr = OS_ERR_EVENT_TYPE;
5652  0083 c601          	ldab	#1
5653                     ; 237              return;
5655  0085 20dc          	bra	LC002
5656                     ; 229         case OS_EVENT_TYPE_SEM:
5656                     ; 230         case OS_EVENT_TYPE_MUTEX:
5656                     ; 231         case OS_EVENT_TYPE_MBOX:
5656                     ; 232         case OS_EVENT_TYPE_Q:
5656                     ; 233              break;
5658  0087               L1073:
5659                     ; 239     OS_ENTER_CRITICAL();
5661  0087 160000        	jsr	_OS_CPU_SR_Save
5663  008a 6b80          	stab	OFST-1,s
5664                     ; 240     pevent->OSEventName = pname;
5666  008c ed81          	ldy	OFST+0,s
5667  008e 1802854e      	movw	OFST+4,s,14,y
5668                     ; 241     OS_EXIT_CRITICAL();
5670  0092 87            	clra	
5671  0093 160000        	jsr	_OS_CPU_SR_Restore
5673                     ; 243     *perr = OS_ERR_NONE;
5676  0096 69f30007      	clr	[OFST+6,s]
5677                     ; 244 }
5679  009a 20cb          	bra	L21
5907                     ; 320 _NEAR INT16U  OSEventPendMulti (OS_EVENT  **pevents_pend,
5907                     ; 321                                OS_EVENT  **pevents_rdy,
5907                     ; 322                                void      **pmsgs_rdy,
5907                     ; 323                                INT32U      timeout,
5907                     ; 324                                INT8U      *perr)
5907                     ; 325 {
5908                     	switch	.text
5909  009c               _OSEventPendMulti:
5911  009c 3b            	pshd	
5912  009d 1b95          	leas	-11,s
5913       0000000b      OFST:	set	11
5916                     ; 335     OS_CPU_SR   cpu_sr = 0u;
5918                     ; 348     if (pevents_pend == (OS_EVENT **)0) {               /* Validate 'pevents_pend'                     */
5920  009f 046402        	tbne	d,L3704
5921                     ; 349        *perr =  OS_ERR_PEVENT_NULL;
5923                     ; 350         return (0u);
5926  00a2 2006          	bra	LC003
5927  00a4               L3704:
5928                     ; 352     if (*pevents_pend  == (OS_EVENT *)0) {              /* Validate 'pevents_pend'                     */
5930  00a4 ecf3000b      	ldd	[OFST+0,s]
5931  00a8 260b          	bne	L5704
5932                     ; 353        *perr =  OS_ERR_PEVENT_NULL;
5934  00aa               LC003:
5935  00aa c604          	ldab	#4
5936                     ; 354         return (0u);
5939  00ac               L61:
5940  00ac 6bf30017      	stab	[OFST+12,s]
5941  00b0 87            	clra	
5942  00b1 c7            	clrb	
5944  00b2 1b8d          	leas	13,s
5945  00b4 3d            	rts	
5946  00b5               L5704:
5947                     ; 356     if (pevents_rdy  == (OS_EVENT **)0) {               /* Validate 'pevents_rdy'                      */
5949  00b5 ec8f          	ldd	OFST+4,s
5950                     ; 357        *perr =  OS_ERR_PEVENT_NULL;
5952                     ; 358         return (0u);
5955  00b7 27f1          	beq	LC003
5956                     ; 360     if (pmsgs_rdy == (void **)0) {                      /* Validate 'pmsgs_rdy'                        */
5958  00b9 ecf011        	ldd	OFST+6,s
5959                     ; 361        *perr =  OS_ERR_PEVENT_NULL;
5961                     ; 362         return (0u);
5964  00bc 27ec          	beq	LC003
5965                     ; 366    *pevents_rdy = (OS_EVENT *)0;                        /* Init array to NULL in case of errors        */
5967  00be 87            	clra	
5968  00bf c7            	clrb	
5969  00c0 6cf3000f      	std	[OFST+4,s]
5970                     ; 368     pevents     =  pevents_pend;
5972  00c4 18028b86      	movw	OFST+0,s,OFST-5,s
5973                     ; 369     pevent      = *pevents;
5975  00c8 ecf30006      	ldd	[OFST-5,s]
5977  00cc 201b          	bra	L5014
5978  00ce               L3014:
5979                     ; 371         switch (pevent->OSEventType) {                  /* Validate event block types                  */
5981  00ce e6f30000      	ldab	[OFST-11,s]
5983  00d2 04010e        	dbeq	b,L3114
5984  00d5 04010b        	dbeq	b,L3114
5985  00d8 040108        	dbeq	b,L3114
5986  00db 040101        	dbeq	b,L1173
5987  00de 53            	decb	
5988  00df               L1173:
5989                     ; 385             case OS_EVENT_TYPE_MUTEX:
5989                     ; 386             case OS_EVENT_TYPE_FLAG:
5989                     ; 387             default:
5989                     ; 388                 *perr = OS_ERR_EVENT_TYPE;
5991  00df c601          	ldab	#1
5992                     ; 389                  return (0u);
5995  00e1 20c9          	bra	L61
5996  00e3               L3114:
5997                     ; 391         pevents++;
5999  00e3 ed86          	ldy	OFST-5,s
6000                     ; 392         pevent = *pevents;
6002  00e5 ec61          	ldd	2,+y
6003  00e7 6d86          	sty	OFST-5,s
6004  00e9               L5014:
6005  00e9 6c80          	std	OFST-11,s
6006                     ; 370     while  (pevent != (OS_EVENT *)0) {
6008  00eb 26e1          	bne	L3014
6009                     ; 395     if (OSIntNesting  > 0u) {                           /* See if called from ISR ...                  */
6011  00ed f604cd        	ldab	_OSIntNesting
6012  00f0 2704          	beq	L5114
6013                     ; 396        *perr =  OS_ERR_PEND_ISR;                        /* ... can't PEND from an ISR                  */
6015  00f2 c602          	ldab	#2
6016                     ; 397         return (0u);
6019  00f4 2007          	bra	L02
6020  00f6               L5114:
6021                     ; 399     if (OSLockNesting > 0u) {                           /* See if called with scheduler locked ...     */
6023  00f6 f604cc        	ldab	_OSLockNesting
6024  00f9 270b          	beq	L7114
6025                     ; 400        *perr =  OS_ERR_PEND_LOCKED;                     /* ... can't PEND when locked                  */
6027  00fb c60d          	ldab	#13
6028                     ; 401         return (0u);
6031  00fd               L02:
6032  00fd 6bf30017      	stab	[OFST+12,s]
6033  0101 87            	clra	
6034  0102 c7            	clrb	
6036  0103 1b8d          	leas	13,s
6037  0105 3d            	rts	
6038  0106               L7114:
6039                     ; 404     events_rdy     =  OS_FALSE;
6041  0106 87            	clra	
6042  0107 6a88          	staa	OFST-3,s
6043                     ; 405     events_rdy_nbr =  0u;
6045  0109 6c84          	std	OFST-7,s
6046                     ; 406     events_stat    =  OS_STAT_RDY;
6048  010b 6989          	clr	OFST-2,s
6049                     ; 407     pevents        =  pevents_pend;
6051  010d ed8b          	ldy	OFST+0,s
6052  010f 6d86          	sty	OFST-5,s
6053                     ; 408     pevent         = *pevents;
6055  0111 18024080      	movw	0,y,OFST-11,s
6056                     ; 409     OS_ENTER_CRITICAL();
6058  0115 160000        	jsr	_OS_CPU_SR_Save
6060  0118 6b8a          	stab	OFST-1,s
6062  011a ec80          	ldd	OFST-11,s
6063  011c 0601e7        	bra	L3214
6064  011f               L1214:
6065                     ; 411         switch (pevent->OSEventType) {
6067  011f b746          	tfr	d,y
6068  0121 e640          	ldab	0,y
6070  0123 04013d        	dbeq	b,L5173
6071  0126 040164        	dbeq	b,L7173
6072  0129 04010d        	dbeq	b,L3173
6073  012c 53            	decb	
6074  012d 1827009b      	beq	L1273
6075  0131 53            	decb	
6076  0132 18270096      	beq	L1273
6077  0136 0601cc        	bra	L1273
6078  0139               L3173:
6079                     ; 413             case OS_EVENT_TYPE_SEM:
6079                     ; 414                  if (pevent->OSEventCnt > 0u) {         /* If semaphore count > 0, resource available; */
6081  0139 ee43          	ldx	3,y
6082  013b 2721          	beq	L3314
6083                     ; 415                      pevent->OSEventCnt--;              /* ... decrement semaphore,                ... */
6085  013d 09            	dex	
6086  013e 6e43          	stx	3,y
6087                     ; 416                     *pevents_rdy++ =  pevent;           /* ... and return available semaphore event    */
6089  0140 ed8f          	ldy	OFST+4,s
6090  0142 18028071      	movw	OFST-11,s,2,y+
6091  0146 6d8f          	sty	OFST+4,s
6092                     ; 417                       events_rdy   =  OS_TRUE;
6094  0148 c601          	ldab	#1
6095  014a 6b88          	stab	OFST-3,s
6096                     ; 418                     *pmsgs_rdy++   = (void *)0;         /* NO message returned  for semaphores         */
6098  014c 87            	clra	
6099  014d c7            	clrb	
6100  014e edf011        	ldy	OFST+6,s
6101  0151 6c71          	std	2,y+
6102  0153 6df011        	sty	OFST+6,s
6103                     ; 419                       events_rdy_nbr++;
6105  0156 ed84          	ldy	OFST-7,s
6106  0158 02            	iny	
6107  0159 6d84          	sty	OFST-7,s
6109  015b 0601df        	bra	L1314
6110  015e               L3314:
6111                     ; 422                       events_stat |=  OS_STAT_SEM;      /* Configure multi-pend for semaphore events   */
6113  015e 0c8901        	bset	OFST-2,s,1
6114  0161 207c          	bra	L1314
6115  0163               L5173:
6116                     ; 428             case OS_EVENT_TYPE_MBOX:
6116                     ; 429                  if (pevent->OSEventPtr != (void *)0) { /* If mailbox NOT empty;                   ... */
6118  0163 ec41          	ldd	1,y
6119  0165 2721          	beq	L7314
6120                     ; 431                     *pmsgs_rdy++         = (void *)pevent->OSEventPtr;
6122  0167 edf011        	ldy	OFST+6,s
6123  016a 6c71          	std	2,y+
6124  016c 6df011        	sty	OFST+6,s
6125                     ; 432                      pevent->OSEventPtr  = (void *)0;
6127  016f 87            	clra	
6128  0170 c7            	clrb	
6129  0171 ed80          	ldy	OFST-11,s
6130  0173 6c41          	std	1,y
6131                     ; 433                     *pevents_rdy++       =  pevent;     /* ... and return available mailbox event      */
6133  0175 b764          	tfr	y,d
6134  0177 ed8f          	ldy	OFST+4,s
6135  0179 6c71          	std	2,y+
6136  017b 6d8f          	sty	OFST+4,s
6137                     ; 434                       events_rdy         =  OS_TRUE;
6139  017d c601          	ldab	#1
6140  017f 6b88          	stab	OFST-3,s
6141                     ; 435                       events_rdy_nbr++;
6143  0181 ed84          	ldy	OFST-7,s
6144  0183 02            	iny	
6145  0184 6d84          	sty	OFST-7,s
6147  0186 2057          	bra	L1314
6148  0188               L7314:
6149                     ; 438                       events_stat |= OS_STAT_MBOX;      /* Configure multi-pend for mailbox events     */
6151  0188 0c8902        	bset	OFST-2,s,2
6152  018b 2052          	bra	L1314
6153  018d               L7173:
6154                     ; 444             case OS_EVENT_TYPE_Q:
6154                     ; 445                  pq = (OS_Q *)pevent->OSEventPtr;
6156  018d ed41          	ldy	1,y
6157  018f 6d82          	sty	OFST-9,s
6158                     ; 446                  if (pq->OSQEntries > 0u) {             /* If queue NOT empty;                     ... */
6160  0191 ec4c          	ldd	12,y
6161  0193 2732          	beq	L3414
6162                     ; 448                     *pmsgs_rdy++ = (void *)*pq->OSQOut++;
6164  0195 ee48          	ldx	8,y
6165  0197 ec31          	ldd	2,x+
6166  0199 6e48          	stx	8,y
6167  019b edf011        	ldy	OFST+6,s
6168  019e 6c71          	std	2,y+
6169  01a0 6df011        	sty	OFST+6,s
6170                     ; 449                      if (pq->OSQOut == pq->OSQEnd) {    /* If OUT ptr at queue end, ...                */
6172  01a3 ed82          	ldy	OFST-9,s
6173  01a5 ec48          	ldd	8,y
6174  01a7 ac44          	cpd	4,y
6175  01a9 2604          	bne	L5414
6176                     ; 450                          pq->OSQOut  = pq->OSQStart;    /* ... wrap   to queue start                   */
6178  01ab 18024248      	movw	2,y,8,y
6179  01af               L5414:
6180                     ; 452                      pq->OSQEntries--;                  /* Update number of queue entries              */
6182  01af ee4c          	ldx	12,y
6183  01b1 09            	dex	
6184  01b2 6e4c          	stx	12,y
6185                     ; 453                     *pevents_rdy++ = pevent;            /* ... and return available queue event        */
6187  01b4 ed8f          	ldy	OFST+4,s
6188  01b6 18028071      	movw	OFST-11,s,2,y+
6189  01ba 6d8f          	sty	OFST+4,s
6190                     ; 454                       events_rdy   = OS_TRUE;
6192  01bc c601          	ldab	#1
6193  01be 6b88          	stab	OFST-3,s
6194                     ; 455                       events_rdy_nbr++;
6196  01c0 ed84          	ldy	OFST-7,s
6197  01c2 02            	iny	
6198  01c3 6d84          	sty	OFST-7,s
6200  01c5 2018          	bra	L1314
6201  01c7               L3414:
6202                     ; 458                       events_stat |= OS_STAT_Q;         /* Configure multi-pend for queue events       */
6204  01c7 0c8904        	bset	OFST-2,s,4
6205  01ca 2013          	bra	L1314
6206  01cc               L1273:
6207                     ; 463             case OS_EVENT_TYPE_MUTEX:
6207                     ; 464             case OS_EVENT_TYPE_FLAG:
6207                     ; 465             default:
6207                     ; 466                  OS_EXIT_CRITICAL();
6209  01cc e68a          	ldab	OFST-1,s
6210  01ce 87            	clra	
6211  01cf 160000        	jsr	_OS_CPU_SR_Restore
6213                     ; 467                 *pevents_rdy = (OS_EVENT *)0;           /* NULL terminate return event array           */
6215  01d2 87            	clra	
6216  01d3 c7            	clrb	
6217  01d4 6cf3000f      	std	[OFST+4,s]
6218                     ; 468                 *perr        =  OS_ERR_EVENT_TYPE;
6220  01d8 52            	incb	
6221  01d9 6bf30017      	stab	[OFST+12,s]
6222                     ; 469                  return (events_rdy_nbr);
6225  01dd 201f          	bra	L22
6226  01df               L1314:
6227                     ; 471         pevents++;
6229  01df ed86          	ldy	OFST-5,s
6230                     ; 472         pevent = *pevents;
6232  01e1 ec61          	ldd	2,+y
6233  01e3 6d86          	sty	OFST-5,s
6234  01e5 6c80          	std	OFST-11,s
6235  01e7               L3214:
6236                     ; 410     while (pevent != (OS_EVENT *)0) {                   /* See if any events already available         */
6238  01e7 1826ff34      	bne	L1214
6239                     ; 475     if ( events_rdy == OS_TRUE) {                       /* Return any events already available         */
6241  01eb e688          	ldab	OFST-3,s
6242  01ed 042113        	dbne	b,L1514
6243                     ; 476        *pevents_rdy = (OS_EVENT *)0;                    /* NULL terminate return event array           */
6245  01f0 87            	clra	
6246  01f1 6cf3000f      	std	[OFST+4,s]
6247                     ; 477         OS_EXIT_CRITICAL();
6249  01f5 e68a          	ldab	OFST-1,s
6250  01f7 160000        	jsr	_OS_CPU_SR_Restore
6252                     ; 478        *perr        =  OS_ERR_NONE;
6254  01fa 69f30017      	clr	[OFST+12,s]
6255                     ; 479         return (events_rdy_nbr);
6258  01fe               L22:
6259  01fe ec84          	ldd	OFST-7,s
6261  0200 1b8d          	leas	13,s
6262  0202 3d            	rts	
6263  0203               L1514:
6264                     ; 483     OSTCBCur->OSTCBStat     |= events_stat  |           /* Resource not available, ...                 */
6264                     ; 484                                OS_STAT_MULTI;           /* ... pend on multiple events                 */
6266  0203 fd0419        	ldy	_OSTCBCur
6267  0206 e689          	ldab	OFST-2,s
6268  0208 ca80          	orab	#128
6269  020a eae822        	orab	34,y
6270  020d 6be822        	stab	34,y
6271                     ; 485     OSTCBCur->OSTCBStatPend  = OS_STAT_PEND_OK;
6273  0210 69e823        	clr	35,y
6274                     ; 486     OSTCBCur->OSTCBDly       = timeout;                 /* Store pend timeout in TCB                   */
6276  0213 ecf015        	ldd	OFST+10,s
6277  0216 6ce820        	std	32,y
6278  0219 ecf013        	ldd	OFST+8,s
6279  021c 6ce81e        	std	30,y
6280                     ; 487     OS_EventTaskWaitMulti(pevents_pend);                /* Suspend task until events or timeout occurs */
6282  021f ec8b          	ldd	OFST+0,s
6283  0221 1605ad        	jsr	_OS_EventTaskWaitMulti
6285                     ; 489     OS_EXIT_CRITICAL();
6287  0224 e68a          	ldab	OFST-1,s
6288  0226 87            	clra	
6289  0227 160000        	jsr	_OS_CPU_SR_Restore
6291                     ; 490     OS_Sched();                                         /* Find next highest priority task ready       */
6293  022a 16080c        	jsr	_OS_Sched
6295                     ; 491     OS_ENTER_CRITICAL();
6297  022d 160000        	jsr	_OS_CPU_SR_Save
6299  0230 6b8a          	stab	OFST-1,s
6300                     ; 493     switch (OSTCBCur->OSTCBStatPend) {                  /* Handle event posted, aborted, or timed-out  */
6302  0232 fd0419        	ldy	_OSTCBCur
6303  0235 e6e823        	ldab	35,y
6305  0238 2706          	beq	L3273
6306  023a 04011e        	dbeq	b,L5273
6307  023d 04211b        	dbne	b,L5273
6308  0240               L3273:
6309                     ; 494         case OS_STAT_PEND_OK:
6309                     ; 495         case OS_STAT_PEND_ABORT:
6309                     ; 496              pevent = OSTCBCur->OSTCBEventMultiRdy;
6311  0240 ece816        	ldd	22,y
6312  0243 6c80          	std	OFST-11,s
6313                     ; 497              if (pevent != (OS_EVENT *)0) {             /* If task event ptr != NULL, ...              */
6315  0245 270f          	beq	L7514
6316                     ; 498                 *pevents_rdy++   =  pevent;             /* ... return available event ...              */
6318  0247 ed8f          	ldy	OFST+4,s
6319  0249 6c71          	std	2,y+
6320  024b 6d8f          	sty	OFST+4,s
6321                     ; 499                 *pevents_rdy     = (OS_EVENT *)0;       /* ... & NULL terminate return event array     */
6323  024d 87            	clra	
6324  024e c7            	clrb	
6325  024f 6c40          	std	0,y
6326                     ; 500                   events_rdy_nbr =  1;
6328  0251 52            	incb	
6329  0252 6c84          	std	OFST-7,s
6331  0254 200f          	bra	L5514
6332  0256               L7514:
6333                     ; 503                  OSTCBCur->OSTCBStatPend = OS_STAT_PEND_TO;
6335  0256 c601          	ldab	#1
6336  0258 6be823        	stab	35,y
6337                     ; 504                  OS_EventTaskRemoveMulti(OSTCBCur, pevents_pend);
6340  025b               L5273:
6341                     ; 508         case OS_STAT_PEND_TO:                           /* If events timed out, ...                    */
6341                     ; 509         default:                                        /* ... remove task from events' wait lists     */
6341                     ; 510              OS_EventTaskRemoveMulti(OSTCBCur, pevents_pend);
6344  025b ec8b          	ldd	OFST+0,s
6345  025d 3b            	pshd	
6346  025e b764          	tfr	y,d
6347  0260 16063d        	jsr	_OS_EventTaskRemoveMulti
6348  0263 1b82          	leas	2,s
6349                     ; 511              break;
6351  0265               L5514:
6352                     ; 514     switch (OSTCBCur->OSTCBStatPend) {
6354  0265 fd0419        	ldy	_OSTCBCur
6355  0268 e6e823        	ldab	35,y
6357  026b 2708          	beq	L7273
6358  026d 040150        	dbeq	b,L1473
6359  0270 040140        	dbeq	b,L7373
6360  0273 204b          	bra	L1473
6361  0275               L7273:
6362                     ; 515         case OS_STAT_PEND_OK:
6362                     ; 516              switch (pevent->OSEventType) {             /* Return event's message                      */
6364  0275 e6f30000      	ldab	[OFST-11,s]
6366  0279 040111        	dbeq	b,L3373
6367  027c 04010e        	dbeq	b,L3373
6368  027f 040108        	dbeq	b,L1373
6369  0282 04010d        	dbeq	b,L5373
6370  0285 04010a        	dbeq	b,L5373
6371  0288 2008          	bra	L5373
6372  028a               L1373:
6373                     ; 518                  case OS_EVENT_TYPE_SEM:
6373                     ; 519                      *pmsgs_rdy++ = (void *)0;          /* NO message returned for semaphores          */
6375  028a 87            	clra	
6376                     ; 520                       break;
6378  028b 2018          	bra	L1714
6379  028d               L3373:
6380                     ; 525                  case OS_EVENT_TYPE_MBOX:
6380                     ; 526                  case OS_EVENT_TYPE_Q:
6380                     ; 527                      *pmsgs_rdy++ = (void *)OSTCBCur->OSTCBMsg;     /* Return received message         */
6382  028d ece818        	ldd	24,y
6383                     ; 528                       break;
6385  0290 2013          	bra	L1714
6386  0292               L5373:
6387                     ; 531                  case OS_EVENT_TYPE_MUTEX:
6387                     ; 532                  case OS_EVENT_TYPE_FLAG:
6387                     ; 533                  default:
6387                     ; 534                       OS_EXIT_CRITICAL();
6389  0292 e68a          	ldab	OFST-1,s
6390  0294 87            	clra	
6391  0295 160000        	jsr	_OS_CPU_SR_Restore
6393                     ; 535                      *pevents_rdy = (OS_EVENT *)0;      /* NULL terminate return event array           */
6395  0298 87            	clra	
6396  0299 c7            	clrb	
6397  029a 6cf3000f      	std	[OFST+4,s]
6398                     ; 536                      *perr        =  OS_ERR_EVENT_TYPE;
6400  029e 52            	incb	
6401  029f 6bf30017      	stab	[OFST+12,s]
6402                     ; 537                       return (events_rdy_nbr);
6405  02a3 2044          	bra	L42
6406  02a5               L1714:
6407  02a5 edf011        	ldy	OFST+6,s
6408  02a8 6c71          	std	2,y+
6409  02aa 6df011        	sty	OFST+6,s
6410                     ; 539             *perr = OS_ERR_NONE;
6412  02ad 69f30017      	clr	[OFST+12,s]
6413                     ; 540              break;
6415  02b1 201d          	bra	L5614
6416  02b3               L7373:
6417                     ; 542         case OS_STAT_PEND_ABORT:
6417                     ; 543             *pmsgs_rdy++ = (void *)0;                   /* NO message returned for abort               */
6419  02b3 87            	clra	
6420  02b4 edf011        	ldy	OFST+6,s
6421  02b7 6c71          	std	2,y+
6422  02b9 6df011        	sty	OFST+6,s
6423                     ; 544             *perr        =  OS_ERR_PEND_ABORT;          /* Indicate that event  aborted                */
6425  02bc c60e          	ldab	#14
6426                     ; 545              break;
6428  02be 200c          	bra	LC005
6429  02c0               L1473:
6430                     ; 547         case OS_STAT_PEND_TO:
6430                     ; 548         default:
6430                     ; 549             *pmsgs_rdy++ = (void *)0;                   /* NO message returned for timeout             */
6432  02c0 87            	clra	
6433  02c1 c7            	clrb	
6434  02c2 edf011        	ldy	OFST+6,s
6435  02c5 6c71          	std	2,y+
6436  02c7 6df011        	sty	OFST+6,s
6437                     ; 550             *perr        =  OS_ERR_TIMEOUT;             /* Indicate that events timed out              */
6439  02ca c60a          	ldab	#10
6440  02cc               LC005:
6441  02cc 6bf30017      	stab	[OFST+12,s]
6442                     ; 551              break;
6444  02d0               L5614:
6445                     ; 554     OSTCBCur->OSTCBStat          =  OS_STAT_RDY;        /* Set   task  status to ready                 */
6447  02d0 fd0419        	ldy	_OSTCBCur
6448  02d3 c7            	clrb	
6449  02d4 6be822        	stab	34,y
6450                     ; 555     OSTCBCur->OSTCBStatPend      =  OS_STAT_PEND_OK;    /* Clear pend  status                          */
6452  02d7 87            	clra	
6453  02d8 6ae823        	staa	35,y
6454                     ; 556     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)0;      /* Clear event pointers                        */
6456  02db 6ce814        	std	20,y
6457                     ; 557     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
6459  02de 6ce816        	std	22,y
6460                     ; 560     OSTCBCur->OSTCBMsg           = (void      *)0;      /* Clear task  message                         */
6462  02e1 6ce818        	std	24,y
6463                     ; 562     OS_EXIT_CRITICAL();
6465  02e4 e68a          	ldab	OFST-1,s
6466  02e6 160000        	jsr	_OS_CPU_SR_Restore
6468                     ; 564     return (events_rdy_nbr);
6471  02e9               L42:
6472  02e9 ec84          	ldd	OFST-7,s
6474  02eb 1b8d          	leas	13,s
6475  02ed 3d            	rts	
6509                     ; 582 _NEAR void  OSInit (void)
6509                     ; 583 {
6510                     	switch	.text
6511  02ee               _OSInit:
6515                     ; 590     OSInitHookBegin();                                           /* Call port specific initialization code   */
6517  02ee 160000        	jsr	_OSInitHookBegin
6519                     ; 592     OS_InitMisc();                                               /* Initialize miscellaneous variables       */
6521  02f1 1606fc        	jsr	L3153_OS_InitMisc
6523                     ; 594     OS_InitRdyList();                                            /* Initialize the Ready List                */
6525  02f4 16071d        	jsr	L5153_OS_InitRdyList
6527                     ; 596     OS_InitTCBList();                                            /* Initialize the free list of OS_TCBs      */
6529  02f7 16077b        	jsr	L1253_OS_InitTCBList
6531                     ; 598     OS_InitEventList();                                          /* Initialize the free list of OS_EVENTs    */
6533  02fa 16069d        	jsr	L1153_OS_InitEventList
6535                     ; 601     OS_FlagInit();                                               /* Initialize the event flag structures     */
6537  02fd 160000        	jsr	_OS_FlagInit
6539                     ; 605     OS_MemInit();                                                /* Initialize the memory manager            */
6541  0300 160000        	jsr	_OS_MemInit
6543                     ; 609     OS_QInit();                                                  /* Initialize the message queue structures  */
6545  0303 160000        	jsr	_OS_QInit
6547                     ; 621     OS_InitTaskIdle();                                           /* Create the Idle Task                     */
6549  0306 160743        	jsr	L7153_OS_InitTaskIdle
6551                     ; 627     OSTmr_Init();                                                /* Initialize the Timer Manager             */
6553  0309 160000        	jsr	_OSTmr_Init
6555                     ; 630     OSInitHookEnd();                                             /* Call port specific init. code            */
6557  030c 160000        	jsr	_OSInitHookEnd
6559                     ; 633     OSDebugInit();
6561  030f 160000        	jsr	_OSDebugInit
6563                     ; 635 }
6566  0312 3d            	rts	
6590                     ; 663 _NEAR void  OSIntEnter (void)
6590                     ; 664 {
6591                     	switch	.text
6592  0313               _OSIntEnter:
6596                     ; 665     if (OSRunning == OS_TRUE) {
6598  0313 f604c0        	ldab	_OSRunning
6599  0316 04210a        	dbne	b,L3124
6600                     ; 666         if (OSIntNesting < 255u) {
6602  0319 f604cd        	ldab	_OSIntNesting
6603  031c c1ff          	cmpb	#255
6604  031e 2403          	bhs	L3124
6605                     ; 667             OSIntNesting++;                      /* Increment ISR nesting level                        */
6607  0320 7204cd        	inc	_OSIntNesting
6608  0323               L3124:
6609                     ; 671 }
6612  0323 3d            	rts	
6614                     	xref	_OSIntCtxSw
6656                     ; 693 _NEAR void  OSIntExit (void)
6656                     ; 694 {
6657                     	switch	.text
6658  0324               _OSIntExit:
6660  0324 37            	pshb	
6661       00000001      OFST:	set	1
6664                     ; 696     OS_CPU_SR  cpu_sr = 0u;
6666                     ; 701     if (OSRunning == OS_TRUE) {
6668  0325 f604c0        	ldab	_OSRunning
6669  0328 04215f        	dbne	b,L3324
6670                     ; 702         OS_ENTER_CRITICAL();
6672  032b 160000        	jsr	_OS_CPU_SR_Save
6674  032e 6b80          	stab	OFST-1,s
6675                     ; 703         if (OSIntNesting > 0u) {                           /* Prevent OSIntNesting from wrapping       */
6677  0330 f704cd        	tst	_OSIntNesting
6678  0333 2703          	beq	L5324
6679                     ; 704             OSIntNesting--;
6681  0335 7304cd        	dec	_OSIntNesting
6682  0338               L5324:
6683                     ; 706         if (OSIntNesting == 0u) {                          /* Reschedule only if all ISRs complete ... */
6685  0338 f604cd        	ldab	_OSIntNesting
6686  033b 2647          	bne	L1524
6687                     ; 707             if (OSLockNesting == 0u) {                     /* ... and not locked.                      */
6689  033d f604cc        	ldab	_OSLockNesting
6690  0340 2642          	bne	L1524
6691                     ; 708                 OS_SchedNew();
6693  0342 160864        	jsr	L3253_OS_SchedNew
6695                     ; 709                 OSTCBHighRdy = OSTCBPrioTbl[OSPrioHighRdy];
6697  0345 f604ca        	ldab	_OSPrioHighRdy
6698  0348 87            	clra	
6699  0349 59            	lsld	
6700  034a b746          	tfr	d,y
6701  034c edea0393      	ldy	_OSTCBPrioTbl,y
6702  0350 7d0415        	sty	_OSTCBHighRdy
6703                     ; 710                 if (OSPrioHighRdy != OSPrioCur) {          /* No Ctx Sw if current task is highest rdy */
6705  0353 f604ca        	ldab	_OSPrioHighRdy
6706  0356 f104cb        	cmpb	_OSPrioCur
6707  0359 2729          	beq	L1524
6708                     ; 712                     OSTCBHighRdy->OSTCBCtxSwCtr++;         /* Inc. # of context switches to this task  */
6710  035b ece82c        	ldd	44,y
6711  035e c30001        	addd	#1
6712  0361 6ce82c        	std	44,y
6713  0364 2408          	bcc	L43
6714  0366 62e82b        	inc	43,y
6715  0369 2603          	bne	L43
6716  036b 62e82a        	inc	42,y
6717  036e               L43:
6718                     ; 714                     OSCtxSwCtr++;                          /* Keep track of the number of ctx switches */
6720  036e fc0597        	ldd	_OSCtxSwCtr+2
6721  0371 c30001        	addd	#1
6722  0374 7c0597        	std	_OSCtxSwCtr+2
6723  0377 2408          	bcc	L63
6724  0379 720596        	inc	_OSCtxSwCtr+1
6725  037c 2603          	bne	L63
6726  037e 720595        	inc	_OSCtxSwCtr
6727  0381               L63:
6728                     ; 723                     OSIntCtxSw();                          /* Perform interrupt level ctx switch       */
6731  0381 160000        	jsr	_OSIntCtxSw
6734  0384               L1524:
6735                     ; 734         OS_EXIT_CRITICAL();
6737  0384 e680          	ldab	OFST-1,s
6738  0386 87            	clra	
6739  0387 160000        	jsr	_OS_CPU_SR_Restore
6741  038a               L3324:
6742                     ; 736 }
6745  038a 1b81          	leas	1,s
6746  038c 3d            	rts	
6782                     ; 782 _NEAR void  OSSchedLock (void)
6782                     ; 783 {
6783                     	switch	.text
6784  038d               _OSSchedLock:
6786  038d 37            	pshb	
6787       00000001      OFST:	set	1
6790                     ; 785     OS_CPU_SR  cpu_sr = 0u;
6792                     ; 790     if (OSRunning == OS_TRUE) {                  /* Make sure multitasking is running                  */
6794  038e f604c0        	ldab	_OSRunning
6795  0391 04211a        	dbne	b,L7624
6796                     ; 791         OS_ENTER_CRITICAL();
6798  0394 160000        	jsr	_OS_CPU_SR_Save
6800  0397 6b80          	stab	OFST-1,s
6801                     ; 792         if (OSIntNesting == 0u) {                /* Can't call from an ISR                             */
6803  0399 f604cd        	ldab	_OSIntNesting
6804  039c 260a          	bne	L1724
6805                     ; 793             if (OSLockNesting < 255u) {          /* Prevent OSLockNesting from wrapping back to 0      */
6807  039e f604cc        	ldab	_OSLockNesting
6808  03a1 c1ff          	cmpb	#255
6809  03a3 2403          	bhs	L1724
6810                     ; 794                 OSLockNesting++;                 /* Increment lock nesting level                       */
6812  03a5 7204cc        	inc	_OSLockNesting
6813  03a8               L1724:
6814                     ; 797         OS_EXIT_CRITICAL();
6816  03a8 e680          	ldab	OFST-1,s
6817  03aa 87            	clra	
6818  03ab 160000        	jsr	_OS_CPU_SR_Restore
6820  03ae               L7624:
6821                     ; 799 }
6824  03ae 1b81          	leas	1,s
6825  03b0 3d            	rts	
6862                     ; 819 _NEAR void  OSSchedUnlock (void)
6862                     ; 820 {
6863                     	switch	.text
6864  03b1               _OSSchedUnlock:
6866  03b1 37            	pshb	
6867       00000001      OFST:	set	1
6870                     ; 822     OS_CPU_SR  cpu_sr = 0u;
6872                     ; 827     if (OSRunning == OS_TRUE) {                            /* Make sure multitasking is running        */
6874  03b2 f604c0        	ldab	_OSRunning
6875  03b5 042121        	dbne	b,L1134
6876                     ; 828         OS_ENTER_CRITICAL();
6878  03b8 160000        	jsr	_OS_CPU_SR_Save
6880  03bb 6b80          	stab	OFST-1,s
6881                     ; 829         if (OSIntNesting == 0u) {                          /* Can't call from an ISR                   */
6883  03bd f704cd        	tst	_OSIntNesting
6884  03c0 2613          	bne	L7134
6885                     ; 830             if (OSLockNesting > 0u) {                      /* Do not decrement if already 0            */
6887  03c2 f704cc        	tst	_OSLockNesting
6888  03c5 270e          	beq	L7134
6889                     ; 831                 OSLockNesting--;                           /* Decrement lock nesting level             */
6891  03c7 7304cc        	dec	_OSLockNesting
6892                     ; 832                 if (OSLockNesting == 0u) {                 /* See if scheduler is enabled              */
6894  03ca 2609          	bne	L7134
6895                     ; 833                     OS_EXIT_CRITICAL();
6897  03cc 87            	clra	
6898  03cd 160000        	jsr	_OS_CPU_SR_Restore
6900                     ; 834                     OS_Sched();                            /* See if a HPT is ready                    */
6902  03d0 16080c        	jsr	_OS_Sched
6905  03d3 2004          	bra	L1134
6906  03d5               L7134:
6907                     ; 836                     OS_EXIT_CRITICAL();
6910                     ; 839                 OS_EXIT_CRITICAL();
6913                     ; 842             OS_EXIT_CRITICAL();
6915  03d5 87            	clra	
6916  03d6 160000        	jsr	_OS_CPU_SR_Restore
6918  03d9               L1134:
6919                     ; 845 }
6922  03d9 1b81          	leas	1,s
6923  03db 3d            	rts	
6925                     	xref	_OSStartHighRdy
6954                     ; 869 _NEAR void  OSStart (void)
6954                     ; 870 {
6955                     	switch	.text
6956  03dc               _OSStart:
6960                     ; 871     if (OSRunning == OS_FALSE) {
6962  03dc f604c0        	ldab	_OSRunning
6963  03df 261a          	bne	L7334
6964                     ; 872         OS_SchedNew();                               /* Find highest priority's task priority number   */
6966  03e1 160864        	jsr	L3253_OS_SchedNew
6968                     ; 873         OSPrioCur     = OSPrioHighRdy;
6970  03e4 f604ca        	ldab	_OSPrioHighRdy
6971  03e7 7b04cb        	stab	_OSPrioCur
6972                     ; 874         OSTCBHighRdy  = OSTCBPrioTbl[OSPrioHighRdy]; /* Point to highest priority task ready to run    */
6974  03ea 87            	clra	
6975  03eb 59            	lsld	
6976  03ec b746          	tfr	d,y
6977  03ee ecea0393      	ldd	_OSTCBPrioTbl,y
6978  03f2 7c0415        	std	_OSTCBHighRdy
6979                     ; 875         OSTCBCur      = OSTCBHighRdy;
6981  03f5 7c0419        	std	_OSTCBCur
6982                     ; 876         OSStartHighRdy();                            /* Execute target specific code to start task     */
6984  03f8 160000        	jsr	_OSStartHighRdy
6986  03fb               L7334:
6987                     ; 878 }
6990  03fb 3d            	rts	
7369                     ; 937 _NEAR void  OSTimeTick (void)
7369                     ; 938 {
7370                     	switch	.text
7371  03fc               _OSTimeTick:
7373  03fc 1b9d          	leas	-3,s
7374       00000003      OFST:	set	3
7377                     ; 944     OS_CPU_SR  cpu_sr = 0u;
7379                     ; 950     OSTimeTickHook();                                      /* Call user definable hook                     */
7381  03fe 160000        	jsr	_OSTimeTickHook
7383                     ; 953     OS_ENTER_CRITICAL();                                   /* Update the 32-bit tick counter               */
7385  0401 160000        	jsr	_OS_CPU_SR_Save
7387  0404 6b82          	stab	OFST-1,s
7388                     ; 954     OSTime++;
7390  0406 fc0240        	ldd	_OSTime+2
7391  0409 c30001        	addd	#1
7392  040c 7c0240        	std	_OSTime+2
7393  040f 2408          	bcc	L05
7394  0411 72023f        	inc	_OSTime+1
7395  0414 2603          	bne	L05
7396  0416 72023e        	inc	_OSTime
7397  0419               L05:
7398                     ; 956     OS_EXIT_CRITICAL();
7401  0419 e682          	ldab	OFST-1,s
7402  041b 87            	clra	
7403  041c 160000        	jsr	_OS_CPU_SR_Restore
7405                     ; 958     if (OSRunning == OS_TRUE) {
7407  041f f604c0        	ldab	_OSRunning
7408  0422 53            	decb	
7409  0423 182600a6      	bne	L7654
7410                     ; 960         switch (OSTickStepState) {                         /* Determine whether we need to process a tick  */
7412  0427 f602d8        	ldab	_OSTickStepState
7414  042a 270f          	beq	L1434
7415  042c 040112        	dbeq	b,L3434
7416  042f 040113        	dbeq	b,L5434
7417                     ; 974             default:                                       /* Invalid case, correct situation              */
7417                     ; 975                  step            = OS_TRUE;
7419  0432 c601          	ldab	#1
7420  0434 6b82          	stab	OFST-1,s
7421                     ; 976                  OSTickStepState = OS_TICK_STEP_DIS;
7423  0436 7902d8        	clr	_OSTickStepState
7424                     ; 977                  break;
7426  0439 2011          	bra	L3754
7427  043b               L1434:
7428                     ; 961             case OS_TICK_STEP_DIS:                         /* Yes, stepping is disabled                    */
7428                     ; 962                  step = OS_TRUE;
7430  043b c601          	ldab	#1
7431  043d 6b82          	stab	OFST-1,s
7432                     ; 963                  break;
7434  043f 200b          	bra	L3754
7435  0441               L3434:
7436                     ; 965             case OS_TICK_STEP_WAIT:                        /* No,  waiting for uC/OS-View to set ...       */
7436                     ; 966                  step = OS_FALSE;                          /*      .. OSTickStepState to OS_TICK_STEP_ONCE */
7438  0441 6982          	clr	OFST-1,s
7439                     ; 967                  break;
7441  0443 2007          	bra	L3754
7442  0445               L5434:
7443                     ; 969             case OS_TICK_STEP_ONCE:                        /* Yes, process tick once and wait for next ... */
7443                     ; 970                  step            = OS_TRUE;                /*      ... step command from uC/OS-View        */
7445  0445 c601          	ldab	#1
7446  0447 6b82          	stab	OFST-1,s
7447                     ; 971                  OSTickStepState = OS_TICK_STEP_WAIT;
7449  0449 7b02d8        	stab	_OSTickStepState
7450                     ; 972                  break;
7452  044c               L3754:
7453                     ; 979         if (step == OS_FALSE) {                            /* Return if waiting for step command           */
7455  044c e682          	ldab	OFST-1,s
7456  044e 2603          	bne	L5754
7457                     ; 980             return;
7460  0450 1b83          	leas	3,s
7461  0452 3d            	rts	
7462  0453               L5754:
7463                     ; 983         ptcb = OSTCBList;                                  /* Point at first TCB in TCB list               */
7465  0453 1801800413    	movw	_OSTCBList,OFST-3,s
7467  0458 206a          	bra	L3064
7468  045a               L7754:
7469                     ; 985             OS_ENTER_CRITICAL();
7471  045a 160000        	jsr	_OS_CPU_SR_Save
7473  045d 6b82          	stab	OFST-1,s
7474                     ; 986             if (ptcb->OSTCBDly != 0u) {                    /* No, Delayed or waiting for event with TO     */
7476  045f ed80          	ldy	OFST-3,s
7477  0461 ece81e        	ldd	30,y
7478  0464 2605          	bne	LC007
7479  0466 ece820        	ldd	32,y
7480  0469 274f          	beq	L7064
7481  046b               LC007:
7482                     ; 987                 ptcb->OSTCBDly--;                          /* Decrement nbr of ticks to end of delay       */
7484  046b ece820        	ldd	32,y
7485  046e 830001        	subd	#1
7486  0471 6ce820        	std	32,y
7487  0474 ece81e        	ldd	30,y
7488  0477 c200          	sbcb	#0
7489  0479 8200          	sbca	#0
7490  047b 6ce81e        	std	30,y
7491                     ; 988                 if (ptcb->OSTCBDly == 0u) {                /* Check for timeout                            */
7493  047e 263a          	bne	L7064
7494  0480 ece820        	ldd	32,y
7495  0483 2635          	bne	L7064
7496                     ; 990                     if ((ptcb->OSTCBStat & OS_STAT_PEND_ANY) != OS_STAT_RDY) {
7498  0485 0fe822370b    	brclr	34,y,55,L3164
7499                     ; 991                         ptcb->OSTCBStat  &= (INT8U)~(INT8U)OS_STAT_PEND_ANY;   /* Yes, Clear status flag   */
7501  048a 0de82237      	bclr	34,y,55
7502                     ; 992                         ptcb->OSTCBStatPend = OS_STAT_PEND_TO;                 /* Indicate PEND timeout    */
7504  048e c601          	ldab	#1
7505  0490 6be823        	stab	35,y
7507  0493 2003          	bra	L5164
7508  0495               L3164:
7509                     ; 994                         ptcb->OSTCBStatPend = OS_STAT_PEND_OK;
7511  0495 69e823        	clr	35,y
7512  0498               L5164:
7513                     ; 997                     if ((ptcb->OSTCBStat & OS_STAT_SUSPEND) == OS_STAT_RDY) {  /* Is task suspended?       */
7515  0498 0ee822081d    	brset	34,y,8,L7064
7516                     ; 998                         OSRdyGrp               |= ptcb->OSTCBBitY;             /* No,  Make ready          */
7518  049d e6e828        	ldab	40,y
7519  04a0 fa04c9        	orab	_OSRdyGrp
7520  04a3 7b04c9        	stab	_OSRdyGrp
7521                     ; 999                         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
7523  04a6 e6e826        	ldab	38,y
7524  04a9 b796          	exg	b,y
7525  04ab ee80          	ldx	OFST-3,s
7526  04ad e6e027        	ldab	39,x
7527  04b0 eaea04c1      	orab	_OSRdyTbl,y
7528  04b4 6bea04c1      	stab	_OSRdyTbl,y
7530  04b8 b756          	tfr	x,y
7531  04ba               L7064:
7532                     ; 1004             ptcb = ptcb->OSTCBNext;                        /* Point at next TCB in TCB list                */
7534  04ba 18024e80      	movw	14,y,OFST-3,s
7535                     ; 1005             OS_EXIT_CRITICAL();
7537  04be e682          	ldab	OFST-1,s
7538  04c0 87            	clra	
7539  04c1 160000        	jsr	_OS_CPU_SR_Restore
7541  04c4               L3064:
7542                     ; 984         while (ptcb->OSTCBPrio != OS_TASK_IDLE_PRIO) {     /* Go through all TCBs in TCB list              */
7544  04c4 ed80          	ldy	OFST-3,s
7545  04c6 e6e824        	ldab	36,y
7546  04c9 c13f          	cmpb	#63
7547  04cb 268d          	bne	L7754
7548  04cd               L7654:
7549                     ; 1008 }
7552  04cd 1b83          	leas	3,s
7553  04cf 3d            	rts	
7575                     ; 1025 _NEAR INT16U  OSVersion (void)
7575                     ; 1026 {
7576                     	switch	.text
7577  04d0               _OSVersion:
7581                     ; 1027     return (OS_VERSION);
7583  04d0 cc7274        	ldd	#29300
7586  04d3 3d            	rts	
7608                     ; 1044 _NEAR void  OS_Dummy (void)
7608                     ; 1045 {
7609                     	switch	.text
7610  04d4               _OS_Dummy:
7614                     ; 1046 }
7617  04d4 3d            	rts	
7716                     ; 1078 _NEAR INT8U  OS_EventTaskRdy (OS_EVENT  *pevent,
7716                     ; 1079                              void      *pmsg,
7716                     ; 1080                              INT8U      msk,
7716                     ; 1081                              INT8U      pend_stat)
7716                     ; 1082 {
7717                     	switch	.text
7718  04d5               _OS_EventTaskRdy:
7720  04d5 3b            	pshd	
7721  04d6 1b9c          	leas	-4,s
7722       00000004      OFST:	set	4
7725                     ; 1093     y    = OSUnMapTbl[pevent->OSEventGrp];              /* Find HPT waiting for message                */
7727  04d8 b746          	tfr	d,y
7728  04da e645          	ldab	5,y
7729  04dc 87            	clra	
7730  04dd b746          	tfr	d,y
7731  04df e6ea0000      	ldab	_OSUnMapTbl,y
7732  04e3 6b83          	stab	OFST-1,s
7733                     ; 1094     x    = OSUnMapTbl[pevent->OSEventTbl[y]];
7735  04e5 ed84          	ldy	OFST+0,s
7736  04e7 19ed          	leay	b,y
7737  04e9 e646          	ldab	6,y
7738  04eb b746          	tfr	d,y
7739  04ed e6ea0000      	ldab	_OSUnMapTbl,y
7740  04f1 6b82          	stab	OFST-2,s
7741                     ; 1095     prio = (INT8U)((y << 3u) + x);                      /* Find priority of task getting the msg       */
7743  04f3 e683          	ldab	OFST-1,s
7744  04f5 58            	lslb	
7745  04f6 58            	lslb	
7746  04f7 58            	lslb	
7747  04f8 eb82          	addb	OFST-2,s
7748  04fa 6b82          	stab	OFST-2,s
7749                     ; 1111     ptcb                  =  OSTCBPrioTbl[prio];        /* Point to this task's OS_TCB                 */
7751  04fc 59            	lsld	
7752  04fd b746          	tfr	d,y
7753  04ff edea0393      	ldy	_OSTCBPrioTbl,y
7754  0503 6d80          	sty	OFST-4,s
7755                     ; 1112     ptcb->OSTCBDly        =  0u;                        /* Prevent OSTimeTick() from readying task     */
7757  0505 87            	clra	
7758  0506 c7            	clrb	
7759  0507 6ce820        	std	32,y
7760  050a 6ce81e        	std	30,y
7761                     ; 1114     ptcb->OSTCBMsg        =  pmsg;                      /* Send message directly to waiting task       */
7763  050d ec88          	ldd	OFST+4,s
7764  050f 6ce818        	std	24,y
7765                     ; 1118     ptcb->OSTCBStat      &= (INT8U)~msk;                /* Clear bit associated with event type        */
7767  0512 e68b          	ldab	OFST+7,s
7768  0514 51            	comb	
7769  0515 e4e822        	andb	34,y
7770  0518 6be822        	stab	34,y
7771                     ; 1119     ptcb->OSTCBStatPend   =  pend_stat;                 /* Set pend status of post or abort            */
7773  051b e68d          	ldab	OFST+9,s
7774  051d 6be823        	stab	35,y
7775                     ; 1121     if ((ptcb->OSTCBStat &   OS_STAT_SUSPEND) == OS_STAT_RDY) {
7777  0520 0ee822081a    	brset	34,y,8,L5074
7778                     ; 1122         OSRdyGrp         |=  ptcb->OSTCBBitY;           /* Put task in the ready to run list           */
7780  0525 e6e828        	ldab	40,y
7781  0528 fa04c9        	orab	_OSRdyGrp
7782  052b 7b04c9        	stab	_OSRdyGrp
7783                     ; 1123         OSRdyTbl[y]      |=  ptcb->OSTCBBitX;
7785  052e e683          	ldab	OFST-1,s
7786  0530 b796          	exg	b,y
7787  0532 ee80          	ldx	OFST-4,s
7788  0534 e6e027        	ldab	39,x
7789  0537 eaea04c1      	orab	_OSRdyTbl,y
7790  053b 6bea04c1      	stab	_OSRdyTbl,y
7792  053f               L5074:
7793                     ; 1127     OS_EventTaskRemove(ptcb, pevent);                   /* Remove this task from event   wait list     */
7795  053f ec84          	ldd	OFST+0,s
7796  0541 3b            	pshd	
7797  0542 ec82          	ldd	OFST-2,s
7798  0544 160610        	jsr	_OS_EventTaskRemove
7800  0547 1b82          	leas	2,s
7801                     ; 1129     if (ptcb->OSTCBEventMultiPtr != (OS_EVENT **)0) {   /* Remove this task from events' wait lists    */
7803  0549 ed80          	ldy	OFST-4,s
7804  054b ece814        	ldd	20,y
7805  054e 2714          	beq	L7074
7806                     ; 1130         OS_EventTaskRemoveMulti(ptcb, ptcb->OSTCBEventMultiPtr);
7808  0550 3b            	pshd	
7809  0551 b764          	tfr	y,d
7810  0553 16063d        	jsr	_OS_EventTaskRemoveMulti
7812  0556 1b82          	leas	2,s
7813                     ; 1131         ptcb->OSTCBEventMultiPtr  = (OS_EVENT **)0;     /* No longer pending on multi list             */
7815  0558 87            	clra	
7816  0559 c7            	clrb	
7817  055a ed80          	ldy	OFST-4,s
7818  055c 6ce814        	std	20,y
7819                     ; 1132         ptcb->OSTCBEventMultiRdy  = (OS_EVENT  *)pevent;/* Return event as first multi-pend event ready*/
7821  055f ec84          	ldd	OFST+0,s
7822  0561 6ce816        	std	22,y
7823  0564               L7074:
7824                     ; 1136     return (prio);
7826  0564 e682          	ldab	OFST-2,s
7829  0566 1b86          	leas	6,s
7830  0568 3d            	rts	
7876                     ; 1156 _NEAR void  OS_EventTaskWait (OS_EVENT *pevent)
7876                     ; 1157 {
7877                     	switch	.text
7878  0569               _OS_EventTaskWait:
7880  0569 3b            	pshd	
7881  056a 37            	pshb	
7882       00000001      OFST:	set	1
7885                     ; 1161     OSTCBCur->OSTCBEventPtr               = pevent;                 /* Store ptr to ECB in TCB         */
7887  056b fe0419        	ldx	_OSTCBCur
7888                     ; 1163     pevent->OSEventTbl[OSTCBCur->OSTCBY] |= OSTCBCur->OSTCBBitX;    /* Put task in waiting list        */
7890  056e b746          	tfr	d,y
7891  0570 6de012        	sty	18,x
7892  0573 e6e026        	ldab	38,x
7893  0576 87            	clra	
7894  0577 19ed          	leay	b,y
7895  0579 e6e027        	ldab	39,x
7896  057c ea46          	orab	6,y
7897  057e 6b46          	stab	6,y
7898                     ; 1164     pevent->OSEventGrp                   |= OSTCBCur->OSTCBBitY;
7900  0580 ed81          	ldy	OFST+0,s
7901  0582 e6e028        	ldab	40,x
7902  0585 ea45          	orab	5,y
7903  0587 6b45          	stab	5,y
7904                     ; 1166     y             =  OSTCBCur->OSTCBY;            /* Task no longer ready                              */
7906  0589 b756          	tfr	x,y
7907  058b e6e826        	ldab	38,y
7908                     ; 1167     OSRdyTbl[y]  &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
7910  058e b746          	tfr	d,y
7911  0590 e6e027        	ldab	39,x
7912  0593 51            	comb	
7913  0594 e4ea04c1      	andb	_OSRdyTbl,y
7914  0598 6bea04c1      	stab	_OSRdyTbl,y
7915                     ; 1169     if (OSRdyTbl[y] == 0u) {                      /* Clear event grp bit if this was only task pending */
7918  059c 260c          	bne	L3374
7919                     ; 1170         OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
7921  059e b756          	tfr	x,y
7922  05a0 e6e828        	ldab	40,y
7923  05a3 51            	comb	
7924  05a4 f404c9        	andb	_OSRdyGrp
7925  05a7 7b04c9        	stab	_OSRdyGrp
7926  05aa               L3374:
7927                     ; 1172 }
7930  05aa 1b83          	leas	3,s
7931  05ac 3d            	rts	
8004                     ; 1192 _NEAR void  OS_EventTaskWaitMulti (OS_EVENT **pevents_wait)
8004                     ; 1193 {
8005                     	switch	.text
8006  05ad               _OS_EventTaskWaitMulti:
8008  05ad 3b            	pshd	
8009  05ae 1b9b          	leas	-5,s
8010       00000005      OFST:	set	5
8013                     ; 1199     OSTCBCur->OSTCBEventMultiPtr = (OS_EVENT **)pevents_wait;       /* Store ptr to ECBs in TCB        */
8015  05b0 fd0419        	ldy	_OSTCBCur
8016  05b3 6ce814        	std	20,y
8017                     ; 1200     OSTCBCur->OSTCBEventMultiRdy = (OS_EVENT  *)0;
8019  05b6 87            	clra	
8020  05b7 c7            	clrb	
8021  05b8 6ce816        	std	22,y
8022                     ; 1202     pevents =  pevents_wait;
8024  05bb ee85          	ldx	OFST+0,s
8025  05bd 6e82          	stx	OFST-3,s
8026                     ; 1203     pevent  = *pevents;
8028  05bf ec00          	ldd	0,x
8029  05c1 6c80          	std	OFST-5,s
8031  05c3 b765          	tfr	y,x
8032  05c5 201f          	bra	L7774
8033  05c7               L3774:
8034                     ; 1205         pevent->OSEventTbl[OSTCBCur->OSTCBY] |= OSTCBCur->OSTCBBitX;
8036  05c7 b746          	tfr	d,y
8037  05c9 e6e026        	ldab	38,x
8038  05cc 19ed          	leay	b,y
8039  05ce e6e027        	ldab	39,x
8040  05d1 ea46          	orab	6,y
8041  05d3 6b46          	stab	6,y
8042                     ; 1206         pevent->OSEventGrp                   |= OSTCBCur->OSTCBBitY;
8044  05d5 ed80          	ldy	OFST-5,s
8045  05d7 e6e028        	ldab	40,x
8046  05da ea45          	orab	5,y
8047  05dc 6b45          	stab	5,y
8048                     ; 1207         pevents++;
8050  05de ed82          	ldy	OFST-3,s
8051                     ; 1208         pevent = *pevents;
8053  05e0 ec61          	ldd	2,+y
8054  05e2 6d82          	sty	OFST-3,s
8055  05e4 6c80          	std	OFST-5,s
8056  05e6               L7774:
8057                     ; 1204     while (pevent != (OS_EVENT *)0) {                               /* Put task in waiting lists       */
8059  05e6 26df          	bne	L3774
8060                     ; 1211     y             =  OSTCBCur->OSTCBY;            /* Task no longer ready                              */
8062  05e8 fd0419        	ldy	_OSTCBCur
8063  05eb e6e826        	ldab	38,y
8064                     ; 1212     OSRdyTbl[y]  &= (OS_PRIO)~OSTCBCur->OSTCBBitX;
8066  05ee b796          	exg	b,y
8067  05f0 fe0419        	ldx	_OSTCBCur
8068  05f3 e6e027        	ldab	39,x
8069  05f6 51            	comb	
8070  05f7 e4ea04c1      	andb	_OSRdyTbl,y
8071  05fb 6bea04c1      	stab	_OSRdyTbl,y
8072                     ; 1214     if (OSRdyTbl[y] == 0u) {                      /* Clear event grp bit if this was only task pending */
8075  05ff 260c          	bne	L3005
8076                     ; 1215         OSRdyGrp &= (OS_PRIO)~OSTCBCur->OSTCBBitY;
8078  0601 b756          	tfr	x,y
8079  0603 e6e828        	ldab	40,y
8080  0606 51            	comb	
8081  0607 f404c9        	andb	_OSRdyGrp
8082  060a 7b04c9        	stab	_OSRdyGrp
8083  060d               L3005:
8084                     ; 1217 }
8087  060d 1b87          	leas	7,s
8088  060f 3d            	rts	
8143                     ; 1237 _NEAR void  OS_EventTaskRemove (OS_TCB   *ptcb,
8143                     ; 1238                                OS_EVENT *pevent)
8143                     ; 1239 {
8144                     	switch	.text
8145  0610               _OS_EventTaskRemove:
8147  0610 3b            	pshd	
8148  0611 37            	pshb	
8149       00000001      OFST:	set	1
8152                     ; 1243     y                       =  ptcb->OSTCBY;
8154  0612 b746          	tfr	d,y
8155  0614 e6e826        	ldab	38,y
8156  0617 6b80          	stab	OFST-1,s
8157                     ; 1244     pevent->OSEventTbl[y]  &= (OS_PRIO)~ptcb->OSTCBBitX;    /* Remove task from wait list              */
8159  0619 ed85          	ldy	OFST+4,s
8160  061b 19ed          	leay	b,y
8161  061d ee81          	ldx	OFST+0,s
8162  061f e6e027        	ldab	39,x
8163  0622 51            	comb	
8164  0623 e446          	andb	6,y
8165  0625 6b46          	stab	6,y
8166                     ; 1245     if (pevent->OSEventTbl[y] == 0u) {
8168  0627 260a          	bne	L5305
8169                     ; 1246         pevent->OSEventGrp &= (OS_PRIO)~ptcb->OSTCBBitY;
8171  0629 ed85          	ldy	OFST+4,s
8172  062b e6e028        	ldab	40,x
8173  062e 51            	comb	
8174  062f e445          	andb	5,y
8175  0631 6b45          	stab	5,y
8176  0633               L5305:
8177                     ; 1248     ptcb->OSTCBEventPtr     = (OS_EVENT  *)0;               /* Unlink OS_EVENT from OS_TCB             */
8179  0633 87            	clra	
8180  0634 c7            	clrb	
8181  0635 b756          	tfr	x,y
8182  0637 6ce812        	std	18,y
8183                     ; 1249 }
8186  063a 1b83          	leas	3,s
8187  063c 3d            	rts	
8283                     ; 1269 _NEAR void  OS_EventTaskRemoveMulti (OS_TCB    *ptcb,
8283                     ; 1270                                     OS_EVENT **pevents_multi)
8283                     ; 1271 {
8284                     	switch	.text
8285  063d               _OS_EventTaskRemoveMulti:
8287  063d 3b            	pshd	
8288  063e 1b99          	leas	-7,s
8289       00000007      OFST:	set	7
8292                     ; 1279     y       =  ptcb->OSTCBY;
8294  0640 b746          	tfr	d,y
8295  0642 e6e826        	ldab	38,y
8296  0645 6b84          	stab	OFST-3,s
8297                     ; 1280     bity    =  ptcb->OSTCBBitY;
8299  0647 ed87          	ldy	OFST+0,s
8300  0649 e6e828        	ldab	40,y
8301  064c 6b85          	stab	OFST-2,s
8302                     ; 1281     bitx    =  ptcb->OSTCBBitX;
8304  064e e6e827        	ldab	39,y
8305  0651 6b86          	stab	OFST-1,s
8306                     ; 1282     pevents =  pevents_multi;
8308  0653 18028b82      	movw	OFST+4,s,OFST-5,s
8309                     ; 1283     pevent  = *pevents;
8311  0657 ecf30002      	ldd	[OFST-5,s]
8313  065b 201c          	bra	L3115
8314  065d               L7015:
8315                     ; 1285         pevent->OSEventTbl[y]  &= (OS_PRIO)~bitx;
8317  065d e684          	ldab	OFST-3,s
8318  065f 19ed          	leay	b,y
8319  0661 e686          	ldab	OFST-1,s
8320  0663 51            	comb	
8321  0664 e446          	andb	6,y
8322  0666 6b46          	stab	6,y
8323                     ; 1286         if (pevent->OSEventTbl[y] == 0u) {
8325  0668 2609          	bne	L7115
8326                     ; 1287             pevent->OSEventGrp &= (OS_PRIO)~bity;
8328  066a ed80          	ldy	OFST-7,s
8329  066c e685          	ldab	OFST-2,s
8330  066e 51            	comb	
8331  066f e445          	andb	5,y
8332  0671 6b45          	stab	5,y
8333  0673               L7115:
8334                     ; 1289         pevents++;
8336  0673 ed82          	ldy	OFST-5,s
8337                     ; 1290         pevent = *pevents;
8339  0675 ec61          	ldd	2,+y
8340  0677 6d82          	sty	OFST-5,s
8341  0679               L3115:
8342  0679 6c80          	std	OFST-7,s
8343                     ; 1284     while (pevent != (OS_EVENT *)0) {                   /* Remove task from all events' wait lists     */
8345  067b ed80          	ldy	OFST-7,s
8346  067d 26de          	bne	L7015
8347                     ; 1292 }
8350  067f 1b89          	leas	9,s
8351  0681 3d            	rts	
8395                     ; 1310 _NEAR void  OS_EventWaitListInit (OS_EVENT *pevent)
8395                     ; 1311 {
8396                     	switch	.text
8397  0682               _OS_EventWaitListInit:
8399  0682 3b            	pshd	
8400  0683 37            	pshb	
8401       00000001      OFST:	set	1
8404                     ; 1315     pevent->OSEventGrp = 0u;                     /* No task waiting on event                           */
8406  0684 b746          	tfr	d,y
8407  0686 c7            	clrb	
8408  0687 6b45          	stab	5,y
8409                     ; 1316     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
8411  0689 6b80          	stab	OFST-1,s
8412  068b               L3415:
8413                     ; 1317         pevent->OSEventTbl[i] = 0u;
8415  068b ed81          	ldy	OFST+0,s
8416  068d 87            	clra	
8417  068e 19ed          	leay	b,y
8418  0690 6a46          	staa	6,y
8419                     ; 1316     for (i = 0u; i < OS_EVENT_TBL_SIZE; i++) {
8421  0692 6280          	inc	OFST-1,s
8424  0694 e680          	ldab	OFST-1,s
8425  0696 c108          	cmpb	#8
8426  0698 25f1          	blo	L3415
8427                     ; 1319 }
8430  069a 1b83          	leas	3,s
8431  069c 3d            	rts	
8496                     ; 1336 static  void  OS_InitEventList (void)
8496                     ; 1337 {
8497                     	switch	.text
8498  069d               L1153_OS_InitEventList:
8500  069d 1b9a          	leas	-6,s
8501       00000006      OFST:	set	6
8504                     ; 1346     OS_MemClr((INT8U *)&OSEventTbl[0], sizeof(OSEventTbl)); /* Clear the event table                   */
8506  069f cc00a0        	ldd	#160
8507  06a2 3b            	pshd	
8508  06a3 cc04f3        	ldd	#_OSEventTbl
8509  06a6 1607e0        	jsr	_OS_MemClr
8511  06a9 1b82          	leas	2,s
8512                     ; 1347     for (ix = 0u; ix < (OS_MAX_EVENTS - 1u); ix++) {        /* Init. list of free EVENT control blocks */
8514  06ab 87            	clra	
8515  06ac c7            	clrb	
8516  06ad b746          	tfr	d,y
8517  06af 6d82          	sty	OFST-4,s
8518  06b1               L3025:
8519                     ; 1348         ix_next = ix + 1u;
8521  06b1 02            	iny	
8522                     ; 1349         pevent1 = &OSEventTbl[ix];
8524  06b2 59            	lsld	
8525  06b3 59            	lsld	
8526  06b4 59            	lsld	
8527  06b5 59            	lsld	
8528  06b6 c304f3        	addd	#_OSEventTbl
8529  06b9 6c80          	std	OFST-6,s
8530                     ; 1350         pevent2 = &OSEventTbl[ix_next];
8532  06bb b764          	tfr	y,d
8533  06bd 59            	lsld	
8534  06be 59            	lsld	
8535  06bf 59            	lsld	
8536  06c0 59            	lsld	
8537  06c1 c304f3        	addd	#_OSEventTbl
8538  06c4 6c84          	std	OFST-2,s
8539                     ; 1351         pevent1->OSEventType    = OS_EVENT_TYPE_UNUSED;
8541  06c6 ed80          	ldy	OFST-6,s
8542  06c8 6940          	clr	0,y
8543                     ; 1352         pevent1->OSEventPtr     = pevent2;
8545  06ca 6c41          	std	1,y
8546                     ; 1354         pevent1->OSEventName    = (INT8U *)(void *)"?";     /* Unknown name                            */
8548  06cc cc010e        	ldd	#L1125
8549  06cf 6c4e          	std	14,y
8550                     ; 1347     for (ix = 0u; ix < (OS_MAX_EVENTS - 1u); ix++) {        /* Init. list of free EVENT control blocks */
8552  06d1 ed82          	ldy	OFST-4,s
8553  06d3 02            	iny	
8556  06d4 b764          	tfr	y,d
8557  06d6 6c82          	std	OFST-4,s
8558  06d8 8c0009        	cpd	#9
8559  06db 25d4          	blo	L3025
8560                     ; 1357     pevent1                         = &OSEventTbl[ix];
8562  06dd 59            	lsld	
8563  06de 59            	lsld	
8564  06df 59            	lsld	
8565  06e0 59            	lsld	
8566  06e1 c304f3        	addd	#_OSEventTbl
8567  06e4 6c80          	std	OFST-6,s
8568                     ; 1358     pevent1->OSEventType            = OS_EVENT_TYPE_UNUSED;
8570  06e6 87            	clra	
8571  06e7 ed80          	ldy	OFST-6,s
8572  06e9 6a40          	staa	0,y
8573                     ; 1359     pevent1->OSEventPtr             = (OS_EVENT *)0;
8575  06eb c7            	clrb	
8576  06ec 6c41          	std	1,y
8577                     ; 1361     pevent1->OSEventName            = (INT8U *)(void *)"?"; /* Unknown name                            */
8579  06ee cc010e        	ldd	#L1125
8580  06f1 6c4e          	std	14,y
8581                     ; 1363     OSEventFreeList                 = &OSEventTbl[0];
8583  06f3 cc04f3        	ldd	#_OSEventTbl
8584  06f6 7c0593        	std	_OSEventFreeList
8585                     ; 1373 }
8588  06f9 1b86          	leas	6,s
8589  06fb 3d            	rts	
8618                     ; 1389 static  void  OS_InitMisc (void)
8618                     ; 1390 {
8619                     	switch	.text
8620  06fc               L3153_OS_InitMisc:
8624                     ; 1392     OSTime                    = 0uL;                       /* Clear the 32-bit system clock            */
8626  06fc 87            	clra	
8627  06fd c7            	clrb	
8628  06fe 7c0240        	std	_OSTime+2
8629  0701 7c023e        	std	_OSTime
8630                     ; 1395     OSIntNesting              = 0u;                        /* Clear the interrupt nesting counter      */
8632  0704 7a04cd        	staa	_OSIntNesting
8633                     ; 1396     OSLockNesting             = 0u;                        /* Clear the scheduling lock counter        */
8635  0707 7b04cc        	stab	_OSLockNesting
8636                     ; 1398     OSTaskCtr                 = 0u;                        /* Clear the number of tasks                */
8638  070a 7b04bf        	stab	_OSTaskCtr
8639                     ; 1400     OSRunning                 = OS_FALSE;                  /* Indicate that multitasking not started   */
8641  070d 7a04c0        	staa	_OSRunning
8642                     ; 1402     OSCtxSwCtr                = 0u;                        /* Clear the context switch counter         */
8644  0710 7c0597        	std	_OSCtxSwCtr+2
8645  0713 7c0595        	std	_OSCtxSwCtr
8646                     ; 1403     OSIdleCtr                 = 0uL;                       /* Clear the 32-bit idle counter            */
8648  0716 7c04bd        	std	_OSIdleCtr+2
8649  0719 7c04bb        	std	_OSIdleCtr
8650                     ; 1418 }
8653  071c 3d            	rts	
8690                     ; 1434 static  void  OS_InitRdyList (void)
8690                     ; 1435 {
8691                     	switch	.text
8692  071d               L5153_OS_InitRdyList:
8694  071d 37            	pshb	
8695       00000001      OFST:	set	1
8698                     ; 1439     OSRdyGrp      = 0u;                                    /* Clear the ready list                     */
8700  071e c7            	clrb	
8701  071f 7b04c9        	stab	_OSRdyGrp
8702                     ; 1440     for (i = 0u; i < OS_RDY_TBL_SIZE; i++) {
8704  0722 6b80          	stab	OFST-1,s
8705  0724               L7325:
8706                     ; 1441         OSRdyTbl[i] = 0u;
8708  0724 87            	clra	
8709  0725 b746          	tfr	d,y
8710  0727 6aea04c1      	staa	_OSRdyTbl,y
8711                     ; 1440     for (i = 0u; i < OS_RDY_TBL_SIZE; i++) {
8713  072b 6280          	inc	OFST-1,s
8716  072d e680          	ldab	OFST-1,s
8717  072f c108          	cmpb	#8
8718  0731 25f1          	blo	L7325
8719                     ; 1444     OSPrioCur     = 0u;
8721  0733 c7            	clrb	
8722  0734 7b04cb        	stab	_OSPrioCur
8723                     ; 1445     OSPrioHighRdy = 0u;
8725  0737 7a04ca        	staa	_OSPrioHighRdy
8726                     ; 1447     OSTCBHighRdy  = (OS_TCB *)0;
8728  073a 7c0415        	std	_OSTCBHighRdy
8729                     ; 1448     OSTCBCur      = (OS_TCB *)0;
8731  073d 7c0419        	std	_OSTCBCur
8732                     ; 1449 }
8735  0740 1b81          	leas	1,s
8736  0742 3d            	rts	
8772                     ; 1465 static  void  OS_InitTaskIdle (void)
8772                     ; 1466 {
8773                     	switch	.text
8774  0743               L7153_OS_InitTaskIdle:
8776  0743 37            	pshb	
8777       00000001      OFST:	set	1
8780                     ; 1474     (void)OSTaskCreateExt(OS_TaskIdle,
8780                     ; 1475                           (void *)0,                                 /* No arguments passed to OS_TaskIdle() */
8780                     ; 1476                           &OSTaskIdleStk[OS_TASK_IDLE_STK_SIZE - 1u],/* Set Top-Of-Stack                     */
8780                     ; 1477                           OS_TASK_IDLE_PRIO,                         /* Lowest priority level                */
8780                     ; 1478                           OS_TASK_IDLE_ID,
8780                     ; 1479                           &OSTaskIdleStk[0],                         /* Set Bottom-Of-Stack                  */
8780                     ; 1480                           OS_TASK_IDLE_STK_SIZE,
8780                     ; 1481                           (void *)0,                                 /* No TCB extension                     */
8780                     ; 1482                           OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);/* Enable stack checking + clear stack  */
8782  0744 cc0003        	ldd	#3
8783  0747 3b            	pshd	
8784  0748 c7            	clrb	
8785  0749 3b            	pshd	
8786  074a c6a0          	ldab	#160
8787  074c 3b            	pshd	
8788  074d c7            	clrb	
8789  074e 3b            	pshd	
8790  074f cc041b        	ldd	#_OSTaskIdleStk
8791  0752 3b            	pshd	
8792  0753 ccffff        	ldd	#-1
8793  0756 3b            	pshd	
8794  0757 cc003f        	ldd	#63
8795  075a 3b            	pshd	
8796  075b cc04ba        	ldd	#_OSTaskIdleStk+159
8797  075e 3b            	pshd	
8798  075f 87            	clra	
8799  0760 c7            	clrb	
8800  0761 3b            	pshd	
8801  0762 cc08a3        	ldd	#_OS_TaskIdle
8802  0765 160000        	jsr	_OSTaskCreateExt
8804  0768 1bf012        	leas	18,s
8805                     ; 1509     OSTaskNameSet(OS_TASK_IDLE_PRIO, (INT8U *)(void *)"uC/OS-II Idle", &err);
8807  076b 1a80          	leax	OFST-1,s
8808  076d 34            	pshx	
8809  076e cc0100        	ldd	#L1625
8810  0771 3b            	pshd	
8811  0772 cc003f        	ldd	#63
8812  0775 160000        	jsr	_OSTaskNameSet
8814                     ; 1511 }
8817  0778 1b85          	leas	5,s
8818  077a 3d            	rts	
8885                     ; 1591 static  void  OS_InitTCBList (void)
8885                     ; 1592 {
8886                     	switch	.text
8887  077b               L1253_OS_InitTCBList:
8889  077b 1b9a          	leas	-6,s
8890       00000006      OFST:	set	6
8893                     ; 1599     OS_MemClr((INT8U *)&OSTCBTbl[0],     sizeof(OSTCBTbl));      /* Clear all the TCBs                 */
8895  077d cc00ba        	ldd	#186
8896  0780 3b            	pshd	
8897  0781 cc02d9        	ldd	#_OSTCBTbl
8898  0784 075a          	jsr	_OS_MemClr
8900                     ; 1600     OS_MemClr((INT8U *)&OSTCBPrioTbl[0], sizeof(OSTCBPrioTbl));  /* Clear the priority table           */
8902  0786 cc0080        	ldd	#128
8903  0789 6c80          	std	0,s
8904  078b cc0393        	ldd	#_OSTCBPrioTbl
8905  078e 0750          	jsr	_OS_MemClr
8907  0790 1b82          	leas	2,s
8908                     ; 1601     for (ix = 0u; ix < (OS_MAX_TASKS + OS_N_SYS_TASKS - 1u); ix++) {    /* Init. list of free TCBs     */
8910  0792 c7            	clrb	
8911  0793 6b80          	stab	OFST-6,s
8912  0795               L5135:
8913                     ; 1602         ix_next =  ix + 1u;
8915  0795 52            	incb	
8916  0796 6b83          	stab	OFST-3,s
8917                     ; 1603         ptcb1   = &OSTCBTbl[ix];
8919  0798 e680          	ldab	OFST-6,s
8920  079a 863e          	ldaa	#62
8921  079c 12            	mul	
8922  079d c302d9        	addd	#_OSTCBTbl
8923  07a0 6c81          	std	OFST-5,s
8924                     ; 1604         ptcb2   = &OSTCBTbl[ix_next];
8926  07a2 e683          	ldab	OFST-3,s
8927  07a4 863e          	ldaa	#62
8928  07a6 12            	mul	
8929  07a7 c302d9        	addd	#_OSTCBTbl
8930  07aa 6c84          	std	OFST-2,s
8931                     ; 1605         ptcb1->OSTCBNext = ptcb2;
8933  07ac ed81          	ldy	OFST-5,s
8934  07ae 6c4e          	std	14,y
8935                     ; 1607         ptcb1->OSTCBTaskName = (INT8U *)(void *)"?";             /* Unknown name                       */
8937  07b0 cc010e        	ldd	#L1125
8938  07b3 6ce83c        	std	60,y
8939                     ; 1601     for (ix = 0u; ix < (OS_MAX_TASKS + OS_N_SYS_TASKS - 1u); ix++) {    /* Init. list of free TCBs     */
8941  07b6 6280          	inc	OFST-6,s
8944  07b8 e680          	ldab	OFST-6,s
8945  07ba c102          	cmpb	#2
8946  07bc 25d7          	blo	L5135
8947                     ; 1610     ptcb1                   = &OSTCBTbl[ix];
8949  07be 863e          	ldaa	#62
8950  07c0 12            	mul	
8951  07c1 c302d9        	addd	#_OSTCBTbl
8952  07c4 6c81          	std	OFST-5,s
8953                     ; 1611     ptcb1->OSTCBNext        = (OS_TCB *)0;                       /* Last OS_TCB                        */
8955  07c6 87            	clra	
8956  07c7 c7            	clrb	
8957  07c8 ed81          	ldy	OFST-5,s
8958  07ca 6c4e          	std	14,y
8959                     ; 1613     ptcb1->OSTCBTaskName    = (INT8U *)(void *)"?";              /* Unknown name                       */
8961  07cc cc010e        	ldd	#L1125
8962  07cf 6ce83c        	std	60,y
8963                     ; 1615     OSTCBList               = (OS_TCB *)0;                       /* TCB lists initializations          */
8965  07d2 87            	clra	
8966  07d3 c7            	clrb	
8967  07d4 7c0413        	std	_OSTCBList
8968                     ; 1616     OSTCBFreeList           = &OSTCBTbl[0];
8970  07d7 cc02d9        	ldd	#_OSTCBTbl
8971  07da 7c0417        	std	_OSTCBFreeList
8972                     ; 1617 }
8975  07dd 1b86          	leas	6,s
8976  07df 3d            	rts	
9017                     ; 1640 _NEAR void  OS_MemClr (INT8U  *pdest,
9017                     ; 1641                       INT16U  size)
9017                     ; 1642 {
9018                     	switch	.text
9019  07e0               _OS_MemClr:
9021  07e0 3b            	pshd	
9022       00000000      OFST:	set	0
9025  07e1 200b          	bra	L5435
9026  07e3               L3435:
9027                     ; 1644         *pdest++ = (INT8U)0;
9029  07e3 ed80          	ldy	OFST+0,s
9030  07e5 6970          	clr	1,y+
9031  07e7 6d80          	sty	OFST+0,s
9032                     ; 1645         size--;
9034  07e9 b746          	tfr	d,y
9035  07eb 03            	dey	
9036  07ec 6d84          	sty	OFST+4,s
9037  07ee               L5435:
9038                     ; 1643     while (size > 0u) {
9040  07ee ec84          	ldd	OFST+4,s
9041  07f0 26f1          	bne	L3435
9042                     ; 1647 }
9045  07f2 31            	puly	
9046  07f3 3d            	rts	
9097                     ; 1674 _NEAR void  OS_MemCopy (INT8U  *pdest,
9097                     ; 1675                        INT8U  *psrc,
9097                     ; 1676                        INT16U  size)
9097                     ; 1677 {
9098                     	switch	.text
9099  07f4               _OS_MemCopy:
9101  07f4 3b            	pshd	
9102       00000000      OFST:	set	0
9105  07f5 ee84          	ldx	OFST+4,s
9106  07f7 200d          	bra	L7735
9107  07f9               L5735:
9108                     ; 1679         *pdest++ = *psrc++;
9110  07f9 ed80          	ldy	OFST+0,s
9111  07fb 180a3070      	movb	1,x+,1,y+
9112  07ff 6d80          	sty	OFST+0,s
9113                     ; 1680         size--;
9115  0801 ed86          	ldy	OFST+6,s
9116  0803 03            	dey	
9117  0804 6d86          	sty	OFST+6,s
9118  0806               L7735:
9119                     ; 1678     while (size > 0u) {
9121  0806 ec86          	ldd	OFST+6,s
9122  0808 26ef          	bne	L5735
9123                     ; 1682 }
9126  080a 31            	puly	
9127  080b 3d            	rts	
9170                     ; 1702 _NEAR void  OS_Sched (void)
9170                     ; 1703 {
9171                     	switch	.text
9172  080c               _OS_Sched:
9174  080c 37            	pshb	
9175       00000001      OFST:	set	1
9178                     ; 1705     OS_CPU_SR  cpu_sr = 0u;
9180                     ; 1710     OS_ENTER_CRITICAL();
9182  080d 160000        	jsr	_OS_CPU_SR_Save
9184  0810 6b80          	stab	OFST-1,s
9185                     ; 1711     if (OSIntNesting == 0u) {                          /* Schedule only if all ISRs done and ...       */
9187  0812 f604cd        	ldab	_OSIntNesting
9188  0815 2644          	bne	L7145
9189                     ; 1712         if (OSLockNesting == 0u) {                     /* ... scheduler is not locked                  */
9191  0817 f604cc        	ldab	_OSLockNesting
9192  081a 263f          	bne	L7145
9193                     ; 1713             OS_SchedNew();
9195  081c 0746          	jsr	L3253_OS_SchedNew
9197                     ; 1714             OSTCBHighRdy = OSTCBPrioTbl[OSPrioHighRdy];
9199  081e f604ca        	ldab	_OSPrioHighRdy
9200  0821 87            	clra	
9201  0822 59            	lsld	
9202  0823 b746          	tfr	d,y
9203  0825 edea0393      	ldy	_OSTCBPrioTbl,y
9204  0829 7d0415        	sty	_OSTCBHighRdy
9205                     ; 1715             if (OSPrioHighRdy != OSPrioCur) {          /* No Ctx Sw if current task is highest rdy     */
9207  082c f604ca        	ldab	_OSPrioHighRdy
9208  082f f104cb        	cmpb	_OSPrioCur
9209  0832 2727          	beq	L7145
9210                     ; 1717                 OSTCBHighRdy->OSTCBCtxSwCtr++;         /* Inc. # of context switches to this task      */
9212  0834 ece82c        	ldd	44,y
9213  0837 c30001        	addd	#1
9214  083a 6ce82c        	std	44,y
9215  083d 2408          	bcc	L611
9216  083f 62e82b        	inc	43,y
9217  0842 2603          	bne	L611
9218  0844 62e82a        	inc	42,y
9219  0847               L611:
9220                     ; 1719                 OSCtxSwCtr++;                          /* Increment context switch counter             */
9222  0847 fc0597        	ldd	_OSCtxSwCtr+2
9223  084a c30001        	addd	#1
9224  084d 7c0597        	std	_OSCtxSwCtr+2
9225  0850 2408          	bcc	L021
9226  0852 720596        	inc	_OSCtxSwCtr+1
9227  0855 2603          	bne	L021
9228  0857 720595        	inc	_OSCtxSwCtr
9229  085a               L021:
9230                     ; 1727                 OS_TASK_SW();                          /* Perform a context switch                     */
9233  085a 3f            	swi	
9236  085b               L7145:
9237                     ; 1731     OS_EXIT_CRITICAL();
9239  085b e680          	ldab	OFST-1,s
9240  085d 87            	clra	
9241  085e 160000        	jsr	_OS_CPU_SR_Restore
9243                     ; 1732 }
9246  0861 1b81          	leas	1,s
9247  0863 3d            	rts	
9282                     ; 1751 _NEAR static  void  OS_SchedNew (void)
9282                     ; 1752 {
9283                     	switch	.text
9284  0864               L3253_OS_SchedNew:
9286  0864 37            	pshb	
9287       00000001      OFST:	set	1
9290                     ; 1757     y             = OSUnMapTbl[OSRdyGrp];
9292  0865 f604c9        	ldab	_OSRdyGrp
9293  0868 87            	clra	
9294  0869 b746          	tfr	d,y
9295  086b e6ea0000      	ldab	_OSUnMapTbl,y
9296  086f 6b80          	stab	OFST-1,s
9297                     ; 1758     OSPrioHighRdy = (INT8U)((y << 3u) + OSUnMapTbl[OSRdyTbl[y]]);
9299  0871 b746          	tfr	d,y
9300  0873 e6ea04c1      	ldab	_OSRdyTbl,y
9301  0877 b746          	tfr	d,y
9302  0879 e680          	ldab	OFST-1,s
9303  087b 58            	lslb	
9304  087c 58            	lslb	
9305  087d 58            	lslb	
9306  087e ebea0000      	addb	_OSUnMapTbl,y
9307  0882 7b04ca        	stab	_OSPrioHighRdy
9308                     ; 1776 }
9311  0885 1b81          	leas	1,s
9312  0887 3d            	rts	
9353                     ; 1796 _NEAR INT8U  OS_StrLen (INT8U *psrc)
9353                     ; 1797 {
9354                     	switch	.text
9355  0888               _OS_StrLen:
9357  0888 3b            	pshd	
9358  0889 37            	pshb	
9359       00000001      OFST:	set	1
9362                     ; 1802     if (psrc == (INT8U *)0) {
9364  088a 046402        	tbne	d,L1645
9365                     ; 1803         return (0u);
9368  088d 2011          	bra	L621
9369  088f               L1645:
9370                     ; 1807     len = 0u;
9372  088f 6980          	clr	OFST-1,s
9374  0891 b746          	tfr	d,y
9375  0893 2003          	bra	L7645
9376  0895               L3645:
9377                     ; 1809         psrc++;
9379  0895 02            	iny	
9380                     ; 1810         len++;
9382  0896 6280          	inc	OFST-1,s
9383  0898               L7645:
9384                     ; 1808     while (*psrc != OS_ASCII_NUL) {
9384                     ; 1809         psrc++;
9384                     ; 1810         len++;
9386  0898 e640          	ldab	0,y
9387  089a 26f9          	bne	L3645
9388  089c 6d81          	sty	OFST+0,s
9389                     ; 1812     return (len);
9391  089e e680          	ldab	OFST-1,s
9393  08a0               L621:
9395  08a0 1b83          	leas	3,s
9396  08a2 3d            	rts	
9441                     ; 1838 _NEAR void  OS_TaskIdle (void *p_arg)
9441                     ; 1839 {
9442                     	switch	.text
9443  08a3               _OS_TaskIdle:
9445  08a3 3b            	pshd	
9446  08a4 37            	pshb	
9447       00000001      OFST:	set	1
9450                     ; 1841     OS_CPU_SR  cpu_sr = 0u;
9452                     ; 1844     (void)p_arg;                                 /* Prevent compiler warning for not using 'p_arg'     */
9454  08a5               L3155:
9455                     ; 1846         OS_ENTER_CRITICAL();
9457  08a5 160000        	jsr	_OS_CPU_SR_Save
9459  08a8 6b80          	stab	OFST-1,s
9460                     ; 1847         OSIdleCtr++;
9462  08aa fc04bd        	ldd	_OSIdleCtr+2
9463  08ad c30001        	addd	#1
9464  08b0 7c04bd        	std	_OSIdleCtr+2
9465  08b3 2408          	bcc	L231
9466  08b5 7204bc        	inc	_OSIdleCtr+1
9467  08b8 2603          	bne	L231
9468  08ba 7204bb        	inc	_OSIdleCtr
9469  08bd               L231:
9470                     ; 1848         OS_EXIT_CRITICAL();
9472  08bd e680          	ldab	OFST-1,s
9473  08bf 87            	clra	
9474  08c0 160000        	jsr	_OS_CPU_SR_Restore
9476                     ; 1849         OSTaskIdleHook();                        /* Call user definable HOOK                           */
9478  08c3 160000        	jsr	_OSTaskIdleHook
9481  08c6 20dd          	bra	L3155
9564                     ; 1949 _NEAR void  OS_TaskStatStkChk (void)
9564                     ; 1950 {
9565                     	switch	.text
9566  08c8               _OS_TaskStatStkChk:
9568  08c8 1b94          	leas	-12,s
9569       0000000c      OFST:	set	12
9572                     ; 1957     for (prio = 0u; prio <= OS_TASK_IDLE_PRIO; prio++) {
9574  08ca 6982          	clr	OFST-10,s
9575  08cc               L7555:
9576                     ; 1958         err = OSTaskStkChk(prio, &stk_data);
9578  08cc 1a83          	leax	OFST-9,s
9579  08ce 34            	pshx	
9580  08cf e684          	ldab	OFST-8,s
9581  08d1 87            	clra	
9582  08d2 160000        	jsr	_OSTaskStkChk
9584  08d5 1b82          	leas	2,s
9585  08d7 6b8b          	stab	OFST-1,s
9586                     ; 1959         if (err == OS_ERR_NONE) {
9588  08d9 2624          	bne	L5655
9589                     ; 1960             ptcb = OSTCBPrioTbl[prio];
9591  08db e682          	ldab	OFST-10,s
9592  08dd 87            	clra	
9593  08de 59            	lsld	
9594  08df b746          	tfr	d,y
9595  08e1 edea0393      	ldy	_OSTCBPrioTbl,y
9596  08e5 6d80          	sty	OFST-12,s
9597                     ; 1961             if (ptcb != (OS_TCB *)0) {                               /* Make sure task 'ptcb' is ...   */
9599  08e7 ec80          	ldd	OFST-12,s
9600  08e9 2714          	beq	L5655
9601                     ; 1962                 if (ptcb != OS_TCB_RESERVED) {                       /* ... still valid.               */
9603  08eb 040411        	dbeq	d,L5655
9604                     ; 1965                     ptcb->OSTCBStkBase = ptcb->OSTCBStkBottom + ptcb->OSTCBStkSize;
9606  08ee ec48          	ldd	8,y
9607  08f0 e344          	addd	4,y
9608  08f2 6ce836        	std	54,y
9609                     ; 1969                     ptcb->OSTCBStkUsed = stk_data.OSUsed;            /* Store number of entries used   */
9611  08f5 ec89          	ldd	OFST-3,s
9612  08f7 6ce83a        	std	58,y
9613  08fa ec87          	ldd	OFST-5,s
9614  08fc 6ce838        	std	56,y
9615  08ff               L5655:
9616                     ; 1957     for (prio = 0u; prio <= OS_TASK_IDLE_PRIO; prio++) {
9618  08ff 6282          	inc	OFST-10,s
9621  0901 e682          	ldab	OFST-10,s
9622  0903 c13f          	cmpb	#63
9623  0905 23c5          	bls	L7555
9624                     ; 1975 }
9627  0907 1b8c          	leas	12,s
9628  0909 3d            	rts	
9739                     ; 2022 _NEAR INT8U  OS_TCBInit (INT8U    prio,
9739                     ; 2023                         OS_STK  *ptos,
9739                     ; 2024                         OS_STK  *pbos,
9739                     ; 2025                         INT16U   id,
9739                     ; 2026                         INT32U   stk_size,
9739                     ; 2027                         void    *pext,
9739                     ; 2028                         INT16U   opt)
9739                     ; 2029 {
9740                     	switch	.text
9741  090a               _OS_TCBInit:
9743  090a 3b            	pshd	
9744  090b 1b9d          	leas	-3,s
9745       00000003      OFST:	set	3
9748                     ; 2032     OS_CPU_SR  cpu_sr = 0u;
9750                     ; 2044     OS_ENTER_CRITICAL();
9752  090d 160000        	jsr	_OS_CPU_SR_Save
9754  0910 6b82          	stab	OFST-1,s
9755                     ; 2045     ptcb = OSTCBFreeList;                                  /* Get a free TCB from the free TCB list    */
9757  0912 fd0417        	ldy	_OSTCBFreeList
9758  0915 6d80          	sty	OFST-3,s
9759                     ; 2046     if (ptcb != (OS_TCB *)0) {
9761  0917 18270104      	beq	L1465
9762                     ; 2047         OSTCBFreeList            = ptcb->OSTCBNext;        /* Update pointer to free TCB list          */
9764  091b 18054e0417    	movw	14,y,_OSTCBFreeList
9765                     ; 2048         OS_EXIT_CRITICAL();
9767  0920 87            	clra	
9768  0921 160000        	jsr	_OS_CPU_SR_Restore
9770                     ; 2049         ptcb->OSTCBStkPtr        = ptos;                   /* Load Stack pointer in TCB                */
9772  0924 ed80          	ldy	OFST-3,s
9773  0926 18028740      	movw	OFST+4,s,0,y
9774                     ; 2050         ptcb->OSTCBPrio          = prio;                   /* Load task priority into TCB              */
9776  092a e684          	ldab	OFST+1,s
9777  092c 6be824        	stab	36,y
9778                     ; 2051         ptcb->OSTCBStat          = OS_STAT_RDY;            /* Task is ready to run                     */
9780  092f c7            	clrb	
9781  0930 6be822        	stab	34,y
9782                     ; 2052         ptcb->OSTCBStatPend      = OS_STAT_PEND_OK;        /* Clear pend status                        */
9784  0933 87            	clra	
9785  0934 6ae823        	staa	35,y
9786                     ; 2053         ptcb->OSTCBDly           = 0u;                     /* Task is not delayed                      */
9788  0937 6ce820        	std	32,y
9789  093a 6ce81e        	std	30,y
9790                     ; 2056         ptcb->OSTCBExtPtr        = pext;                   /* Store pointer to TCB extension           */
9792  093d ecf011        	ldd	OFST+14,s
9793  0940 6c42          	std	2,y
9794                     ; 2057         ptcb->OSTCBStkSize       = stk_size;               /* Store stack size                         */
9796  0942 18028f48      	movw	OFST+12,s,8,y
9797  0946 18028d46      	movw	OFST+10,s,6,y
9798                     ; 2058         ptcb->OSTCBStkBottom     = pbos;                   /* Store pointer to bottom of stack         */
9800  094a 18028944      	movw	OFST+6,s,4,y
9801                     ; 2059         ptcb->OSTCBOpt           = opt;                    /* Store task options                       */
9803  094e ecf013        	ldd	OFST+16,s
9804  0951 6c4a          	std	10,y
9805                     ; 2060         ptcb->OSTCBId            = id;                     /* Store task ID                            */
9807  0953 18028b4c      	movw	OFST+8,s,12,y
9808                     ; 2070         ptcb->OSTCBDelReq        = OS_ERR_NONE;
9810  0957 69e829        	clr	41,y
9811                     ; 2074         ptcb->OSTCBY             = (INT8U)(prio >> 3u);
9813  095a e684          	ldab	OFST+1,s
9814  095c 54            	lsrb	
9815  095d 54            	lsrb	
9816  095e 54            	lsrb	
9817  095f 6be826        	stab	38,y
9818                     ; 2075         ptcb->OSTCBX             = (INT8U)(prio & 0x07u);
9820  0962 e684          	ldab	OFST+1,s
9821  0964 c407          	andb	#7
9822  0966 6be825        	stab	37,y
9823                     ; 2081         ptcb->OSTCBBitY          = (OS_PRIO)(1uL << ptcb->OSTCBY);
9825  0969 c601          	ldab	#1
9826  096b a6e826        	ldaa	38,y
9827  096e 2704          	beq	L041
9828  0970               L241:
9829  0970 58            	lslb	
9830  0971 0430fc        	dbne	a,L241
9831  0974               L041:
9832  0974 6be828        	stab	40,y
9833                     ; 2082         ptcb->OSTCBBitX          = (OS_PRIO)(1uL << ptcb->OSTCBX);
9835  0977 c601          	ldab	#1
9836  0979 a6e825        	ldaa	37,y
9837  097c 2704          	beq	L441
9838  097e               L641:
9839  097e 58            	lslb	
9840  097f 0430fc        	dbne	a,L641
9841  0982               L441:
9842  0982 6be827        	stab	39,y
9843                     ; 2085         ptcb->OSTCBEventPtr      = (OS_EVENT  *)0;         /* Task is not pending on an  event         */
9845  0985 87            	clra	
9846  0986 c7            	clrb	
9847  0987 6ce812        	std	18,y
9848                     ; 2087         ptcb->OSTCBEventMultiPtr = (OS_EVENT **)0;         /* Task is not pending on any events        */
9850  098a 6ce814        	std	20,y
9851                     ; 2088         ptcb->OSTCBEventMultiRdy = (OS_EVENT  *)0;         /* No events readied for Multipend          */
9853  098d 6ce816        	std	22,y
9854                     ; 2093         ptcb->OSTCBFlagNode      = (OS_FLAG_NODE *)0;      /* Task is not pending on an event flag     */
9856  0990 6ce81a        	std	26,y
9857                     ; 2097         ptcb->OSTCBMsg           = (void *)0;              /* No message received                      */
9859  0993 6ce818        	std	24,y
9860                     ; 2101         ptcb->OSTCBCtxSwCtr      = 0uL;                    /* Initialize profiling variables           */
9862  0996 6ce82c        	std	44,y
9863  0999 6ce82a        	std	42,y
9864                     ; 2102         ptcb->OSTCBCyclesStart   = 0uL;
9866  099c 6ce834        	std	52,y
9867  099f 6ce832        	std	50,y
9868                     ; 2103         ptcb->OSTCBCyclesTot     = 0uL;
9870  09a2 6ce830        	std	48,y
9871  09a5 6ce82e        	std	46,y
9872                     ; 2104         ptcb->OSTCBStkBase       = (OS_STK *)0;
9874  09a8 6ce836        	std	54,y
9875                     ; 2105         ptcb->OSTCBStkUsed       = 0uL;
9877  09ab 6ce83a        	std	58,y
9878  09ae 6ce838        	std	56,y
9879                     ; 2109         ptcb->OSTCBTaskName      = (INT8U *)(void *)"?";
9881  09b1 cc010e        	ldd	#L1125
9882  09b4 6ce83c        	std	60,y
9883                     ; 2118         OSTCBInitHook(ptcb);
9885  09b7 ec80          	ldd	OFST-3,s
9886  09b9 160000        	jsr	_OSTCBInitHook
9888                     ; 2120         OS_ENTER_CRITICAL();
9890  09bc 160000        	jsr	_OS_CPU_SR_Save
9892  09bf 6b82          	stab	OFST-1,s
9893                     ; 2121         OSTCBPrioTbl[prio] = ptcb;
9895  09c1 e684          	ldab	OFST+1,s
9896  09c3 87            	clra	
9897  09c4 59            	lsld	
9898  09c5 b746          	tfr	d,y
9899  09c7 ec80          	ldd	OFST-3,s
9900  09c9 6cea0393      	std	_OSTCBPrioTbl,y
9901                     ; 2122         OS_EXIT_CRITICAL();
9903  09cd e682          	ldab	OFST-1,s
9904  09cf 87            	clra	
9905  09d0 160000        	jsr	_OS_CPU_SR_Restore
9907                     ; 2124         OSTaskCreateHook(ptcb);                            /* Call user defined hook                   */
9909  09d3 ec80          	ldd	OFST-3,s
9910  09d5 160000        	jsr	_OSTaskCreateHook
9912                     ; 2135         OS_ENTER_CRITICAL();
9914  09d8 160000        	jsr	_OS_CPU_SR_Save
9916  09db 6b82          	stab	OFST-1,s
9917                     ; 2136         ptcb->OSTCBNext = OSTCBList;                       /* Link into TCB chain                      */
9919  09dd ed80          	ldy	OFST-3,s
9920  09df 18014e0413    	movw	_OSTCBList,14,y
9921                     ; 2137         ptcb->OSTCBPrev = (OS_TCB *)0;
9923  09e4 87            	clra	
9924  09e5 c7            	clrb	
9925  09e6 6ce810        	std	16,y
9926                     ; 2138         if (OSTCBList != (OS_TCB *)0) {
9928  09e9 fd0413        	ldy	_OSTCBList
9929  09ec 2705          	beq	L3465
9930                     ; 2139             OSTCBList->OSTCBPrev = ptcb;
9932  09ee ec80          	ldd	OFST-3,s
9933  09f0 6ce810        	std	16,y
9934  09f3               L3465:
9935                     ; 2141         OSTCBList               = ptcb;
9937  09f3 ed80          	ldy	OFST-3,s
9938  09f5 7d0413        	sty	_OSTCBList
9939                     ; 2142         OSRdyGrp               |= ptcb->OSTCBBitY;         /* Make task ready to run                   */
9941  09f8 e6e828        	ldab	40,y
9942  09fb fa04c9        	orab	_OSRdyGrp
9943  09fe 7b04c9        	stab	_OSRdyGrp
9944                     ; 2143         OSRdyTbl[ptcb->OSTCBY] |= ptcb->OSTCBBitX;
9946  0a01 e6e826        	ldab	38,y
9947  0a04 87            	clra	
9948  0a05 b746          	tfr	d,y
9949  0a07 ee80          	ldx	OFST-3,s
9950  0a09 e6e027        	ldab	39,x
9951  0a0c eaea04c1      	orab	_OSRdyTbl,y
9952  0a10 6bea04c1      	stab	_OSRdyTbl,y
9953                     ; 2144         OSTaskCtr++;                                       /* Increment the #tasks counter             */
9955  0a14 7204bf        	inc	_OSTaskCtr
9956                     ; 2146         OS_EXIT_CRITICAL();
9959  0a17 e682          	ldab	OFST-1,s
9960  0a19 160000        	jsr	_OS_CPU_SR_Restore
9962                     ; 2147         return (OS_ERR_NONE);
9964  0a1c c7            	clrb	
9966  0a1d 2006          	bra	L051
9967  0a1f               L1465:
9968                     ; 2149     OS_EXIT_CRITICAL();
9970  0a1f 87            	clra	
9971  0a20 160000        	jsr	_OS_CPU_SR_Restore
9973                     ; 2150     return (OS_ERR_TASK_NO_MORE_TCB);
9975  0a23 c642          	ldab	#66
9977  0a25               L051:
9979  0a25 1b85          	leas	5,s
9980  0a27 3d            	rts	
10004                     	xref	_OSTimeTickHook
10005                     	xref	_OSTCBInitHook
10006                     	xref	_OSTaskIdleHook
10007                     	xref	_OSTaskCreateHook
10008                     	xref	_OSInitHookEnd
10009                     	xref	_OSInitHookBegin
10010                     	xref	_OSDebugInit
10011                     	xref	_OSTmr_Init
10012                     	xdef	_OS_TCBInit
10013                     	xdef	_OS_TaskStatStkChk
10014                     	xdef	_OS_TaskIdle
10015                     	xdef	_OS_StrLen
10016                     	xdef	_OS_Sched
10017                     	xref	_OS_QInit
10018                     	xref	_OS_MemInit
10019                     	xdef	_OS_MemCopy
10020                     	xdef	_OS_MemClr
10021                     	xref	_OS_FlagInit
10022                     	xdef	_OS_EventWaitListInit
10023                     	xdef	_OS_EventTaskRemoveMulti
10024                     	xdef	_OS_EventTaskWaitMulti
10025                     	xdef	_OS_EventTaskRemove
10026                     	xdef	_OS_EventTaskWait
10027                     	xdef	_OS_EventTaskRdy
10028                     	xdef	_OS_Dummy
10029                     	xdef	_OSVersion
10030                     	xdef	_OSStart
10031                     	xdef	_OSSchedUnlock
10032                     	xdef	_OSSchedLock
10033                     	xdef	_OSIntExit
10034                     	xdef	_OSIntEnter
10035                     	xdef	_OSInit
10036                     	xdef	_OSTimeTick
10037                     	xref	_OSTaskStkChk
10038                     	xref	_OSTaskNameSet
10039                     	xref	_OSTaskCreateExt
10040                     	xdef	_OSEventPendMulti
10041                     	xdef	_OSEventNameSet
10042                     	xdef	_OSEventNameGet
10043                     	xdef	_OSUnMapTbl
10044                     	switch	.bss
10045  0000               _OSTmrWheelTbl:
10046  0000 000000000000  	ds.b	32
10047                     	xdef	_OSTmrWheelTbl
10048  0020               _OSTmrTaskStk:
10049  0020 000000000000  	ds.b	160
10050                     	xdef	_OSTmrTaskStk
10051  00c0               _OSTmrFreeList:
10052  00c0 0000          	ds.b	2
10053                     	xdef	_OSTmrFreeList
10054  00c2               _OSTmrTbl:
10055  00c2 000000000000  	ds.b	368
10056                     	xdef	_OSTmrTbl
10057  0232               _OSTmrSemSignal:
10058  0232 0000          	ds.b	2
10059                     	xdef	_OSTmrSemSignal
10060  0234               _OSTmrSem:
10061  0234 0000          	ds.b	2
10062                     	xdef	_OSTmrSem
10063  0236               _OSTmrTime:
10064  0236 00000000      	ds.b	4
10065                     	xdef	_OSTmrTime
10066  023a               _OSTmrUsed:
10067  023a 0000          	ds.b	2
10068                     	xdef	_OSTmrUsed
10069  023c               _OSTmrFree:
10070  023c 0000          	ds.b	2
10071                     	xdef	_OSTmrFree
10072  023e               _OSTime:
10073  023e 00000000      	ds.b	4
10074                     	xdef	_OSTime
10075  0242               _OSQTbl:
10076  0242 000000000000  	ds.b	56
10077                     	xdef	_OSQTbl
10078  027a               _OSQFreeList:
10079  027a 0000          	ds.b	2
10080                     	xdef	_OSQFreeList
10081  027c               _OSMemTbl:
10082  027c 000000000000  	ds.b	90
10083                     	xdef	_OSMemTbl
10084  02d6               _OSMemFreeList:
10085  02d6 0000          	ds.b	2
10086                     	xdef	_OSMemFreeList
10087  02d8               _OSTickStepState:
10088  02d8 00            	ds.b	1
10089                     	xdef	_OSTickStepState
10090  02d9               _OSTCBTbl:
10091  02d9 000000000000  	ds.b	186
10092                     	xdef	_OSTCBTbl
10093  0393               _OSTCBPrioTbl:
10094  0393 000000000000  	ds.b	128
10095                     	xdef	_OSTCBPrioTbl
10096  0413               _OSTCBList:
10097  0413 0000          	ds.b	2
10098                     	xdef	_OSTCBList
10099  0415               _OSTCBHighRdy:
10100  0415 0000          	ds.b	2
10101                     	xdef	_OSTCBHighRdy
10102  0417               _OSTCBFreeList:
10103  0417 0000          	ds.b	2
10104                     	xdef	_OSTCBFreeList
10105  0419               _OSTCBCur:
10106  0419 0000          	ds.b	2
10107                     	xdef	_OSTCBCur
10108  041b               _OSTaskIdleStk:
10109  041b 000000000000  	ds.b	160
10110                     	xdef	_OSTaskIdleStk
10111  04bb               _OSIdleCtr:
10112  04bb 00000000      	ds.b	4
10113                     	xdef	_OSIdleCtr
10114  04bf               _OSTaskCtr:
10115  04bf 00            	ds.b	1
10116                     	xdef	_OSTaskCtr
10117  04c0               _OSRunning:
10118  04c0 00            	ds.b	1
10119                     	xdef	_OSRunning
10120  04c1               _OSRdyTbl:
10121  04c1 000000000000  	ds.b	8
10122                     	xdef	_OSRdyTbl
10123  04c9               _OSRdyGrp:
10124  04c9 00            	ds.b	1
10125                     	xdef	_OSRdyGrp
10126  04ca               _OSPrioHighRdy:
10127  04ca 00            	ds.b	1
10128                     	xdef	_OSPrioHighRdy
10129  04cb               _OSPrioCur:
10130  04cb 00            	ds.b	1
10131                     	xdef	_OSPrioCur
10132  04cc               _OSLockNesting:
10133  04cc 00            	ds.b	1
10134                     	xdef	_OSLockNesting
10135  04cd               _OSIntNesting:
10136  04cd 00            	ds.b	1
10137                     	xdef	_OSIntNesting
10138  04ce               _OSFlagFreeList:
10139  04ce 0000          	ds.b	2
10140                     	xdef	_OSFlagFreeList
10141  04d0               _OSFlagTbl:
10142  04d0 000000000000  	ds.b	35
10143                     	xdef	_OSFlagTbl
10144  04f3               _OSEventTbl:
10145  04f3 000000000000  	ds.b	160
10146                     	xdef	_OSEventTbl
10147  0593               _OSEventFreeList:
10148  0593 0000          	ds.b	2
10149                     	xdef	_OSEventFreeList
10150  0595               _OSCtxSwCtr:
10151  0595 00000000      	ds.b	4
10152                     	xdef	_OSCtxSwCtr
10153                     	xref	_OS_CPU_SR_Restore
10154                     	xref	_OS_CPU_SR_Save
10155                     	switch	.const
10156  0100               L1625:
10157  0100 75432f4f532d  	dc.b	"uC/OS-II Idle",0
10158  010e               L1125:
10159  010e 3f00          	dc.b	"?",0
10180                     	end

   1                     ; C Compiler for 68HCS12 [COSMIC Software]
   2                     ; Parser V4.11.9 - 08 Feb 2017
   3                     ; Generator V4.8.12 - 22 Feb 2017
   4                     ; Optimizer V4.7.11 - 22 Feb 2017
4025                     ; 53 _FAR static BOOL isLeapYear(
4025                     ; 54     UINT16 year)                  // 4-digit year
4025                     ; 55 {
4026                     .ftext:	section	.text
4027  0000               L7462f_isLeapYear:
4029  0000 3b            	pshd	
4030  0001 37            	pshb	
4031       00000001      OFST:	set	1
4034                     ; 62     isLeapYear = (BOOL)
4034                     ; 63         (((year % 4 == 0) && (year % 100 != 0))
4034                     ; 64                 ||
4034                     ; 65          (year % 400 == 0));
4036  0002 c503          	bitb	#3
4037  0004 2608          	bne	L21
4038  0006 ce0064        	ldx	#100
4039  0009 1810          	idiv	
4040  000b 04640a        	tbne	d,L01
4041  000e               L21:
4042  000e ec81          	ldd	OFST+0,s
4043  0010 ce0190        	ldx	#400
4044  0013 1810          	idiv	
4045  0015 046404        	tbne	d,L6
4046  0018               L01:
4047  0018 c601          	ldab	#1
4048  001a 2001          	bra	L41
4049  001c               L6:
4050  001c c7            	clrb	
4051  001d               L41:
4052                     ; 67     return(isLeapYear);
4056  001d 1b83          	leas	3,s
4057  001f 0a            	rtc	
4059                     .const:	section	.data
4060  0000               L7762_daysInMonth:
4061  0000 00            	dc.b	0
4062  0001 1f            	dc.b	31
4063  0002 1c            	dc.b	28
4064  0003 1f            	dc.b	31
4065  0004 1e            	dc.b	30
4066  0005 1f            	dc.b	31
4067  0006 1e            	dc.b	30
4068  0007 1f            	dc.b	31
4069  0008 1f            	dc.b	31
4070  0009 1e            	dc.b	30
4071  000a 1f            	dc.b	31
4072  000b 1e            	dc.b	30
4073  000c 1f            	dc.b	31
4128                     ; 78 _FAR static UINT8 getDaysInMonth(
4128                     ; 79     UINT8 month,                  // month
4128                     ; 80     UINT16 year)                  // year (4-digit)
4128                     ; 81 {
4129                     	switch	.ftext
4130  0020               L5762f_getDaysInMonth:
4132  0020 3b            	pshd	
4133  0021 37            	pshb	
4134       00000001      OFST:	set	1
4137                     ; 94     if ((month >= JANUARY) && (month <= DECEMBER)) {
4139  0022 04411f        	tbeq	b,L5272
4141  0025 c10c          	cmpb	#12
4142  0027 221b          	bhi	L5272
4143                     ; 95         numDaysInMonth = daysInMonth[month];
4145  0029 b796          	exg	b,y
4146  002b a6ea0000      	ldaa	L7762_daysInMonth,y
4147  002f 6a80          	staa	OFST-1,s
4148                     ; 96         if ((month == FEBRUARY) && (isLeapYear(year))) {
4150  0031 e682          	ldab	OFST+1,s
4151  0033 c102          	cmpb	#2
4152  0035 260f          	bne	L1372
4154  0037 ec86          	ldd	OFST+5,s
4155  0039 4a000000      	call	L7462f_isLeapYear
4157  003d 044106        	tbeq	b,L1372
4158                     ; 97             numDaysInMonth++;
4160  0040 6280          	inc	OFST-1,s
4161  0042 2002          	bra	L1372
4162  0044               L5272:
4163                     ; 101         numDaysInMonth = (UINT8)0;
4165  0044 6980          	clr	OFST-1,s
4166  0046               L1372:
4167                     ; 104     return(numDaysInMonth);
4169  0046 e680          	ldab	OFST-1,s
4172  0048 1b83          	leas	3,s
4173  004a 0a            	rtc	
4271                     ; 113 _FAR void Time_GetTime(
4271                     ; 114     TIME_ST *pTimeGetSt)          // addr to store time structure
4271                     ; 115 {
4272                     	switch	.ftext
4273  004b               f_Time_GetTime:
4275  004b 3b            	pshd	
4276  004c 3b            	pshd	
4277       00000002      OFST:	set	2
4280                     ; 116     TIME_ST *pTimeSt = &TimeSt;
4282  004d ce0002        	ldx	#L3462_TimeSt
4283  0050 6e80          	stx	OFST-2,s
4284                     ; 118     if (pTimeGetSt != NULL) {
4286  0052 ed82          	ldy	OFST+0,s
4287  0054 271c          	beq	L1003
4288                     ; 119         DISABLE_INTS();
4291  0056 1410          	sei	
4293                     ; 121         pTimeGetSt->hour     = pTimeSt->hour;
4295  0058 180a0444      	movb	4,x,4,y
4296                     ; 122         pTimeGetSt->minute   = pTimeSt->minute;
4298  005c 180a0545      	movb	5,x,5,y
4299                     ; 123         pTimeGetSt->second   = pTimeSt->second;
4301  0060 180a0646      	movb	6,x,6,y
4302                     ; 124         pTimeGetSt->month    = pTimeSt->month;
4304  0064 180a0242      	movb	2,x,2,y
4305                     ; 125         pTimeGetSt->day      = pTimeSt->day;
4307  0068 180a0343      	movb	3,x,3,y
4308                     ; 126         pTimeGetSt->year     = pTimeSt->year;
4310  006c 18020040      	movw	0,x,0,y
4311                     ; 127         ENABLE_INTS();
4314  0070 10ef          	cli	
4316  0072               L1003:
4317                     ; 130     return;
4320  0072 1b84          	leas	4,s
4321  0074 0a            	rtc	
4365                     ; 142 _FAR static BOOL isTimeValid(
4365                     ; 143     const TIME_ST *pTimeSt)
4365                     ; 144 {
4366                     	switch	.ftext
4367  0075               L3003f_isTimeValid:
4369  0075 3b            	pshd	
4370  0076 37            	pshb	
4371       00000001      OFST:	set	1
4374                     ; 148     if ((pTimeSt->year  >= 1900 && pTimeSt->year   <= 9999) &&
4374                     ; 149         (pTimeSt->month >= 1 &&    pTimeSt->month  <= 12)   &&
4374                     ; 150         (pTimeSt->day   >= 1 &&    pTimeSt->day    <= getDaysInMonth(
4374                     ; 151                                                         pTimeSt->month,
4374                     ; 152                                                         pTimeSt->year)) &&
4374                     ; 153         (                          pTimeSt->hour   <= 23)   &&
4374                     ; 154         (                          pTimeSt->minute <= 59)   &&
4374                     ; 155         (                          pTimeSt->second <= 59)) {
4376  0077 b746          	tfr	d,y
4377  0079 ec40          	ldd	0,y
4378  007b 8c076c        	cpd	#1900
4379  007e 253d          	blo	L7203
4381  0080 ed81          	ldy	OFST+0,s
4382  0082 ec40          	ldd	0,y
4383  0084 8c270f        	cpd	#9999
4384  0087 2234          	bhi	L7203
4386  0089 e642          	ldab	2,y
4387  008b 2730          	beq	L7203
4389  008d c10c          	cmpb	#12
4390  008f 222c          	bhi	L7203
4392  0091 e643          	ldab	3,y
4393  0093 2728          	beq	L7203
4395  0095 ec40          	ldd	0,y
4396  0097 3b            	pshd	
4397  0098 e642          	ldab	2,y
4398  009a 87            	clra	
4399  009b 4a002020      	call	L5762f_getDaysInMonth
4401  009f 1b82          	leas	2,s
4402  00a1 ed81          	ldy	OFST+0,s
4403  00a3 e143          	cmpb	3,y
4404  00a5 2516          	blo	L7203
4406  00a7 e644          	ldab	4,y
4407  00a9 c117          	cmpb	#23
4408  00ab 2210          	bhi	L7203
4410  00ad e645          	ldab	5,y
4411  00af c13b          	cmpb	#59
4412  00b1 220a          	bhi	L7203
4414  00b3 e646          	ldab	6,y
4415  00b5 c13b          	cmpb	#59
4416  00b7 2204          	bhi	L7203
4417                     ; 156         isValid = TRUE;
4419  00b9 c601          	ldab	#1
4421  00bb 2001          	bra	L1303
4422  00bd               L7203:
4423                     ; 159         isValid = FALSE;
4425  00bd c7            	clrb	
4426  00be               L1303:
4427                     ; 162     return(isValid);
4431  00be 1b83          	leas	3,s
4432  00c0 0a            	rtc	
4490                     ; 174 _FAR BOOL Time_DidSetTime(
4490                     ; 175     const TIME_ST *pTimeNewSt)
4490                     ; 176 {
4491                     	switch	.ftext
4492  00c1               f_Time_DidSetTime:
4494  00c1 3b            	pshd	
4495  00c2 1b9d          	leas	-3,s
4496       00000003      OFST:	set	3
4499                     ; 178     TIME_ST *pTimeSt = &TimeSt;
4501  00c4 cc0002        	ldd	#L3462_TimeSt
4502  00c7 6c80          	std	OFST-3,s
4503                     ; 181     if (isTimeValid(pTimeNewSt)) {
4505  00c9 ec83          	ldd	OFST+0,s
4506  00cb 4a007575      	call	L3003f_isTimeValid
4508  00cf 044126        	tbeq	b,L3603
4509                     ; 185         DISABLE_INTS();
4512  00d2 1410          	sei	
4514                     ; 186         pTimeSt->year    = pTimeNewSt->year;
4516  00d4 ee83          	ldx	OFST+0,s
4517  00d6 ed80          	ldy	OFST-3,s
4518  00d8 18020040      	movw	0,x,0,y
4519                     ; 187         pTimeSt->month   = pTimeNewSt->month;
4521  00dc 180a0242      	movb	2,x,2,y
4522                     ; 188         pTimeSt->day     = pTimeNewSt->day;
4524  00e0 180a0343      	movb	3,x,3,y
4525                     ; 189         pTimeSt->hour    = pTimeNewSt->hour;
4527  00e4 180a0444      	movb	4,x,4,y
4528                     ; 190         pTimeSt->minute  = pTimeNewSt->minute;
4530  00e8 180a0545      	movb	5,x,5,y
4531                     ; 191         pTimeSt->second  = pTimeNewSt->second;
4533  00ec 180a0646      	movb	6,x,6,y
4534                     ; 192         Millisec         = 0;
4536  00f0 87            	clra	
4537  00f1 c7            	clrb	
4538  00f2 7c0000        	std	L5462_Millisec
4539                     ; 193         ENABLE_INTS();
4542  00f5 10ef          	cli	
4544                     ; 195         didSetTime = TRUE;
4546  00f7 52            	incb	
4548  00f8               L3603:
4549                     ; 199         didSetTime = FALSE;
4551                     ; 202     return(didSetTime);
4555  00f8 1b85          	leas	5,s
4556  00fa 0a            	rtc	
4602                     ; 212 _FAR void Time_IncrementTime(
4602                     ; 213     UINT16 incrMillisec)
4602                     ; 214 {
4603                     	switch	.ftext
4604  00fb               f_Time_IncrementTime:
4606  00fb 3b            	pshd	
4607  00fc 3b            	pshd	
4608       00000002      OFST:	set	2
4611                     ; 215     TIME_ST *pTimeSt = &TimeSt;
4613  00fd cd0002        	ldy	#L3462_TimeSt
4614  0100 6d80          	sty	OFST-2,s
4615                     ; 217     DISABLE_INTS();
4618  0102 1410          	sei	
4620                     ; 219     Millisec += incrMillisec;
4622  0104 fc0000        	ldd	L5462_Millisec
4623  0107 e382          	addd	OFST+0,s
4624  0109 7c0000        	std	L5462_Millisec
4625                     ; 221     if (Millisec >= MS_PER_SEC) {
4627  010c 8c03e8        	cpd	#1000
4628  010f 2558          	blo	L1113
4630  0111 2005          	bra	L5113
4631  0113               L3113:
4632                     ; 224             Millisec -= MS_PER_SEC;
4634  0113 c3fc18        	addd	#-1000
4635                     ; 225             pTimeSt->second++;
4637  0116 6246          	inc	6,y
4638  0118               L5113:
4639                     ; 223         while (Millisec >= MS_PER_SEC) {
4641  0118 8c03e8        	cpd	#1000
4642  011b 24f6          	bhs	L3113
4643  011d 7c0000        	std	L5462_Millisec
4644                     ; 228         if (pTimeSt->second >= SEC_PER_MIN) {
4646  0120 ed80          	ldy	OFST-2,s
4647  0122 e646          	ldab	6,y
4648  0124 c13c          	cmpb	#60
4649  0126 2541          	blo	L1113
4650                     ; 229             pTimeSt->second = 0;
4652  0128 6946          	clr	6,y
4653                     ; 230             pTimeSt->minute++;
4655  012a 6245          	inc	5,y
4656                     ; 232             if (pTimeSt->minute >= MIN_PER_HR) {
4658  012c e645          	ldab	5,y
4659  012e c13c          	cmpb	#60
4660  0130 2537          	blo	L1113
4661                     ; 233                 pTimeSt->minute = 0;
4663  0132 6945          	clr	5,y
4664                     ; 234                 pTimeSt->hour++;
4666  0134 6244          	inc	4,y
4667                     ; 236                 if (pTimeSt->hour >= HR_PER_DAY) {
4669  0136 e644          	ldab	4,y
4670  0138 c118          	cmpb	#24
4671  013a 252d          	blo	L1113
4672                     ; 237                     pTimeSt->hour = 0;
4674  013c 6944          	clr	4,y
4675                     ; 238                     pTimeSt->day++;
4677  013e 6243          	inc	3,y
4678                     ; 240                     if (pTimeSt->day >
4678                     ; 241                         getDaysInMonth(pTimeSt->month, pTimeSt->year)) {
4680  0140 ec40          	ldd	0,y
4681  0142 3b            	pshd	
4682  0143 e642          	ldab	2,y
4683  0145 87            	clra	
4684  0146 4a002020      	call	L5762f_getDaysInMonth
4686  014a 1b82          	leas	2,s
4687  014c ed80          	ldy	OFST-2,s
4688  014e e143          	cmpb	3,y
4689  0150 2417          	bhs	L1113
4690                     ; 242                         pTimeSt->day = 1;
4692  0152 c601          	ldab	#1
4693  0154 6b43          	stab	3,y
4694                     ; 243                         pTimeSt->month++;
4696  0156 6242          	inc	2,y
4697                     ; 245                         if (pTimeSt->month > MONTHS_PER_YEAR) {
4699  0158 e642          	ldab	2,y
4700  015a c10c          	cmpb	#12
4701  015c 230b          	bls	L1113
4702                     ; 246                             pTimeSt->month = 1;
4704  015e c601          	ldab	#1
4705  0160 6b42          	stab	2,y
4706                     ; 247                             pTimeSt->year++;
4708  0162 ed40          	ldy	0,y
4709  0164 02            	iny	
4710  0165 6df30000      	sty	[OFST-2,s]
4711  0169               L1113:
4712                     ; 256     ENABLE_INTS();
4715  0169 10ef          	cli	
4717                     ; 258     return;
4720  016b 1b84          	leas	4,s
4721  016d 0a            	rtc	
4844                     ; 270 _FAR BOOL Time_DidPackTime(
4844                     ; 271     const TIME_ST *pTimeSt,              // ptr to time structure
4844                     ; 272     PACKED_TIME_ST *pTimePackedSt) {     // ptr to packed time structure
4845                     	switch	.ftext
4846  016e               f_Time_DidPackTime:
4848  016e 3b            	pshd	
4849  016f 37            	pshb	
4850       00000001      OFST:	set	1
4853                     ; 276     if (isTimeValid(pTimeSt)) {
4855  0170 4a007575      	call	L3003f_isTimeValid
4857  0174 d7            	tstb	
4858  0175 276f          	beq	L7123
4859                     ; 279         pTimePackedSt->year   = (pTimeSt->year % 1000) % 100;
4861  0177 ecf30001      	ldd	[OFST+0,s]
4862  017b ce03e8        	ldx	#1000
4863  017e 1810          	idiv	
4864  0180 ce0064        	ldx	#100
4865  0183 1810          	idiv	
4866  0185 ed86          	ldy	OFST+5,s
4867  0187 58            	lslb	
4868  0188 0d40fe        	bclr	0,y,254
4869  018b c4fe          	andb	#254
4870  018d ea40          	orab	0,y
4871  018f 6b40          	stab	0,y
4872                     ; 280         pTimePackedSt->month  = pTimeSt->month;
4874  0191 ee81          	ldx	OFST+0,s
4875  0193 a602          	ldaa	2,x
4876  0195 c7            	clrb	
4877  0196 49            	lsrd	
4878  0197 49            	lsrd	
4879  0198 49            	lsrd	
4880  0199 0d41e0        	bclr	1,y,224
4881  019c ea41          	orab	1,y
4882  019e 0d4001        	bclr	0,y,1
4883  01a1 8401          	anda	#1
4884  01a3 aa40          	oraa	0,y
4885  01a5 6c40          	std	0,y
4886                     ; 281         pTimePackedSt->day    = pTimeSt->day;
4888  01a7 e603          	ldab	3,x
4889  01a9 0d411f        	bclr	1,y,31
4890  01ac c41f          	andb	#31
4891  01ae ea41          	orab	1,y
4892  01b0 6b41          	stab	1,y
4893                     ; 282         pTimePackedSt->hour   = pTimeSt->hour;
4895  01b2 e604          	ldab	4,x
4896  01b4 58            	lslb	
4897  01b5 58            	lslb	
4898  01b6 58            	lslb	
4899  01b7 0d42f8        	bclr	2,y,248
4900  01ba c4f8          	andb	#248
4901  01bc ea42          	orab	2,y
4902  01be 6b42          	stab	2,y
4903                     ; 283         pTimePackedSt->minute = pTimeSt->minute;
4905  01c0 a605          	ldaa	5,x
4906  01c2 c7            	clrb	
4907  01c3 49            	lsrd	
4908  01c4 49            	lsrd	
4909  01c5 49            	lsrd	
4910  01c6 0d43e0        	bclr	3,y,224
4911  01c9 ea43          	orab	3,y
4912  01cb 0d4207        	bclr	2,y,7
4913  01ce 8407          	anda	#7
4914  01d0 aa42          	oraa	2,y
4915  01d2 6c42          	std	2,y
4916                     ; 284         pTimePackedSt->second = pTimeSt->second >> 1;
4918  01d4 b756          	tfr	x,y
4919  01d6 e646          	ldab	6,y
4920  01d8 54            	lsrb	
4921  01d9 ed86          	ldy	OFST+5,s
4922  01db 0d431f        	bclr	3,y,31
4923  01de c41f          	andb	#31
4924  01e0 ea43          	orab	3,y
4925  01e2 6b43          	stab	3,y
4926                     ; 286         didPackTime = TRUE;
4928  01e4 c601          	ldab	#1
4930  01e6               L7123:
4931                     ; 289         didPackTime = FALSE;
4933                     ; 292     return(didPackTime);
4937  01e6 1b83          	leas	3,s
4938  01e8 0a            	rtc	
4987                     ; 306 _FAR BOOL Time_DidUnpackTime(
4987                     ; 307     const PACKED_TIME_ST *pTimePackedSt, // ptr to packed time structure
4987                     ; 308     TIME_ST *pTimeSt) {                  // ptr to (unpacked) time structure
4988                     	switch	.ftext
4989  01e9               f_Time_DidUnpackTime:
4991  01e9 3b            	pshd	
4992       00000000      OFST:	set	0
4995                     ; 310     pTimeSt->year   = pTimePackedSt->year + 2000;
4997  01ea b746          	tfr	d,y
4998  01ec e640          	ldab	0,y
4999  01ee 54            	lsrb	
5000  01ef 87            	clra	
5001  01f0 c307d0        	addd	#2000
5002  01f3 ee85          	ldx	OFST+5,s
5003  01f5 6c00          	std	0,x
5004                     ; 311     pTimeSt->month  = pTimePackedSt->month;
5006  01f7 ed80          	ldy	OFST+0,s
5007  01f9 ec40          	ldd	0,y
5008  01fb 59            	lsld	
5009  01fc 59            	lsld	
5010  01fd 59            	lsld	
5011  01fe b701          	tfr	a,b
5012  0200 c40f          	andb	#15
5013  0202 6b02          	stab	2,x
5014                     ; 312     pTimeSt->day    = pTimePackedSt->day;
5016  0204 e641          	ldab	1,y
5017  0206 c41f          	andb	#31
5018  0208 b756          	tfr	x,y
5019  020a 6b43          	stab	3,y
5020                     ; 313     pTimeSt->hour   = pTimePackedSt->hour;
5022  020c ed80          	ldy	OFST+0,s
5023  020e e642          	ldab	2,y
5024  0210 54            	lsrb	
5025  0211 54            	lsrb	
5026  0212 54            	lsrb	
5027  0213 b756          	tfr	x,y
5028  0215 6b44          	stab	4,y
5029                     ; 314     pTimeSt->minute = pTimePackedSt->minute;
5031  0217 ed80          	ldy	OFST+0,s
5032  0219 ec42          	ldd	2,y
5033  021b 59            	lsld	
5034  021c 59            	lsld	
5035  021d 59            	lsld	
5036  021e b701          	tfr	a,b
5037  0220 c43f          	andb	#63
5038  0222 b756          	tfr	x,y
5039  0224 6b45          	stab	5,y
5040                     ; 315     pTimeSt->second = pTimePackedSt->second << 1;
5042  0226 ed80          	ldy	OFST+0,s
5043  0228 e643          	ldab	3,y
5044  022a c41f          	andb	#31
5045  022c 58            	lslb	
5046  022d b756          	tfr	x,y
5047  022f 6b46          	stab	6,y
5048                     ; 317     return(isTimeValid(pTimeSt));
5050  0231 b764          	tfr	y,d
5051  0233 4a007575      	call	L3003f_isTimeValid
5055  0237 31            	puly	
5056  0238 0a            	rtc	
5079                     ; 327 _FAR void Time_Init(void)
5079                     ; 328 {
5080                     	switch	.ftext
5081  0239               f_Time_Init:
5085                     ; 330     TimeSt.year    =  2000;
5087  0239 cc07d0        	ldd	#2000
5088  023c 7c0002        	std	L3462_TimeSt
5089                     ; 331     TimeSt.month   =  1;
5091  023f c601          	ldab	#1
5092  0241 7b0004        	stab	L3462_TimeSt+2
5093                     ; 332     TimeSt.day     =  1;
5095  0244 7b0005        	stab	L3462_TimeSt+3
5096                     ; 333     TimeSt.hour    =  0;
5098                     ; 334     TimeSt.minute  =  0;
5100  0247 87            	clra	
5101  0248 c7            	clrb	
5102  0249 7c0006        	std	L3462_TimeSt+4
5103                     ; 335     TimeSt.second  =  0;
5105  024c 790008        	clr	L3462_TimeSt+6
5106                     ; 337     return;
5109  024f 0a            	rtc	
5140                     	switch	.bss
5141  0000               L5462_Millisec:
5142  0000 0000          	ds.b	2
5143  0002               L3462_TimeSt:
5144  0002 000000000000  	ds.b	7
5145                     	xdef	f_Time_DidUnpackTime
5146                     	xdef	f_Time_DidPackTime
5147                     	xdef	f_Time_IncrementTime
5148                     	xdef	f_Time_DidSetTime
5149                     	xdef	f_Time_GetTime
5150                     	xdef	f_Time_Init
5171                     	end
